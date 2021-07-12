# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'maxlab_node_nas_filer'

default_source :supermarket

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_base::deploy]",
         "recipe[maxlab_users::general]",
         "recipe[mylab_smartd::deploy]",
         "recipe[maxlab_chrony::deploy]",
         "recipe[maxlab_nfs::server]",
         "recipe[maxlab_samba::server]",
         "recipe[maxlab_postfix::deploy]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_firewall', path: '../cookbooks/maxlab_firewall'
cookbook 'maxlab_base',     path: '../cookbooks/maxlab_base'
cookbook 'maxlab_users',    path: '../cookbooks/maxlab_users'
cookbook 'maxlab_smartd',   path: '../cookbooks/maxlab_smartd'
cookbook 'mylab_smartd',    path: '../cookbooks/mylab_smartd'
cookbook 'maxlab_chrony',   path: '../cookbooks/maxlab_chrony'
cookbook 'maxlab_nfs',      path: '../cookbooks/maxlab_nfs'
cookbook 'maxlab_samba',    path: '../cookbooks/maxlab_samba'
cookbook 'maxlab_postfix',  path: '../cookbooks/maxlab_postfix'

cookbook 'chef-vault'

# From role base_firewall_maxlab_nas
default['config_firewall']['base_config'] = 'base_firewall.maxlab.nas'

# From role client_chrony_maxlab
default['instance_config_chrony']['instance'] = 'chrony.maxlab'
default['instance_config_chrony']['instance_type'] = 'client'

# From role service_nfs_instance_maxlab_nfs_testred
default['instance_config_nfs']['instance'] = 'maxlab_nfs_filer'

# From role service_samba_instance_maxlab_samba_testred
default['instance_config_samba']['instance'] = 'maxlab_samba_filer'

# From role service_postfix_instance_maxlab_postfix
default['instance_config_postfix']['instance'] = 'maxlab_postfix'

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
