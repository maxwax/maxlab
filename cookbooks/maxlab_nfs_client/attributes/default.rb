# maxlab_nfs_client/attributes/default.rb

# Packages required to deploy an NFS server
default['nfs_client']['packages'] = [ 'nfs-utils' ]

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

case platform_and_version
when 'redhat7', 'centos7'
  default['nfs_client']['packages'] = [ 'nfs-utils' ]

when 'redhat8', 'centos8'
  default['nfs_client']['packages'] = [ 'nfs-utils' ]
end
