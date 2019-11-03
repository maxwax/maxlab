#
# Cookbook:: maxlab-bind
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'date'

# Calculate a precise serial number for this BIND config file update
bind_serial_string = Time.now.strftime('%Y%m%d%H%M%S%L')

# BIND specific data bag
config_bind = data_bag_item('config_bind', node['config_bind']['instance']).to_h

### Should loop at this point to read in networks 'maxlab' and 'dmz' to setup
### config files for each. bleh 

#template '/etc/named.conf' do
#  attributes
#end

# Network specific configuration
config_network = data_bag_item('config_network', config_bind['config_network_ids'][0]).to_h

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

config_network['subnet'].each do |network_name, subnet|

  # Construct a unique list of groups by scanning all nodes here
  groups = []
  subnet['nodes'].each do |ip, node_cfg|
    if not groups.include? node_cfg['group']
      groups << node_cfg['group']
    end
  end

  fname_forward = "/var/named/db.#{subnet['domain_name']}"

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
  end

end

## Should be in a firewall cookbook
#open firewall 
#firewall-cmd --add-service=dns
#firewall-cmd --reload
#
#service enable, start
#  subscribes to file changes
