require 'spec_helper'

describe 'nextcloud-test::default' do
  stubs_for_provider('osl_nextcloud[test]') do |provider|
    allow_any_instance_of(osl_nextcloud_config).to receive().and_return(user) 
    domains_json = {"system" => { "trusted_domains" => ["localhost","nextcloud.example.com"] } }
    allow(provider).to receive_shell_out('php occ config:list', { cwd: '/usr/share/nextcloud/', user: 'apache', group: 'apache' }).and_return(domains_json)
  end
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
            osl-apache
            osl-apache::mod_php
            osl-git
            osl-php
            osl-repos::epel
          ).each do |r|
          it do
            expect(chef_run).to include_recipe(r)
          end
        end
      end

      it { expect(chef_run).to install_package(%w(nextcloud redis)) }
      it { expect(chef_run).to enable_service('redis') }
      it { expect(chef_run).to start_service('redis') }

      it 'installs nextcloud' do
        expect(chef_run).to run_execute('occ-nextcloud').with(user: 'apache')
      end

      describe 'trusted hosts' do
        it { expect(chef_run).to run_execute('trusted-domains').with(user: 'apache') }
      end
    end
  end
end
