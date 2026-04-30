provides :osl_nextcloud
unified_mode true

property :version, String, default: '32'
property :checksum, String
property :apps, Array, default: []
property :apps_disable, Array, default: []
property :database_host, String, sensitive: true, required: true
property :database_name, String, required: true
property :database_password, String, sensitive: true, required: true
property :database_user, String, sensitive: true, required: true
property :extra_config, Hash, default: {}
property :nextcloud_admin_password, String, sensitive: true, required: true
property :nextcloud_admin_user, String, default: 'admin'
property :mail_smtphost, String, default: 'smtp.osuosl.org'
property :mail_from_address, String, default: 'noreply'
property :mail_domain, String, required: true
property :maintenance_window_start, Integer, default: 1
property :php_packages, Array, default: []
property :server_name, String, name_property: true
property :sensitive, [true, false], default: true
property :server_aliases, Array, default: %w(localhost)
property :max_filesize, String, default: '1G'

default_action :create

action :create do
  node.default['osl-apache']['mpm'] = 'event'
  node.default['osl-apache']['behind_loadbalancer'] = true

  include_recipe 'osl-selinux'
  include_recipe 'osl-apache'
  include_recipe 'osl-apache::mod_remoteip'
  include_recipe 'osl-repos::epel'

  osl_php_install 'osl-nextcloud' do
    version '8.3'
    use_opcache true
    opcache_conf('opcache.interned_strings_buffer' => 16)
    php_packages (osl_nextcloud_php_packages << new_resource.php_packages).flatten.sort
    notifies :reload, 'service[php-fpm]'
  end

  %w(proxy proxy_fcgi).each do |m|
    apache2_module m do
      notifies :reload, 'apache2_service[osuosl]'
    end
  end

  osl_php_ini 'nextcloud' do
    options(
      'apc.enable_cli' => '1',
      'memory_limit' => '512M',
      'output_buffering' => false,
      'post_max_size' => new_resource.max_filesize,
      'upload_max_filesize' => new_resource.max_filesize
    )
    notifies :reload, 'service[php-fpm]'
  end

  # Current size is 52MB
  fpm_settings = osl_php_fpm_settings(52)

  php_fpm_pool 'nextcloud' do
    listen '/var/run/nextcloud-fpm.sock'
    max_children fpm_settings['max_children']
    start_servers fpm_settings['start_servers']
    min_spare_servers fpm_settings['min_spare_servers']
    max_spare_servers fpm_settings['max_spare_servers']
  end

  # Register service for reloads
  service 'php-fpm' do
    action :nothing
  end

  nextcloud_version = osl_nextcloud_latest_version(new_resource.version)
  nextcloud_dir = "/var/www/#{new_resource.server_name}"
  nextcloud_webroot = "#{nextcloud_dir}/nextcloud"
  nextcloud_webroot_versioned = "#{nextcloud_dir}/nextcloud-#{nextcloud_version}"
  nextcloud_data = "#{nextcloud_dir}/data"
  download_successful = true

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

  selinux_fcontext "#{nextcloud_dir}/custom_apps(/.*)?" do
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
  end unless docker?

  directory nextcloud_dir

  directory nextcloud_data do
    owner 'apache'
    group 'apache'
  end

  directory "#{nextcloud_dir}/custom_apps" do
    owner 'apache'
    group 'apache'
  end

  package %w(tar bzip2)

  ruby_block 'ark_notifies' do
    block do
      Chef::Log.info('Notifying other resources from ark[nextcloud]')
    end
    notifies :create, "remote_file[#{nextcloud_webroot}/config/config.php]", :immediately
    notifies :run, 'execute[fix-nextcloud-owner]', :immediately
    notifies :run, 'execute[disable-nextcloud-crontab]', :immediately
    notifies :run, 'execute[systemctl restart php-fpm]', :immediately
    notifies :create, "link[#{nextcloud_webroot_versioned}/custom_apps]", :immediately
    notifies :create, "file[#{nextcloud_webroot}/config/apps_paths.config.php]", :immediately
    notifies :run, 'execute[upgrade-nextcloud]', :immediately
    action :nothing
    only_if { download_successful }
  end

  begin
    ark 'nextcloud' do
      url "https://download.nextcloud.com/server/releases/nextcloud-#{nextcloud_version}.tar.bz2"
      prefix_root nextcloud_dir
      prefix_home nextcloud_dir
      version nextcloud_version
      checksum new_resource.checksum || osl_nextcloud_checksum(nextcloud_version)
      notifies :run, 'ruby_block[ark_notifies]', :immediately
    end
  rescue
    Chef::Log.warn("Error downloading nextcloud-#{nextcloud_version} tarball, skipping remaining steps")
    download_successful = false
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
    command "chown -R apache:apache #{nextcloud_dir}/custom_apps #{nextcloud_webroot}/{apps,config}"
    action :nothing
  end

  # Symlink the persistent custom_apps dir into the versioned Nextcloud directory so
  # Apache can serve app assets and occ sees both app paths on every version.
  link "#{nextcloud_webroot_versioned}/custom_apps" do
    to "#{nextcloud_dir}/custom_apps"
    only_if { ::Dir.exist?(nextcloud_webroot_versioned) }
  end

  # Write apps_paths as a standalone config file rather than via `occ config:system:set
  # apps_paths 0 path` etc. The positional-key form leaves apps_paths in an invalid
  # intermediate state between calls (only `path` set, no `url`/`writable`), which makes
  # Nextcloud print "apps directory not found!" on stdout and silently break every
  # subsequent occ command. Nextcloud loads all *.config.php files in config/ and merges
  # them via array_replace_recursive, so a complete config here is applied atomically.
  file "#{nextcloud_webroot}/config/apps_paths.config.php" do
    owner 'apache'
    group 'apache'
    mode '0640'
    content <<~PHP
      <?php
      $CONFIG = array (
        'apps_paths' =>
        array (
          0 =>
          array (
            'path' => '#{nextcloud_webroot}/apps',
            'url' => '/apps',
            'writable' => false,
          ),
          1 =>
          array (
            'path' => '#{nextcloud_dir}/custom_apps',
            'url' => '/custom_apps',
            'writable' => true,
          ),
        ),
      );
    PHP
    only_if { ::Dir.exist?("#{nextcloud_webroot}/config") }
  end

  package osl_redis_pkg

  service osl_redis_pkg do
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
      '<IfModule mod_headers.c>',
      '  Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"',
      '</IfModule>',
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
        --database-host #{new_resource.database_host} \
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
    only_if { download_successful }
  end

  # Call this once
  if download_successful
    nc_config = osl_nextcloud_config
    nc_apps = osl_nextcloud_apps

    nc_installed = nc_config['system']['installed']
    cur_trusted_domains = nc_config['system']['trusted_domains']
    new_trusted_domains = [new_resource.server_name, new_resource.server_aliases].flatten!.sort.uniq
  end

  # Disable crontab entry while doing an upgrade
  execute 'disable-nextcloud-crontab' do
    command 'crontab -u apache -r'
    action :nothing
    only_if { download_successful }
    only_if { nc_installed == true && ::File.exist?('/var/spool/cron/apache') }
  end

  execute 'systemctl restart php-fpm' do
    action :nothing
    only_if { download_successful }
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
      php occ maintenance:repair --include-expensive
    EOC
    live_stream true
    action :nothing
    only_if { download_successful }
    only_if { nc_installed == true }
  end

  new_trusted_domains.each do |domain|
    execute "nextcloud-config: trusted-domains-#{domain}" do
      cwd nextcloud_webroot
      user 'apache'
      command "php occ config:system:set trusted_domains #{new_trusted_domains.find_index(domain)} --value=#{domain}"
      not_if { cur_trusted_domains.include?(domain) }
    end
  end if download_successful

  execute 'nextcloud-config: memcache' do
    cwd nextcloud_webroot
    user 'apache'
    command 'php occ config:system:set memcache.distributed --value="\OC\Memcache\Redis" && php occ config:system:set memcache.local --value="\OC\Memcache\APCu"'
    not_if do
      nc_config['system']['memcache.distributed'] == '\OC\Memcache\Redis' && \
        nc_config['system']['memcache.local'] == '\OC\Memcache\APCu'
    end
  end if download_successful

  execute 'nextcloud-config: redis' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set redis host --value=127.0.0.1
      php occ config:system:set redis port --value=6379
    EOC
    not_if { nc_config['system']['redis'] == { 'host' => '127.0.0.1', 'port' => '6379' } }
  end if download_successful

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
  end if download_successful

  execute 'nextcloud-config: phone_region' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set default_phone_region --value=us
    EOC
    not_if { nc_config['system']['default_phone_region'] == 'us' }
  end if download_successful

  new_resource.extra_config.each do |key, value|
    execute "nextcloud-config: #{key}" do
      cwd nextcloud_webroot
      user 'apache'
      command <<~EOC
        php occ config:system:set #{key} --value=#{value}
      EOC
      not_if { nc_config['system'][key] == value }
    end if download_successful
  end

  # This fixes the url in activity notifications; see Issue #24.
  execute 'nextcloud-config: overwrite.cli.url' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set overwrite.cli.url --value=#{osl_nextcloud_scheme}://#{new_resource.server_name}
    EOC
    not_if { nc_config['system']['overwrite.cli.url'] == "#{osl_nextcloud_scheme}://#{new_resource.server_name}" }
  end if download_successful

  execute 'nextcloud-config: maintenance_window_start' do
    cwd nextcloud_webroot
    user 'apache'
    command <<~EOC
      php occ config:system:set maintenance_window_start --type=integer --value=#{new_resource.maintenance_window_start}
    EOC
    not_if { nc_config['system']['maintenance_window_start'] == new_resource.maintenance_window_start }
  end if download_successful

  # One-time migration: move any user-installed (non-shipped) apps out of the versioned
  # apps/ directory into the persistent custom_apps/ directory so future upgrades don't
  # blow them away. Shipped apps (bundled in the tarball) are identified by
  # <shipped>true</shipped> in their appinfo/info.xml and stay in apps/.
  execute 'nextcloud-migrate-apps-to-custom' do
    cwd nextcloud_webroot
    user 'apache'
    group 'apache'
    command <<~EOC
      for dir in #{nextcloud_webroot}/apps/*/; do
        [ -d "$dir" ] || continue
        app=$(basename "$dir")
        [ -f "$dir/appinfo/info.xml" ] || continue
        grep -q '<shipped>true</shipped>' "$dir/appinfo/info.xml" && continue
        [ -d "#{nextcloud_dir}/custom_apps/$app" ] && continue
        mv "$dir" "#{nextcloud_dir}/custom_apps/$app"
      done
    EOC
    not_if do
      Dir.glob("#{nextcloud_webroot}/apps/*/").none? do |app_dir|
        info_xml = ::File.join(app_dir, 'appinfo', 'info.xml')
        ::File.exist?(info_xml) &&
          !::File.read(info_xml).include?('<shipped>true</shipped>') &&
          !::File.exist?(::File.join("#{nextcloud_dir}/custom_apps", ::File.basename(app_dir.chomp('/'))))
      end
    end
    only_if { nc_installed == true }
  end if download_successful

  new_resource.apps.each do |app|
    execute "nextcloud-app: install and enable #{app}" do
      cwd nextcloud_webroot
      user 'apache'
      command <<~EOC
        php occ app:install -n #{app}
        php occ app:enable -n #{app}
      EOC
      only_if { nc_apps['enabled'][app].nil? }
    end
  end if download_successful

  new_resource.apps_disable.each do |app|
    execute "nextcloud-app: disable #{app}" do
      cwd nextcloud_webroot
      user 'apache'
      command <<~EOC
        php occ app:disable -n #{app}
      EOC
      only_if { nc_apps['disabled'][app].nil? }
    end
  end if download_successful

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
    only_if { download_successful }
    only_if { nc_installed == true }
  end

  directory 'create theming directory' do
    path lazy { theming_global_directory(nextcloud_data) }
    owner 'apache'
    group 'apache'
    recursive true
    only_if { download_successful }
    only_if { theming_global_directory(nextcloud_data) }
  end
end
