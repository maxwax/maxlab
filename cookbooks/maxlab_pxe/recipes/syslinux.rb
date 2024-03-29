#
# Cookbook:: maxlab_pxe
# Recipe:: syslinux
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.

include_recipe 'maxlab_tftp'

# Load the main PXE configuration
config_pxe = data_bag_item('config_pxe', 'pxeconfig')

%W( syslinux-tftpboot ).each do |pkg|

  package pkg do
    action :install
  end
end

execute 'copy-syslinux-files' do
  command "cp /tftpboot/* #{config_pxe['pxelinux_cfg_root']}"
  action :run
end
