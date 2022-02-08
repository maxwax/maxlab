# Inspec test for recipe maxlab_apcupsd::deploy

describe package('apcupsd') do
  it { should be_installed }
end

describe directory('/etc/apcupsd') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe file('/etc/apcupsd/apcupsd.conf') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/apcupsd/apccontrol') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe firewalld do
  it { should be_running }
  it { should have_port_enabled_in_zone('3551/tcp', 'internal') }
end

describe systemd_service('apcupsd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/usr/local/bin/log-apc-ups-stats') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe crontab do
  its('commands') { should include '/usr/local/bin/log-apc-ups-stats' }
end
