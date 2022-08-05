# proj-snowdrift civicrbm
# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
resource_name :osl_nextcloud
provides :osl_nextcloud
unified_mode true


property :server_name # (also name property)
property :version # default (latest version)
property :checksum # (256sum of tarball): default latest version's checksum)
property :database_host # (sensitive): required
property :database_name # :required
property :database_user # (sensitive): required
property :database_password # (sensitive): required

default_action :create

action :create do
  node.default['php']['version'] = '7.4'
  node.default['osl-php']['use_ius'] = true

  node.default['osl-php']['php_packages'] = %w(
    gd
    imagick
    intl
    json
    mbstring
    mysqlnd
    opcache
    pecl-apcu
    redis
    zip
  )
  node.default['php']['fpm_package'] = 'php76u-fpm'
  node.default['apache']['mod_fastcgi']['package'] = 'mod_fcgid'
  node.default['osl-apache']['behind_loadbalancer'] = true

  ::Chef::Resource.include Apache2::Cookbook::Helpers

  include_recipe 'ark'
  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-apache'
  include_recipe 'osl-repos::epel'

  package %w(
    redis
    wget
    yum-utils
  )

  %w(redis).each do |s|
    service s do
      action [:enable, :start]
    end
  end

  # Extract the archive
  ark 'nextcloud' do
    url 'https://download.nextcloud.com/server/releases/nextcloud-23.0.7.tar.bz2'
    path '/opt/nextcloud'
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

  # Want to make ${:serverName} work

  service 'apache2' do
    service_name lazy { apache_platform_service_name }
    supports restart: true, status: true, reload: true, enable: true
    action :nothing
  end

  apache_app '${serverName}' do
    name :serverName
    directory '/opt/nextcloud'
    directory_options 'FollowSymLinks MultiViews'
    allow_override 'All'
    # Require all granted
    #     <IfModule mod_dav.c>
    #       Dav off
    #     </IfModule>
  end
end
