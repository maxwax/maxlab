#
# Cookbook:: maxlab_dhcp
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy a DHCP server.
#>
=end

# Load data bag configuration for a specific DHCP server instance
#config_dhcp = data_bag_item('config_dhcp', node['config_dhcp']['instance'])
config_dhcp = node['dhcp']

## Catches Redhat/Centos/Fedora/etc
os_dist  = node['platform_family']
os_major = node['platform_version'].split('.')[0]

# Install packages for DHCP
dhcp_packages = node['dhcp']['packages'][os_dist][os_major].each do |pkg, ver|
  if ver == "any"
    package pkg do
      action :install
    end
  else
    package pkg do
      version ver
      action :install
    end
  end
end

subnets = {}

# Iterate over each network supported by this DHCP server
config_dhcp['serve_dhcp_for'].each do |network_id, subnet_id|

  # Load data bag configuration for the network (subnets, netmasks, etc)
  config_network = data_bag_item('config_network', network_id)

  # The DHCP server may serve > 1 subnet, so add each subnet to a hash of
  # subnet info and all will be populated in the dhcpd.conf file
  subnets[subnet_id] = config_network['subnet'][subnet_id]

  # Construct a string of DNS servers in format "A, B, C"
  dns_list = ""
  subnets[subnet_id]['dns']['domain_name_servers'].each do |dns_target|
    if not dns_list == ""
      dns_list = dns_list + ", "
    end
    dns_list = dns_list + dns_target
  end
  subnets[subnet_id]['dns_list'] = dns_list

  # Construct a hash of groups with options so we can organize dhcpd.conf
  # with groups, include group-specific options and exclude things like VIPs
  # First, gather all groups explicitly defined in the config_network json
  groups = {}

  subnets[subnet_id]['groups'].each do |group_name, group_options|
    if not groups.has_key?(group_name['group']) and
       not group_options['dhcp'] == false
      groups[group_name] = group_options
    end
  end

  # Next, scan all nodes defined in the config_network json and
  # include any groups assigned to nodes but not defined in json's groups{}
  # section.  Do not append groups for nodes that fail to have a MAC address
  subnets[subnet_id]['nodes'].each do |node_ip, node_info|

    if not groups.has_key?(node_info['group']) and
       node_info.has_key?('mac_address')

      # Do not include this node's group
      # if the node does not have a MAC address VALUE - it may be a VIP
      if not node_info['mac_address'].empty?
        groups[node_info['group']] = {
          "dhcp": true,
          "dhcp_option": []
        }
      end
    end
  end

  # Assign our list of groups to this subnet's config_network hash
  # We'll pass this to the template for unified access of network info
  subnets[subnet_id]['groups'] = groups

end

# Master DHCP server configuration file
template '/etc/dhcp/dhcpd.conf' do
  source 'dhcpd.conf.erb'
  variables (
    {
      config_dhcp: config_dhcp,
      subnets: subnets
    }
  )
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if config_dhcp['firewall']['firewalld'].key?('service')
  config_dhcp['firewall']['firewalld']['service'].each do |service_string|

    if not node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if config_dhcp['firewall']['firewalld'].key?('ports')
  config_dhcp['firewall']['firewalld']['ports'].each do |port_string|

    if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if config_dhcp['firewall']['firewalld'].key?('sources')
  config_dhcp['firewall']['firewalld']['sources'].each do |source_string|

    if not node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end
#---

# # Acquire one node that is a dhcp-server and the primary dhcp-server
# dhcp_nodes = search(:node, "tags:dhcp-server AND tags:dhcp-primary")
#
# # We might get more than one, but we should get only one if tags are managed
# enable_dhcp = false
# dhcp_nodes.each do |this_node|
#   puts "CHECKING #{this_node}"
#   # if this node is in the list of primary-dhcp servers, then enable it.
#   if this_node['hostname'] == node['hostname']
#     enable_dhcp = true
#   end
#
# end

# Ensure the service starts on boot and is reloaded upon config file updates
service 'dhcpd' do
  subscribes :restart, 'template[/etc/dhcp/dhcpd.conf]', :delayed

  action [:enable, :start]

#  only_if { enable_dhcp == true }
  only_if { node['dhcp']['instance_config_dhcp']['primary'] == true }
end

# Now that we've deployed a DHCP server, tag the node
tag('dhcp-server')

if node['dhcp']['instance_config_dhcp']['primary'] == true
  tag('dhcp-primary')
end
