# InSpec test for recipe osl-nextcloud::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/
control 'osl_nextcloud' do
  describe package 'redis' do
    it { should be_installed }
  end
  describe service 'redis' do
    it { should be_running }
  end
  describe service 'httpd' do
    it { should be_enabled }
    it { should be_running }
  end

  describe directory '/var/www/html/nextcloud/' do
    it { should exist }
    its('owner') { should eq 'apache' }
  end

  describe file '/var/www/html/nextcloud/' do
    it { should exist }
    its('owner') { should eq 'apache' }
  end

  describe file '/var/www/html/nextcloud/config/CAN_INSTALL' do
    it { should_not exist }
  end

  describe host('localhost') do
    it { should be_reachable }
    it { should be_resolvable }
  end

  describe http('http://localhost/nextcloud/index.php/login') do
    its('status') { should cmp 200 }
  end
end
