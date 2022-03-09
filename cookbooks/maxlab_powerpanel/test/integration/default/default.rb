# Inspec test for recipe maxlab_powerpanelups::deploy

describe package('powerpanel') do
  it { should be_installed }
end

describe file('/etc/pwrstatd.conf') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0644' }
end

describe systemd_service('pwrstatd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/usr/local/bin/log-powerpanel-ups-stats') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe crontab do
  its('commands') { should include '/usr/local/bin/log-powerpanel-ups-stats' }
end
