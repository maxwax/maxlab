#
# maxlab_firewall attributes default.rb
#

# Not required in the home lab
node.default['firewall']['ipv6_enabled'] = false

default['firewall']['allow_ssh'] = true
default['firewall']['allow_icmp'] = true
default['firewall']['allow_loopback'] = true

default['firewall']['enabled_zone'] = 'public'
