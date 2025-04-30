#
# Cookbook:: osl-nextcloud
# Recipe:: default
#
# Copyright:: 2022-2025, Oregon State University
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
  server_aliases %w(localhost nextcloud.example.com)
end

# Used for testing
package 'jq'
