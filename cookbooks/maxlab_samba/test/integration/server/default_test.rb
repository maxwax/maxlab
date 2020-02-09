# # encoding: utf-8

# Inspec test for recipe maxlab_samba::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('samba') do
  it { should be_installed }
end

describe directory('/etc/samba') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe file('/etc/samba/smb.conf') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
end

describe service('smb') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('nmb') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# describe command('curl -I localhost:32400') do
#   its('exit_status') { should cmp 0 }
#   its('stdout') { should match (/.*(200\ OK).*/) }
# end
