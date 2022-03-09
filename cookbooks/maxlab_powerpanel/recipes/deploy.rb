#
# Cookbook:: maxlab_powerpanel
# Recipe:: deploy
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

remote_file_source = "#{node['powerpanel']['url']}/#{node['powerpanel']['filename']}"

local_rpm_file = "/tmp/#{node['powerpanel']['filename']}"

remote_file local_rpm_file do
  source remote_file_source
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Deploy packages for the powerpanel service
# package node['powerpanel']['packages'] do
package node['powerpanel']['filename'] do
  source local_rpm_file

  action :install
end

# Identify a unique configuration for the service apcsupd
# as defined in the node's policyfile as a node attribute
config_id = node['instance_config_powerpanel']['instance']

# Deploy the system-wide configuration file for powerpanel on this node
template '/etc/pwrstatd.conf' do
  source 'pwrstatd.conf.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables({
      config_id: config_id,
      config_powerpanel: node['powerpanel']['config']
  })

  action :create
end

# Configure this service's daemons to be enabled and start each of them
node['powerpanel']['services'].each do |service_name|
  service service_name do
    action [ :enable, :start ]
  end
end

# Deploy logging script regardless of whether we schedule it with cron
cookbook_file '/usr/local/bin/log-powerpanel-ups-stats' do
  source 'usr/local/bin/log-powerpanel-ups-stats'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

if node['powerpanel']['config']['enable_logger'] == true
  cron 'cron_job_ups_logger' do
    command '/usr/local/bin/log-powerpanel-ups-stats'

    month  node['powerpanel']['config']['log_month']
    day    node['powerpanel']['config']['log_day']
    hour   node['powerpanel']['config']['log_hour']
    minute node['powerpanel']['config']['log_minute']

    action :create
  end

end

# Tag the node as supporting this service
tag('powerpanel')
# Tag the node as operating this configuration of the service
tag(config_id)
