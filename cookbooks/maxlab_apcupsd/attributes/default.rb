# maxlab_apcupsd/attributes/default.rb

#<> Packages required to deploy an apcupsd server
default['apcupsd']['packages'] = [ "apcupsd" ]

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

case platform_and_version

  when 'redhat7', 'centos7'
    default['apcupsd']['packages'] = [ "apcupsd" ]

  when 'redhat8', 'centos8'
    default['apcupsd']['packages'] = [ "apcupsd" ]

end

#<> Services required to be running for NFS server operations
default['apcupsd']['services'] = [ "apcupsd" ]

#<> Firewalld service names to open for operation
default['apcupsd']['firewalld']['services'] = [  ]

#<> Ad-hoc ports to open for operation
default['apcupsd']['firewalld']['ports'] = [ "3551/tcp" ]

#<> Network sources to open for operation
default['apcupsd']['firewalld']['sources'] = [ ]

#<> These attributes are used to deploy the apcupsd.conf configuration file
default['apcupsd']['config']['sysadmin']       = "maxops@maxwellspangler.com"
default['apcupsd']['config']['upsname']        = "APC-UPS-unique-name"
default['apcupsd']['config']['upscable']       = "usb"
default['apcupsd']['config']['upstype']        = "usb"
default['apcupsd']['config']['device']         = ""
default['apcupsd']['config']['polltime']       = "60"
default['apcupsd']['config']['lockfile']       = "/var/lock"
default['apcupsd']['config']['scriptdir']      = "/etc/apcupsd"
default['apcupsd']['config']['pwrfaildir']     = "/etc/apcupsd"
default['apcupsd']['config']['nologindir']     = "/etc"
default['apcupsd']['config']['onbatterydelay'] = 30
default['apcupsd']['config']['batterylevel']   = 15
default['apcupsd']['config']['minutes']        = 5
default['apcupsd']['config']['timeout']        = 0
default['apcupsd']['config']['annoy']          = 300
default['apcupsd']['config']['annoydelay']     = 60
default['apcupsd']['config']['nologon']        = "disable"
default['apcupsd']['config']['killdelay']      = 0
default['apcupsd']['config']['netserver']      = "on"
default['apcupsd']['config']['nisip']          = "0.0.0.0"
default['apcupsd']['config']['nisport']        = "3551"
default['apcupsd']['config']['eventsfile']     = "/var/log/apcupsd.events"
default['apcupsd']['config']['eventsfilemax']  = 10
default['apcupsd']['config']['stattime']       = 0
default['apcupsd']['config']['statfile']       = "/var/log/apcupsd.status"
default['apcupsd']['config']['logstats']       = "off"
default['apcupsd']['config']['datatime']       = 0
default['apcupsd']['config']['facility']       = "daemon"

default['apcupsd']['config']['enable_logger']  = true
default['apcupsd']['config']['log_month']      = "*"
default['apcupsd']['config']['log_day']        = "*"
default['apcupsd']['config']['log_hour']       = "12"
default['apcupsd']['config']['log_minute']     = "0"
