# Inspec test for recipe maxlab_chrony::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/dhcp/dhcpd.conf') do
  it { should exist }
end

describe service('dhcpd') do
  it { should be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

# DHCP Server Port
describe port(67) do
  it { should_not be_listening }
end
