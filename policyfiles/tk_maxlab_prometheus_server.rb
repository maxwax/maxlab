# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'tk_maxlab_prometheus_server'

default_source :supermarket

#
# Chrony is commented out in the KITCHEN environment for this service
#

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_users::general]",
         "recipe[maxlab_base::deploy]",
         "recipe[maxlab_chrony::deploy]",
         "recipe[maxlab_prometheus::server]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_firewall',   path: '../cookbooks/maxlab_firewall'
cookbook 'maxlab_base',       path: '../cookbooks/maxlab_base'
cookbook 'maxlab_users',      path: '../cookbooks/maxlab_users'
cookbook 'maxlab_chrony',     path: '../cookbooks/maxlab_chrony'
cookbook 'maxlab_prometheus', path: '../cookbooks/maxlab_prometheus'

default['config_firewall']['base_config'] = 'base_firewall.maxlab.dmz'

# From role client_chrony_maxlab
default['instance_config_chrony']['instance'] = 'chrony.maxlab'
default['instance_config_chrony']['instance_type'] = 'client'

# From role service_nfs_instance_maxlab_nfs_testred
default['instance_config_prometheus']['instance'] = 'maxlab_prom_server_metrics'

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


default['prometheus']['server']['scrape_configs'] = {
  'prometheus-svr': {
    'static_configs': {
      'targets': [ 'localhost:9100' ],
    },
  },
  'filer.maxlab': {
    'static_configs': {
      'targets': [ 'filer.maxlab:9100' ],
    },
  },
  'aux.maxlab': {
    'static_configs': {
      'targets': [ 'aux.maxlab:9100' ],
    },
  },
  'depot.maxlab': {
    'static_configs': {
      'targets': [ 'depot.maxlab:9100' ],
    },
  },
  'core.maxlab': {
    'static_configs': {
      'targets': [ 'core.maxlab:9100' ],
    },
  },
  'plex.maxlab': {
    'static_configs': {
      'targets': [ 'plex.maxlab:9100' ],
    },
  },
  'pixie.maxlab': {
    'static_configs': {
      'targets': [ 'pixie.maxlab:9100' ],
    },
  },
  'metrics.maxlab': {
    'static_configs': {
      'targets': [ 'metrics.maxlab:9100' ],
    },
  },
  'repo.maxlab': {
    'static_configs': {
      'targets': [ 'repo.maxlab:9100' ],
    },
  },
  'coalbox.maxlab': {
    'static_configs': {
      'targets': [ 'coalbox.maxlab:9100' ],
    },
  },
}
