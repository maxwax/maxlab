#
# Cookbook:: maxlab_users
# Recipe:: general
#
# Copyright:: 2020, The Authors, All Rights Reserved.

config_servicesets = data_bag_item('config_servicesets', 'maxlab_global')
config_groups = data_bag_item('config_groups', 'maxlab_global')
config_users = data_bag_item('config_users', 'maxlab_global')

service_set = 'general'

# Create all groups defined in this service set
config_servicesets[service_set]['groups'].each do | groupname |

  group groupname do
    gid config_groups['gid']
    system false

    action :create
  end

end

# Create all users defined in this service set
config_servicesets[service_set]['users'].each do | username |

  user username do
    uid config_users[username]['uid']
    gid config_users[username]['group']
    shell config_users[username]['shell']
    comment config_users[username]['fullname']

    action :create
  end

end
