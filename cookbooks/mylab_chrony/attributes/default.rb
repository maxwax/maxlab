# mylab_chrony wrapper attributes

#
# Client configuration attributes
#

# force_default['chrony']['serve_chrony_for']['maxlab'] = "192.168.9.0"
#
# force_default['chrony']['firewall']['firewalld']['services'] = [ "ntp" ]
# force_default['chrony']['firewall']['firewalld']['ports'] = [ "323/udp" ]
# force_default['chrony']['firewall']['firewalld']['sources'] = [ ]
#
#
# force_default['chrony']['client']['options']['pool']['comment'] = [
#   "# Use public servers from the pool.ntp.org project.",
#   "# Please consider joining the pool (http://www.pool.ntp.org/join.html)."
# ]
#
# force_default['chrony']['client']['options']['pool']['config'] = "pool"
# force_default['chrony']['client']['options']['pool']['value'] = "2.centos.pool.ntp.org"
# force_default['chrony']['client']['options']['pool']['config_options'] = "iburst"
#
#
# force_default['chrony']['client']['options']['driftfile']['comment'] = [
#     "# Record the rate at which the system clock gains/losses time."
#   ]
# force_default['chrony']['client']['options']['driftfile']['config'] = "driftfile /var/lib/chrony/drift"
#
# force_default['chrony']['client']['options']['makestep']['comment'] = [
#   "# Allow the system clock to be stepped in the first three updates",
#   "# if its offset is larger than 1 second."
#   ]
# force_default['chrony']['client']['options']['makestep']['config'] = "makestep 1.0 3"
#
#
# force_default['chrony']['client']['options']['rtcsync']['comment'] = [
#   "# Enable kernel synchronization of the real-time clock (RTC)."
# ]
# force_default['chrony']['client']['options']['rtcsync']['config'] = "rtcsync"
#
#
# force_default['chrony']['client']['options']['local_stratum']['comment'] = [
#   "# Serve time even if not synchronized to a time source."
# ]
# force_default['chrony']['client']['options']['local_stratum']['config'] = "local stratum 10"
#
#
# force_default['chrony']['client']['options']['keyfile']['comment'] = [
#   "# Specify file containing keys for NTP authentication."
# ]
# force_default['chrony']['client']['options']['keyfile']['config'] = "keyfile /etc/chrony.keys"
#
#
# force_default['chrony']['client']['options']['leapsectz']['comment'] = [
#   "# Get TAI-UTC offset and leap seconds from the system tz database."
# ]
# force_default['chrony']['client']['options']['leapsectz']['config'] = "leapsectz right/UTC"
#
#
# force_default['chrony']['client']['options']['logdir']['comment'] = [
#   "# Specify directory for log files."
# ]
# force_default['chrony']['client']['options']['logdir']['config'] = "logdir /var/log/chrony"
#
# #
# # Server configuration attributes
# #
#
# force_default['chrony']['server']['options']['pool']['comment'] = [
#   "# Use public servers from the pool.ntp.org project.",
#   "# Please consider joining the pool (http://www.pool.ntp.org/join.html)."
# ]
# force_default['chrony']['server']['options']['pool']['config'] = "pool"
# force_default['chrony']['server']['options']['pool']['value'] = "2.centos.pool.ntp.org"
# force_default['chrony']['server']['options']['pool']['config_options'] = "iburst"
#
#
# force_default['chrony']['server']['options']['driftfile']['comment'] = [
#   "# Record the rate at which the system clock gains/losses time."
# ]
# force_default['chrony']['server']['options']['driftfile']['config'] = "driftfile /var/lib/chrony/drift"
#
#
# force_default['chrony']['server']['options']['makestep']['comment'] = [
#   "# Allow the system clock to be stepped in the first three updates",
#   "# if its offset is larger than 1 second."
#   ]
# force_default['chrony']['server']['options']['makestep']['config'] = "makestep 1.0 3"
#
#
# force_default['chrony']['server']['options']['rtcsync']['comment'] = [
#   "# Enable kernel synchronization of the real-time clock (RTC)."
# ]
# force_default['chrony']['server']['options']['rtcsync']['config'] = "rtcsync"
#
#
# force_default['chrony']['server']['options']['hwtimestamp']['comment'] = [
#   "# Enable hardware timestamping on all interfaces that support it."
# ]
# force_default['chrony']['server']['options']['hwtimestamp']['config'] = "#hwtimestamp *"
#
#
# force_default['chrony']['server']['options']['minsources']['comment'] = [
#   "# Increase the minimum number of selectable sources required to adjust",
#   "# the system clock."
# ]
# force_default['chrony']['server']['options']['minsources']['config'] = "#minsources 2"
#
#
# force_default['chrony']['server']['options']['allow']['comment'] = [
#   "# Allow NTP client access from local network."
# ]
# force_default['chrony']['server']['options']['allow']['config'] = "allow"
# force_default['chrony']['server']['options']['allow']['enabled'] = true
# force_default['chrony']['server']['options']['allow']['value'] = "auto_subnet"
#
#
# force_default['chrony']['server']['options']['bindacqaddress']['comment'] = [
#   "# Serve NTP clients via this address"
# ]
# force_default['chrony']['server']['options']['bindacqaddress']['config'] = "bindacqaddress"
# force_default['chrony']['server']['options']['bindacqaddress']['enabled'] = true
# force_default['chrony']['server']['options']['bindacqaddress']['value'] = "auto_ipaddress"
#
#
# force_default['chrony']['server']['options']['cmdallow']['comment'] = [
#   "# Allow chronyc clients from these addresses"
# ]
# force_default['chrony']['server']['options']['cmdallow']['config'] = "cmdallow"
# force_default['chrony']['server']['options']['cmdallow']['enabled'] = true
# force_default['chrony']['server']['options']['cmdallow']['value'] = "auto_subnet"
#
#
# force_default['chrony']['server']['options']['bindcmdaddress']['comment'] = [
#   "# Serve chronyc commands via this address"
# ]
# force_default['chrony']['server']['options']['bindcmdaddress']['config'] = "bindcmdaddress"
# force_default['chrony']['server']['options']['bindcmdaddress']['enabled'] = true
# force_default['chrony']['server']['options']['bindcmdaddress']['value'] = "auto_ipaddress"
#
#
# force_default['chrony']['server']['options']['local_stratum']['comment'] = [
#   "# Serve time even if not synchronized to a time source."
# ]
# force_default['chrony']['server']['options']['local_stratum']['config'] = "local stratum 10"
#
#
# force_default['chrony']['server']['options']['keyfile']['comment'] = [
#   "# Specify file containing keys for NTP authentication."
# ]
# force_default['chrony']['server']['options']['keyfile']['config'] = "keyfile /etc/chrony.keys"
#
#
# force_default['chrony']['server']['options']['leapsectz']['comment'] = [
#   "# Get TAI-UTC offset and leap seconds from the system tz database."
# ]
# force_default['chrony']['server']['options']['leapsectz']['config'] = "leapsectz right/UTC"
#
#
# force_default['chrony']['server']['options']['logdir']['comment'] = [
#   "# Specify directory for log files."
# ]
# force_default['chrony']['server']['options']['logdir']['config'] = "logdir /var/log/chrony"
#
#
# force_default['chrony']['server']['options']['log_options']['comment'] = [
#   "# Select which information is logged."
# ]
# force_default['chrony']['server']['options']['log_options']['config'] = "#log measurements statistics tracking"
