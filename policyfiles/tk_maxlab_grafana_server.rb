# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'tk_maxlab_grafana_server'

default_source :supermarket

#
# Chrony is commented out in the KITCHEN environment for this service
#

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_users::general]",
         "recipe[maxlab_base::deploy]",
         "recipe[maxlab_chrony::deploy]",
         "recipe[maxlab_grafana::server]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_firewall',   path: '../cookbooks/maxlab_firewall'
cookbook 'maxlab_base',       path: '../cookbooks/maxlab_base'
cookbook 'maxlab_users',      path: '../cookbooks/maxlab_users'
cookbook 'maxlab_chrony',     path: '../cookbooks/maxlab_chrony'
cookbook 'maxlab_grafana',    path: '../cookbooks/maxlab_grafana'

default['config_firewall']['base_config'] = 'base_firewall.maxlab.dmz'

# From role client_chrony_maxlab
default['instance_config_chrony']['instance'] = 'chrony.maxlab'
default['instance_config_chrony']['instance_type'] = 'client'

# From role service_nfs_instance_maxlab_nfs_testred
default['instance_config_grafana']['instance'] = 'maxlab_prom_server_metrics'

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
default['env']['maxlab']['grafana_vip']       = "http://grafana.maxlab"
