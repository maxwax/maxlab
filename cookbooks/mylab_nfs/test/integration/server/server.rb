# # encoding: utf-8

# Inspec test for recipe mylab_nfs::server

#
# Test real node configurations to ensure that nfs is deployed
# with the right configuration, and DO EXPECT the service to start
# within a test kitchen VM on the VM's 10.0.2.0/24 network.
#

describe package('nfs-utils') do
  it { should be_installed }
end

describe file('/etc/exports') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
end

describe service('nfs-server') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('nfs-mountd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe service('nfs-idmapd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
