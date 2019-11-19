#
# Cookbook:: maxlab_firewall
# Recipe:: base_firewall
#
# Copyright:: 2019, The Authors, All Rights Reserved.



#firewall 'default' do
#  ipv6_enabled node['firewall']['ipv6_enabled']
##  enabled_zone :public
#  action :install
#end
#
#firewall_rule 'SSH' do
#  port 22
#  source '0.0.0.0/0'
#  command :allow
#  only_if { linux? && node['firewall']['allow_ssh'] }
#  action :create
#end
#
#firewall_rule 'P5000' do
#  port 5000
#  source '0.0.0.0/0'
#  command :allow
#  action :create
#end
