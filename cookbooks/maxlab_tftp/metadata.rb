name 'maxlab_tftp'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Deploys a TFTP server for the maxlab home lab'
version '1.4.2'
chef_version '>= 13.0'

supports 'redhat', '>= 8.0'
supports 'centos', '>= 8.0'

depends 'maxlab_firewall'
