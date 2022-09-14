require 'spec_helper'
unified_mode true

describe 'nextcloud-test::default' do
  ALL_PLATFORMS.each do |platform|
    context "on platform #{platform[:platform]} #{platform[:version]}" do
      let(:runner) do
        ChefSpec::SoloRunner.new(
          platform.dup.merge(step_into: ['osl_nextcloud'])
        )
      end
      let(:node) { runner.node }
      cached(:chef_run) { runner.converge(described_recipe) }

      include_context 'common_stubs'

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      describe 'included recipes' do
        %w(
          ark
          osl-git
          osl-php
          osl-apache::mod_php
          osl-apache
          osl-repos::epel
        ).each do |r|
          it do
            expect(chef_run).to include_recipe(r)
          end
        end
      end

      it { expect(chef_run).to install_package('redis') }
      it { expect(chef_run).to enable_service('redis') }
      it { expect(chef_run).to start_service('redis') }

      it do
        expect(chef_run).to put_ark('nextcloud').with(
          url: 'https://download.nextcloud.com/server/releases/nextcloud-23.0.7.tar.bz2',
          path: '/var/www/html/',
          owner: 'apache',
          group: 'apache',
          creates: '/var/www/html/nextcloud'
        )
      end

      describe 'installs nextcloud' do
        it { expect(chef_run).to run_execute('occ-nextcloud').with(user: 'apache') }
      end

      describe 'trusted hosts' do
        it { expect(chef_run).to run_execute('trusted-domains').with(user: 'apache') }
      end

      it { expect(chef_run).to restart_service('httpd') }
    end
  end
end
