require 'spec_helper'

describe 'nextcloud-test::default' do
  ALL_PLATFORMS.each do |platform|
    context "on platform #{platform[:platform]} #{platform[:version]}" do
      let(:runner) do
        ChefSpec::SoloRunner.new(
          platform.dup.merge(step_into: ['osl_nextcloud'])
        )
      end

      include_context 'common_stubs'

      occ_config = '{"system": { "trusted_domains": [ "localhost", "nextcloud.example.com" ] }}'
      occ_config = JSON.parse(occ_config)

      occ_config_new = '{"system": { "trusted_domains": [ "localhost" ] }}'
      occ_config_new = JSON.parse(occ_config_new)

      context 'nextcloud not installed' do
        before do
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:can_install?).and_return(true)
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:osl_nextcloud_config).and_return(occ_config_new)
        end

        let(:node) { runner.node }
        cached(:chef_run) { runner.converge(described_recipe) }

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

        it { expect(chef_run).to create_directory('/etc/httpd/nextcloud') }

        %w(
          /etc/httpd/nextcloud/nextcloud-access.conf.avail
          /etc/httpd/nextcloud/nextcloud-auth-any.inc
          /etc/httpd/nextcloud/nextcloud-auth-local.inc
          /etc/httpd/nextcloud/nextcloud-auth-none.inc
          /etc/httpd/nextcloud/nextcloud-defaults.inc
        ).each do |f|
          it { expect(chef_run).to create_cookbook_file(f) }
        end

        it { expect(chef_run).to enable_service('redis') }
        it { expect(chef_run).to start_service('redis') }

        it { expect(chef_run).to run_execute('occ-nextcloud').with(user: 'apache') }
        it { expect(chef_run).to_not run_execute('trusted-domains-localhost') }
        it { expect(chef_run).to run_execute('trusted-domains-nextcloud.example.com').with(user: 'apache') }
      end

      context 'nextcloud installed' do
        before do
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:can_install?).and_return(false)
          allow_any_instance_of(OSLNextcloud::Cookbook::Helpers).to receive(:osl_nextcloud_config).and_return(occ_config)
        end
        let(:node) { runner.node }
        cached(:chef_run) { runner.converge(described_recipe) }
        it { expect(chef_run).to_not run_execute('trusted-domains-localhost') }
        it { expect(chef_run).to_not run_execute('trusted-domains-nextcloud.example.com') }
        it { expect(chef_run).to_not run_execute('occ-nextcloud') }
      end
    end
  end
end
