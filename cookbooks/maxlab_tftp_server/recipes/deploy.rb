#
# Cookbook:: maxlab_tftp
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy a TFTP server instance to support PXE netbooting of VM nodes.
#>
=end

config_tftp_server = data_bag_item('config_tftp_server', node['instance_config_tftp_server']['instance'])

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
if config_tftp_server['firewall']['firewalld'].key?('services')
  config_tftp_server['firewall']['firewalld']['services'].each do |service_string|

    if not node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if config_tftp_server['firewall']['firewalld'].key?('ports')
  config_tftp_server['firewall']['firewalld']['ports'].each do |port_string|

    if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if config_tftp_server['firewall']['firewalld'].key?('sources')
  config_tftp_server['firewall']['firewalld']['sources'].each do |source_string|

    if not node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

service 'xinetd' do
  subscribes :reload, '/etc/xinetd.d/ttp-server', :delayed

  action [ :enable, :start ]
end

# Tag the node with tftp-server now that the service has been deployed
tag('tftp-server')
