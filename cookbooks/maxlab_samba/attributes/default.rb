# maxlab_samba/attributes/default.rb

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

case platform_and_version

  when 'rhel7', 'centos7'
    #<> Packages required to support this service
    default['samba']['packages'] = [ "samba", "samba-common", "samba-libs" ]

    #<> Services required to be running for samba server operations
    default['samba']['services'] = [ "smb", "nmb" ]

    #<> Firewalld service names to open for operation
    default['samba']['firewalld']['services'] = [ "samba" ]

    #<> Ad-hoc ports to open for operation
    default['samba']['firewalld']['ports'] = [ ]

    #<> Network sources to open for operation
    default['samba']['firewalld']['sources'] = [ ]

  when 'rhel8', 'centos8'
    #<> Packages required to support this service
    default['samba']['packages'] = [ "samba", "samba-common", "samba-libs" ]

    #<> Services required to be running for samba server operations
    default['samba']['services'] = [ "smb", "nmb" ]

    #<> Firewalld service names to open for operation
    default['samba']['firewalld']['services'] = [ "samba" ]

    #<> Ad-hoc ports to open for operation
    default['samba']['firewalld']['ports'] = [ ]

    #<> Network sources to open for operation
    default['samba']['firewalld']['sources'] = [ ]

end
