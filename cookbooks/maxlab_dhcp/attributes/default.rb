#
# Attributes for maxlab-dhcp cookbook
#

#<> Redhat/Centos 8 packages
node.default['dhcp']['packages']['rhel']['8']['dhcp-server'] = "4.3.6-30.el8"

#<> Redhat/Centos 7 packages
node.default['dhcp']['packages']['rhel']['7']['dhcp-server'] = "any"
