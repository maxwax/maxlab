# Inspec test for recipe maxlab_pxe::deploy

# Core directory for kickstart files
describe directory('/repo/kickstart') do
  it { should exist }
end

# Directory of scripts appended to kickstart files
describe directory('/repo/kickstart/build') do
  it { should exist }
end

# Kickstart for Centos 6, 7, 8
describe directory('/repo/kickstart/centos') do
  it { should exist }
end

# Kickstart for Centos Stream
describe directory('/repo/kickstart/centos_stream') do
  it { should exist }
end

# Kickstart for Red Hat Enterprise Linux (RHEL)
describe directory('/repo/kickstart/rhel') do
  it { should exist }
end

# Sample kickstart file for CentOS Stream 8
describe file('/repo/kickstart/centos_stream/ks-centos_stream-8.x-base.ks') do
  it { should exist }
end

# Core directory for TFTP boot images with vmlinuz and initrd files
describe directory('/var/lib/tftpboot/images') do
  it { should exist }
end

# Boot directory for Centos 8 Stream
describe directory('/var/lib/tftpboot/images/centos_stream') do
  it { should exist }
end

# syslinux pxe boot image file
describe file('/var/lib/tftpboot/pxelinux.0') do
  it { should exist }
end

# Sample tool memtest86
describe file('/var/lib/tftpboot/images/tools/memtest86') do
  it { should exist }
end

# Default root level PXE boot menu
describe file('/var/lib/tftpboot/pxelinux.cfg/default') do
  it { should exist }
end

# PXE boot menu for Centos 6, 7, 8
describe file('/var/lib/tftpboot/pxelinux.cfg/centos/main.conf') do
  it { should exist }
end

# PXE boot menu for CentOS Stream 8
describe file('/var/lib/tftpboot/pxelinux.cfg/centos_stream/centos_stream-8.x.conf') do
  it { should exist }
end

# Test tftp client to tftp server on local node
describe command('tftp 127.0.0.1 -c get pxelinux.0 /tmp/pxelinux.0') do
  its('exit_status') { should cmp 0 }
end

# Ensure firewalld allows incoming tftp service
describe command('firewall-cmd --list-services') do
  its('stdout') { should match /.*(tftp).*/ }
  its('exit_status') { should cmp 0 }
end
