#
# Cookbook:: maxlab_users
# Recipe:: general
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

# A serviceset defines the users and groups required on a node to op a service
config_servicesets = data_bag_item('config_servicesets', 'maxlab_global')

# This is a maxlab-wide list of groups with specific GIDs for consistency
config_groups = data_bag_item('config_groups', 'maxlab_global')

# This is a maxlab-wide list of users with specific UIDs for consistency
config_users = data_bag_item('config_users', 'maxlab_global')

# 1. Identify the node's serviceset
# 2. Make any groups defined by the serviceset; config_groups is src for details
# 3. Make any users defined by the serviceset: config_users is the src for details
# 4. config_users may point to a group name; config_groups is the src for group details like GID
# 5. Optionally add each user to other, non-primary groups if config_users requires this.

# relationships
# serviceset -> required users -> config_users
# serviceset -> required groups -> config_groups

service_set = node['config_serviceset']

# relationships
# config_groups -> Group ID

# Make each group defined in the service set and required on this node
config_servicesets[service_set]['groups'].each do |groupname|

  # If we're running in Test Kitchen then bump group IDs up by 1000
  if node.attribute?('kitchen_testing_maxlab') &&
     node['kitchen_testing_maxlab'] == true
    group_id = config_groups[groupname]['gid'].to_i + 1000
  else
    # group_id = config_users[username]['group']
    group_id = config_groups[groupname]['gid']
  end

  group groupname do
    # gid config_groups['gid']
    gid group_id
    system false

    action :create
  end
end

# Make each user defined in the service set and required on this node
config_servicesets[service_set]['users'].each do |username|

  # relationships
  # config_users -> user ID
  # config_users -> group name -> config_groups -> GID

  # Lookup the username in the config_users data bag.
  # From that record, pull the UID number so we can have consistent UIDs
  # across multiple nodes
  # From that record, pull the group name, and make this user's primary
  # group that group name.  Assume the group was created above.

  # If we're running in Test Kitchen then bump user IDs up by 1000
  # Maxwell: Why? Can't remember. Something about the vagrant VM maybe
  if node.attribute?('kitchen_testing_maxlab') &&
     node['kitchen_testing_maxlab'] == true
    user_id = config_users[username]['uid'].to_i + 1000
    # group_name = config_users[groupname]['group'].to_i + 1000
  else
    # group_id = config_users[username]['group']
    user_id = config_users[username]['uid']
    # group_name = config_users[groupname]['group']
  end

  group_name = config_users[username]['group']
  group_id = config_groups[group_name]['gid']

  log 'MAKING USER1' do
    message "DEBUG DEBUG CONFIG_GROUP #{config_groups[group_name].to_s}"
    level :info
  end

  log 'MAKING USER2' do
    message "****** USER GROUP_ID #{group_id}"
    level :info
  end

  user username do
    uid user_id
    gid group_id
    shell config_users[username]['shell']
    comment config_users[username]['fullname']
    manage_home true
    home "/home/#{username}"

    action [:create, :modify]
  end

  # If this user is a member of other groups, add them to those groups here
  config_users[username]['other_groups'].each do |other_group_name|

    group other_group_name do
      append true
      members username

      action [ :manage ]
    end
  end

end

tag('users-#{serviceset}')
