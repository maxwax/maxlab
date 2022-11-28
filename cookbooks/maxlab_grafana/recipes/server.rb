#
# Cookbook:: maxlab_grafana
# Recipe:: server
#
# Copyright:: 2022, Maxwell Spangler, All Rights Reserved.

# Create a service-specific group to operate grafana server
group node['grafana']['server']['group'] do

  system false
  action :create

end

# Create a home for a service-specific user
directory "/home/#{node['grafana']['server']['user']}" do

  mode '0755'
  action :create

end

# Create a service-specific user to operate grafana server
user node['grafana']['server']['user'] do

  gid node['grafana']['server']['group']
  comment 'grafana Services'
  home "/home/#{username}"

  action :create

end

yum_repository "grafana" do
  baseurl "https://packages.grafana.com/oss/rpm"
  description "Grafana public OSS yum repo"
  enabled true

  gpgkey "https://packages.grafana.com/gpg.key"
  skip_if_unavailable true

  action :create
end


# We require this and a minimal server install does not have it.
package 'grafana' do

  action :install

  not_if { node['packages'].key? 'grafana' }

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
if node['grafana']['server']['firewalld'].key?('services')
  node['grafana']['server']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if node['grafana']['server']['firewalld'].key?('ports')
  node['grafana']['server']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if node['grafana']['server']['firewalld'].key?('sources')
  node['grafana']['server']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

node['grafana']['server']['services'].each do |service_name|

  service service_name do

    action [ :enable, :start, :restart ]

  end

end

tag('grafana-server')
