# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'maxlab_node_nas_depot'

default_source :supermarket

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_base::deploy]",
         "recipe[maxlab_base::deploy-bare-metal]",         "recipe[maxlab_users::general]",
         "recipe[maxlab_smartd::deploy]",
         "recipe[maxlab_chrony::deploy]",
         "recipe[maxlab_nfs::server]",
         "recipe[maxlab_samba::server]",
         "recipe[maxlab_apcupsd::deploy]",
         "recipe[maxlab_postfix::deploy]",
         "recipe[maxlab_prometheus::exporter]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_firewall', path: '../cookbooks/maxlab_firewall'
cookbook 'maxlab_base',     path: '../cookbooks/maxlab_base'
cookbook 'maxlab_users',    path: '../cookbooks/maxlab_users'
cookbook 'maxlab_smartd',   path: '../cookbooks/maxlab_smartd'
cookbook 'maxlab_chrony',   path: '../cookbooks/maxlab_chrony'
cookbook 'maxlab_nfs',      path: '../cookbooks/maxlab_nfs'
cookbook 'maxlab_samba',    path: '../cookbooks/maxlab_samba'
cookbook 'maxlab_apcupsd',  path: '../cookbooks/maxlab_apcupsd'
cookbook 'maxlab_postfix',  path: '../cookbooks/maxlab_postfix'
cookbook 'maxlab_prometheus', path: '../cookbooks/maxlab_prometheus'

cookbook 'chef-vault'

# From role base_firewall_maxlab_nas
default['config_firewall']['base_config'] = 'base_firewall.maxlab.nas'

# From role client_chrony_maxlab
default['instance_config_chrony']['instance'] = 'chrony.maxlab'
default['instance_config_chrony']['instance_type'] = 'client'

# From role service_nfs_instance_maxlab_nfs_testred
default['instance_config_nfs']['instance'] = 'maxlab_nfs_depot'

# From role service_samba_instance_maxlab_samba_testred
default['instance_config_samba']['instance'] = 'maxlab_samba_depot'

# From role service_postfix_instance_maxlab_postfix
default['instance_config_postfix']['instance'] = 'maxlab_postfix'

# The config_apcupsd data bag used to configure apcupsd on this node
default['instance_config_apcupsd']['instance'] = 'maxlab_apcupsd_depot'

# Previously environment variables
default['env']['maxlab']['repo_url']          = "http://repo.maxlab"
default['env']['maxlab']['dist_url']          = "http://repo.maxlab/dist"
default['env']['maxlab']['iso_url']           = "http://repo.maxlab/iso"
default['env']['maxlab']['files_url']         = "http://repo.maxlab/files"
default['env']['maxlab']['typefaces_url']     = "http://repo.maxlab/files/typefaces"
default['env']['maxlab']['tarballs_url']      = "http://repo.maxlab/files/tarballs"
default['env']['maxlab']['chef_url']          = "https://chef.maxlab/organizations/maxlab"
default['env']['maxlab']['tftp_url']          = "http://repo.maxlab"
default['env']['maxlab']['upstream_ntp']      = "2.centos.pool.ntp.org"
default['env']['maxlab']['metric_submit_vip'] = "http://metric_submit.maxlab"
default['env']['maxlab']['metric_query_vip']  = "http://metric_query.maxlab"
default['env']['maxlab']['graphite_vip']      = "http://graphite.maxlab"
default['env']['maxlab']['graphite_vip']      = "http://grafana.maxlab"

# Custom settings to override default values from maxlab_apcupsd cookbook
default['apcupsd']['config']['sysadmin']       = "maxops@maxwellspangler.com"

default['apcupsd']['config']['upsname']        = "depot-backups-pro-1500"
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
