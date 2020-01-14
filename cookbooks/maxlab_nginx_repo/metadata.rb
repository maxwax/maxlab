name 'maxlab_nginx_repo'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Simple deploy of nginx to serve home lab repository needs'
long_description 'Simple deploy of nginx to serve home lab repository needs'
version '1.1.0'
chef_version '>= 13.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/maxlab_nginx_repo/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/maxlab_nginx_repo'

supports 'redhat', '>= 8.0'
supports 'centos', '>= 8.0'

depends 'maxlab_firewall'
depends 'selinux_policy'
