# InSpec test for recipe osl-nextcloud::default

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

  describe command('sudo -u apache php /usr/share/nextcloud/occ status') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /installed: true/ }
    its('stdout') { should match /versionstring: 23.0.7/ }
  end

  describe http('http://localhost',
                headers: { 'host' => 'nextcloud.example.com' }) do
    its('status') { should eq 200 }
    its('headers.Content-Type') { should match 'text/html' }
  end
end
