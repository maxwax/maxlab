#
# Cookbook:: maxlab_prometheus
# Recipe:: server
#
# Copyright:: 2022, Maxwell Spangler, All Rights Reserved.

# July 2022: This is an old pattern to load service configuration data via a data bag instead of node attributes.
# In this cookbook I'm switching back to cookbook attibutes with overrides possible in policyfiles.
# The config file should be used to customize the *service instance* of the standard deployment.  Tuning, etc.

# config_id = node['instance_config_prometheus']['instance']

# Retrieve the data bag with prometheus config information for this node
# config_prom_server = data_bag_item('config_prometheus', config_id)

# Create a service-specific group to operate Prometheus server
group node['prometheus']['server']['group'] do

  system false
  action :create

end

# Create a home for a service-specific user
directory "/home/#{node['prometheus']['server']['user']}" do

  mode '0755'
  action :create

end

# Create a service-specific user to operate Prometheus server
user node['prometheus']['server']['user'] do

  gid node['prometheus']['server']['group']
  comment 'Prometheus Services'
  home "/home/#{username}"

  action :create

end

# In a Test Kitchen VM, simulate a dedicated metrics storage backend
# by simply creating a mock /metrics directory
# This attribute only exists when set in a kitchen.yml file for a vm
if node.exist?('kitchen_testing_maxlab')

  directory node['prometheus']['server']['metrics_backend'] do

    owner node['prometheus']['server']['user']
    group node['prometheus']['server']['group']
    mode '0755'

    recursive false

    action :create

    # not_if is crtiical.
    # Attempting to execute this directory resource on an existing
    # directory may result in an SELinux 'restorecon -R' being
    # issued to restore the context of MANY files mounted at
    # an existing filesystem mount point.

    not_if { ::File.directory?(node['prometheus']['server']['metrics_backend']) }

  end
end

# Create a directory to hold metric data
# Ideally this is on time series database optimized backend storage
directory "#{node['prometheus']['server']['metrics_dir']}" do

  owner node['prometheus']['server']['user']
  group node['prometheus']['server']['group']
  mode '0755'

  action :create

end

#
# Download Prometheus from maxlab repo
#

# Download prometheus .tar.gz file to here
tmp_tarball_file = "/tmp/#{node['prometheus']['server']['tarball']['filename']}"

# Ex: http://green.maxlab/images-dirs.tar
tarball_source = "#{node['env']['maxlab']['tarballs_url']}/#{node['prometheus']['server']['tarball']['filename']}"

# Download prometheus tarball
remote_file tmp_tarball_file do

  source tarball_source
  owner node['prometheus']['server']['user']
  group node['prometheus']['server']['group']
  mode '0744'

  action :create

  not_if do

    File.exist?("#{tmp_tarball_file}") ||
      File.exist?("#{node['prometheus']['server']['deploy_executable']}")

  end

end

# We require this and a minimal server install does not have it.
package 'tar' do

  action :install

  not_if { node['packages'].key? 'tar' }

end

# Both create the destination directory and untar files into it
# If the directory already exists, the files won't be unpacked.
archive_file tmp_tarball_file do

  destination "#{node['prometheus']['server']['deploy_dir']}"
  owner node['prometheus']['server']['user']
  group node['prometheus']['server']['group']
  mode '0755'

  action :extract

  not_if { ::File.exist?("#{node['prometheus']['server']['deploy_executable']}") }

end

# Ensure this exists
directory "#{node['prometheus']['server']['deploy_dir']}" do

  owner node['prometheus']['server']['user']
  group node['prometheus']['server']['group']
  mode '0755'

  action :create

end

# Delete the tmp file when done, it can be quite large
file tmp_tarball_file do

  action :delete

  only_if { ::File.exist?("#{tmp_tarball_file}") }

end

template "#{node['prometheus']['server']['deploy_dir']}/prometheus.yml" do

  source 'prometheus.yml.erb'
  owner node['prometheus']['server']['user']
  group node['prometheus']['server']['group']
  mode '0644'

  variables(
    scrape_configs: node['prometheus']['server']['scrape_configs']
  )

  action :create

end

# Deploy a systemd unit file to start/stop/reload the prometheus server
template "/etc/systemd/system/#{node['prometheus']['server']['systemd-unit-file']}" do

  source "#{node['prometheus']['server']['systemd-template-file']}"

  owner 'root'
  group 'root'
  mode '0644'

  action :create

end

# Reload the systemd unit files since we just dropped in a new one.
execute 'systemctl-daemon-reload' do

  command 'systemctl daemon-reload'

end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if node['prometheus']['server']['firewalld'].key?('services')
  node['prometheus']['server']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if node['prometheus']['server']['firewalld'].key?('ports')
  node['prometheus']['server']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if node['prometheus']['server']['firewalld'].key?('sources')
  node['prometheus']['server']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

node['prometheus']['server']['services'].each do |service_name|

  service service_name do

    action [ :enable, :start, :restart ]

  end

end

tag('prometheus-server')
