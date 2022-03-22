#
# Cookbook:: maxlab_base
# Recipe:: deploy
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

# Consult this table to determine the config_os data bag that defines this OSver
os_table = data_bag_item('config_os_table', 'os_table')

# Convert compatible OS versions to base versions: centos8 == rhel8
this_os = os_table[platform_and_version]['config_os']

# Consult this table to determine the config_os data bag that defines this OSver
config_os = data_bag_item('config_os', this_os)

# Download rpm packages that configure repos for this OS. Ex: rpmfusion
config_os['repo_packages'].each do |pkg_name, pkg_details|

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
config_os['repo_config_commands'].each do |_command_name, cmd_details|

  execute cmd_details['command'] do
    command cmd_details['command']

    guard_interpreter :bash

    # Skip this if we see a repo for codeready-builder enabled
    # Not the best guard, but its fast and good enough for me right now
    not_if %(#{cmd_details['not_if']})

  end
end

# Ensure these packages are installed as a common foundation for this OSver
package config_os['default_packages'] do
  action :install
end

# Deploy OS specific scripts for things like /etc/bashrc
config_os['default_os_scripts'].each do |dir_name, dir_config|
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
config_os['default_scripts_generic'].each do |dir_name, dir_config|
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

config_os['cron_jobs'].each do |cron_id, cron_cfg|
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
