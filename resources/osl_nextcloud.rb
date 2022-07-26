# proj-snowdrift civicrbm
# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
resource_name :nextcloud
provides :nextcloud
unified_mode true

default_action :create

action :create do
  ::Chef::Resource.include Apache2::Cookbook::Helpers
  include_recipe 'ark'
  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-apache'
  # include_recipe 'osl-apache::mod_php'

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

  package %w(
    bash-completion
    bzip2
    curl
    epel-release
    mariadb
    mariadb-server
    mlocate
    policycoreutils-python-utils
    redis
    unzip
    wget
    yum-utils
  )

  # After you have done this, make sure you create a database with a username
  # and password so that Nextcloud will have access to it. For further details
  # on database setup and configuration, see the Database configuration
  # documentation.
  # https://docs.nextcloud.com/server/latest/admin_manual/configuration_database/linux_database_configuration.html
  service %w(mariadb redis) do
    action [:enable, :start]
  end

  # Extract the archive
  ark 'nextcloud' do
    url 'https://download.nextcloud.com/server/releases/latest.tar.bz2'
    path '/var/www/html'
    strip_components 0
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


  # Want to make ${:serverName} work
  file '/etc/httpd/conf.d/nextcloud.conf' do
    content <<~EOS
    <VirtualHost *:80>
      DocumentRoot /var/www/html/nextcloud/
      ServerName  ${:serverName}

      <Directory /var/www/html/nextcloud/>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews

        <IfModule mod_dav.c>
          Dav off
        </IfModule>

      </Directory>
    </VirtualHost>
    EOS
  end

  apache_app '${serverName}' do
    name :serverName
    directory '/var/www/html/nextcloud'
  end
end

action :delete do
end
