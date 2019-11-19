#
# Cookbook:: maxlab_firewall
# Recipe:: base_firewall
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Install firewalld and use a configuration defined via data bag to configure default zone, default interface zone, etc.
#>
=end

# When provisioning a freshly built node, set this node attribute with the
# data bag base firewall configuration
if not node.attribute?('maxlab_firewall')

  # Load a data bag with a base firewall configuration
  # base_config is set via a role in the node's runlist (set manually)
  config_firewall_base =
    data_bag_item('config_firewall', node['config_firewall']['base_config']).to_h

  node.normal['maxlab_firewall'] = config_firewall_base
end

# Install firewalld required package(s)
package 'firewalld' do
  action :install
end

# Set the default firewall zone
execute 'set-default-zone' do
  command "firewall-cmd --set-default-zone=#{node['maxlab_firewall']['default_zone']}"
  action :run
end

# Set the default network interface (identified via ohai) to the default fw zone
execute 'set-default-interface-default-zone' do
  command "firewall-cmd --change-interface=#{node['network']['default_interface']} --zone=#{node['maxlab_firewall']['default_interface_zone']}"
  action :run
end

# Ensure this service is enabled to start upon boot
service 'firewalld' do
  action [ :enable, :start ]
end
