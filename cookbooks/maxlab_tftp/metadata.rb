name 'maxlab_tftp'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Deploys a TFTP server for the maxlab home lab'
long_description 'Deploys a TFTP server for the maxlab home lab'
version '1.4.0'
chef_version '>= 13.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/maxlab_tftp/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/maxlab_tftp'

supports 'redhat', '>= 8.0'
supports 'centos', '>= 8.0'

depends 'maxlab_firewall'
