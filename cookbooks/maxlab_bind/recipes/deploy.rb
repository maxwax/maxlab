#
# Cookbook:: maxlab_bind
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy DNS services using bind.
#>
=end

require 'date'

# Calculate a precise serial number for this BIND config file update
bind_serial_string = Time.now.strftime('%y%m%d%H%M')

# Catches Redhat/Centos/Fedora/etc
os_dist  = node['platform_family']
os_major = node['platform_version'].split('.')[0]

# Install packages for BIND
bind_packages = node['bind']['packages'][os_dist][os_major].each do |pkg, ver|
  package pkg do
    version ver
    action :install
  end
end

# Start with empty hash of zones, add them each time we drop fwd/rev config files
config_zones = {}

# BIND specific data bag
config_bind = data_bag_item('config_bind', node['config_bind']['instance']).to_h

# The first network listed in the data bag will be used to configure DNS
# while any additional networks will be scanned for forward and reverse DNS
# resolution files.  This allows easy config for a home lab + limited DMZ DNS

config_bind['config_network_ids'].each do |cfg_net_id|

  # Find network information to support deploying each bind instance
  config_network = data_bag_item('config_network', cfg_net_id).to_h

  # Iterate over each subnet defined in the network data bag configuration
  config_network['subnet'].each do |network_name, subnet|

    # Add each forward and reverse zone config to config_zones.
    # This will be used to configure /etc/named.conf later
    subnet['dns']['zones'].each do |zone_name, zone_cfg|
      config_zones[zone_name] = zone_cfg

      # Remove '.in-addr.arpa' from filenames, leaving 'db.9.168.192' (example)
      config_zones[zone_name]['fname'] = zone_name.gsub(".in-addr.arpa","")
    end

    # Construct a unique list of groups by scanning all nodes here
    groups = []
    subnet['nodes'].each do |ip, node_cfg|
      if not groups.include? node_cfg['group']
        groups << node_cfg['group']
      end
    end

    # Config file name, ex: db.maxlab
    fname_forward = "/var/named/db.#{cfg_net_id}"

    # Convert network prefix '192.168.9' to '9.168.192'
    reverse_network = subnet['network_prefix'].split('.')[2] + "." + subnet['network_prefix'].split('.')[1] + "." + subnet['network_prefix'].split('.')[0]

    # Config file name, ex: db.9.168.192
    fname_reverse = "/var/named/db.#{reverse_network}"

    # Deploy the forward resolution DNS file
    template fname_forward do
      source 'db.forward.erb'
      variables (
        {
          fname: fname_forward,
          bind_serial_string: bind_serial_string,
          network_prefix: subnet['network_prefix'],
          bind_cfg: subnet['dns'],
          aliases: subnet['aliases'],
          nodes: subnet['nodes'],
          groups: groups
        }
      )
      notifies :reload, 'service[named]', :delayed
    end

    # Deploy the reverse resolution DNS file
    template fname_reverse do
      source 'db.reverse.erb'
      variables (
        {
          fname: fname_reverse,
          domain_name: subnet['domain_name'],
          bind_serial_string: bind_serial_string,
          bind_cfg: subnet['dns'],
          nodes: subnet['nodes'],
          groups: groups
        }
      )
      notifies :reload, 'service[named]', :delayed
    end

  end

end

# Auto configure listening IP address for ipv4 or use a specified value
case config_bind['config_listen_on_address_ipv4']
  when 'ipaddress'
    cfg_listen_ipv4 = node['ipaddress']
  else
    cfg_listen_ipv4 = config_bind['listen_on_address_ipv4']
end

# Auto configure listening IP address for ipv6 or use a specified value
case config_bind['config_listen_on_address_ipv6']
  when 'ipaddress'
    cfg_listen_ipv6 = node['ipaddress']
  else
    cfg_listen_ipv6 = config_bind['listen_on_address_ipv6']
end

# Deploy master bind config file
template '/etc/named.conf' do
  source 'named.conf.erb'
  variables (
    {
      config_bind: config_bind,
      config_zones: config_zones,
      cfg_listen_ipv4: cfg_listen_ipv4,
      cfg_listen_ipv6: cfg_listen_ipv6
    }
  )

  notifies :reload, 'service[named]', :delayed
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
bind_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if not node['maxlab_firewall']['zones'][bind_zone]['services'].include? config_bind['firewall']['firewalld']['service']
  node.normal['maxlab_firewall']['zones'][bind_zone]['services'] << config_bind['firewall']['firewalld']['service']
end

#---

# Ensure the service starts on boot and is reloaded upon config file updates
service 'named' do
  subscribes :reload, 'template[/etc/named.conf]', :delayed

  action [:enable, :start]
end
