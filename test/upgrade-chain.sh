#!/usr/bin/env bash
#
# Walk an imported Nextcloud database up to the deployed major one major at a time in a
# staging kitchen VM (Nextcloud only upgrades one major per occ upgrade), then dump it.
# Re-converges the `upgrade` suite once per STEPS entry with the right version + PHP.
#
# Prereqs (run from the cookbook root):
#   - source dump at test/cookbooks/nextcloud-test/files/nextcloud-source.sql (git-ignored)
#   - export NC_INSTANCEID, NC_SALT, NC_SECRET, NC_SOURCE_VERSION (from the old config.php)
#
# Usage: test/upgrade-chain.sh [instance]   (default: upgrade-almalinux-9)
#   NC_RESUME=1  resume after a failure from .upgrade-chain-<instance>.state (no destroy)
#   NC_YES=1     skip the destroy confirmation
#
# PHP: 8.1 runs NC 25-31; 32/33 need 8.3 — the chain switches in place at the 32 step.
# Confirm exact patch versions at https://download.nextcloud.com/server/releases/.
# Runs are logged under test/upgrade-logs/ (.kitchen/logs is truncated each action).
# Assumes the login user has passwordless sudo for `mysqldump` over ssh.
set -euo pipefail

INSTANCE="${1:-upgrade-almalinux-9}"

# Require the source instance's identity + version (all read from its old config.php).
# Report every missing/empty one at once rather than failing on the first.
missing=()
for var in NC_INSTANCEID NC_SALT NC_SECRET NC_SOURCE_VERSION; do
  [ -n "${!var:-}" ] || missing+=("$var")
done
if [ "${#missing[@]}" -gt 0 ]; then
  {
    echo "Missing required environment variable(s): ${missing[*]}"
    echo "Set them from the source instance's config.php, for example:"
    echo "  export NC_INSTANCEID=...  NC_SALT=...  NC_SECRET=...  NC_SOURCE_VERSION=25.0.7"
  } >&2
  exit 1
fi
export NC_INSTANCEID NC_SALT NC_SECRET

[ -f kitchen.yml ] || { echo "run from the cookbook root (kitchen.yml not found)" >&2; exit 1; }
src='test/cookbooks/nextcloud-test/files/nextcloud-source.sql'
[ -f "$src" ] || { echo "missing source dump: $src" >&2; exit 1; }

# Persistent, timestamped log of this run (.kitchen/logs is truncated each action).
log_dir='test/upgrade-logs'
mkdir -p "$log_dir"
run_log="${log_dir}/${INSTANCE}-$(date -u +%Y%m%dT%H%M%SZ).log"
# Echo to both console and the run log.
say() { echo "$@" | tee -a "$run_log"; }
say "==> Run started $(date -u +%Y-%m-%dT%H:%M:%SZ) — logging to $run_log"

# "<nextcloud version> <php version>" per major step. First entry = your source's major
# (NC_SOURCE_VERSION pins the real start); last = the deployed target (default 33). Old
# majors need exact versions; a bare major resolves to latest via GitHub (recent only).
STEPS=(
  "25.0.13 8.1"
  "26.0.13 8.1"
  "27.1.11 8.1"
  "28.0.14 8.1"
  "29.0.16 8.1"
  "30.0.14 8.1"
  "31.0.10 8.1"
  "32.0.11 8.3"
  "33 8.3"
)

# Progress is recorded (last completed step index) so a failed run can be resumed with
# NC_RESUME=1 instead of rebuilding from scratch.
state_file=".upgrade-chain-${INSTANCE}.state"
target="${STEPS[-1]%% *}"

if [ "${NC_RESUME:-}" = 1 ]; then
  start=0
  [ -f "$state_file" ] && start=$(( $(cat "$state_file") + 1 ))
  if [ "$start" -ge "${#STEPS[@]}" ]; then
    echo "All ${#STEPS[@]} steps already completed (per $state_file); nothing to resume." >&2
    echo "Remove $state_file to start over." >&2
    exit 1
  fi
  say "==> Resuming on '$INSTANCE' at step $((start + 1))/${#STEPS[@]} (${STEPS[$start]%% *}); not destroying."
else
  # Confirm before the destructive rebuild (set NC_YES=1 to skip, e.g. in automation).
  if [ "${NC_YES:-}" != 1 ]; then
    read -r -p "Destroy '$INSTANCE' and rebuild it from scratch, walking ${NC_SOURCE_VERSION} -> ${target}? [y/N] " reply || reply=''
    case "$reply" in
      [yY] | [yY][eE][sS]) ;;
      *) echo 'Aborted.' >&2; exit 1 ;;
    esac
  fi
  rm -f "$state_file"
  kitchen destroy "$INSTANCE"
  start=0
fi

for (( i = start; i < ${#STEPS[@]}; i++ )); do
  # shellcheck disable=SC2086
  set -- ${STEPS[$i]}
  version="$1"; php="$2"
  say "==================================================================="
  say "==> Step $((i + 1))/${#STEPS[@]}: Nextcloud ${version} on PHP ${php} ($(date -u +%H:%M:%SZ))"
  say "==================================================================="
  # Tee to console + run log; pipefail keeps a converge failure fatal.
  if [ "$i" -eq 0 ]; then
    # Stamp the imported DB's real version so occ upgrades from the correct baseline.
    NC_SOURCE_VERSION="$NC_SOURCE_VERSION" NC_VERSION="$version" NC_PHP="$php" kitchen converge "$INSTANCE" 2>&1 | tee -a "$run_log"
  else
    # source_version only applies to the initial bootstrap; clear it on later steps.
    NC_SOURCE_VERSION='' NC_VERSION="$version" NC_PHP="$php" kitchen converge "$INSTANCE" 2>&1 | tee -a "$run_log"
  fi
  # Record the last successfully completed step so NC_RESUME=1 can continue after it.
  echo "$i" > "$state_file"
done

say "==> Dumping migrated database ($(date -u +%H:%M:%SZ))"
# Resolve the instance's SSH details from kitchen (driver-agnostic); ssh stdout is clean.
read -r ssh_host ssh_user ssh_key ssh_port < <(
  kitchen diagnose "$INSTANCE" | ruby -ryaml -e '
    cfg = YAML.unsafe_load(STDIN.read)
    inst = cfg.fetch("instances").values.first
    state = inst["state_file"] || {}
    transport = inst["transport"] || {}
    host = state["hostname"] || transport["hostname"]
    user = state["username"] || transport["username"]
    key  = Array(transport["ssh_key"]).first || state["ssh_key"]
    port = state["port"] || transport["port"] || 22
    abort("could not determine ssh host (is the instance converged?)") if host.to_s.empty?
    puts [host, user, key, port].join(" ")
  '
)

# stdout (the dump) goes to the file; stderr (any mysqldump/ssh warnings) is kept in the log.
ssh -i "$ssh_key" -p "$ssh_port" \
  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  "${ssh_user}@${ssh_host}" \
  'sudo mysqldump --single-transaction --routines --default-character-set=utf8mb4 nextcloud' \
  > nextcloud-migrated.sql 2> >(tee -a "$run_log" >&2)

grep -q 'CREATE TABLE' nextcloud-migrated.sql || {
  echo "ERROR: nextcloud-migrated.sql does not look like a complete dump" >&2
  exit 1
}

say "==> Wrote nextcloud-migrated.sql ($(du -h nextcloud-migrated.sql | cut -f1))"

# Sidecar of actionable WARN:/ERROR:/FATAL: lines, dropping high-volume benign noise; the
# full output stays in $run_log. (grep before the summary lines so it doesn't match itself.)
warn_ignore='built into Cinc Client is being overridden|shard_seed: Failed to get dmi|manage_symlink_source|is really a symlink|Failed to load data bag item|print STDERR'
warn_log="${run_log%.log}.warnings"
if grep -anE '(WARN|ERROR|FATAL):' "$run_log" | grep -avE "$warn_ignore" > "$warn_log"; then
  say "==> $(wc -l < "$warn_log" | tr -d ' ') warning/error line(s) flagged — see $warn_log"
  say "    (full unfiltered output: $run_log)"
else
  rm -f "$warn_log"
  say "==> No actionable warnings/errors flagged this run (full log: $run_log)"
fi
echo "    Adopt it in production with osl_nextcloud at the target version (no source_version)."
