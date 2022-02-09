#
# Cookbook:: maxlab_apcupsd
# Recipe:: deploy
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

# Deploy packages for the apcupsd service
package node['apcupsd']['packages'] do
  action :install
end

# Identify a unique configuration for the service apcsupd
# as defined in the node's policyfile as a node attribute
config_id = node['instance_config_apcupsd']['instance']

# 2022-0126 OBSOLETE USE OF DATA BAG, using attributes in policyfile instead
# Retrieve the data bag with apcsupd config information for this node
# config_apcupsd = data_bag_item('config_apcupsd', config_id)

# Deploy the system-wide configuration file for apcupsd on this node
template '/etc/apcupsd/apcupsd.conf' do
  source 'apcupsd.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables({
      config_id: config_id,
      config_apcupsd: node['apcupsd']['config']
  })

  action :create
end

# Deploy a custom apccontrol script, mostly just to embed a custom email address
template '/etc/apcupsd/apccontrol' do
  source 'apccontrol.erb'

  owner 'root'
  group 'root'
  mode '0755'

  variables({
      config_id: config_id,
      sysadmin: node['apcupsd']['config']['sysadmin']
  })

  action :create
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if node['apcupsd']['firewalld'].key?('services')
  node['apcupsd']['firewalld']['services'].each do |service_string|
    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end
  end
end

# Append individual port definitions
if node['apcupsd']['firewalld'].key?('ports')
  node['apcupsd']['firewalld']['ports'].each do |port_string|
    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end
  end
end

# Append individual sources definitions
if node['apcupsd']['firewalld'].key?('sources')
  node['apcupsd']['firewalld']['sources'].each do |source_string|
    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end
  end
end

#---

# Configure this service's daemons to be enabled and start each of them
node['apcupsd']['services'].each do |service_name|
  service service_name do
    action [ :enable, :start ]
  end
end

# Deploy logging script regardless of whether we schedule it with cron
cookbook_file '/usr/local/bin/log-apc-ups-stats' do
  source 'usr/local/bin/log-apc-ups-stats'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

if node['apcupsd']['config']['enable_logger'] == true
  cron 'cron_job_apcups_logger' do
    command '/usr/local/bin/log-apc-ups-stats'

    month  node['apcupsd']['config']['log_month']
    day    node['apcupsd']['config']['log_day']
    hour   node['apcupsd']['config']['log_hour']
    minute node['apcupsd']['config']['log_minute']

    action :create
  end

end

# Tag the node as supporting this service
tag('apcupsd')
# Tag the node as operating this configuration of the service
tag(config_id)
