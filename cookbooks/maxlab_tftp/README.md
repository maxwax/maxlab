# Description

Deploys a TFTP server for the maxlab home lab

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)
* oracle (>= 8.0)

## Cookbooks:

* maxlab_firewall

# Attributes

*No attributes defined*

# Recipes

* [maxlab_tftp::default](#maxlab_tftpdefault) - The default recipe performs no actions.
* [maxlab_tftp::deploy](#maxlab_tftpdeploy) - Deploy a TFTP server instance to support PXE netbooting of VM nodes.

## maxlab_tftp::default

The default recipe performs no actions.

## maxlab_tftp::deploy

Deploy a TFTP server instance to support PXE netbooting of VM nodes.

# License and Maintainer

Maintainer:: Maxwell Spangler (<maxcode@maxwellspangler.com>)



License:: All Rights Reserved
