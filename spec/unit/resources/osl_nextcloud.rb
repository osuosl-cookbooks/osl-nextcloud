require 'spec_helper'

describe 'osl_nextcloud' do
  recipe do
    osl_nextcloud 'test' do
      database_host 'localhost'
      database_name 'test-db'
      database_user 'test-user'
      ooo
      database_password 'test-pass'
      version '23.0.7'
    end
  end

  context 'centos' do
    platform 'centos'
    cached(:subject) { chef_run }
    step_into :osl_nextcloud

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
    end
  end
end
