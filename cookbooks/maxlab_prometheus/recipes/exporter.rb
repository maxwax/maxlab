#
# Cookbook:: maxlab_prometheus
# Recipe:: node_exporter
#
# Copyright:: 2022, Maxwell Spangler, All Rights Reserved.

# config_id = node['instance_config_prometheus']['instance']
#
# # Retrieve the data bag with prometheus config information for this node
# config_prom_server = data_bag_item('config_prometheus', config_id)

#
# Create group and user for this service
#

group node['prometheus']['node_exporter']['group'] do

  system false

  action :create

end

# Ensure this exists
directory "/home/#{node['prometheus']['node_exporter']['user']}" do

  mode '0755'

  action :create

end

user node['prometheus']['node_exporter']['user'] do

  gid node['prometheus']['node_exporter']['group']
  comment 'Prometheus Node Exporter Services'
  home "/home/#{username}"

  action :create

end

#
# Download Prometheus from maxlab repo
#

# Download prometheus .tar.gz file to here
tmp_tarball_file = "/tmp/#{node['prometheus']['node_exporter']['tarball']['filename']}"

# Ex: http://green.maxlab/images-dirs.tar
tarball_source = "#{node['env']['maxlab']['tarballs_url']}/#{node['prometheus']['node_exporter']['tarball']['filename']}"

# Download prometheus tarball
remote_file tmp_tarball_file do

  source tarball_source
  owner node['prometheus']['node_exporter']['user']
  group node['prometheus']['node_exporter']['group']
  mode '0744'

  action :create

  not_if do

    ::File.exist?("#{tmp_tarball_file}") ||
      File.exist?("#{node['prometheus']['node_exporter']['deploy_executable']}")

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

  destination "#{node['prometheus']['node_exporter']['deploy_dir']}"
  owner node['prometheus']['node_exporter']['user']
  group node['prometheus']['node_exporter']['group']
  mode '0755'

  action :extract

  not_if { ::File.exist?("#{node['prometheus']['node_exporter']['deploy_executable']}") }

end

# Ensure this exists
directory "#{node['prometheus']['node_exporter']['deploy_dir']}" do

  owner node['prometheus']['node_exporter']['user']
  group node['prometheus']['node_exporter']['group']
  mode '0755'

  action :create

end

# Delete the tmp file when done, it can be quite large
file tmp_tarball_file do

  action :delete

  only_if { ::File.exist?("#{tmp_tarball_file}") }

end

# Deploy a systemd unit file to start/stop/reload the prometheus server
template "/etc/systemd/system/#{node['prometheus']['node_exporter']['systemd-unit-file']}" do

  source "#{node['prometheus']['node_exporter']['systemd-template-file']}"

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
if node['prometheus']['node_exporter']['firewalld'].key?('services')
  node['prometheus']['node_exporter']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if node['prometheus']['node_exporter']['firewalld'].key?('ports')
  node['prometheus']['node_exporter']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if node['prometheus']['node_exporter']['firewalld'].key?('sources')
  node['prometheus']['node_exporter']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

node['prometheus']['node_exporter']['services'].each do |service_name|

  service service_name do

    action [ :enable, :start ]

  end

end

tag('node-exporter')
