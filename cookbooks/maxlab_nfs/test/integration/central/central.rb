# # encoding: utf-8

# Inspec test for recipe maxlab_nfs::server

#
# Test real node configurations to ensure that nfs is deployed
# with the right configuration, and DO EXPECT the service to start
# within a test kitchen VM on the VM's 10.0.2.0/24 network.
#

describe file('/etc/exports') do
  it { should exist }
  its('content') { should match(%r{^\/srv\/avarchive*}) }
end

describe file('/etc/exports') do
  it { should exist }
  its('content') { should match(%r{^\/srv\/audiovideo*}) }
end
