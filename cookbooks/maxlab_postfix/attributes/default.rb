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

default['postfix']['core_config']['queue_directory'] = "/var/spool/postfix"
default['postfix']['core_config']['command_directory'] = "/usr/sbin"
default['postfix']['core_config']['daemon_directory'] = "/usr/libexec/postfix"
default['postfix']['core_config']['data_directory'] =  "/var/lib/postfix"
default['postfix']['core_config']['mail_owner'] = "postfix"
#default['postfix']['core_config']['myhostname'] = "filer.maxwellspangler.com"
default['postfix']['faux_domain'] = "maxwellspangler.com"
default['postfix']['core_config']['inet_interfaces'] = "localhost"
default['postfix']['core_config']['inet_protocols'] = "ipv4"
default['postfix']['core_config']['mydestination'] = "$myhostname, localhost.$mydomain, localhost"
default['postfix']['core_config']['mynetworks'] = "192.168.9.0/24, 127.0.0.0/8"
default['postfix']['core_config']['relayhost'] = "[mail.maxwellspangler.com]:587"
default['postfix']['core_config']['alias_maps'] = "hash:/etc/aliases"
default['postfix']['core_config']['alias_database'] = "hash:/etc/aliases"
default['postfix']['core_config']['debug_peer_level'] = "2"
default['postfix']['core_config']['sendmail_path'] = "/usr/sbin/sendmail.postfix"
default['postfix']['core_config']['newaliases_path'] = "/usr/bin/newaliases.postfix"
default['postfix']['core_config']['mailq_path'] = "/usr/bin/mailq.postfix"
default['postfix']['core_config']['setgid_group'] = "postdrop"
default['postfix']['core_config']['html_directory'] = "no"

default['postfix']['additional_config']['smtp_sasl_auth_enable']['comment'] = "# Enable SASL Authentiation"
default['postfix']['additional_config']['smtp_sasl_auth_enable']['value'] = "yes"

default['postfix']['additional_config']['smtp_sasl_security_options']['comment'] = "# Disallow methods that allow anonymouse authentication"
default['postfix']['additional_config']['smtp_sasl_security_options']['value'] = "noanonymous"

default['postfix']['additional_config']['smtp_sasl_password_maps']['comment'] = "# Where to find sasl_passwd"
default['postfix']['additional_config']['smtp_sasl_password_maps']['value'] = "hash:/etc/postfix/sasl_passwd"

default['postfix']['additional_config']['smtp_use_tls']['comment'] = "# EnableS STARTTLS encryption"
default['postfix']['additional_config']['smtp_use_tls']['value'] = "yes"

default['postfix']['additional_config']['smtp_tls_CApath']['comment'] = "# Where to find CA certificates"
default['postfix']['additional_config']['smtp_tls_CApath']['value'] = "/etc/ssl/certs"
