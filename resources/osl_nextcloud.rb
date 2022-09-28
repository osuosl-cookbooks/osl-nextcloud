provides :osl_nextcloud
unified_mode true

property :server_name, String, default: 'nextcloud' # (also name property)
property :version, String, default: '23.0.7'
property :checksum, String, default: '320c81f9b902922b4bcef3eacf858596a14347fd45bddd26dac198562d212439' # (256sum of tarball): default latest version's checksum)
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

  # node.default['osl-php']['php_packages'] = %w(
  #   gd
  #   intl
  #   json
  #   mbstring
  #   mysqlnd
  #   opcache
  #   pecl-apcu
  #   pecl-imagick
  #   zip
  # )
  node.default['php']['fpm_package'] = 'php80u-fpm'
  node.default['apache']['mod_fastcgi']['package'] = 'mod_fcgid'
  node.default['osl-apache']['behind_loadbalancer'] = true

  ::Chef::Resource.include Apache2::Cookbook::Helpers

  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-apache'
  include_recipe 'osl-apache::mod_php'
  include_recipe 'osl-repos::epel'

  dnf_module 'nextcloud:23'

  package %w( nextcloud nextcloud-httpd )

  package 'redis'

  %w( redis ).each do |s|
    service s do
      action [:enable, :start]
    end
  end

  #  link '/etc/httpd/conf.d/nextcloud-access.conf.avail' do
  #     to '/etc/httpd/conf.d/z-nextcloud-access.conf'
  #  end

  apache_app new_resource.server_name do
    directory_options %w(FollowSymLinks MultiViews)
    directory '/etc/nextcloud'
    allow_override 'All'
  end

  #  ark 'nextcloud' do
  #    url "https://download.nextcloud.com/server/releases/nextcloud-#{new_resource.version}.tar.bz2"
  #    path '/var/www/html/'
  #    strip_components 1
  #    action :put
  #    owner 'apache'
  #    group 'apache'
  #    creates '/var/www/html/nextcloud'
  #  end
  #
  #  execute 'chown-apache' do
  #    command 'chown -R apache:apache /var/www/html/nextcloud'
  #    user 'root'
  #  end
  #
  #  execute 'occ-nextcloud' do
  #    cwd '/var/www/html/nextcloud/'
  #    user 'apache'
  #    command "php occ maintenance:install --database 'mysql' \
  #    --database-name #{new_resource.database_name} \
  #    --database-user #{new_resource.database_user} \
  #    --database-pass #{new_resource.database_password} \
  #    --admin-user #{new_resource.nextcloud_user} \
  #    --admin-pass #{new_resource.nextcloud_password}"
  #    sensitive true
  #    only_if { ::File.exist?('/var/www/html/nextcloud/config/CAN_INSTALL') }
  #  end
  #
  #  new_resource.trusted_domains.each do |host|
  #    execute 'trusted-domains' do
  #      cwd '/var/www/html/nextcloud/'
  #      user 'apache'
  #      command "php occ config:system:set trusted_domains \
  #      #{new_resource.trusted_domains.find_index(host)} --value=#{host}"
  #    end
  #  end
  #
  #  directory '/etc/httpd/conf.d' do
  #    owner 'apache'
  #    group 'apache'
  #  end

end
