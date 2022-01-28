# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'tk_maxlab_apcupsd'

default_source :supermarket

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_base::deploy]",
         "recipe[maxlab_users::general_kitchen]",
         "recipe[maxlab_apcupsd::deploy]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_base',     path: '../cookbooks/maxlab_base'
cookbook 'maxlab_apcupsd',  path: '../cookbooks/maxlab_apcupsd'
cookbook 'maxlab_users',    path: '../cookbooks/maxlab_users'
cookbook 'maxlab_firewall', path: '../cookbooks/maxlab_firewall'

default['config_firewall']['base_config'] = 'base_firewall.maxlab.internal'

# Previously environment variables
default['env']['maxlab']['repo_url']          = "http://repo.maxlab"
default['env']['maxlab']['dist_url']          = "http://repo.maxlab/dist"
default['env']['maxlab']['iso_url']           = "http://repo.maxlab/iso"
default['env']['maxlab']['files_url']         = "http://repo.maxlab/files"
default['env']['maxlab']['typefaces_url']     = "http://repo.maxlab/files/typefaces"
default['env']['maxlab']['chef_url']          = "https://chef.maxlab/organizations/maxlab"
default['env']['maxlab']['tftp_url']          = "http://repo.maxlab"
default['env']['maxlab']['upstream_ntp']      = "2.centos.pool.ntp.org"
default['env']['maxlab']['metric_submit_vip'] = "http://metric_submit.maxlab"
default['env']['maxlab']['metric_query_vip']  = "http://metric_query.maxlab"
default['env']['maxlab']['graphite_vip']      = "http://graphite.maxlab"
default['env']['maxlab']['graphite_vip']      = "http://grafana.maxlab"

# The config_apcupsd data bag used to configure apcupsd on this node
default['instance_config_apcupsd']['instance'] = 'maxlab_apcupsd_filer'

# Custom settings to override default values from maxlab_apcupsd cookbook
default['apcupsd']['config']['sysadmin']       = "maxops@maxwellspangler.com"
default['apcupsd']['config']['upsname']        = "filer-backups-pro-1500"
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
