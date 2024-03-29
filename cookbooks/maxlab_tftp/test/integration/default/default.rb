# Inspec test for recipe maxlab_tftp::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('tftp') do
  it { should be_installed }
end

describe package('tftp-server') do
  it { should be_installed }
end

describe package('xinetd') do
  it { should be_installed }
end

describe service('xinetd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/xinetd.d/tftp-server') do
  it { should exist }
end
