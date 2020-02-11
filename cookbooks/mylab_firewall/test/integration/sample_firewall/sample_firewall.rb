# # encoding: utf-8

# Inspec test for recipe maxlab_firewall::sample_firewall

describe package('firewalld') do
  it { should be_installed }
end

describe file('/etc/firewalld/firewalld.conf') do
  it { should exist }
end

describe service('firewalld') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe firewalld do
  it { should be_running }
  its('default_zone') { should cmp 'dmz'}
  it { should have_service_enabled_in_zone('http', 'dmz') }
  it { should have_service_enabled_in_zone('https', 'dmz') }
  it { should have_service_enabled_in_zone('ssh', 'dmz') }
  it { should have_port_enabled_in_zone('5000/tcp', 'dmz') }
  it { should have_port_enabled_in_zone('5000/udp', 'dmz') }
end

# 2020-02-10 Issues encountered, possible RHEL/Centos 8?
# Must compare to [['element1', 'element2']]
# Cannot place this rule within firewall rules above.
describe firewalld.where { zone == 'dmz' } do
  its('sources') { should cmp [['10.0.2.100', '10.0.2.200']] }
end
