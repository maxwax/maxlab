#
# Cookbook:: maxlab_base
# Recipe:: deploy_svc_base
#
# Copyright:: 2022, Maxwell Spangler, All Rights Reserved.

#
# Optionally configure a variety of repos, packages, commands etc to support
# services deployed on a node calling this recipe.
#
# Ex: Define optional packages for video processing and always deploy them
# on nodes supporting video processing activities, regardless of underlying
# OS distribution/version/etc.
#

# The ID should be set in a policyfile associated with each node
config_base = data_bag_item('config_base', node['config_base']['id'])

# Download rpm packages that configure repos for this OS. Ex: rpmfusion
config_base['repo_packages'].each do |pkg_name, pkg_details|

  remote_file "/tmp/#{pkg_details['filename']}" do
    source pkg_details['source']
    action :create

    not_if { node['packages'].key? pkg_details['not_if_package'] }
  end

  package pkg_name do
    source "/tmp/#{pkg_details['filename']}"
    action :install

    not_if { node['packages'].key? pkg_details['not_if_package'] }
  end

  file "/tmp/#{pkg_name}" do
    action :delete
  end
end

# Execute any commands related to enabling base repos
# Ex: Red Hat 7 requires an additional 'subscription-manager' command
config_base['repo_config_commands'].each do |_command_name, cmd_details|

  execute cmd_details['command'] do
    command cmd_details['command']

    guard_interpreter :bash

    # Skip this if we see a repo for codeready-builder enabled
    # Not the best guard, but its fast and good enough for me right now
    not_if %(#{cmd_details['not_if']})

  end
end

# Ex: Software that might be installed via Python pip or ruby's gem
config_base['sw_install_commands'].each do |_command_name, cmd_details|

  execute cmd_details['command'] do
    command cmd_details['command']

    guard_interpreter :bash

    # Skip this if we see a repo for codeready-builder enabled
    # Not the best guard, but its fast and good enough for me right now
    not_if %(#{cmd_details['not_if']})

  end
end

# Ensure these packages are installed as a common foundation for this OSver
package config_base['default_packages'] do
  action :install
end

# Deploy OS specific scripts for things like /etc/bashrc
config_base['default_os_scripts'].each do |dir_name, dir_config|
  dir_config.each do |file_name, file_config|
    template "#{dir_name}/#{file_name}" do
      source "#{this_os}/#{file_config['subdir']}/#{file_name}.erb"

      owner file_config['owner']
      group file_config['group']
      mode file_config['mode']

      action :create
    end
  end
end

# Deploy OS specific scripts for things like /etc/bashrc
config_base['default_scripts_generic'].each do |dir_name, dir_config|
  dir_config.each do |file_name, file_config|
    cookbook_file "#{dir_name}/#{file_name}" do
      source "#{dir_name}/#{file_name}"

      owner file_config['owner']
      group file_config['group']
      mode file_config['mode']

      action :create
    end
  end
end

config_base['cron_jobs'].each do |cron_id, cron_cfg|
  cron cron_id do
    command     cron_cfg['command']
    minute      cron_cfg['minute']
    hour        cron_cfg['hour']
    day         cron_cfg['day']
    month       cron_cfg['month']
    weekday     cron_cfg['day_of_week']
    user        cron_cfg['user']

    action :create
  end
end
