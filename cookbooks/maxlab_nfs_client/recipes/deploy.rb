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

# Build our /etc/exports config lines here so the template is simple
#exports_lines = {}

# Piece by piece construct a hash entry that configures an NFS mount point with one or more allowed clients and one or more allowed options per client.
# ex: /srv/mount_point_dir hostname1(rw,no_root_squash) hostname2(rw)
config_nfs_client['cfg']['mounts'].sort.each do | nfs_share_id, nfs_share_details|

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

#   # Comment out non-enabled filesystems
#   if nfs_share_details['enabled'] == true
#     export_text = "#{mount_point} "
#   else
#     export_text = "##{mount_point} "
#   end
#
#   nfs_share_details['clients'].sort.each do |client_name, client_details|
#
#     # Reject and do not include clients with no configured options
#     # this should not occur, but is protection against mis-configured data bags
#     if client_details['options'].length > 0
#
#       # start of allowed client definition
#       export_text << "#{client_name}("
#
#       first_opt = true
#       client_details['options'].each do |nfs_client_opt|
#
#         # Append ", " if we are about to append another opt beyond the first
#         if first_opt
#           first_opt = false
#         else
#           export_text << ","
#         end
#
#         export_text << "#{nfs_client_opt}"
#
#       end
#       # All options provided, close the host definition
#       export_text << ") "
#     end
#
#     exports_lines[mount_point] = {
#       comment: "# #{nfs_share_details['comment']}",
#       export_text: export_text
#     }
#   end
end
#
# template '/etc/exports' do
#   source 'exports.erb'
#
#   owner 'root'
#   group 'root'
#   mode '0644'
#
#   variables ({
#       exports_lines: exports_lines,
#       config_id: config_id
#   })
#
#   action :create
# end
#
# # Tell the NFS system to export all our configured items in /etc/exports
# execute 'export-filesystems' do
#   command 'exportfs -a'
#
#   action :run
# end
#
# # Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
# #---
#
# # Allow this service via the default interface's firewalld zone
# service_zone = node['maxlab_firewall']['default_interface_zone']
#
# # Add the service to this node's firewalld service requirements
# # Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
# if node['nfs']['firewalld'].key?('services')
#   node['nfs']['firewalld']['services'].each do |service_string|
#
#     if not node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
#       node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
#     end
#
#   end
# end
#
# # Append individual port definitions
# if node['nfs']['firewalld'].key?('ports')
#   node['nfs']['firewalld']['ports'].each do |port_string|
#
#     if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
#       node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
#     end
#
#   end
# end
#
# # Append individual sources definitions
# if node['nfs']['firewalld'].key?('sources')
#   node['nfs']['firewalld']['sources'].each do |source_string|
#
#     if not node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
#       node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
#     end
#
#   end
# end
#
# #---
#
# # Ex: nfs-server, rpcbind
# node['nfs']['services'].each do |service_name|
#   service service_name do
#     action [ :enable, :start ]
#   end
# end

tag('nfs-client')
