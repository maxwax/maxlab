#
# Cookbook:: maxlab_pxe
# Recipe:: images
#
# Copyright:: 2019, Maxwell Spangler, All Rights Reserved.

# Load the main PXE configuration
config_pxe = data_bag_item('config_pxe', 'pxeconfig')

# Ex: /var/lib/tftpboot/images
images_dir = "#{config_pxe['pxelinux_cfg_root']}/#{config_pxe['default_kernel_dir']}"

# Create this flag file after the initial run of deploying tftp boot images
# After the initial images file is untarred it is expected that the admin
# will manually manipulate image files directly.
images_flag_file = "#{images_dir}/#{config_pxe['images_flag_file']}"

tmp_file = "/tmp/#{config_pxe['images_source']['filename']}"

# Ex: http://green.maxlab/images-dirs.tar
images_http_name = "#{config_pxe['images_source']['http']}/#{config_pxe['images_source']['filename']}"

# Create 'images' directory in tftpboot dir
directory images_dir do
  owner config_pxe['user']
  group config_pxe['user']
  mode '0755'
  action :create

  not_if { File.exist?("#{images_flag_file}") }
end

# Download a tar file with manually prepared kernel, initrd and tools images
remote_file tmp_file do
  source images_http_name
  owner config_pxe['user']
  group config_pxe['user']
  mode '0755'

  action :create

  not_if { File.exist?("#{images_flag_file}") }
end

# We require this and a minimal server install does not have it.
package 'tar' do
  action :install

  not_if { node['packages'].key? "tar" }
end

# Untar the file to make the files available
execute 'untar' do
  command 'tar xvf /tmp/images-dirs.tar'
  cwd "#{config_pxe['pxelinux_cfg_root']}/#{config_pxe['default_kernel_dir']}"
  action :run

  not_if { File.exist?("#{images_flag_file}") }
end

# Delete the tmp file when done, it can be quite large
file tmp_file do
  action :delete

  only_if { File.exist?("#{tmp_file}") }
end

file "#{images_flag_file}" do
  content "This flag file is deployed by CHEF to indicate an initial images.tar file has been deployed.  Further content is manipulated manually."
  owner 'root'
  group 'root'
  mode '0755'

  action :create

  not_if { File.exist?("#{images_flag_file}") }
end
