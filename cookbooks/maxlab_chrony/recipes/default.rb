#
# Cookbook:: maxlab-chrony
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Configure the Chrony NTP client in a standard fashion.
#>
=end

# Load Chrony config from data bag
full_config_chrony = data_bag_item('config_chrony',             node['config_chrony']['instance'])

# Load config_chrony with only the client or server data bag config
# Also set the time source to the first local ntp-server tagged node
# or the upstream internet NTP server
case node['config_chrony']['instance_type']

  when 'client'
    config_chrony = full_config_chrony['client']

    ntp_server = search(:node, "tags:ntp-server")[0]['fqdn']

  when 'server'
    config_chrony = full_config_chrony['server']

    ntp_server = node['global']['upstream_ntp']

end

# Identify the first network and subnet from the chrony config
#
# If the config has multiple, we can currently only use one, so use first
# This is a bad limitation, but OK, for now, for our home lab use
network_id, subnet_id = full_config_chrony['serve_chrony_for'].first

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
cfg_allow= ""
cfg_bindacqaddress = ""
cfg_cmd_allow = ""
cfg_bindcmdaddress = ""

# Auto configure options for allowing NTP client access
if config_chrony['options'].has_key?('allow')

  case config_chrony['options']['allow']['value']
    when 'auto_subnet'
      # Construct using this node's default subnet, ex:'192.168.75.0/24'
      cfg_allow = "#{config_chrony['options']['allow']['config']} #{subnet_id}/#{subnet_info['network_mask']}"
    else
      # Constrct using manually configured 'value' key
      cfg_allow = "#{config_chrony['options']['allow']['config']} #{config_chrony['options']['allow']['value']}"
  end

  # Replace the data bag value with a auto configured command to drop in cfg file
  config_chrony['options']['allow']['config'] = cfg_allow
end

# Auto configure options for cmdallowing chroncy client command
if config_chrony['options'].has_key?('cmdallow')

  case config_chrony['options']['cmdallow']['value']
    when 'auto_subnet'
      cfg_cmdallow = "#{config_chrony['options']['cmdallow']['config']} #{subnet_id}/#{subnet_info['network_mask']}"
    else
      cfg_cmdallow = "#{config_chrony['options']['cmdallow']['config']} #{config_chrony['options']['cmdallow']['value']}"
  end
  config_chrony['options']['cmdallow']['config'] = cfg_cmdallow
end

# Auto configure binding of an IP address to serve Chrony commands
if config_chrony['options'].has_key?('bindcmdaddress')

  case config_chrony['options']['bindcmdaddress']['value']
    when 'auto_ipaddress'
      cfg_bindcmdaddress = "#{config_chrony['options']['bindcmdaddress']['config']} #{node['ipaddress']}"
    else
      cfg_bindcmdaddress = "#{config_chrony['options']['bindcmdaddress']['config']} #{node['ipaddress']} #{config_chrony['options']['bindcmdaddress']['value']}"
  end
  config_chrony['options']['bindcmdaddress']['config'] = cfg_bindcmdaddress
end

# Auto configure binding of an IP address to serve Chrony commands
if config_chrony['options'].has_key?('bindacqaddress')

  case config_chrony['options']['bindacqaddress']['value']
    when 'auto_ipaddress'
      cfg_bindacqaddress = "#{config_chrony['options']['bindacqaddress']['config']} #{node['ipaddress']}"
    else
      cfg_bindacqaddress = "#{config_chrony['options']['bindacqaddress']['config']} #{node['ipaddress']} #{config_chrony['options']['bindacqaddress']['value']}"
  end
  config_chrony['options']['bindacqaddress']['config'] = cfg_bindacqaddress
end

# Catches Redhat/Centos/Fedora/etc
os_dist  = node['platform_family']
os_major = node['platform_version'].split('.')[0]

# Install packages for Chrony
chrony_packages = node['chrony']['packages'][os_dist][os_major].each do |pkg, ver|
  package pkg do
    version ver
    action :install
  end
end

# Master Chrony configuration file
template '/etc/chrony.conf' do
  source 'chrony.conf.erb'
  variables (
    {
      config_chrony: config_chrony,
      ntp_server: ntp_server,
      subnet_info: subnet_info
    }
  )
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

if node['config_chrony']['instance_type'] == 'server'
  # Allow this service via the default interface's firewalld zone
  service_zone = node['maxlab_firewall']['default_interface_zone']

  # Add the service to this node's firewalld service requirements
  # Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
  if not node['maxlab_firewall']['zones'][service_zone]['services'].include? full_config_chrony['firewall']['firewalld']['service']
    node.normal['maxlab_firewall']['zones'][service_zone]['services'] << full_config_chrony['firewall']['firewalld']['service']
  end

  # Add the chronyc port to this node's firewalld service requirements
  if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? full_config_chrony['firewall']['firewalld']['ports']
    node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << full_config_chrony['firewall']['firewalld']['ports']
  end

end
#---

# Ensure the service starts on boot and is reloaded upon config file updates
service 'chronyd' do
  subscribes :restart, 'template[/etc/chronyd.conf]', :delayed

  action [:enable, :restart]
end
