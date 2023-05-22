provides :osl_nextcloud
unified_mode true

property :version, String, default: '26.0.1'
property :checksum, String
property :database_host, String, sensitive: true, required: true
property :database_name, String, required: true
property :database_password, String, sensitive: true, required: true
property :database_user, String, sensitive: true, required: true
property :nextcloud_admin_password, String, sensitive: true, required: true
property :nextcloud_admin_user, String, default: 'admin'
property :mail_smtphost, String, default: 'smtp.osuosl.org'
property :mail_from_address, String, default: 'noreply'
property :mail_domain, String, required: true
property :server_name, String, name_property: true
property :sensitive, [true, false], default: true
property :server_aliases, Array, default: %w(localhost)
property :max_filesize, String, default: '1G'

default_action :create

action :create do
  node.default['php']['version'] = '8.1'
  node.default['osl-php']['php_packages'] = %w(
    bcmath
    gd
    gmp
    intl
    json
    mbstring
    mysqlnd
    opcache
    pecl-apcu
    pecl-imagick
    pecl-redis5
    zip
  )
  node.default['osl-apache']['mpm'] = 'event'
  node.default['osl-apache']['behind_loadbalancer'] = true

  include_recipe 'osl-selinux'
  include_recipe 'osl-apache'
  include_recipe 'osl-apache::mod_remoteip'
  include_recipe 'osl-php'
  include_recipe 'osl-repos::epel'

  %w(proxy proxy_fcgi).each do |m|
    apache2_module m do
      notifies :reload, 'apache2_service[osuosl]'
    end
  end

  php_ini 'nextcloud' do
    options(
      'apc.enable_cli' => '1',
      'memory_limit' => '512M',
      'output_buffering' => false,
      'post_max_size' => new_resource.max_filesize,
      'upload_max_filesize' => new_resource.max_filesize
    )
  end

  php_fpm_pool 'nextcloud' do
    listen '/var/run/nextcloud-fpm.sock'
  end

  nextcloud_dir = "/var/www/#{new_resource.server_name}"
  nextcloud_webroot = "#{nextcloud_dir}/nextcloud"
  nextcloud_webroot_versioned = "#{nextcloud_dir}/nextcloud-#{new_resource.version}"
  nextcloud_data = "#{nextcloud_dir}/data"

  selinux_fcontext "#{nextcloud_data}(/.*)?" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  selinux_fcontext "#{nextcloud_webroot_versioned}/config(/.*)?" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  selinux_fcontext "#{nextcloud_webroot_versioned}/apps(/.*)?" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  selinux_fcontext "#{nextcloud_webroot_versioned}/.htaccess" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  selinux_fcontext "#{nextcloud_webroot_versioned}/.user.ini" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  selinux_fcontext "#{nextcloud_webroot_versioned}/3rdparty/aws/aws-sdk-php/src/data/logs(/.*)?" do
    secontext 'httpd_sys_rw_content_t'
    notifies :run, 'execute[nextcloud: restorecon]'
  end

  execute 'nextcloud: restorecon' do
    command "restorecon -R #{nextcloud_dir}"
    action :nothing
  end

  %w(
    httpd_can_network_connect
    httpd_can_network_connect_db
    httpd_can_network_memcache
    httpd_can_sendmail
    httpd_use_gpg
  ).each do |b|
    selinux_boolean b do
      value true
    end
  end

  directory nextcloud_dir

  directory nextcloud_data do
    owner 'apache'
    group 'apache'
  end

  package %w(tar bzip2)

  ark 'nextcloud' do
    url "https://download.nextcloud.com/server/releases/nextcloud-#{new_resource.version}.tar.bz2"
    prefix_root nextcloud_dir
    prefix_home nextcloud_dir
    version new_resource.version
    checksum new_resource.checksum || osl_nextcloud_checksum(new_resource.version)
    notifies :create, "remote_file[#{nextcloud_webroot}/config/config.php]", :immediately
    notifies :run, 'execute[fix-nextcloud-owner]', :immediately
    notifies :run, 'execute[disable-nextcloud-crontab]', :immediately
    notifies :run, 'execute[upgrade-nextcloud]', :immediately
  end

  # Copy current config (if it exists) to webroot
  # This is primarily needed when upgrading between versions
  remote_file "#{nextcloud_webroot}/config/config.php" do
    owner 'apache'
    group 'apache'
    mode '0640'
    source "file://#{nextcloud_dir}/config.php"
    only_if { ::File.exist?("#{nextcloud_dir}/config.php") }
    sensitive true
    action :nothing
  end

  execute 'fix-nextcloud-owner' do
    command "chown -R apache:apache #{nextcloud_webroot}/{apps,config}"
    action :nothing
  end

  package 'redis'

  service 'redis' do
    action [:enable, :start]
  end

  apache_app new_resource.server_name do
    directory nextcloud_webroot
    allow_override 'All'
    directory_options %w(FollowSymLinks MultiViews)
    directive_http [
      '<FilesMatch "\.(php|phar)$">',
      '  SetHandler "proxy:unix:/var/run/nextcloud-fpm.sock|fcgi://localhost/"',
      '</FilesMatch>',
    ]
    directory_custom_directives [
      'Require all granted',
      '<IfModule mod_dav.c>',
      '  Dav off',
      '</IfModule>',
    ]
  end

  execute 'install-nextcloud' do
    cwd nextcloud_webroot
    user 'apache'
    group 'apache'
    command <<~EOC
      php occ maintenance:install --database 'mysql' \
        --database-name #{new_resource.database_name} \
        --database-user #{new_resource.database_user} \
        --database-pass #{new_resource.database_password} \
        --admin-user #{new_resource.nextcloud_admin_user} \
        --admin-pass #{new_resource.nextcloud_admin_password} \
        --data-dir #{nextcloud_data}
    EOC
    live_stream true
    sensitive new_resource.sensitive
    only_if { can_install? }
  end

  # Call this once
  nc_config = osl_nextcloud_config

  nc_installed = nc_config['system']['installed']
  cur_trusted_domains = nc_config['system']['trusted_domains']
  new_trusted_domains = [new_resource.server_name, new_resource.server_aliases].flatten!.sort.uniq

  # Disable crontab entry while doing an upgrade
  execute 'disable-nextcloud-crontab' do
    command 'crontab -u apache -r'
    action :nothing
    only_if { nc_installed == true && ::File.exist?('/var/spool/cron/apache') }
  end

  # https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html
  execute 'upgrade-nextcloud' do
    cwd nextcloud_webroot
    user 'apache'
    group 'apache'
    command <<~EOC
      php occ maintenance:mode --on
      php occ upgrade
      php occ maintenance:mode --off
      php occ db:add-missing-columns
      php occ db:add-missing-indices
      php occ db:add-missing-primary-keys
    EOC
    live_stream true
    action :nothing
    only_if { nc_installed == true }
  end

  new_trusted_domains.each do |domain|
    execute "nextcloud-config: trusted-domains-#{domain}" do
      cwd nextcloud_webroot
      user 'apache'
      command "php occ config:system:set trusted_domains #{new_resource.server_aliases.find_index(domain)} --value=#{domain}"
      not_if { cur_trusted_domains.include?(domain) }
    end
  end

  execute 'nextcloud-config: memcache' do
    cwd nextcloud_webroot
    user 'apache'
    command 'php occ config:system:set memcache.distributed --value="\OC\Memcache\Redis" && php occ config:system:set memcache.local --value="\OC\Memcache\APCu"'
    not_if do
      nc_config['system']['memcache.distributed'] == '\OC\Memcache\Redis' && \
        nc_config['system']['memcache.local'] == '\OC\Memcache\APCu'
    end
  end

  execute 'nextcloud-config: redis' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set redis host --value=127.0.0.1
      php occ config:system:set redis port --value=6379
    EOC
    not_if { nc_config['system']['redis'] == { 'host' => '127.0.0.1', 'port' => '6379' } }
  end

  execute 'nextcloud-config: mail' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set mail_smtpmode --value=smtp
      php occ config:system:set mail_sendmailmode --value=smtp
      php occ config:system:set mail_smtphost --value=#{new_resource.mail_smtphost}
      php occ config:system:set mail_from_address --value=#{new_resource.mail_from_address}
      php occ config:system:set mail_domain --value=#{new_resource.mail_domain}
    EOC
    not_if do
      nc_config['system']['mail_smtpmode'] == 'smtp' && \
        nc_config['system']['mail_sendmailmode'] == 'smtp' && \
        nc_config['system']['mail_smtphost'] == new_resource.mail_smtphost && \
        nc_config['system']['mail_from_address'] == new_resource.mail_from_address && \
        nc_config['system']['mail_domain'] == new_resource.mail_domain
    end
  end

  execute 'nextcloud-config: phone_region' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set default_phone_region --value=us
    EOC
    not_if { nc_config['system']['default_phone_region'] == 'us' }
  end

  cron 'nextcloud' do
    command "/usr/bin/php -f #{nextcloud_webroot}/cron.php"
    user 'apache'
    minute '*/5'
  end

  # Copy current config to top of webroot. This is used during upgrades
  remote_file "#{nextcloud_dir}/config.php" do
    owner 'apache'
    group 'apache'
    mode '0640'
    source "file://#{nextcloud_webroot}/config/config.php"
    sensitive true
    only_if { nc_installed == true }
  end
end
