# # encoding: utf-8

# Inspec test for recipe maxlab_chrony::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/chrony.conf') do
  it { should exist }
end

describe service('chronyd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# NTP port
describe port(123) do
  it { should be_listening }
end

# Chrony cmd port
describe port(323) do
  it { should be_listening }
end
