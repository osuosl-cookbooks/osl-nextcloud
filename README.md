# osl-nextcloud

Installs and configures [Nextcloud](https://nextcloud.com/) behind Apache with PHP-FPM and
Redis/Valkey, via the `osl_nextcloud` custom resource. It handles fresh installs, in-place
upgrades between Nextcloud versions, and adopting an existing (imported) database.

## Requirements

### Platforms

- AlmaLinux 8
- AlmaLinux 9
- AlmaLinux 10

### Chef

- Chef Infra Client >= 18.0

### Cookbooks

- `ark` — downloads and extracts the Nextcloud release tarball
- `osl-apache` — Apache vhost (`apache_app`) and `mod_remoteip`
- `osl-php` — PHP install, `php.ini`, and PHP-FPM pool
- `osl-repos` — EPEL (and Alma) repositories
- `osl-selinux` — SELinux contexts and booleans

## Attributes

This cookbook exposes no user-facing node attributes; all configuration is done through
the `osl_nextcloud` resource. (It does set `node['osl-apache']['mpm']` and
`node['osl-apache']['behind_loadbalancer']` internally.)

## Resources

### `osl_nextcloud`

Installs and configures a complete Nextcloud instance. The default (and only) action is
`:create`.

#### Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `server_name` | String | resource name | Site/vhost name (also the install path under `/var/www`). |
| `server_aliases` | Array | `%w(localhost)` | Additional trusted domains / Apache aliases. |
| `version` | String | `'33'` | Nextcloud version to deploy. A bare major (`'33'`) resolves to the latest release via GitHub; an exact version (`'25.0.13'`) is used as-is (required for older releases). |
| `checksum` | String | _(auto)_ | sha256 of the release tarball. Fetched from nextcloud.com if unset. |
| `php_version` | String | `'8.3'` | PHP version to install. |
| `php_packages` | Array | `[]` | Extra PHP packages to install beyond the defaults. |
| `max_filesize` | String | `'1G'` | `upload_max_filesize` / `post_max_size`. |
| `redis_port` | Integer | `6379` | Port for the Redis/Valkey `redis` config (`port`). Override when 6379 conflicts with another service. |
| `database_host` | String (sensitive) | — | **Required.** Database host. |
| `database_name` | String | — | **Required.** Database name. |
| `database_user` | String (sensitive) | — | **Required.** Database user. |
| `database_password` | String (sensitive) | — | **Required.** Database password. |
| `nextcloud_admin_user` | String | `'admin'` | Admin account created on a fresh install. |
| `nextcloud_admin_password` | String (sensitive) | — | **Required.** Admin password. |
| `mail_domain` | String | — | **Required.** Mail domain (`mail_domain`). |
| `mail_smtphost` | String | `'smtp.osuosl.org'` | SMTP host. |
| `mail_from_address` | String | `'noreply'` | From address. |
| `apps` | Array | `[]` | Apps to `app:install` and `app:enable`. |
| `apps_disable` | Array | `[]` | Apps to `app:disable`. |
| `extra_config` | Hash | `{}` | Extra `config:system:set` values. Ruby booleans/integers are written with the matching `--type=boolean`/`--type=integer`; strings are written untyped. |
| `maintenance_window_start` | Integer | `1` | `maintenance_window_start` (UTC hour). |
| `instance_id` | String (sensitive) | — | Adopt mode: `instanceid` of an existing instance. |
| `password_salt` | String (sensitive) | — | Adopt mode: `passwordsalt` of an existing instance. |
| `secret` | String (sensitive) | — | Adopt mode: `secret` of an existing instance. |
| `source_version` | String | — | Adopt mode: version recorded in the imported database's original `config.php` (see below). |
| `sensitive` | true/false | `true` | Mask sensitive command output in logs. |

#### Example

```ruby
osl_nextcloud 'nextcloud.example.com' do
  server_aliases           %w(localhost nextcloud.example.com)
  database_host            'db.example.com'
  database_name            'nextcloud'
  database_user            'nextcloud'
  database_password        'super-secret'
  nextcloud_admin_password 'unguessable'
  mail_domain              'example.com'
  php_packages             %w(ldap)
  apps                     %w(forms)
  extra_config(
    'default_phone_region'              => 'US',
    'allow_user_to_change_display_name' => false  # written with --type=boolean
  )
end
```

## Recipes

This cookbook ships no recipes; it provides the `osl_nextcloud` resource for use in a
wrapper/consumer cookbook. The recipes under `test/cookbooks/nextcloud-test` exercise the
resource for Test Kitchen and ChefSpec.

## Migrating an existing Nextcloud instance

`osl_nextcloud` can adopt an existing instance's database instead of running a fresh
`maintenance:install`. Supply the identity from the source instance's `config.php`
(typically sourced from a data bag) and the resource bootstraps `config.php` from it,
skips `maintenance:install`, and lets `occ upgrade` migrate the imported schema:

```ruby
osl_nextcloud 'files.example.org' do
  database_host            '...'
  database_name            '...'
  database_user            '...'
  database_password        '...'
  nextcloud_admin_password '...'
  mail_domain              'example.org'
  # All three are required to enable "adopt existing instance" mode.
  instance_id              dbcreds['instanceid']
  password_salt            dbcreds['passwordsalt']
  secret                   dbcreds['secret']
end
```

When all three of `instance_id`, `password_salt`, and `secret` are set, the resource is in
adopt mode. Leave them unset for a normal fresh install.

### Upgrading an old database across major versions

Nextcloud only upgrades **one major version at a time**, and each major supports a
different range of PHP. Because this cookbook deploys a single target version, you cannot
adopt a database more than one major behind the deployed code — `occ upgrade` refuses
multi-major jumps. To migrate an old instance (e.g. 25.x) up to the deployed major (e.g.
33.x), step its database through each major in a staging VM first, then adopt the result.

The `upgrade` Test Kitchen suite and `test/upgrade-chain.sh` automate this:

1. Place the source database dump at
   `test/cookbooks/nextcloud-test/files/nextcloud-source.sql` (git-ignored). Only the
   database is needed — `occ upgrade` migrates the schema and does not read the file data
   directory.
2. Export the source instance's identity and its current version (read from its old
   `config.php`):

   ```sh
   export NC_INSTANCEID=...  NC_SALT=...  NC_SECRET=...
   export NC_SOURCE_VERSION=25.0.7   # the `version` key from the source config.php
   ```

3. Review the version/PHP steps in `test/upgrade-chain.sh` and confirm each exact patch
   release exists at <https://download.nextcloud.com/server/releases/>, then run it from the
   cookbook root:

   ```sh
   test/upgrade-chain.sh upgrade-almalinux-9
   ```

Up front, the script fails fast if it isn't run from the cookbook root, if the source dump
is missing, or if any of the four required environment variables are unset/empty (it
reports all the missing ones at once). It then prompts for confirmation before destroying
the instance — set `NC_YES=1` to skip the prompt in automation.

After confirming, it destroys the instance and converges the `upgrade` suite once per major
(PHP 8.1 covers Nextcloud 25–31; 32 and 33 need PHP 8.3), letting `occ upgrade` migrate the
schema at each step. Each major is a single converge — the `upgrade` suite disables the
idempotency check, since every step is a deliberate one-way change. On the first converge it
stamps `source_version` so occ upgrades from the imported database's real baseline; later
steps clear it. Finally it SSHes in, `mysqldump`s the migrated database to
`nextcloud-migrated.sql`, and verifies the dump looks complete. Adopt that dump in
production at the target version (with `source_version` left unset).

If a step fails, fix the cause and resume from where it stopped instead of rebuilding from
scratch — the last completed step is recorded in `.upgrade-chain-<instance>.state`:

```sh
NC_RESUME=1 test/upgrade-chain.sh upgrade-almalinux-9
```

`NC_RESUME=1` skips the destroy and continues from the next step. The resource also
re-runs `occ upgrade` whenever `config.php`'s recorded version is behind the deployed code,
so resuming a step whose upgrade failed partway retries it (rather than silently skipping it
because the tarball is already extracted).

The `source_version` property is what makes this work: it records the version of the
imported database so `occ upgrade` runs from the correct baseline. Set it when the
database's version differs from the deployed code; leave it unset for same-version
adoption (where the deployed code's version is used).

### Logs and expected warnings

Every run is logged to a timestamped file under `test/upgrade-logs/` (the `.kitchen/logs`
files are truncated each kitchen action). At the end the script writes a filtered
`.warnings` sidecar of actionable `WARN:`/`ERROR:`/`FATAL:` lines, dropping known-benign
noise (chef built-in resource overrides, ohai `dmidecode`, symlink notices, the test-only
missing `apache htpasswds` data bag, etc.). The full, unfiltered output stays in the `.log`.

When staging an **LDAP-backed** instance you will see repeated
`- ERROR: Lost connection to LDAP server.` lines. These are **expected and safe to ignore**
in staging: the kitchen VM can't reach the LDAP server, so a few `occ maintenance:repair`
steps that consult the group backend (e.g. "Remove shares of old group memberships") can't
run. They are post-migration cleanups, not schema work — the schema migration itself is
DB-only and completes — and the step fails safe (it aborts without modifying shares when it
can't verify membership), so the dump is intact. Most other repair steps only **queue
background jobs**, which run later via `cron.php`.

You do **not** need a separate manual upgrade on production. The production adopt converge
re-runs `occ maintenance:repair --include-expensive` itself (ark extracts the tarball, which
notifies `upgrade-nextcloud`), and there LDAP is reachable, so those steps complete. After
the production import + first converge, just verify:

1. The converge log shows `occ maintenance:repair` ran **without** "Lost connection to LDAP"
   (optionally run `sudo -u apache php occ maintenance:repair --include-expensive` once and
   confirm it's clean).
2. The `apache` cron is active (`crontab -l -u apache`) so the queued background jobs run.
3. `sudo -u apache php occ files:scan --all` for storage paths, per the migration handoff.

## Testing

```sh
cinc exec rspec       # ChefSpec unit tests
cinc exec cookstyle   # lint
```

Test Kitchen suites:

- `default` — fresh install.
- `migrate` — adopts a same-version database dump (`nextcloud-fixture.sql`).
- `upgrade` — staging chain for stepping an old database up across majors (see above).

## Contributing

1. Fork the repository on Github
1. Create a named feature branch (like `username/add_component_x`)
1. Write tests for your change
1. Write your change
1. Run the tests, ensuring they all pass
1. Submit a Pull Request using Github

## License and Authors

- Author:: Oregon State University <chef@osuosl.org>

```text
Copyright:: 2022, Oregon State University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
