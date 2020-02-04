# # encoding: utf-8

# Inspec test for recipe maxlab_chrony::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/dhcp/dhcpd.conf') do
  it { should exist }
end

describe service('dhcpd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# DHCP Server Port
describe port(67) do
  it { should be_listening }
end
