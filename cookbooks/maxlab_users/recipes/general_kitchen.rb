#
# Cookbook:: maxlab_users
# Recipe:: general_kitchen
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

config_servicesets = data_bag_item('config_servicesets', 'maxlab_global')
config_groups = data_bag_item('config_groups', 'maxlab_global')
config_users = data_bag_item('config_users', 'maxlab_global')

service_set = 'general'

# Create all groups defined in this service set
config_servicesets[service_set]['groups'].each do |groupname|

  group_id = config_groups[groupname]['gid'].to_i + 1000

  group groupname do
    gid group_id
    system false

    action :create
  end
end

# Create all users defined in this service set
config_servicesets[service_set]['users'].each do |username|

  user_id  = config_users[username]['uid'].to_i   + 1000
  group_id = config_users[username]['group'].to_i + 1000

  user username do
    # uid config_users[username]['uid']
    # gid config_users[username]['group']
    uid user_id
    gid group_id
    shell config_users[username]['shell']
    comment config_users[username]['fullname']

    action :create
  end
end

tag('users-general')
