# # encoding: utf-8

# Inspec test for recipe maxlab_base::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('rpmfusion-free-release-8') do
  it { should be_installed }
end

describe package('rpmfusion-nonfree-release-8') do
  it { should be_installed }
end

describe file('/etc/yum.repos.d/rpmfusion-free-updates.repo') do
  it { should exist }
end

describe file('/etc/yum.repos.d/rpmfusion-nonfree-updates.repo') do
  it { should exist }
end

describe file('/etc/yum.repos.d/epel.repo') do
  it { should exist }
end

describe package('vim-enhanced') do
  it { should be_installed }
end

describe package('atop') do
  it { should be_installed }
end

describe package('htop') do
  it { should be_installed }
end

describe package('nmap-ncat') do
  it { should be_installed }
end

describe package('wget') do
  it { should be_installed }
end

describe package('policycoreutils-python-utils') do
  it { should be_installed }
end

describe file('/usr/local/etc/shell-basics') do
  it { should exist }
end

describe file('/usr/local/etc/shell-history') do
  it { should exist }
end
