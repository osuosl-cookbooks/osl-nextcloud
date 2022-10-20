provides :osl_nextcloud
unified_mode true

property :server_name, String
property :database_host, String, sensitive: true, required: true
property :database_name, String, required: true
property :database_user, String, sensitive: true, required: true
property :database_password, String, sensitive: true, required: true
property :nextcloud_user, String, sensitive: true, required: true
property :nextcloud_password, String, sensitive: true, required: true
property :trusted_domains, Array, default: ['localhost']

default_action :create

action :create do
  node.default['php']['version'] = '8.0'
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
  node.default['php']['fpm_package'] = 'php80u-fpm'
  node.default['apache']['mod_fastcgi']['package'] = 'mod_fcgid'
  node.default['osl-apache']['behind_loadbalancer'] = true

  ::Chef::Resource.include Apache2::Cookbook::Helpers

  include_recipe 'osl-apache'
  include_recipe 'osl-apache::mod_php'
  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-repos::epel'

  dnf_module 'nextcloud:23'

  package %w( nextcloud redis )

  directory '/etc/httpd/nextcloud' do
    owner 'apache'
  end

  %w(
    nextcloud-access.conf.avail
    nextcloud-auth-any.inc
    nextcloud-auth-local.inc
    nextcloud-auth-none.inc
    nextcloud-defaults.inc
  ).each do |f|
    cookbook_file "/etc/httpd/nextcloud/#{f}" do
      cookbook 'osl-nextcloud'
    end
  end

  apache_app new_resource.server_name do
    directory '/usr/share/nextcloud'
    allow_override 'All'
    cookbook_include 'osl-nextcloud'
    include_config true
    include_name 'nextcloud'
  end

  file '/usr/share/nextcloud/config/CAN_INSTALL' do
    owner 'apache'
  end

  service 'redis' do
    action [:enable, :start]
  end

  execute 'chown-apache' do
    command 'chown -R apache:apache /usr/share/nextcloud/'
    user 'root'
  end

  execute 'chown-etc/nextcloud' do
    command 'chown -R apache:apache /etc/nextcloud/*'
    user 'root'
  end

  execute 'occ-nextcloud' do
    cwd '/usr/share/nextcloud/'
    user 'apache'
    group 'apache'
    command "php occ maintenance:install --database 'mysql' \
    --database-name #{new_resource.database_name} \
    --database-user #{new_resource.database_user} \
    --database-pass #{new_resource.database_password} \
    --admin-user #{new_resource.nextcloud_user} \
    --admin-pass #{new_resource.nextcloud_password}"
    sensitive true
    creates '/usr/share/nextcloud/data'
  end

  new_resource.trusted_domains.each do |host|
    execute 'trusted-domains' do
      cwd '/usr/share/nextcloud/'
      user 'apache'
      command "php occ config:system:set trusted_domains \
      #{new_resource.trusted_domains.find_index(host)} --value=#{host}"
    end
  end
end
