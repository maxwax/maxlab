# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'tk_maxlab_base'

default_source :supermarket

run_list  "recipe[maxlab_users::general]",
          "recipe[maxlab_base::deploy]",
          "recipe[maxlab_base::deploy_svc_base]"

cookbook 'maxlab_base',  path: '../maxlab_base'
cookbook 'maxlab_users', path: '../maxlab_users'

# ID a config_base data bag to configure services for this type of node
default['config_base']['id'] = 'kitchen_testing_maxlab'

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
