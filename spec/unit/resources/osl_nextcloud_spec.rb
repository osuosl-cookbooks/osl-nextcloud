require 'spec_helper'

describe 'nextcloud-test::default' do
  ALL_PLATFORMS.each do |platform|
    context "on platform #{platform[:platform]} #{platform[:version]}" do
      let(:runner) do
        ChefSpec::SoloRunner.new(
          platform.dup.merge(step_into: ['osl_nextcloud'])
        )
      end

      nc_version = '30.0.0'
      nc_checksum = '2d49d297dc340092021057823e8e78a312bc00f56de7d8677ac790590918ab17'
      nc = '/var/www/nextcloud.example.com'
      nc_d = "#{nc}/data"
      nc_wr = "#{nc}/nextcloud"
      nc_v = "#{nc}/nextcloud-#{nc_version}"
      github_releases = [{ name: 'v30.0.0' }, { name: 'v29.0.0' }, { name: 'v28.0.0' }]

      occ_config =
        '{
          "system": {
            "default_phone_region": "us",
            "installed": true,
            "memcache.distributed": "\\\OC\\\Memcache\\\Redis",
            "memcache.local": "\\\OC\\\Memcache\\\APCu",
            "mail_smtpmode": "smtp",
            "mail_sendmailmode": "smtp",
            "mail_smtphost": "smtp.osuosl.org",
            "mail_from_address": "noreply",
            "mail_domain": "example.com",
            "trusted_domains": [ "localhost", "nextcloud.example.com" ],
            "redis": {
                "host": "127.0.0.1",
                "port": "6379"
              }
            }
          }'
      occ_config = JSON.parse(occ_config)
      occ_apps_not_installed =
        '{
          "enabled": {
            "text": "1.0.0",
            "weather_status": "1.0.0"
          },
          "disabled": {
            "user_ldap": "1.0.0"
          }
        }'
      occ_apps_installed =
        '{
          "enabled": {
            "text": "1.0.0",
            "forms": "1.0.0"
          },
          "disabled": {
            "user_ldap": "1.0.0",
            "weather_status": "1.0.0"
          }
        }'

      context 'nextcloud not installed' do
        before do
          stubs_for_provider('osl_nextcloud[nextcloud.example.com]') do |provider|
            allow(provider).to receive_shell_out(
              'php occ config:list --private',
              {
                cwd: '/var/www/nextcloud.example.com/nextcloud',
                user: 'apache',
                group: 'apache',
              }
            ).and_return(
              double(stdout: '{"system": {"trusted_domains": ["localhost"]}}', exitstatus: 0)
            )
            allow(provider).to receive_shell_out(
              'php occ app:list --output json',
              {
                cwd: '/var/www/nextcloud.example.com/nextcloud',
                user: 'apache',
                group: 'apache',
              }
            ).and_return(
              double(stdout: occ_apps_not_installed, exitstatus: 0)
            )
          end

          stubs_for_resource('execute[install-nextcloud]') do |resource|
            allow(resource).to receive_shell_out(
              'php occ | grep maintenance:install',
              {
                cwd: '/var/www/nextcloud.example.com/nextcloud',
                user: 'apache',
                group: 'apache',
              }
            ).and_return(
              double(exitstatus: 0)
            )
          end

          content = StringIO.new "#{nc_checksum}  nextcloud-#{nc_version}.tar.bz2"
          allow(URI).to receive(:open).and_return(content)
          allow(Net::HTTP).to receive(:get).and_return(github_releases.to_json)
        end

        let(:node) { runner.node }
        cached(:chef_run) { runner.converge(described_recipe) }

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end

        describe 'included recipes' do
          %w(
            osl-apache
            osl-apache::mod_remoteip
            osl-repos::epel
            osl-selinux
          ).each do |r|
            it do
              is_expected.to include_recipe(r)
            end
          end
        end

        it do
          is_expected.to install_osl_php_install('osl-nextcloud').with(
            version: '8.3',
            php_packages: %w(
              bcmath
              gd
              gmp
              intl
              json
              ldap
              mbstring
              mysqlnd
              opcache
              pecl-apcu
              pecl-imagick
              pecl-redis6
              zip
            )
          )
        end

        %w(proxy proxy_fcgi).each do |m|
          it { is_expected.to enable_apache2_module m }
          it { expect(chef_run.apache2_module(m)).to notify('apache2_service[osuosl]').to(:reload) }
        end

        it do
          is_expected.to add_osl_php_ini('nextcloud').with(
            options: {
              'apc.enable_cli' => '1',
              'memory_limit' => '512M',
              'output_buffering' => false,
              'post_max_size' => '1G',
              'upload_max_filesize' => '1G',
            }
          )
        end

        it do
          is_expected.to install_php_fpm_pool('nextcloud').with(
            listen: '/var/run/nextcloud-fpm.sock',
            max_children: 4,
            start_servers: 1,
            min_spare_servers: 1,
            max_spare_servers: 3
          )
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_d}(/.*)?").with(secontext: 'httpd_sys_rw_content_t')
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_v}/config(/.*)?").with(secontext: 'httpd_sys_rw_content_t')
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_v}/apps(/.*)?").with(secontext: 'httpd_sys_rw_content_t')
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_v}/.htaccess").with(secontext: 'httpd_sys_rw_content_t')
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_v}/.user.ini").with(secontext: 'httpd_sys_rw_content_t')
        end

        it do
          is_expected.to manage_selinux_fcontext("#{nc_v}/3rdparty/aws/aws-sdk-php/src/data/logs(/.*)?").with(
            secontext: 'httpd_sys_rw_content_t'
          )
        end

        [
          "#{nc_d}(/.*)?",
          "#{nc_v}/config(/.*)?",
          "#{nc_v}/apps(/.*)?",
          "#{nc_v}/.htaccess",
          "#{nc_v}/.user.ini",
          "#{nc_v}/3rdparty/aws/aws-sdk-php/src/data/logs(/.*)?",
        ].each do |f|
          it { expect(chef_run.selinux_fcontext(f)).to notify('execute[nextcloud: restorecon]').to(:run) }
        end

        it do
          is_expected.to nothing_execute('nextcloud: restorecon').with(
            command: "restorecon -R #{nc}"
          )
        end

        %w(
          httpd_can_network_connect
          httpd_can_network_connect_db
          httpd_can_network_memcache
          httpd_can_sendmail
          httpd_use_gpg
        ).each do |b|
          it { is_expected.to set_selinux_boolean(b).with(value: 'on') }
        end

        it { is_expected.to create_directory(nc) }
        it { is_expected.to create_directory(nc_d).with(owner: 'apache', group: 'apache') }
        it { is_expected.to install_package(%w(tar bzip2)) }

        it do
          is_expected.to install_ark('nextcloud').with(
            url: "https://download.nextcloud.com/server/releases/nextcloud-#{nc_version}.tar.bz2",
            prefix_root: nc,
            prefix_home: nc,
            checksum: nc_checksum
          )
        end

        it do
          expect(chef_run.ark('nextcloud')).to \
            notify("remote_file[#{nc_wr}/config/config.php]").to(:create).immediately
        end

        it { expect(chef_run.ark('nextcloud')).to notify('execute[fix-nextcloud-owner]').to(:run).immediately }
        it { expect(chef_run.ark('nextcloud')).to notify('execute[disable-nextcloud-crontab]').to(:run).immediately }
        it { expect(chef_run.ark('nextcloud')).to notify('execute[systemctl restart php-fpm]').to(:run).immediately }
        it { expect(chef_run.ark('nextcloud')).to notify('execute[upgrade-nextcloud]').to(:run).immediately }

        it do
          is_expected.to nothing_remote_file("#{nc_wr}/config/config.php").with(
            owner: 'apache',
            group: 'apache',
            mode: '0640',
            source: "file://#{nc}/config.php",
            sensitive: true
          )
        end

        it do
          is_expected.to nothing_execute('fix-nextcloud-owner').with(
            command: "chown -R apache:apache #{nc_wr}/{apps,config}"
          )
        end

        it { is_expected.to install_package('redis') }
        it { is_expected.to enable_service('redis') }
        it { is_expected.to start_service('redis') }

        it do
          is_expected.to create_apache_app('nextcloud.example.com').with(
            directory: nc_wr,
            allow_override: 'All',
            directory_options: %w(FollowSymLinks MultiViews),
            directive_http: [
              '<FilesMatch "\.(php|phar)$">',
              '  SetHandler "proxy:unix:/var/run/nextcloud-fpm.sock|fcgi://localhost/"',
              '</FilesMatch>',
            ]
          )
        end

        it do
          is_expected.to run_execute('install-nextcloud').with(
            cwd: nc_wr,
            user: 'apache',
            group: 'apache',
            command: "php occ maintenance:install --database 'mysql'   --database-host localhost   --database-name nextcloud   --database-user nextcloud   --database-pass nextcloud   --admin-user admin   --admin-pass unguessable   --data-dir /var/www/nextcloud.example.com/data\n",
            live_stream: true,
            sensitive: true
          )
        end

        it { is_expected.to nothing_execute('disable-nextcloud-crontab').with(command: 'crontab -u apache -r') }
        it { is_expected.to nothing_execute 'systemctl restart php-fpm' }

        it do
          is_expected.to nothing_execute('upgrade-nextcloud').with(
            cwd: nc_wr,
            user: 'apache',
            group: 'apache',
            command: "php occ maintenance:mode --on\nphp occ upgrade\nphp occ maintenance:mode --off\nphp occ db:add-missing-columns\nphp occ db:add-missing-indices\nphp occ db:add-missing-primary-keys\nphp occ maintenance:repair --include-expensive\n",
            live_stream: true
          )
        end

        it do
          is_expected.to_not run_execute('nextcloud-config: trusted-domains-localhost')
        end

        it do
          is_expected.to run_execute('nextcloud-config: trusted-domains-nextcloud.example.com').with(
            cwd: nc_wr,
            user: 'apache',
            command: 'php occ config:system:set trusted_domains 1 --value=nextcloud.example.com'
          )
        end

        it do
          is_expected.to run_execute('nextcloud-config: memcache').with(
            cwd: nc_wr,
            user: 'apache',
            command: 'php occ config:system:set memcache.distributed --value="\OC\Memcache\Redis" && php occ config:system:set memcache.local --value="\OC\Memcache\APCu"'
          )
        end

        it do
          is_expected.to run_execute('nextcloud-config: redis').with(
            cwd: nc_wr,
            user: 'apache',
            command: "php occ config:system:set redis host --value=127.0.0.1\nphp occ config:system:set redis port --value=6379\n"
          )
        end

        it do
          is_expected.to run_execute('nextcloud-config: mail').with(
            cwd: nc_wr,
            user: 'apache',
            command: "php occ config:system:set mail_smtpmode --value=smtp\nphp occ config:system:set mail_sendmailmode --value=smtp\nphp occ config:system:set mail_smtphost --value=smtp.osuosl.org\nphp occ config:system:set mail_from_address --value=noreply\nphp occ config:system:set mail_domain --value=example.com\n"
          )
        end

        it do
          is_expected.to run_execute('nextcloud-config: phone_region').with(
            cwd: nc_wr,
            user: 'apache',
            command: "php occ config:system:set default_phone_region --value=us\n"
          )
        end

        it do
          is_expected.to create_cron('nextcloud').with(
            command: '/usr/bin/php -f /var/www/nextcloud.example.com/nextcloud/cron.php',
            user: 'apache',
            minute: '*/5'
          )
        end

        it do
          is_expected.to run_execute('nextcloud-app: install and enable forms').with(
            cwd: nc_wr,
            user: 'apache',
            command: "php occ app:install -n forms\nphp occ app:enable -n forms\n"
          )
        end

        it do
          is_expected.to run_execute('nextcloud-app: disable weather_status').with(
            cwd: nc_wr,
            user: 'apache',
            command: "php occ app:disable -n weather_status\n"
          )
        end

        it do
          is_expected.to_not create_remote_file("#{nc}/config.php").with(
            owner: 'apache',
            group: 'apache',
            mode: '0640',
            source: "file://#{nc_wr}/config/config.php",
            sensitive: true
          )
        end
      end

      context 'nextcloud installed' do
        before do
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:can_install?).and_return(false)
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:osl_nextcloud_config).and_return(occ_config)
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to \
            receive(:osl_nextcloud_apps).and_return(JSON.parse(occ_apps_installed))
          content = StringIO.new "#{nc_checksum}  nextcloud-#{nc_version}.tar.bz2"
          allow(URI).to receive(:open).and_return(content)
          allow(Net::HTTP).to receive(:get).and_return(github_releases.to_json)
        end

        let(:node) { runner.node }
        cached(:chef_run) { runner.converge(described_recipe) }

        it { is_expected.to_not run_execute('install-nextcloud') }
        it { is_expected.to_not run_execute('upgrade-nextcloud') }
        it { is_expected.to_not run_execute('trusted-domains-localhost') }
        it { is_expected.to_not run_execute('trusted-domains-nextcloud.example.com') }
        it { is_expected.to_not run_execute('nextcloud-config: memcache') }
        it { is_expected.to_not run_execute('nextcloud-config: redis') }
        it { is_expected.to_not run_execute('nextcloud-config: mail') }
        it { is_expected.to_not run_execute('nextcloud-config: phone_region') }
        it { is_expected.to_not run_execute('nextcloud-app: install and enable forms') }
        it { is_expected.to_not run_execute('nextcloud-app: disable weather_status') }
        it { is_expected.to create_remote_file("#{nc}/config.php") }
      end
    end
  end
end
