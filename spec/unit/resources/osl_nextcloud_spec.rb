require 'spec_helper'

describe 'nextcloud-test::default' do
  recipe do
    osl_nextcloud 'test' do
      database_host 'localhost'
      database_name 'test-db'
      database_user 'test-user'
      database_password 'test-pass'
      version '23.0.7'
    end
  end

  context 'centos' do
    platform 'centos'
    cached(:chef_run) { runner.converge(described_recipe) }
    step_into 'osl_nextcloud'

    it do
      is_expected.to install_package('redis')
      is_expected.to start_service('redis')
      is_expected.to create_apache_app('test').with(
        directory_options: %w(FollowSymLinks MultiViews),
        allow_override: 'All'
      )

      is_expected.to put_ark('nextcloud').with(
        url: "https://download.nextcloud.com/server/releases/nextcloud-23.0.7.tar.bz2",
        path: '/var/www/html/',
        strip_components: 1 # Can't escape /var/www/html/nextcloud/nextcloud
      )

      is_expected.to create_directory('/var/www/html/nextcloud/').with(
        owner: 'apache',
        group: 'apache'
      )

      is_expected.to create_directory('/var/www/html/nextcloud/data').with(
        owner: 'apache',
        group: 'apache'
      )

      is_expected.to create_directory('/etc/httpd/conf.d').with(
        owner: 'apache',
        group: 'apache'
      )
    end
  end
end
