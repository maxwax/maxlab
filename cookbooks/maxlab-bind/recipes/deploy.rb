#
# Cookbook:: maxlab-bind
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'date'

# BIND specific data bag
config_bind = data_bag_item('config_bind', node['config_bind']['instance']).to_h

### Should loop at this point to read in networks 'maxlab' and 'dmz' to setup
### config files for each. bleh 

#template '/etc/named.conf' do
#  attributes
#end

# Network specific configuration
config_network = data_bag_item('config_network', config_bind['config_network_ids'][0]).to_h

#puts "NETWORK CONFIG"
#pp config_network.to_h

## Catches Redhat/Centos/Fedora/etc
#os_dist  = node['platform_family']
#os_major = node['platform_version'].split('.')[0]
#
## Install packages for BIND
#bind_packages = node['bind']['packages'][os_dist][os_major].each do |pkg, ver|
#  puts "Package #{pkg} Version #{ver}"
#  puts
#
#  package pkg do
#    version ver
#    action :install
#  end
#
#end

config_network['subnet'].each do |network_name, subnet|
  puts "PROCESSING SUBNET #{network_name}"
  puts "PROCESSING domain #{subnet['domain_name']}"

  # Construct a unique list of groups by scanning all nodes here
  groups = []
  subnet['nodes'].each do |ip, node_cfg|
    if not groups.include? node_cfg['group']
      groups << node_cfg['group']
    end
  end
  puts "GROUPS"
  pp groups

  fname = "/var/named/db.#{subnet['domain_name']}"

  template fname do
    source 'db.forward.erb'
    variables (
      {
        fname: fname,
        network_prefix: subnet['network_prefix'],
        bind_cfg: subnet['dns'],
        aliases: subnet['aliases'],
        nodes: subnet['nodes'],
        groups: groups
      }
    )
  end

end

#for each reverse file do
#  template '/var/named/db.9.168.192' do
#    attributes
#  end
#end
#
## Should be in a firewall cookbook
#open firewall 
#firewall-cmd --add-service=dns
#firewall-cmd --reload
#
#service enable, start
#  subscribes to file changes
