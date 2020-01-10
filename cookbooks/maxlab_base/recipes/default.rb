#
# Cookbook:: maxlab-base
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Load a config data bag that defines base requirements for each supported OS
base_config = data_bag_item('config_base', node['config_base'])

# Ex: 'rhelv8', 'centosv7', 'fedorav30'
this_os = node['platform'] + "v" + node['platform_version'].split('.')[0]

distver_found = false

#
# Iterate through defined OS and act when we find ours
#
base_config['distver'].each do |distver, dist_config|

  if distver.include? this_os

    distver_found = true

    dist_config['repo_packages'].each do |pkg_name, pkg_details|

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

    dist_config['default_packages'].each do |pkg_name|
      package pkg_name do
        action :install
      end
    end

    #
    # For each configured dir (ex: /usr/local/etc), deploy each file defined
    #

    dist_config['default_scripts'].each do |dir_name, dir_config|

      dir_config.each do |file_name, file_config|

        template "#{dir_name}/#{file_name}" do
          source "#{file_config['subdir']}/#{file_name}.erb"

          owner file_config['owner']
          group file_config['group']
          mode file_config['mode']

          action :create
        end
      end

    end
  end
end

if distver_found == false
  log "ERROR: maxlab_base could not find this node's supported distribution + version defined in data bag config_base.  No base packages or scripts have been deployed."
end
