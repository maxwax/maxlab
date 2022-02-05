# InSpec test for recipe maxlab_smartd::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('smartmontools') do
  it { should be_installed }
end

describe directory('/etc/smartmontools') do
  it { should exist }
end

describe file('/etc/smartmontools/smartd.conf') do
  it { should exist }
  its('content') { should match /.*(DEVICESCAN -m example@example.com).*/ }
end

describe service('smartd') do
  it { should be_running }
end
