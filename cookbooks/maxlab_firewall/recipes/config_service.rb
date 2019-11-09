#
# Cookbook:: maxlab_firewall
# Recipe:: config_service
#
# Copyright:: 2019, The Authors, All Rights Reserved.

#include_recipe 'firewall::default'

firewall 'default' do
  ipv6_enabled node['firewall']['ipv6_enabled']
  action :install
end

firewall_rule 'allow world to ssh' do
  port 22
  source '0.0.0.0/0'
#  only_if { linux? && node['firewall']['allow_ssh'] }
end

firewall_rule 'Allow DNS requests to BIND/named' do
  port 53
  source '0.0.0.0/0'
end
