# Inspec test for recipe maxlab_postfix::deploy

#
# Test real node configurations to ensure that postfix is deployed
# with the right configuration, and DO EXPECT the service to start
# within a test kitchen VM on the VM's 10.0.2.0/24 network.
#

describe package('postfix') do
  it { should be_installed }
end

describe directory('/etc/postfix') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
  its('mode') { should cmp '0755' }
end

describe file('/etc/postfix/main.cf') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
end

describe file('/etc/postfix/sasl_passwd') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
end

describe file('/etc/postfix/sasl_passwd.db') do
  it { should exist }
  its('owner') { should cmp 'root' }
  its('group') { should cmp 'root' }
end

describe service('postfix') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
