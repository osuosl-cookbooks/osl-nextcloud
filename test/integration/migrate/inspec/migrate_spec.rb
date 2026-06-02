# InSpec test for recipe osl-nextcloud::migrate (adopt existing instance / migration mode)

control 'osl_nextcloud_migrate' do
  def occ(cmd)
    "sudo -u apache php /var/www/nextcloud.example.com/nextcloud/occ #{cmd}"
  end

  # The bootstrapped config.php carries the supplied identity and is owned by apache.
  describe file '/var/www/nextcloud.example.com/nextcloud/config/config.php' do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('owner') { should eq 'apache' }
    its('group') { should eq 'apache' }
  end

  # The imported database was adopted (not reinstalled), so the instance reports as
  # installed and its instanceid is the exact value supplied to the resource.
  describe command occ('config:system:get instanceid') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/^ocm9ua92lqzi\s*$/) }
  end

  describe command occ('config:system:get --output json installed') do
    its('stdout') { should match /^true$/ }
  end

  # `occ status` does not expose instanceid; that assertion lives in the dedicated
  # `config:system:get instanceid` check above.
  describe json({ command: occ('status --output json') }) do
    its('installed') { should cmp true }
    its('versionstring') { should match /^32\.[0-9]+\.[0-9]+/ }
  end

  describe command occ('check') do
    its('exit_status') { should eq 0 }
  end
end
