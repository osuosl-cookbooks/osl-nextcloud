module OslNextcloud
  module Cookbook
    module Helpers
      require 'json'
      def can_install?
        cmd = shell_out('php occ | grep maintenance:install', cwd: '/usr/share/nextcloud/', user: 'apache', group: 'apache')
        return true if cmd.exitstatus == 0
        return false
      end

      def osl_nextcloud_config
        cmd = shell_out!('php occ config:list', cwd: '/usr/share/nextcloud/', user: 'apache', group: 'apache')
        if cmd.exitstatus != 0
          Chef::Log.fatal('Failed executing: php occ config:list')
          Chef::Log.fatal(cmd.stderr)
        end
        JSON.parse(cmd.stdout)
      end
    end
  end
end
Chef::DSL::Recipe.include ::OslNextcloud::Cookbook::Helpers
Chef::Resource.include ::OslNextcloud::Cookbook::Helpers
