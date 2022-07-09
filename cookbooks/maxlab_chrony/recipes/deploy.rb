#
# Cookbook:: maxlab_chrony
# Recipe:: deploy
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.

# Default NTP server to upstream. Works in test kitchen
ntp_server = node['env']['maxlab']['upstream_ntp']

# Load client or server node attributes into a variable for easier
# access and code readability.

# Also set the time source to the first local ntp-server tagged node
# or the upstream internet NTP server

case node['instance_config_chrony']['instance_type']
when 'client'
  config_chrony = node['chrony']['client'].to_h

  # If we're not running in Test Kitchen, set an NTP server
  unless node['kitchen_testing_maxlab']

    ntp_server = search(:node, 'tags:ntp-server')[0]['fqdn']

  end

when 'server'
  config_chrony = node['chrony']['server'].to_h
  ntp_server = node['env']['maxlab']['upstream_ntp']
end

# Identify the first network and subnet from the chrony config
#
network_id, subnet_id_list = node['chrony']['serve_chrony_for'].first

# Select only the first subnet if there are more than one
# Currently this cookbook only configures chrony to support one subnet
# bad 2019 code I don't feel like completely fixing right now.
subnet_id = subnet_id_list.first

# Load network configuration for this network ID only
full_config_network = data_bag_item('config_network', network_id)

# Clip the network config so config_network has only the subnet we need
subnet_info = full_config_network['subnet'][subnet_id]

#
# Automatically configure some options
#

# Construct command to set NTP time source
cfg_pool = "#{config_chrony['options']['pool']['config']} #{ntp_server} #{config_chrony['options']['pool']['config_options']}"

# Replace the 'config' data bag value with this constructed command
config_chrony['options']['pool']['config'] = cfg_pool

# Temp variables which will reset json data bag values
# cfg_allow = ''
# cfg_bindacqaddr = ''
# cfg_cmd_allow = ''
# cfg_bindcmdaddr = ''

# Auto configure options for allowing NTP client access
if config_chrony['options'].key?('allow')

  cfg_allow = case config_chrony['options']['allow']['value']
              when 'auto_subnet'
                # Construct using this node's def. subnet, ex:'192.168.75.0/24'
                "#{config_chrony['options']['allow']['config']} #{subnet_id}/#{subnet_info['network_mask']}"
              else
                # Constrct using manually configured 'value' key
                "#{config_chrony['options']['allow']['config']} #{config_chrony['options']['allow']['value']}"
              end

  # Replace the data bag value with a auto config command to drop in cfg file
  config_chrony['options']['allow']['config'] = cfg_allow
end

# Auto configure options for cmdallowing chroncy client command
if config_chrony['options'].key?('cmdallow')

  cfg_cmd_allow = case config_chrony['options']['cmdallow']['value']
                  when 'auto_subnet'
                    "#{config_chrony['options']['cmdallow']['config']} #{subnet_id}/#{subnet_info['network_mask']}"
                  else
                    "#{config_chrony['options']['cmdallow']['config']} #{config_chrony['options']['cmdallow']['value']}"
                  end

  config_chrony['options']['cmdallow']['config'] = cfg_cmd_allow
end

# Auto configure binding of an IP address to serve Chrony commands
if config_chrony['options'].key?('bindcmdaddress')

  cfg_bindcmdaddr = case config_chrony['options']['bindcmdaddress']['value']
                    when 'auto_ipaddress'
                      "#{config_chrony['options']['bindcmdaddress']['config']} #{node['ipaddress']}"
                    else
                      "#{config_chrony['options']['bindcmdaddress']['config']} #{node['ipaddress']} #{config_chrony['options']['bindcmdaddress']['value']}"
                    end
  config_chrony['options']['bindcmdaddress']['config'] = cfg_bindcmdaddr
end

# Auto configure binding of an IP address to serve Chrony commands
if config_chrony['options'].key?('bindacqaddress')

  cfg_bindacqaddr = case config_chrony['options']['bindacqaddress']['value']
                    when 'auto_ipaddress'
                      "#{config_chrony['options']['bindacqaddress']['config']} #{node['ipaddress']}"
                    else
                      "#{config_chrony['options']['bindacqaddress']['config']} #{node['ipaddress']} #{config_chrony['options']['bindacqaddress']['value']}"
                    end
  config_chrony['options']['bindacqaddress']['config'] = cfg_bindacqaddr
end

# Catches Redhat/Centos/Fedora/etc
os_dist  = node['platform_family']
os_major = node['platform_version'].to_i.to_s

log "os_dist #{os_dist}"
log "os_major #{os_major}"

# Install packages for Chrony
node['chrony']['packages'][os_dist][os_major].each do |pkg, ver|

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

# Master Chrony configuration file
template '/etc/chrony.conf' do
  source 'chrony.conf.erb'
  variables(
    {
      config_chrony: config_chrony
    }
  )
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

if node['instance_config_chrony']['instance_type'] == 'server'
  # Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
  #---

  # Allow this service via the default interface's firewalld zone
  service_zone = node['maxlab_firewall']['default_interface_zone']

  # Add the service to this node's firewalld service requirements
  # Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
  if node['chrony']['firewall']['firewalld'].key?('services')
    node['chrony']['firewall']['firewalld']['services'].each do |service_string|

      unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
        node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
      end

    end
  end

  # Append individual port definitions
  if node['chrony']['firewall']['firewalld'].key?('ports')
    node['chrony']['firewall']['firewalld']['ports'].each do |port_string|

      unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
        node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
      end

    end
  end

  # Append individual sources definitions
  if node['chrony']['firewall']['firewalld'].key?('sources')
    node['chrony']['firewall']['firewalld']['sources'].each do |source_string|

      unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
        node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
      end

    end
  end

end
#---

# Ensure the service starts on boot and is reloaded upon config file updates
service 'chronyd' do
  subscribes :restart, 'template[/etc/chronyd.conf]', :delayed

  action [:enable, :restart]
end

case node['instance_config_chrony']['instance_type']
when 'server'
  tag('ntp-server')
when 'client'
  tag('ntp-client')
end
