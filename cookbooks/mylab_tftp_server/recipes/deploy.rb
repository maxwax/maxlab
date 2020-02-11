#
# Cookbook:: mylab_tftp_server
# Recipe:: deploy
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Wrapper for maxlab_tftp_server::deploy to deploy a basic TFTP server.
#>
=end

include_recipe 'maxlab_tftp_server::deploy'
