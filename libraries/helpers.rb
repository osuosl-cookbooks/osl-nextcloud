module OSLNextcloud
  module Cookbook
    module Helpers
      require 'json'
      require 'net/http'
      require 'open-uri'
      require 'uri'

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
        releases[0]
      end

      # Get sha256sum from nextcloud website
      def osl_nextcloud_checksum(version)
        download_url = 'https://download.nextcloud.com/server/releases'
        begin
          checksums = URI.open("#{download_url}/nextcloud-#{version}.tar.bz2.sha256")
          checksums.grep(/nextcloud-#{version}/)[0].split.first
        rescue OpenURI::HTTPError => e
          Chef::Log.warn("Error getting checksum for nextcloud-#{version}: #{e}")
          nil
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
      def osl_nextcloud_config
        cmd = shell_out(
          'php occ config:list --private',
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
          'php occ app:list --output json',
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
            json
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
            json
            mbstring
            mysqlnd
            opcache
            pecl-apcu
            pecl-imagick
            pecl-redis6
            zip
          )
        end
      end
    end
  end
end
Chef::DSL::Recipe.include ::OSLNextcloud::Cookbook::Helpers
Chef::Resource.include ::OSLNextcloud::Cookbook::Helpers
