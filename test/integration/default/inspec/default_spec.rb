# InSpec test for recipe osl-nextcloud::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/
control 'osl_nextcloud' do
  describe package 'nextcloud' do
    it { should be_installed }
  end
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

  describe directory '/usr/share/nextcloud/data' do
    it { should exist }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  describe host('localhost') do
    it { should be_reachable }
    it { should be_resolvable }
  end

  describe http('http://localhost',
                headers: {'host' => 'nextcloud.example.com'}) do
    its('status') { should eq 200 }
    its('headers.Content-Type') { should match 'text/html' }
  end
end
