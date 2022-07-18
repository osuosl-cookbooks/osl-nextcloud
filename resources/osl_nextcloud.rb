# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/
resource_name :nextcloud
provides :nextcloud
unified_mode true

default_action :create

action :create do
  default['php']['version'] = '5.6'
  default['osl-php']['use_ius'] = true
  default['osl-php']['php_packages'] = %w(pecl-memcached pecl-apc mcrypt mysqlnd pdo) # fpm
  default['php']['fpm_package'] = 'php56u-fpm'
  default['apache']['mod_fastcgi']['package'] = 'mod_fcgid'
  default['osl-apache']['behind_loadbalancer'] = true

  include_recipe 'osl-git'
  include_recipe 'osl-php'
  include_recipe 'osl-apache'

  package %w(
    bash-completion
    bzip2
    curl
    epel-release
    mlocate
    policycoreutils-python-utils
    unzip
    wget
    yum-utils
  )

  # Extract the archive
  ark 'nextcloud' do
    url 'https://download.nextcloud.com/server/releases/latest.tar.bz2'
    move to '/var/www/html'
  end
  # then make directory www/html/nextcloud/data
  # chown -R apache:apache /var/www/html/nextcloud
  # proj-lf
  # https://github.com/osuosl-cookbooks/proj-lf/blob/master/recipes/web1.rb

  archive_file 'nextcloud archive' do
    path '/tmp/nextcloud.tar.bz2'
    destination '/var/www'
  end

  # Does the ${:serverName} thing work??
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

  # mod_{rewrite,headers,env,dir,mime}
end
end

action :delete do
end
