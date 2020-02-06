#
# Cookbook:: mylab_smartd
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Experimental wrapper cookbook to maxlab_smartd that deploys smartd for storage health monitoring. Uses experimental methods to use data bags to replace node attributes.
#>
=end

# PLEASE IGNORE THE MESS - WORK IN PROGRESS.

# puts
# puts "DEBUG WRAPPER COOKBOOK mylab_smartd node['smartd']['cfg']"
# puts
# pp node['smartd']['cfg']
# puts

# puts
# puts "DEBUG ENTRY TO WRAPPER node['smartd']['cfg']"
# pp node['smartd']['cfg']
# pp node['smartd']['cfg'].class
# puts

# Remove default tree branches from maxcomm_smartd cookbook
# without_sda = node['smartd']['cfg'].reject { |k,v| k == 'sda'}
# without_sdb = without_sda.reject { |k,v| k == 'sdb'}

# puts
# puts "DEBUG MANIPULATE without_sdb variable"
# pp without_sdb
# pp without_sdb.class
#
# MERGE force_override the
#node.force_override['smartd']['cfg'] = without_sdb

# puts
# puts "DEBUG FORCE_DEFAULT NODE TO WITHOUT_SDB node['smartd']['cfg']"
# pp node['smartd']['cfg']

# If this is done, then we remove the whole tree and
#node.default['smartd']['cfg'][sda] = {}
#node.default['smartd']['cfg'][sdb] = {}

#
# LAST CALL TO DATA BAG REMOVED HERE
#

config_smartd = data_bag_item('config_smartd', "#{node['domain']}_#{node['hostname']}")

# MERGE override this cookbook and the community cookbook values with data bag values
node.force_default['smartd']['cfg'] = config_smartd['cfg']

# puts
# puts "DEBUG FORCE DEFAULT WITH DATA BAG TO node['smartd']['cfg']"
# pp node['smartd']

# puts
# puts "DEBUG LEAVING WRAPPER ^^ USING ^^ THIS IN COMMUNITY"

include_recipe 'maxlab_smartd::deploy'
