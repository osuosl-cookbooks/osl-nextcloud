#
# Cookbook:: osl-nextcloud
# Recipe:: upgrade
#
# Copyright:: 2022-2026, Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Staging recipe for walking an imported database up one major at a time (25 -> 33), driven
# by test/upgrade-chain.sh. Attributes are injected per-step via kitchen.yml ERB; the source
# dump goes at files/nextcloud-source.sql (git-ignored).
# ERB-injected attributes arrive as '' — normalize to nil for the optional/presence checks.
up = node['nextcloud_upgrade'].to_h
up.each { |k, v| up[k] = nil if v.respond_to?(:empty?) && v.empty? }

append_if_no_line node['ipaddress'] do
  path '/etc/hosts'
  line "#{node['ipaddress']} nextcloud.example.com"
  sensitive false
end

osl_mysql_test 'nextcloud' do
  username 'nextcloud'
  password 'nextcloud'
end

# Import the source dump once (marker-guarded); later converges only run occ upgrade.
cookbook_file '/tmp/nextcloud-source.sql' do
  source 'nextcloud-source.sql'
  sensitive true
end

execute 'import source nextcloud database' do
  command 'mysql nextcloud < /tmp/nextcloud-source.sql && touch /tmp/nextcloud-db-imported'
  creates '/tmp/nextcloud-db-imported'
  sensitive true
end

osl_nextcloud 'nextcloud.example.com' do
  version up['version']
  php_version up['php_version']
  # Only used on the first converge (initial config.php stamp).
  source_version up['source_version']
  database_host 'localhost'
  database_name 'nextcloud'
  database_user 'nextcloud'
  database_password 'nextcloud'
  nextcloud_admin_password 'unguessable'
  mail_domain 'example.com'
  php_packages %w(ldap)
  instance_id up['instance_id']
  password_salt up['password_salt']
  secret up['secret']
  server_aliases %w(localhost nextcloud.example.com)
end
