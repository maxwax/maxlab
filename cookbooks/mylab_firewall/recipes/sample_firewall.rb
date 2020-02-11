#
# Cookbook:: mylab_firewall
# Recipe:: sample_firewall
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Wrapper to maxlab_firewall for experimental purposes.
#>
=end

# # Open three sample services
# node.default['faux_service']['firewall']['firewalld']['services'] = [ "http", "https", "ssh" ]
#
# # Open two ports
# node.default['faux_service']['firewall']['firewalld']['ports'] = [ "5000/tcp", "5000/udp" ]
#
# #
# node.default['faux_service']['firewall']['firewalld']['sources'] = [ "10.0.2.100" ]

#---

include_recipe ['maxlab_firewall::sample_firewall']
