# maxlab_chrony default attributes

#<> Chrony packages for Red Hat Linux 8
default['chrony']['packages']['rhel']['8']['chrony'] = [ "3.3-3.el8" ]

#<> Chrony packages for Red Hat Linux 7
default['chrony']['packages']['rhel']['7']['chrony'] = [ "any" ]

#
# Client configuration attributes
#

default['chrony']['serve_chrony_for']['maxlab'] = "192.168.9.0"

default['chrony']['firewall']['firewalld']['services'] = [ "ntp" ]
default['chrony']['firewall']['firewalld']['ports'] = [ "323/udp" ]
default['chrony']['firewall']['firewalld']['sources'] = [ ]


default['chrony']['client']['options']['pool']['comment'] = [
  "# Use public servers from the pool.ntp.org project.",
  "# Please consider joining the pool (http://www.pool.ntp.org/join.html)."
]
default['chrony']['client']['options']['pool']['config'] = "pool"
default['chrony']['client']['options']['pool']['value'] = "2.centos.pool.ntp.org"
default['chrony']['client']['options']['pool']['config_options'] = "iburst"


default['chrony']['client']['options']['driftfile']['comment'] = [
    "# Record the rate at which the system clock gains/losses time."
  ]
default['chrony']['client']['options']['driftfile']['config'] = "driftfile /var/lib/chrony/drift"


default['chrony']['client']['options']['makestep']['comment'] = [
  "# Allow the system clock to be stepped in the first three updates",
  "# if its offset is larger than 1 second."
  ]
default['chrony']['client']['options']['makestep']['config'] = "makestep 1.0 3"


default['chrony']['client']['options']['rtcsync']['comment'] = [
  "# Enable kernel synchronization of the real-time clock (RTC)."
]
default['chrony']['client']['options']['rtcsync']['config'] = "rtcsync"


default['chrony']['client']['options']['local_stratum']['comment'] = [
  "# Serve time even if not synchronized to a time source."
]
default['chrony']['client']['options']['local_stratum']['config'] = "local stratum 10"


default['chrony']['client']['options']['keyfile']['comment'] = [
  "# Specify file containing keys for NTP authentication."
]
default['chrony']['client']['options']['keyfile']['config'] = "keyfile /etc/chrony.keys"


default['chrony']['client']['options']['leapsectz']['comment'] = [
  "# Get TAI-UTC offset and leap seconds from the system tz database."
]
default['chrony']['client']['options']['leapsectz']['config'] = "leapsectz right/UTC"


default['chrony']['client']['options']['port']['comment'] = [
  "# Disable NTP port on clients"
]
default['chrony']['client']['options']['port']['config'] = "port 0"


default['chrony']['client']['options']['cmdport']['comment'] = [
  "# Disable Chrony command port on clients"
]
default['chrony']['client']['options']['cmdport']['config'] = "cmdport 0"


#
# Server configuration attributes
#

default['chrony']['server']['options']['pool']['comment'] = [
  "# Use public servers from the pool.ntp.org project.",
  "# Please consider joining the pool (http://www.pool.ntp.org/join.html)."
]
default['chrony']['server']['options']['pool']['config'] = "pool"
default['chrony']['server']['options']['pool']['value'] = "2.centos.pool.ntp.org"
default['chrony']['server']['options']['pool']['config_options'] = "iburst"


default['chrony']['server']['options']['driftfile']['comment'] = [
  "# Record the rate at which the system clock gains/losses time."
]
default['chrony']['server']['options']['driftfile']['config'] = "driftfile /var/lib/chrony/drift"


default['chrony']['server']['options']['makestep']['comment'] = [
  "# Allow the system clock to be stepped in the first three updates",
  "# if its offset is larger than 1 second."
  ]
default['chrony']['server']['options']['makestep']['config'] = "makestep 1.0 3"


default['chrony']['server']['options']['rtcsync']['comment'] = [
  "# Enable kernel synchronization of the real-time clock (RTC)."
]
default['chrony']['server']['options']['rtcsync']['config'] = "rtcsync"


default['chrony']['server']['options']['hwtimestamp']['comment'] = [
  "# Enable hardware timestamping on all interfaces that support it."
]
default['chrony']['server']['options']['hwtimestamp']['config'] = "#hwtimestamp *"


default['chrony']['server']['options']['minsources']['comment'] = [
  "# Increase the minimum number of selectable sources required to adjust",
  "# the system clock."
]
default['chrony']['server']['options']['minsources']['config'] = "#minsources 2"


default['chrony']['server']['options']['allow']['comment'] = [
  "# Allow NTP client access from local network."
]
default['chrony']['server']['options']['allow']['config'] = "allow"
default['chrony']['server']['options']['allow']['enabled'] = true
default['chrony']['server']['options']['allow']['value'] = "auto_subnet"


default['chrony']['server']['options']['bindacqaddress']['comment'] = [
  "# Serve NTP clients via this address"
]
default['chrony']['server']['options']['bindacqaddress']['config'] = "bindacqaddress"
default['chrony']['server']['options']['bindacqaddress']['enabled'] = true
default['chrony']['server']['options']['bindacqaddress']['value'] = "auto_ipaddress"


default['chrony']['server']['options']['cmdallow']['comment'] = [
  "# Allow chronyc clients from these addresses"
]
default['chrony']['server']['options']['cmdallow']['config'] = "cmdallow"
default['chrony']['server']['options']['cmdallow']['enabled'] = true
default['chrony']['server']['options']['cmdallow']['value'] = "auto_subnet"


default['chrony']['server']['options']['bindcmdaddress']['comment'] = [
  "# Serve chronyc commands via this address"
]
default['chrony']['server']['options']['bindcmdaddress']['config'] = "bindcmdaddress"
default['chrony']['server']['options']['bindcmdaddress']['enabled'] = true
default['chrony']['server']['options']['bindcmdaddress']['value'] = "auto_ipaddress"


default['chrony']['server']['options']['local_stratum']['comment'] = [
  "# Serve time even if not synchronized to a time source."
]
default['chrony']['server']['options']['local_stratum']['config'] = "local stratum 10"


default['chrony']['server']['options']['keyfile']['comment'] = [
  "# Specify file containing keys for NTP authentication."
]
default['chrony']['server']['options']['keyfile']['config'] = "keyfile /etc/chrony.keys"


default['chrony']['server']['options']['leapsectz']['comment'] = [
  "# Get TAI-UTC offset and leap seconds from the system tz database."
]
default['chrony']['server']['options']['leapsectz']['config'] = "leapsectz right/UTC"


default['chrony']['server']['options']['logdir']['comment'] = [
  "# Specify directory for log files."
]
default['chrony']['server']['options']['logdir']['config'] = "logdir /var/log/chrony"


default['chrony']['server']['options']['log_options']['comment'] = [
  "# Select which information is logged."
]
default['chrony']['server']['options']['log_options']['config'] = "#log measurements statistics tracking"
