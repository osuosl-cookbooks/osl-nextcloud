#
# Cookbook:: osl-nextcloud
# Recipe:: default
#
# Copyright:: 2022, Oregon State University
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


service 'apache2' do
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true, enable: true
  action :nothing
end
nextcloud 'test' do
  action :create
end
