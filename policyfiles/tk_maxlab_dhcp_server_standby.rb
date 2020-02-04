# Policyfile.rb - Describe how you want Chef Infra Client to build your system.

name 'tk_maxlab_dhcp_server_standby'

default_source :supermarket

run_list "recipe[maxlab_firewall::base_firewalld]",
         "recipe[maxlab_dhcp::deploy]",
         "recipe[maxlab_firewall::update_firewalld]"

cookbook 'maxlab_dhcp',     path: '../cookbooks/maxlab_dhcp'
cookbook 'maxlab_firewall', path: '../cookbooks/maxlab_firewall'

default['config_firewall']['base_config'] = 'base_firewall.maxlab.dmz'

default['dhcp']['serve_dhcp_for']['testkitchen'] = "10.0.2.0"
default['dhcp']['instance_config_dhcp']['testkitchen'] = "10.0.2.0"
default['dhcp']['instance_config_dhcp']['primary'] = false

#
# 'Environment' specific attributes
#

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
