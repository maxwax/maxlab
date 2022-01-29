#
# Cookbook:: maxlab_base
# Recipe:: deploy-hardware
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.


=begin
#<
Deploy repos, repo commands, packages and scripts required to support bare metal hardware components.
#>
=end

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

# Consult this table to determine the config_os data bag that defines this OSver
os_table = data_bag_item('config_os_table', 'os_table')

# Convert compatible OS versions to base versions: centos8 == rhel8
this_os = os_table[platform_and_version]['config_os']

# Consult this table to determine the config_os data bag that defines this OSver
config_os = data_bag_item('config_os', this_os)

# Download rpm packages that configure repos for this OS. Ex: rpmfusion
config_os['repo_packages_bare_metal'].each do |pkg_name, pkg_details|

  remote_file "/tmp/#{pkg_details['filename']}" do
    source pkg_details['source']
    action :create

    not_if { node['packages'].key? pkg_name }
  end

  package pkg_name do
    source "/tmp/#{pkg_details['filename']}"
    action :install

    not_if { node['packages'].key? pkg_name }
  end

  file "/tmp/#{pkg_name}" do
    action :delete
  end

end

# Execute any commands related to enabling base repos
# Ex: Red Hat 7 requires an additional 'subscription-manager' command
config_os['repo_config_commands_bare_metal'].each do |config_item, config_commands|

  config_commands.each do |command_name, exec_command|

    execute command_name do
      command exec_command
    end
  end
end

# Ensure these packages are installed as a common foundation for this OSver
package config_os['default_packages_bare_metal'] do
  action :install
end

# Deploy OS specific scripts for things like /etc/bashrc
config_os['default_scripts_bare_metal'].each do |dir_name, dir_config|

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
