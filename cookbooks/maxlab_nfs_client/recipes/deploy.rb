#
# Cookbook:: maxlab_nfs_client
# Recipe:: deploy
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Configure an NFS client
#>
=end

package node['nfs_client']['packages'] do
  action :install
end

config_id = node['instance_config_nfs_client']['instance']

# Retrieve the data bag with NFS config information for this node
config_nfs_client = data_bag_item('config_nfs_client', config_id)

# Empty array to hold lines to be added to /etc/fstab
nfs_mount_lines = {}

# Piece by piece construct a hash entry that configures an NFS mount point with one or more allowed clients and one or more allowed options per client.
# ex: /srv/mount_point_dir hostname1(rw,no_root_squash) hostname2(rw)
config_nfs_client['cfg']['mounts'].sort.each do | nfs_share_id, nfs_share_details|

  # Create a parent directory like /net
  # This is lazy to use a dedicated variable but quick, easy and SAFE
  directory nfs_share_details['local_parent_directory'] do
    owner nfs_share_details['owner']
    group nfs_share_details['group']
    mode nfs_share_details['mode']

    recursive false

    action :create

    # not_if is crtiical.
    # Attempting to execute this directory resource on an existing
    # directory may result in an SELinux 'restorecon -R' being
    # issued to restore the context of MANY files mounted at
    # an existing filesystem mount point.

    not_if { File.directory?(nfs_share_details['local_parent_directory']) }
  end

  # Make the mount directory within the parent directory
  directory nfs_share_details['local_mount_directory'] do
    owner nfs_share_details['owner']
    group nfs_share_details['group']
    mode nfs_share_details['mode']

    recursive false

    action :create

    # not_if is crtiical.
    # Attempting to execute this directory resource on an existing
    # directory may result in an SELinux 'restorecon -R' being
    # issued to restore the context of MANY files mounted at
    # an existing filesystem mount point.

    not_if { File.directory?(nfs_share_details['local_mount_directory']) }
  end

  # Safety: Clear this variable within our loop
  mount_line = ""

  # Construct a line of mount information to be added to /etc/fstab
  mount_line =  "#{nfs_share_details[:nfs_server]}:#{nfs_share_details[:nfs_share]}    #{nfs_share_details[:local_mount_directory]} #{nfs_share_details[:nfs_version]} #{nfs_share_details[:nfs_options]} #{nfs_share_details[:fstab_options]}"

  # If not enabled in attribute/data bag then comment it out
  # This lets me manually uncomment it on the node, use it
  if nfs_share_details['enabled'] == false
    mount_line = "##{mount_line}"
  end

  log "RECORDING MOUNT POINT ON CLIENT"
  log mount_line

  file = Chef::Util::FileEdit.new('/etc/fstab')
  file.insert_line_if_no_match(/#{mount_line}/, mount_line)
  file.write_file

end

tag('nfs-client')
