# maxlab_nfs/attributes/default.rb

#<> Packages required to deploy an NFS server
default['nfs']['packages'] = [ "nfs-utils", "nfs4-acl-tools", "rpcbind", "portmap", "mdadm", "cryptsetup" ]

#<> Services required to be running for NFS server operations
default['nfs']['services'] = [ "nfs-server", "rpcbind" ]

#<> Firewalld service names to open for operation
default['nfs']['firewalld']['services'] = [ "nfs", "mountd" ]

#<> Ad-hoc ports to open for operation
default['nfs']['firewalld']['ports'] = [ ]

#<> Network sources to open for operation
default['nfs']['firewalld']['sources'] = [ ]

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

case platform_and_version

  when 'redhat7', 'centos7'
    default['nfs']['packages'] = [ "nfs-utils", "nfs4-acl-tools", "rpcbind", "portmap", "mdadm", "cryptsetup" ]

    default['nfs']['services'] = [ "nfs-server", "rpcbind" ]

    default['nfs']['firewall_ports'] = [ "nfs", "mountd" ]

    default['nfs']['firewalld']['services'] = [ "nfs", "mountd" ]
    default['nfs']['firewalld']['ports'] = [ ]
    default['nfs']['firewalld']['sources'] = [ ]

  when 'redhat8', 'centos8'
    default['nfs']['packages'] = [ "nfs-utils", "nfs4-acl-tools", "rpcbind", "portmap", "mdadm", "cryptsetup" ]

    default['nfs']['services'] = [ "nfs-server", "rpcbind" ]

    default['nfs']['firewalld']['services'] = [ "nfs", "mountd" ]
    default['nfs']['firewalld']['ports'] = [ ]
    default['nfs']['firewalld']['sources'] = [ ]

end
