#
# Cookbook:: osl-nextcloud
# Recipe:: migrate
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

# Exercises adopt-existing-instance mode: import a real mysqldump fixture, then give
# osl_nextcloud the matching identity so it bootstraps config.php and skips install.

append_if_no_line node['ipaddress'] do
  path '/etc/hosts'
  line "#{node['ipaddress']} nextcloud.example.com"
  sensitive false
end

osl_mysql_test 'nextcloud' do
  username 'nextcloud'
  password 'nextcloud'
end

# Stand-in for the operator-side DB import; marker file keeps it idempotent.
cookbook_file '/tmp/nextcloud-fixture.sql' do
  source 'nextcloud-fixture.sql'
  sensitive true
end

execute 'import existing nextcloud database' do
  command 'mysql nextcloud < /tmp/nextcloud-fixture.sql && touch /tmp/nextcloud-db-imported'
  creates '/tmp/nextcloud-db-imported'
  sensitive true
end

osl_nextcloud 'nextcloud.example.com' do
  # Pin to the fixture's major (dumped from 32.x) so this stays a same-version adopt.
  version '32'
  database_host 'localhost'
  database_name 'nextcloud'
  database_user 'nextcloud'
  database_password 'nextcloud'
  nextcloud_admin_password 'unguessable'
  mail_domain 'example.com'
  php_packages %w(ldap)
  # Identity from the dumped instance; in production these come from the data bag.
  instance_id 'ocm9ua92lqzi'
  password_salt 'il4t2Kt3sJT+y7R5T3STtlDBgZy/S6'
  secret 'aG7+wjGIP0FOQOAgJgsHoeGnAibLN60Cyy14TuYWDZxrZlfg'
  server_aliases %w(localhost nextcloud.example.com)
end

# Used for testing
package 'jq'
