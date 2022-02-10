name 'maxlab_nginx_repo'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Simple deploy of nginx to serve home lab repository needs'
version '1.3.1'
chef_version '>= 13.0'

supports 'redhat', '>= 8.0'
supports 'centos', '>= 8.0'

depends 'maxlab_firewall'
depends 'selinux_policy'
