# proj-snowdrift civicrbm
# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
resource_name :osl_nextcloud
provides :osl_nextcloud
unified_mode true

property :server_name, String, default: 'nextcloud' # (also name property)
property :version, String, default: '23.0.7'
property :checksum, String, default: '320c81f9b902922b4bcef3eacf858596a14347fd45bddd26dac198562d212439' # (256sum of tarball): default latest version's checksum)
property :database_host, String, sensitive: true # required
property :database_name, String # :required
property :database_user, String, sensitive: true # required
property :database_password, String, sensitive: true # required

default_action :create

action :create do
  node.default['php']['version'] = '7.4'
  node.default['osl-php']['use_ius'] = true

  node.default['osl-php']['php_packages'] = %w(
    gd
    intl
    json
    mbstring
    mysqlnd
    opcache
    pecl-apcu
    pecl-imagick
    zip
  )
  node.default['php']['fpm_package'] = 'php74u-fpm'
  node.default['apache']['mod_fastcgi']['package'] = 'mod_fcgid'
  node.default['osl-apache']['behind_loadbalancer'] = true

  ::Chef::Resource.include Apache2::Cookbook::Helpers

  include_recipe 'ark'
  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-apache::mod_php'
  include_recipe 'osl-apache'
  include_recipe 'osl-repos::epel'

  package 'redis'

  service 'redis' do
    action [:enable, :start]
  end

  apache_app new_resource.server_name do
    # name new_resource.server_name
    # directory '/opt/nextcloud'
    directory_options %w(FollowSymLinks MultiViews)
    allow_override 'All'
    # Require all granted
    #     <IfModule mod_dav.c>
    #       Dav off
    #     </IfModule>
  end

  # Extract the archive
  ark 'nextcloud' do
    url "https://download.nextcloud.com/server/releases/nextcloud-#{new_resource.version}.tar.bz2"
    path '/var/www/html/'
    strip_components 1 # Can't escape /var/www/html/nextcloud/nextcloud
    action :put
  end

  directory '/var/www/html/nextcloud/' do
    owner 'apache'
    group 'apache'
  end

  directory '/var/www/html/nextcloud/data' do
    owner 'apache'
    group 'apache'
  end

  directory '/etc/httpd/conf.d' do
    owner 'apache'
    group 'apache'
  end

  service 'httpd' do
    action :restart
  end
end
