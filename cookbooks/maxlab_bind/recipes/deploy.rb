#
# Cookbook:: maxlab_bind
# Recipe:: deploy
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.

require 'date'

# Calculate a precise serial number for this BIND config file update
bind_serial_string = Time.now.strftime('%y%m%d%H%M')

# Catches Redhat/Centos/Fedora/etc
os_dist  = node['platform_family']
# os_major = node['platform_version'].split('.')[0]
os_major = node['platform_version'].to_i.to_s

# Install packages for BIND
# bind_packages = node['bind']['packages'][os_dist][os_major].each do |pkg, ver|
node['bind']['packages'][os_dist][os_major].each do |pkg, ver|

  if ver == 'any'
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

# Start with empty hash of zones, add them each time we drop fwd/rev config files
config_zones = {}

config_listen_on_ipv4_list = []
config_listen_on_ipv6_list = []

# Load the bind config attributes. This used to be from a data bag.
config_bind = node['bind']

# The first network listed in the data bag will be used to configure DNS
# while any additional networks will be scanned for forward and reverse DNS
# resolution files.  This allows easy config for a home lab + limited DMZ DNS

config_bind['config_network_ids'].each do |cfg_net_id|

  # Find network information to support deploying each bind instance
  config_network = data_bag_item('config_network', cfg_net_id)

  log "log-config-network-#{cfg_net_id}" do

    message "debug-log-config-cfg_net_id: #{cfg_net_id}"
    level :debug

  end

  # Iterate over each subnet defined in the network data bag configuration
  config_network['subnet'].each do |network_name, subnet|

    log "log-cn-subnet-#{network_name}" do

      message "debug-log-cn-subnet network-name: #{network_name}"
      message "debug-log-cn-subnet subnet #{subnet['domain_name']}"
      level :debug

    end

    # Append this subnet's listen on address here
    # A single DHCP config may listen on multiple network subnets
    unless subnet['dns']['listen_on_address_ipv4'].empty?
      config_listen_on_ipv4_list.append(subnet['dns']['listen_on_address_ipv4'])
    end

    # Append this subnet's listen on address here
    # A single DHCP config may listen on multiple network subnets
    unless subnet['dns']['listen_on_address_ipv6'].empty?
      config_listen_on_ipv6_list.append(subnet['dns']['listen_on_address_ipv6'])
    end

    # Add each forward and reverse zone config to config_zones.
    # This will be used to configure /etc/named.conf later
    subnet['dns']['zones'].each do |zone_name, zone_cfg|

      config_zones[zone_name] = zone_cfg

      # Remove '.in-addr.arpa' from filenames, leaving 'db.9.168.192' (example)
      config_zones[zone_name]['fname'] = zone_name.gsub('.in-addr.arpa', '')

    end

    # Construct a unique list of groups by scanning all nodes here
    groups = []
    subnet['nodes'].each do |_ip, node_cfg|

      unless groups.include? node_cfg['group']
        groups << node_cfg['group']
      end

    end

    # Config file name, ex: db.maxlab
    # Was ok with cfg_net_id when only processing id:maxlab and single subnet
    # But now we need to configure each subnet via its domain_name
    # fname_forward = "/var/named/db.#{cfg_net_id}"
    fname_forward = "/var/named/db.#{subnet['domain_name']}"

    log "log-cn-subnet-#{network_name}" do

      message "debug-log-fname_forward #{fname_forward}"
      level :debug

    end

    # Convert network prefix '192.168.9' to '9.168.192'
    reverse_network = subnet['network_prefix'].split('.')[2] + '.' + subnet['network_prefix'].split('.')[1] + '.' + subnet['network_prefix'].split('.')[0]

    # Config file name, ex: db.9.168.192
    fname_reverse = "/var/named/db.#{reverse_network}"

    # Deploy the forward resolution DNS file
    template fname_forward do

      source 'db.forward.erb'
      variables(
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
      variables(
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
# cfg_listen_ipv4 = case config_bind['config_listen_on_address_ipv4']
#                   when 'ipaddress'
#                     node['ipaddress']
#                   else
#                     config_bind['listen_on_address_ipv4']
#                   end
#
# # Auto configure listening IP address for ipv6 or use a specified value
# cfg_listen_ipv6 = case config_bind['config_listen_on_address_ipv6']
#                   when 'ipaddress'
#                     node['ipaddress']
#                   else
#                     config_bind['listen_on_address_ipv6']
#                   end

log "log-namedconf" do

  message "debug-log-cn-subnet config_bind: #{config_bind}"
  message "debug-log-cn-subnet config_zones #{config_zones}"
  message "debug-log-cn-subnet config_zones #{config_listen_on_ipv4_list}"
  message "debug-log-cn-subnet config_zones #{config_listen_on_ipv6_list}"
  level :debug

end

# Deploy master bind config file
template '/etc/named.conf' do

  source 'named.conf.erb'
  variables(
    {
      config_bind: config_bind,
      config_zones: config_zones,
      # cfg_listen_ipv4: cfg_listen_ipv4,
      # cfg_listen_ipv6: cfg_listen_ipv6,
      config_listen_on_ipv4_list: config_listen_on_ipv4_list,
      config_listen_on_ipv6_list: config_listen_on_ipv6_list
    }
  )

  notifies :reload, 'service[named]', :delayed

end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if config_bind['firewall']['firewalld'].key?('services')
  config_bind['firewall']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if config_bind['firewall']['firewalld'].key?('ports')
  config_bind['firewall']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if config_bind['firewall']['firewalld'].key?('sources')
  config_bind['firewall']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

# Ensure the service starts on boot and is reloaded upon config file updates
service 'named' do

  subscribes :reload, 'template[/etc/named.conf]', :delayed
  action [:enable, :start]

end

# Now that we've deployed a DNS server, tag this node as a DNS server
tag('dns-server')
