#
# Cookbook:: maxlab_plex
# Recipe:: deploy
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

# Load the main PXE configuration
# config_plex = data_bag_item('config_plex', node['config_plex']['instance'])
config_plex = node['plex']

# Load network information for the network this kickstart config uses
# config_network = data_bag_item('config_network', config_plex['network'])

# Pull subnet specific info from the overall network
# subnet_info = config_network['subnet'][config_plex['subnet']]

# If plex is installed, then attempt to update it
unless node['packages'].key?(config_plex['package_name'])
  # If plex is not already installed, deploy a repo and install it.
  yum_repository 'PlexRepo' do
    baseurl 'https://downloads.plex.tv/repo/rpm/$basearch/'
    gpgkey 'https://downloads.plex.tv/plex-keys/PlexSign.key'
    gpgcheck true
    enabled true
  end
end

package "install-upgrade-#{config_plex['package_name']}" do
  package_name config_plex['package_name']

  action [:install, :upgrade]
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if config_plex['firewall']['firewalld'].key?('services')
  config_plex['firewall']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if config_plex['firewall']['firewalld'].key?('ports')
  config_plex['firewall']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if config_plex['firewall']['firewalld'].key?('sources')
  config_plex['firewall']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---
# If installed, then ensure it is running
if node['packages'].key?(config_plex['package_name'])
  service config_plex['service_name'] do
    action [:enable, :start]
  end
end

# Now that we've deployed a simple nginx repo, tag the node
tag('plex')
