#
# Cookbook:: maxlab_firewall
# Recipe:: sample_firewall
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Open some services, ports and sources when testing maxlab_firewall with Test Kitchen.
#>
=end

# Open three sample services
node.default['faux_service']['firewall']['firewalld']['services'] = [ "http", "https", "ssh" ]

# Open two ports
node.default['faux_service']['firewall']['firewalld']['ports'] = [ "5000/tcp", "5000/udp" ]

#
node.default['faux_service']['firewall']['firewalld']['sources'] = [ "10.0.2.100", "10.0.2.200" ]

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

config_faux_service = node['faux_service']

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if config_faux_service['firewall']['firewalld'].key?('services')
  config_faux_service['firewall']['firewalld']['services'].each do |service_string|

    if not node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if config_faux_service['firewall']['firewalld'].key?('ports')
  config_faux_service['firewall']['firewalld']['ports'].each do |port_string|

    if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if config_faux_service['firewall']['firewalld'].key?('sources')
  config_faux_service['firewall']['firewalld']['sources'].each do |source_string|

    if not node['maxlab_firewall']['zones'][service_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][service_zone]['sources'] << source_string
    end

  end
end

#---
