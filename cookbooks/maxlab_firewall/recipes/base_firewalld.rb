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

# Load a data bag with a base firewall configuration
# base_config is set via a role in the node's runlist (set manually)
config_firewall_base =
  data_bag_item('config_firewall', node['config_firewall']['base_config'])

# On a new node, assign the base firewall config
# to this persistent node attribute
if not node.attribute?('maxlab_firewall')
  node.normal['maxlab_firewall'] = config_firewall_base['fw_config']
else

  puts
  puts "DEBUG - maxlab_firewall::base_firewalld -Current node['maxlab_firewall']"
  puts
  pp node['maxlab_firewall']
  puts
  puts "About to merge config_firewall_base['fw_config'] for type node['config_firewall']['base_config']"
  puts
  pp config_firewall_base['fw_config'].to_h
  puts

  # On an existing config, merge the data bag values with this node's values
  # So that any out of date values on the node (zones) are replaced and any
  # additional values are added to the node.
  node.normal['maxlab_firewall'].merge!(config_firewall_base['fw_config'])

  puts
  puts "DEBUG - maxlab_firewall::base_firewalld AFTER MERGE node['maxlab_firewall']"
  pp node['maxlab_firewall']
  puts

end

# Now 'maxlab_firewall' is either the data bag defined values or a mix of
# previously applied firewall settings and the current data bag values.
# So we are ready to configure this node's firewall

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
