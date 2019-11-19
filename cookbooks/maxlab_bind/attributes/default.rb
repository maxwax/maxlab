#
# Attributes for maxlab_bind cookbook
#

#<> BIND package for Red Hat 8
default['bind']['packages']['rhel']['8']['bind'] = "32:9.11.4-17.P2.el8_0.1"

#<> bind-utils package for Red Hat 8
default['bind']['packages']['rhel']['8']['bind-utils'] = "32:9.11.4-17.P2.el8_0.1"

#<> bind package for Red Hat 7
default['bind']['packages']['rhel']['7']['bind'] = "32:9.11.4-9.P2.el7"

#<> bind-utils package for Red Hat 7
default['bind']['packages']['rhel']['7']['bind-utils'] = "32:9.11.4-9.P2.el7"
