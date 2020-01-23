# maxlab_postfix/attributes/default.rb

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

case platform_and_version

  when 'rhel8', 'centos8'
    #<> Packages required to support this service
    default['postfix']['packages'] = [ "postfix", "mailx", "cyrus-sasl-plain"]

    #<> Services required to be running for postfix server operations
    default['postfix']['services'] = [ ]

    #<> Firewalld service names to open for operation
    default['postfix']['firewalld']['services'] = [ "postfix" ]

    #<> Ad-hoc ports to open for operation
    default['postfix']['firewalld']['ports'] = [ ]

    #<> Network sources to open for operation
    default['postfix']['firewalld']['sources'] = [ ]

  when 'rhel7', 'centos7'
    #<> Packages required to support this service
    default['postfix']['packages'] = [ "postfix", "mailx", "cyrus-sasl-plain" ]

    #<> Services required to be running for postfix server operations
    default['postfix']['services'] = [ ]

    #<> Firewalld service names to open for operation
    default['postfix']['firewalld']['services'] = [ ]

    #<> Ad-hoc ports to open for operation
    default['postfix']['firewalld']['ports'] = [ ]

    #<> Network sources to open for operation
    default['postfix']['firewalld']['sources'] = [ ]

end
