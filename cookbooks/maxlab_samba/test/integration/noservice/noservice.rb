# # encoding: utf-8

# Inspec test for recipe maxlab_samba::noservice

#
# Test real node configurations to ensure that samba is deployed
# with the right configuration, but do not expect the service to start
# within Test Kitchen VMs that use internal only NAT networks
#

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

# When testing real node configs in test kitchen, the network is
# not available for testing, so the service won't start.
# describe service('smb') do
#   it { should be_installed }
#   it { should be_enabled }
#   it { should be_running }
# end
#
# describe service('nmb') do
#   it { should be_installed }
#   it { should be_enabled }
#   it { should be_running }
# end
