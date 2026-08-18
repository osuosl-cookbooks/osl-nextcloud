#
# Cookbook:: osl-nextcloud
# Recipe:: default
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

append_if_no_line node['ipaddress'] do
  path '/etc/hosts'
  line "#{node['ipaddress']} nextcloud.example.com"
  sensitive false
end

osl_mysql_test 'nextcloud' do
  username 'nextcloud'
  password 'nextcloud'
end

osl_nextcloud 'nextcloud.example.com' do
  apps %w(forms user_ldap)
  apps_disable %w(weather_status)
  database_host 'localhost'
  database_name 'nextcloud'
  database_user 'nextcloud'
  database_password 'nextcloud'
  nextcloud_admin_password 'unguessable'
  mail_domain 'example.com'
  php_packages %w(ldap)
  # Set only by ChefSpec, to cover the non-load-balanced path.
  behind_loadbalancer node['nextcloud_behind_lb'] unless node['nextcloud_behind_lb'].nil?
  extra_config(
    'default_timezone' => 'UTC',
    'allow_user_to_change_display_name' => false,
    'log_rotate_size' => 104857600
  )
  # cloud.example.com sorts before localhost, so set-by-index 0 overwrites the
  # installer's localhost entry mid-converge — regression coverage proving the
  # converge-time trusted-domain guards re-add it in the same run (the second
  # cinc run then enforces idempotency).
  server_aliases %w(cloud.example.com localhost nextcloud.example.com)
end

# Used for testing
package 'jq'

execute 'nextcloud cronjob' do
  command '/usr/bin/php -f /var/www/nextcloud.example.com/nextcloud/cron.php; touch /tmp/nextcloud-cron-ran'
  creates '/tmp/nextcloud-cron-ran'
  user 'apache'
end
