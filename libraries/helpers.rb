module OSLNextcloud
  module Cookbook
    module Helpers
      require 'json'
      require 'net/http'
      require 'open-uri'
      require 'uri'

      def osl_redis_pkg
        (platform_family?('rhel') && node['platform_version'].to_i >= 10) ? 'valkey' : 'redis'
      end

      # Path to the redis/valkey config file, which moved between EL releases:
      #   EL8 redis  -> /etc/redis.conf
      #   EL9 redis  -> /etc/redis/redis.conf
      #   EL10 valkey -> /etc/valkey/valkey.conf
      def osl_redis_conf
        case node['platform_version'].to_i
        when 8
          '/etc/redis.conf'
        when 9
          '/etc/redis/redis.conf'
        else
          '/etc/valkey/valkey.conf'
        end
      end

      # Get latest version of nextcloud from Github
      def osl_nextcloud_latest_version(version)
        releases = []
        uri = URI('https://api.github.com/repos/nextcloud/server/releases')
        response = JSON.parse(Net::HTTP.get(uri))
        response.each do |rel|
          # Match version given and exclude all release candidate and beta releases
          if rel['name'].match?(/^v#{version}/) && !rel['name'].match?(/rc|beta/)
            # Remove leading 'v' from name
            releases << rel['name'][1..-1]
          end
        end
        # First one should be latest
        releases.first
      end

      # Get sha256sum from nextcloud website
      def osl_nextcloud_checksum(version)
        download_url = 'https://download.nextcloud.com/server/releases'
        begin
          checksums = URI.open("#{download_url}/nextcloud-#{version}.tar.bz2.sha256")
          checksums.grep(/nextcloud-#{version}/).first.split.first
        rescue OpenURI::HTTPError => e
          Chef::Log.warn("Error getting checksum for nextcloud-#{version}: #{e}")
          nil
        end
      end

      def osl_nextcloud_scheme
        if kitchen?
          'http'
        else
          'https'
        end
      end

      # Return true if Nextcloud has not yet been installed
      def can_install?
        cmd = shell_out(
          'php occ | grep maintenance:install',
          cwd: "/var/www/#{new_resource.server_name}/nextcloud",
          user: 'apache',
          group: 'apache'
        )
        return true if cmd.exitstatus == 0
        false
      end

      # Return parsed output of current Nextcloud configuration
      # --no-warnings suppresses Symfony Console pre-command banners (e.g. app/upgrade
      # notices) that would otherwise prepend non-JSON text and break JSON.parse.
      def osl_nextcloud_config
        cmd = shell_out(
          'php occ --no-warnings config:list --private',
          cwd: "/var/www/#{new_resource.server_name}/nextcloud",
          user: 'apache',
          group: 'apache'
        )
        if cmd.exitstatus != 0
          Chef::Log.fatal('Failed executing: php occ config:list')
          Chef::Log.fatal(cmd.stderr)
        end
        JSON.parse(cmd.stdout)
      end

      # Return parsed output of current Nextcloud apps
      def osl_nextcloud_apps
        cmd = shell_out(
          'php occ --no-warnings app:list --output json',
          cwd: "/var/www/#{new_resource.server_name}/nextcloud",
          user: 'apache',
          group: 'apache'
        )
        if cmd.exitstatus != 0
          Chef::Log.fatal('Failed executing: php occ app:list')
          Chef::Log.fatal(cmd.stderr)
        end
        JSON.parse(cmd.stdout)
      end

      # changed pecl-imagick to imagick
      def osl_nextcloud_php_packages
        if node['platform_version'].to_i >= 9
          %w(
            bcmath
            gd
            gmp
            intl
            mbstring
            mysqlnd
            opcache
            pecl-apcu
            imagick
            pecl-redis6
            zip
          )
        else
          %w(
            bcmath
            gd
            gmp
            intl
            mbstring
            mysqlnd
            opcache
            pecl-apcu
            pecl-imagick-im7
            pecl-redis6
            zip
          )
        end
      end

      # Deployed code version from version.php ($OC_Version) as a dotted string, or nil if
      # not extracted yet. Used to stamp the bootstrapped config.php's 'version'.
      def nextcloud_installed_version(webroot)
        version_php = ::File.join(webroot, 'version.php')
        return unless ::File.exist?(version_php)
        match = ::File.read(version_php).match(/\$OC_Version\s*=\s*array\s*\(([0-9,\s]+)\)/)
        return unless match
        match[1].split(',').map(&:strip).reject(&:empty?).join('.')
      end

      # Version currently recorded in the live config.php, or nil. Compared with the code
      # version to decide whether occ upgrade still needs to run.
      def nextcloud_config_version(webroot)
        config = ::File.join(webroot, 'config', 'config.php')
        return unless ::File.exist?(config)
        match = ::File.read(config).match(/'version'\s*=>\s*'([0-9.]+)'/)
        match && match[1]
      end

      def theming_directory(data_dir)
        if Dir.exist?(data_dir)
          Dir.entries(data_dir).sort.each do |entry|
            next unless entry.start_with?('appdata_')
            appdata_dir = File.join(data_dir, entry)
            return appdata_dir
          end
        end
        nil
      end

      def theming_global_directory(data_dir)
        appdata = theming_directory(data_dir)
        return unless appdata
        ::File.join(appdata, 'theming', 'global')
      end
    end
  end
end
Chef::DSL::Recipe.include ::OSLNextcloud::Cookbook::Helpers
Chef::Resource.include ::OSLNextcloud::Cookbook::Helpers
