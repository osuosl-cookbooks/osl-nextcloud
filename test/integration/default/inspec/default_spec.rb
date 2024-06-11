# InSpec test for recipe osl-nextcloud::default

# Openstack, Vagrant, and Dokken all have different php configurations
vagrant = inspec.file('/home/vagrant').exist?
docker = inspec.file('/.dockerenv').exist?
openstack = !vagrant and !docker

control 'osl_nextcloud' do
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

  describe command('sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ status') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /installed: true/ }
    its('stdout') { should match /versionstring: 29.[0-9]+.[0-9]+/ }
  end

  describe command('sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ check') do
    its('exit_status') { should eq 0 }
  end

  describe command('sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ config:system:get installed') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /^true$/ }
  end

  describe command('sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ config:system:get redis') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /^host: 127.0.0.1$/ }
    its('stdout') { should match /^port: 6379$/ }
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
