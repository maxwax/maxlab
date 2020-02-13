name 'maxlab_pxe'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Deploys infrastructure files for PXE booting'
long_description 'Deploys infrastructure files for PXE booting'
version '1.1.3'
chef_version '>= 13.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/maxlab_pxe/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/maxlab_pxe'

supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

depends 'maxlab_tftp'
