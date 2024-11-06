# InSpec test for recipe osl-nextcloud::default

# Openstack, Vagrant, and Dokken all have different php configurations
vagrant = inspec.file('/home/vagrant').exist?
docker = inspec.file('/.dockerenv').exist?
openstack = !vagrant and !docker

control 'osl_nextcloud' do
  def occ(cmd)
    "sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ #{cmd}"
  end

  describe php_config 'apc.enable_cli' do
    its('value') { should eq 1 }
  end

  describe php_config 'memory_limit' do
    its('value') { should eq '512M' }
  end

  describe php_config 'output_buffering' do
    its('value') { should eq 0 }
  end

  describe php_config 'post_max_size' do
    its('value') { should eq '1G' }
  end

  describe php_config 'upload_max_filesize' do
    its('value') { should eq '1G' }
  end

  describe package 'php-ldap' do
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

  describe directory '/var/www/nextcloud.example.com/data' do
    it { should exist }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  describe directory '/var/www/nextcloud.example.com/nextcloud/apps' do
    it { should exist }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  describe file '/var/www/nextcloud.example.com/nextcloud/config/config.php' do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  describe file '/var/www/nextcloud.example.com/config.php' do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  describe host('localhost') do
    it { should be_reachable }
    it { should be_resolvable }
  end

  describe json({ command: occ('status --output json') }) do
    its('installed') { should cmp true }
    its('versionstring') { should match /^30.[0-9]+.[0-9]+/ }
  end

  describe command occ('check') do
    its('exit_status') { should eq 0 }
  end

  describe command occ('config:system:get --output json installed') do
    its('stdout') { should match /^true$/ }
  end

  describe json({ command: occ('config:system:get --output json redis') }) do
    its('host') { should cmp '127.0.0.1' }
    its('port') { should cmp '6379' }
  end

  describe json({ command: occ('app:list --output json') }) do
    its('enabled') { should include 'forms' }
    its('enabled') { should include 'user_ldap' }
    its('enabled') { should_not include 'weather_status' }
    its('disabled') { should include 'weather_status' }
  end

  # PHP attributes are different for Docker instances
  describe file('/etc/php-fpm.d/nextcloud.conf') do
    its('content') { should match /^pm.max_children = 43$/ }
    its('content') { should match /^pm.start_servers = 10$/ }
    its('content') { should match /^pm.min_spare_servers = 10$/ }
    its('content') { should match /^pm.max_spare_servers = 32$/ }
  end if openstack

  describe file('/etc/php-fpm.d/nextcloud.conf') do
    its('content') { should match /^pm.max_children = 10$/ }
    its('content') { should match /^pm.start_servers = 2$/ }
    its('content') { should match /^pm.min_spare_servers = 2$/ }
    its('content') { should match /^pm.max_spare_servers = 7$/ }
  end if vagrant

  describe file('/etc/php-fpm.d/nextcloud.conf') do
    its('content') { should match /^pm.max_children = 255$/ }
    its('content') { should match /^pm.start_servers = 63$/ }
    its('content') { should match /^pm.min_spare_servers = 63$/ }
    its('content') { should match /^pm.max_spare_servers = 191$/ }
  end if docker

  describe http('http://localhost') do
    its('status') { should eq 200 }
    its('headers.Content-Type') { should match 'text/html' }
  end

  describe http('http://localhost', headers: { 'host' => 'nextcloud.example.com' }) do
    its('status') { should eq 302 }
    its('headers.Content-Type') { should match 'text/html' }
    its('headers.Location') { should match 'http://nextcloud.example.com/index.php/login' }
  end
end
