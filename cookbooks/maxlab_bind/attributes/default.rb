#
# Attributes for maxlab_bind cookbook
#

# BIND package for Red Hat 8
# Example left of pinning version syntax
default['bind']['packages']['rhel']['8']['bind'] = 'any'

# bind-utils package for Red Hat 8
default['bind']['packages']['rhel']['8']['bind-utils'] = 'any'

# bind package for Red Hat 7
default['bind']['packages']['rhel']['7']['bind'] = 'any'

# bind-utils package for Red Hat 7
default['bind']['packages']['rhel']['7']['bind-utils'] = 'any'

#
# Standard firewall allowances
#

# Allow these services via firewalld
default['bind']['firewall']['firewalld']['services'] = [ 'dns' ]

# Allow these ports via firewalld
default['bind']['firewall']['firewalld']['ports'] = [ ]

# Allow these sources via firewalld
default['bind']['firewall']['firewalld']['sources'] = [ ]

#
# bind service attributes
#

# Networks to be supported with this bind installation
default['bind']['config_network_ids'] = %w(maxlab dmz)

# Service DNS on this subnet
default['bind']['subnet'] = '192.168.9.0'
# Network prefix
default['bind']['network_prefix'] = '192.168.9'
# Network mask as number of bits
default['bind']['network_mask'] = 24
# Domain name (for DNS config file)
default['bind']['domain_name'] = 'maxlab'
# Allow dns requests on this network
default['bind']['acl'] = '192.168.9.0/24'
# Listen on this IPv4 port
default['bind']['listen_on_port_ipv4'] = '53'
# Listen on this IPv4 address. Use 'ipaddress' for auto-configure to each node
default['bind']['config_listen_on_address_ipv4'] = 'ipaddress'
# Listen on this IPv4 specific address (if not auto configured above)
default['bind']['listen_on_address_ipv4'] = ''
# Listen on this IPv6 port
default['bind']['listen_on_port_ipv6'] = '53'
# Listen on this IPv6 address. Use 'ipaddress' for auto-configure to each node
default['bind']['config_listen_on_address_ipv6'] = 'ipaddress'
# Listen on this IPv6 specific address (if not auto configured above)
default['bind']['listen_on_address_ipv6'] = ''
# Allow queries from this network
default['bind']['allow_query'] = '192.168.9.0/24'
# Allow DNS recursion to root level servers
default['bind']['recursion'] = 'yes'
# Enable/Disable dnssec
default['bind']['dnssec_enable'] = 'yes'
# Enable/disable dnssec validation
default['bind']['dnssec_validation'] = 'yes'
# Enable/disable crypto policies - RHEL default
default['bind']['crypto_policies'] = false
# Crypto policies file
default['bind']['crypto_policies_file'] = '/etc/crypto-policies/back-ends/bind.config'
# Forward DNS requests to these DNS servers
default['bind']['forwarders'] = [ '1.1.1.1', '8.8.8.8', '8.8.4.4' ]
