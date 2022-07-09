# Policyfile.rb - Describe how you want Chef Infra server to build your system.

name 'maxlab_node_netinfra_auxillary'

default_source :supermarket

run_list "recipe[maxlab_base::deploy]",
         "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_users::general]",
         "recipe[maxlab_bind::deploy]",
         "recipe[maxlab_dhcp::deploy]",
         "recipe[maxlab_chrony::deploy]",
         "recipe[maxlab_postfix::deploy]",
         "recipe[maxlab_prometheus::exporter]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_base',     path: '../cookbooks/maxlab_base'
cookbook 'maxlab_users',    path: '../cookbooks/maxlab_users'
cookbook 'maxlab_firewall', path: '../cookbooks/maxlab_firewall'
cookbook 'maxlab_bind',     path: '../cookbooks/maxlab_bind'
cookbook 'maxlab_dhcp',     path: '../cookbooks/maxlab_dhcp'
cookbook 'maxlab_chrony',   path: '../cookbooks/maxlab_chrony'
cookbook 'maxlab_postfix',  path: '../cookbooks/maxlab_postfix'
cookbook 'maxlab_prometheus', path: '../cookbooks/maxlab_prometheus'

cookbook 'chef-vault'

# From role base_firewall_maxlab_nas
default['config_firewall']['base_config'] = 'base_firewall.maxlab.dmz'

# From role client_chrony_maxlab
default['instance_config_chrony']['instance'] = 'chrony.maxlab'
default['instance_config_chrony']['instance_type'] = 'server'

# From role service_binddns_instance_maxlab
default['config_bind']['instance'] = 'dns_server.maxlab'

# From role service_dhcp_instance_core
default['dhcp']['serve_dhcp_for']['maxlab'] = "192.168.9.0"
default['dhcp']['instance_config_dhcp']['primary'] = false

# From role service_postfix_instance_maxlab_postfix
default['instance_config_postfix']['instance'] = 'maxlab_postfix'

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
