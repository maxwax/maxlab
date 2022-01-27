# # encoding: utf-8

# Inspec test for recipe maxlab_nfs_client::client

#
# Test real node configurations to ensure that nfs is deployed
# with the right configuration, and DO EXPECT the service to start
# within a test kitchen VM on the VM's 10.0.2.0/24 network.
#

describe package('nfs-utils') do
  it { should be_installed }
end

describe directory('/net') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe directory('/net') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe directory('/net/audiovideo') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe directory('/net/avarchive') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end
