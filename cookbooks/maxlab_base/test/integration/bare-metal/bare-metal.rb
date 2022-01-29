# # encoding: utf-8

# Inspec test for recipe maxlab_base::deploy-bare-metal

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

describe package('bpytop') do
  it { should be_installed }
end

describe package('htop') do
  it { should be_installed }
end

describe package('bmon') do
  it { should be_installed }
end

describe package('iftop') do
  it { should be_installed }
end

describe package('nmon') do
  it { should be_installed }
end

# Disabled due to bug in Fedora 35
# describe package('nmap-ncat') do
#   it { should be_installed }
# end

# Replacement for nmap-ncat
describe package('netcat') do
  it { should be_installed }
end

describe package('tree') do
  it { should be_installed }
end

describe package('wget') do
  it { should be_installed }
end

describe package('tar') do
  it { should be_installed }
end

describe package('bzip2') do
  it { should be_installed }
end

describe package('which') do
  it { should be_installed }
end

describe package('rsync') do
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

# ADDTIONAL PACKAGE DEPLOYED BY deploy-bare-metal.rb recipe

describe package('lm_sensors') do
  it { should be_installed }
end
