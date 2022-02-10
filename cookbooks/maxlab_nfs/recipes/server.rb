#
# Cookbook:: maxlab_nfs
# Recipe:: server
#
# Copyright:: 2020, Maxwell Spangler, All Rights Reserved.

# Install requires packages to support NFS from node attributes
package node['nfs']['packages'] do
  action :install
end

config_id = node['instance_config_nfs']['instance']

# Retrieve the data bag with NFS config information for this node
config_nfs_server = data_bag_item('config_nfs_server', config_id)

# Create a directory tree where storage can be mounted then later shared.
# Ex: Create /srv so that a RAID filesystem can be mounted at /srv/filerdata.
# Create /srv via Chef but the admin will manually configure /srv/filerdata.
# Then add /srv/filerdata as an export to be shared via NFS

# WARNING: Do not create subdirectories here such as /srv/filerdata/mydata.
# If the filesystem /srv/filerdata is not mounted, this code will create
# /srv/filerdata/mydata on the root filesystem and it will be hidden if
# /srv/filerdata is mounted on top of it.
config_nfs_server['cfg']['directory_tree'].each do |_id, details|

  directory details['directory'] do
    owner details['owner']
    group details['group']
    mode details['mode']

    recursive false

    action :create

    # not_if is crtiical.
    # Attempting to execute this directory resource on an existing
    # directory may result in an SELinux 'restorecon -R' being
    # issued to restore the context of MANY files mounted at
    # an existing filesystem mount point.

    not_if { File.directory?(details['directory']) }
  end
end

# Build our /etc/exports config lines here so the template is simple
exports_lines = {}

# For each NFS share, construct a line for /etc/exports to define the share
# and how it should be shared to client nodes
# ex: /srv/mount_point_dir hostname1(rw,no_root_squash) hostname2(rw)
config_nfs_server['cfg']['exports'].sort.each do |mount_point, mount_details|

  # IF this attribute is set, we're in Test Kitchen, so make these directories
  # to mock up actual storage on mounted drives
  if node.exist?('kitchen_testing_maxlab')
    directory mount_point do
      owner mount_details['owner']
      group mount_details['group']
      mode mount_details['mode']

      recursive true

      action :create

      # not_if is crtiical.
      # Attempting to execute this directory resource on an existing
      # directory may result in an SELinux 'restorecon -R' being
      # issued to restore the context of MANY files mounted at
      # an existing filesystem mount point.

      not_if { File.directory?(mount_point) }
    end
  end

  # Comment out non-enabled filesystems
  export_text = if mount_details['enabled'] == true
                  "#{mount_point} "
                else
                  "##{mount_point} "
                end

  mount_details['clients'].sort.each do |client_name, client_details|

    # Reject and do not include clients with no configured options
    # this should not occur, but is protection against mis-configured data bags
    unless client_details['options'].empty?

      # start of allowed client definition
      export_text << "#{client_name}("

      first_opt = true
      client_details['options'].each do |nfs_client_opt|

        # Append ", " if we are about to append another opt beyond the first
        if first_opt
          first_opt = false
        else
          export_text << ','
        end

        export_text << "#{nfs_client_opt}"

      end
      # All options provided, close the host definition
      export_text << ') '
    end

    exports_lines[mount_point] = {
      comment: "# #{mount_details['comment']}",
      export_text: export_text
    }
  end
end

template '/etc/exports' do
  source 'exports.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables({
      exports_lines: exports_lines,
      config_id: config_id
  })

  action :create
end

# Tell the NFS system to export all our configured items in /etc/exports
execute 'export-filesystems' do
  command 'exportfs -a'

  action :run
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if node['nfs']['firewalld'].key?('services')
  node['nfs']['firewalld']['services'].each do |service_string|

    unless node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if node['nfs']['firewalld'].key?('ports')
  node['nfs']['firewalld']['ports'].each do |port_string|

    unless node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if node['nfs']['firewalld'].key?('sources')
  node['nfs']['firewalld']['sources'].each do |source_string|

    unless node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

# Ex: nfs-server, rpcbind
node['nfs']['services'].each do |service_name|
  service service_name do
    action [ :enable, :start ]
  end
end

tag('nfs-server')
