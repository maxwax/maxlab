#
# Cookbook:: mylab_nginx_repo
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy a simple instance of nginx to serve basic files via HTTP in maxlab.
#>
=end

include_recipe 'maxlab_nginx_repo::deploy'
