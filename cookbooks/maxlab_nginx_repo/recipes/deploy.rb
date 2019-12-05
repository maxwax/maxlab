#
# Cookbook:: maxlab_nginx_repo
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy a simple instance of nginx to serve basic files via HTTP in maxlab.
#>
=end

# Load the main PXE configuration
config_nginx_repo = data_bag_item('config_nginx_repo', node['config_nginx_repo']['instance'])

# Load network information for the network this kickstart config uses
config_network = data_bag_item('config_network', config_nginx_repo['network'])
        
# Pull subnet specific info from the overall network
subnet_info = config_network['subnet'][config_nginx_repo['subnet']]

package %w(nginx) do
  action :install
end

directory config_nginx_repo['root_dir'] do
  owner config_nginx_repo['user']
  group config_nginx_repo['group']
  mode  config_nginx_repo['mode']

  action :create
end

template '/etc/nginx/conf.d/maxlab-repo.conf' do
  source 'maxlab-repo.conf.erb'
  owner  config_nginx_repo['user']
  group  config_nginx_repo['group']
  mode   config_nginx_repo['mode']

  variables(
    port:                config_nginx_repo['port'],
    root_dir:            config_nginx_repo['root_dir'],
    user:                config_nginx_repo['owner'],
    worker_processes:    config_nginx_repo['worker_processes'],
    error_log:           config_nginx_repo['error_log'],
    pid_file:            config_nginx_repo['pid_file'],
    worker_connections:  config_nginx_repo['worker_connections'],
    access_log:          config_nginx_repo['access_log'],
    sendfile:            config_nginx_repo['sendfile'],
    tcp_nopush:          config_nginx_repo['tcp_nopush'],
    tcp_nodelay:         config_nginx_repo['tcp_nodelay'],
    keepalive_timeout:   config_nginx_repo['keepalive_timeout'],
    types_hash_max_size: config_nginx_repo['types_hash_max_size']
  )

  notifies :reload, 'service[nginx]', :delayed
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner  config_nginx_repo['user']
  group  config_nginx_repo['group']
  mode   config_nginx_repo['mode']

  variables(
    port:                config_nginx_repo['port'],
    root_dir:            config_nginx_repo['root_dir'],
    user:                config_nginx_repo['owner'],
    worker_processes:    config_nginx_repo['worker_processes'],
    error_log:           config_nginx_repo['error_log'],
    pid_file:            config_nginx_repo['pid_file'],
    worker_connections:  config_nginx_repo['worker_connections'],
    access_log:          config_nginx_repo['access_log'],
    sendfile:            config_nginx_repo['sendfile'],
    tcp_nopush:          config_nginx_repo['tcp_nopush'],
    tcp_nodelay:         config_nginx_repo['tcp_nodelay'],
    keepalive_timeout:   config_nginx_repo['keepalive_timeout'],
    types_hash_max_size: config_nginx_repo['types_hash_max_size']
  )

  notifies :reload, 'service[nginx]', :delayed
end

#
# TODO - to enable access to /repo, SELinux must be modified
#
#   88  semanage fcontext -a -t httpd_sys_content_t /repo
#   89  restorecon -Rv /repo


# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if not node['maxlab_firewall']['zones'][service_zone]['services'].include? config_nginx_repo['firewall']['firewalld']['service']
  node.normal['maxlab_firewall']['zones'][service_zone]['services'] << config_nginx_repo['firewall']['firewalld']['service']
end

#---

service 'nginx' do
  action [:enable, :start]
end
