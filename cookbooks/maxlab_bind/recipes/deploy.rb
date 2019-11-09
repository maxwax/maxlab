#
# Cookbook:: maxlab_bind
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'date'

# Calculate a precise serial number for this BIND config file update
bind_serial_string = Time.now.strftime('%y%m%d%H%M')

# Start with empty hash of zones, add them each time we drop fwd/rev config files
config_zones = {}

# BIND specific data bag
config_bind = data_bag_item('config_bind', node['config_bind']['instance']).to_h

# The first network listed in the data bag will be used to configure DNS
# while any additional networks will be scanned for forward and reverse DNS
# resolution files.  This allows easy config for a home lab + limited DMZ DNS

config_bind['config_network_ids'].each do |cfg_net_id|

  Chef::Log.info "PROCESSING NETWORK ID #{cfg_net_id}"

  # Network specific configuration
  #config_network = data_bag_item('config_network', config_bind['config_network_ids'][0]).to_h
  #
  config_network = data_bag_item('config_network', cfg_net_id).to_h

  config_network['subnet'].each do |network_name, subnet|

    puts
    puts "PROCESSING SUBNET #{network_name}"
    puts

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

    #fname_forward = "/var/named/db.#{subnet['domain_name']}"
    fname_forward = "/var/named/db.#{cfg_net_id}"

    # Convert network prefix '192.168.9' to '9.168.192'
    reverse_network = subnet['network_prefix'].split('.')[2] + "." + subnet['network_prefix'].split('.')[1] + "." + subnet['network_prefix'].split('.')[0]

    fname_reverse = "/var/named/db.#{reverse_network}"

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
      notifies :reload, 'service[named]', :immediately
    end

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
      notifies :reload, 'service[named]', :immediately
    end

  end

end

puts "CONFIG BIND"
pp config_bind

puts "ZONES"
pp config_zones

template '/etc/named.conf' do
  source 'named.conf.erb'
  variables (
    {
      config_bind: config_bind,
      config_zones: config_zones
    }
  )

  notifies :reload, 'service[named]', :immediately
end

## Catches Redhat/Centos/Fedora/etc
#os_dist  = node['platform_family']
#os_major = node['platform_version'].split('.')[0]
#
## Install packages for BIND
#bind_packages = node['bind']['packages'][os_dist][os_major].each do |pkg, ver|
#  package pkg do
#    version ver
#    action :install
#  end
#end

## Should be in a firewall cookbook
#open firewall 
#firewall-cmd --add-service=dns
#firewall-cmd --reload

service 'named' do
  subscribes :reload, 'template[/etc/named.conf]', :immediate

  action [:enable, :start]
end
