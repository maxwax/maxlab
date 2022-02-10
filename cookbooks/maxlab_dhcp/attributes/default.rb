#
# Attributes for maxlab-dhcp cookbook
#

# Redhat/Centos 8 packages
default['dhcp']['packages']['rhel']['8']['dhcp-server'] = 'any'

# Redhat/Centos 7 packages
default['dhcp']['packages']['rhel']['7']['dhcp-server'] = 'any'

# Set this in each policyfile to drive instance specific configurations
# default['dhcp']['serve_dhcp_for']['maxlab'] = '192.168.9.0'

default['dhcp']['dhcp_global_options'] = [
  'ddns-update-style interim',
  'authoritative'
  ]

# Allow these services via firewalld
default['dhcp']['firewall']['firewalld']['services'] = [ 'dhcp' ]

# Allow these ports via firewalld
default['dhcp']['firewall']['firewalld']['ports'] = [ ]

# Allow these sources via firewalld
default['dhcp']['firewall']['firewalld']['sources'] = [ ]
