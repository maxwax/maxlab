# # encoding: utf-8

# Inspec test for recipe maxlab_bind::server

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/named.conf') do
  it { should exist }
end

describe service('named') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# DNS tcp/udp port
describe port(53) do
  it { should be_listening }
end
