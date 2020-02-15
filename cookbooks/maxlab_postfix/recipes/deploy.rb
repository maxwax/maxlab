#
# Cookbook:: maxlab_postfix
# Recipe:: deploy
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Deploy a basic maxlab internal postfix email relay.
#>
=end

#
# Use chef-vault to load encrypted sasl_passwd config
#
# When in Test Kitchen, chef_vault_item will fall back to raw, local
# unencrypted data bag files not included in git
#

chef_gem 'chef-vault' do
  compile_time true if respond_to?(:compile_time)
end

include_recipe 'chef-vault'

sasl_config = chef_vault_item('secret_postfix', 'secret_maxlab_relay')

#
# Required packages
#

package node['postfix']['packages'] do
  action :install
end

# Configure it now that its installed

config_id = node['instance_config_postfix']['instance']

# Retrieve the data bag with postfix config information for this node
#config_postfix = data_bag_item('config_postfix', config_id)
config_postfix = node['postfix']

faux_hostname = "#{node['hostname']}.#{config_postfix['faux_domain']}"

template '/etc/postfix/main.cf' do
  source 'main.cf.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables ({
    queue_directory:   config_postfix['core_config']['queue_directory'],
    command_directory: config_postfix['core_config']['command_directory'],
    daemon_directory:  config_postfix['core_config']['daemon_directory'],
    data_directory:    config_postfix['core_config']['data_directory'],
    mail_owner:        config_postfix['core_config']['mail_owner'],
    myhostname:        faux_hostname,
    inet_interfaces:   config_postfix['core_config']['inet_interfaces'],
    inet_protocols:    config_postfix['core_config']['inet_protocols'],
    mydestination:     config_postfix['core_config']['mydestination'],
    mynetworks:        config_postfix['core_config']['mynetworks'],
    relayhost:         config_postfix['core_config']['relayhost'],
    alias_maps:        config_postfix['core_config']['alias_maps'],
    alias_database:    config_postfix['core_config']['alias_database'],
    debug_peer_level:  config_postfix['core_config']['debug_peer_level'],
    sendmail_path:     config_postfix['core_config']['sendmail_path'],
    newaliases_path:   config_postfix['core_config']['newaliases_path'],
    mailq_path:        config_postfix['core_config']['mailq_path'],
    setgid_group:      config_postfix['core_config']['setgid_group'],
    html_directory:    config_postfix['core_config']['html_directory'],
    additional_config: config_postfix['additional_config'],
    config_id:         config_id
  })

  action :create
end

#
# This the only use of secret values
#

template '/etc/postfix/sasl_passwd' do
  source 'sasl_passwd.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables({
    server_name: sasl_config['server_name'],
    server_port: sasl_config['server_port'],
    username:    sasl_config['username'],
    password:    sasl_config['password']
  })
end

#
# Execute postmap to create a .db file with sasl_passwd values
#

execute 'postmap-saslpasswd' do
  command 'postmap /etc/postfix/sasl_passwd'

  cwd '/etc/postfix'
  user 'root'
  group 'root'

  action :run
end

service 'postfix' do
  action [:enable, :start]
end

tag('postfix')
tag('postfix-relay')
