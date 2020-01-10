#
# Cookbook:: maxlab-tftp
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy a TFTP server instance to support PXE netbooting of VM nodes.
#>
=end

config_tftp_server = data_bag_item('config_tftp_server', node['config_tftp_server']['instance'])

%W[ tftp tftp-server xinetd ].each do |pkg|

  package pkg do
    action :install
  end
end

template '/etc/xinetd.d/tftp-server' do
  source 'tftp-server.erb'

  user config_tftp_server['user']
  group config_tftp_server['group']
  mode '0700'
  action :create

end

# Normally created by rpm tftp-server but not re-created if the dir is removed
# and the package is already installed
directory config_tftp_server['pxelinux_cfg_root'] do
  user config_tftp_server['user']
  group config_tftp_server['group']
  mode '0755'
  action :create
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if not node['maxlab_firewall']['zones'][service_zone]['services'].include?  config_tftp_server['firewall']['firewalld']['service']
  node.normal['maxlab_firewall']['zones'][service_zone]['services'] << config_tftp_server['firewall']['firewalld']['service']
end

#---

service 'xinetd' do
  subscribes :reload, '/etc/xinetd.d/ttp-server', :delayed

  action [ :enable, :start ]
end
