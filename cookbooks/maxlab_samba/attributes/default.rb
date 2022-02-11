# maxlab_samba/attributes/default.rb

# Ex: 'redhat8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

case platform_and_version

when 'redhat8', 'centos8'
  # Packages required to support this service
  default['samba']['packages'] = %w( samba samba-common samba-libs )

  # Services required to be running for samba server operations
  default['samba']['services'] = %w( smb nmb )

  # Firewalld service names to open for operation
  default['samba']['firewalld']['services'] = %w( samba )

  # Ad-hoc ports to open for operation
  default['samba']['firewalld']['ports'] = []

  # Network sources to open for operation
  default['samba']['firewalld']['sources'] = []

when 'redhat7', 'centos7'
  # Packages required to support this service
  default['samba']['packages'] = %w( samba samba-common samba-libs )

  # Services required to be running for samba server operations
  default['samba']['services'] = %w( smb nmb )

  # Firewalld service names to open for operation
  default['samba']['firewalld']['services'] = %w( samba )

  # Ad-hoc ports to open for operation
  default['samba']['firewalld']['ports'] = []

  # Network sources to open for operation
  default['samba']['firewalld']['sources'] = []
end
