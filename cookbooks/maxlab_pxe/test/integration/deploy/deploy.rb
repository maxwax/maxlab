# Inspec test for recipe maxlab_pxe::deploy

describe directory('/repo/kickstart') do
  it { should exist }
end

describe directory('/repo/kickstart/build') do
  it { should exist }
end

describe directory('/repo/kickstart/centos') do
  it { should exist }
end

describe directory('/repo/kickstart/rhel') do
  it { should exist }
end

describe file('/repo/kickstart/centos/ks-centos-8.1905-base.ks') do
  it { should exist }
end

describe directory('/var/lib/tftpboot/images') do
  it { should exist }
end

describe directory('/var/lib/tftpboot/images/centos/centos-8.1905') do
  it { should exist }
end

describe file('/var/lib/tftpboot/images/centos/centos-8.1905/initrd.img') do
  it { should exist }
end

describe file('/var/lib/tftpboot/images/centos/centos-8.1905/vmlinuz') do
  it { should exist }
end

describe file('/var/lib/tftpboot/pxelinux.0') do
  it { should exist }
end

describe file('/var/lib/tftpboot/pxelinux.cfg/default') do
  it { should exist }
end

describe file('/var/lib/tftpboot/pxelinux.cfg/centos/main.conf') do
  it { should exist }
end

describe file('/var/lib/tftpboot/pxelinux.cfg/centos/centos-8.1905.conf') do
  it { should exist }
end

# Test tftp client to tftp server on local node
describe command('tftp 127.0.0.1 -c get pxelinux.0 /tmp/pxelinux.0') do
  its('exit_status') { should cmp 0 }
end

describe file('/tmp/pxelinux.0') do
  it { should exist }
end

# Ensure firewalld allows incoming tftp service
describe command('firewall-cmd --list-services') do
  its('stdout') { should match /.*(tftp).*/ }
  its('exit_status') { should cmp 0 }
end
