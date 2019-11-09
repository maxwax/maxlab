#
# Attributes for maxlab_bind cookbook
#

# Redhat/Centos 8 packages
node.default['bind']['packages']['rhel']['8']['bind'] = "32:9.11.4-17.P2.el8_0.1"
node.default['bind']['packages']['rhel']['8']['bind-utils'] = "32:9.11.4-17.P2.el8_0.1"

# Redhat/Centos 7 packages
node.default['bind']['packages']['rhel']['7']['bind'] = "any"
node.default['bind']['packages']['rhel']['7']['bind-utils'] = "any"

# Redhat/Centos 6 packages
node.default['bind']['packages']['rhel']['6']['bind'] = "any"
node.default['bind']['packages']['rhel']['6']['bind-utils'] = "any"
