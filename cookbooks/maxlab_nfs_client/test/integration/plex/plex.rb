# Inspec test for recipe maxlab_nfs_client::client

# Check for NFS client directories on node plex.maxlab

#
# Test real node configurations to ensure that nfs is deployed
# with the right configuration, and DO EXPECT the service to start
# within a test kitchen VM on the VM's 10.0.2.0/24 network.
#

describe directory('/net/av') do
  it { should exist }
  its('owner') { should cmp 'maxwell' }
  its('group') { should cmp 'maxwell' }
  its('mode') { should cmp '0755' }
end
