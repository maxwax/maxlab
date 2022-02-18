name 'maxlab_pxe'
maintainer 'Maxwell Spangler'
maintainer_email 'maxcode@maxwellspangler.com'
license 'All Rights Reserved'
description 'Deploys infrastructure files for PXE booting'
version '1.3.4'
chef_version '>= 13.0'

supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

depends 'maxlab_tftp'
depends 'chef-vault'
