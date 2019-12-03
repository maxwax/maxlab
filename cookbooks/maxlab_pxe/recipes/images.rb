#
# Cookbook:: maxlab_pxe
# Recipe:: images
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy Linux Distribution images (kernel and initrd files) to support PXE boots
#>
=end

# Load the main PXE configuration
config_pxe = data_bag_item('config_pxe', 'pxeconfig').to_h

# Ex: /var/lib/tftpboot/images
images_dir = "#{config_pxe['pxelinux_cfg_root']}/#{config_pxe['default_kernel_dir']}"

# Ex: images-dirs.tar
images_name = config_pxe['images_source']['filename']

tmp_file = "/tmp/#{config_pxe['images_source']['filename']}"

# Ex: http://green.maxlab/images-dirs.tar
images_http_name = "#{config_pxe['images_source']['http']}/#{config_pxe['images_source']['filename']}"

if not File.directory?(images_dir)

  # Create 'images' directory in tftpboot dir
  directory images_dir do
    owner config_pxe['user']
    group config_pxe['user']
    mode 0755
    action :create
  end

  # Download a tar file with manually prepared kernel, initrd and tools images
  remote_file tmp_file do
    source images_http_name
    owner config_pxe['user']
    group config_pxe['user']
    mode 0755
    action :create
  end

  # We require this and a minimal server install does not have it.
  package 'tar' do
    action :install
  end

  # Untar the file to make the files available
  execute "untar" do
    command 'tar xvf /tmp/images-dirs.tar'
    cwd "#{config_pxe['pxelinux_cfg_root']}/#{config_pxe['default_kernel_dir']}"
    action :run
  end

  # Delete the tmp file when done, it can be quite large
  file tmp_file do
    action :delete
  end

end
