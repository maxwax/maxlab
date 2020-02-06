# Description

Deploy a basic, internal only DNS server for homelab network 'maxlab'.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_smartd

# Attributes

*No attributes defined*

# Recipes

* [mylab_smartd::default](#mylab_smartddefault) - This recipe performs no actions.
* [mylab_smartd::deploy](#mylab_smartddeploy) - Experimental wrapper cookbook to maxlab_smartd that deploys smartd for storage health monitoring.

## mylab_smartd::default

This recipe performs no actions.

## mylab_smartd::deploy

Experimental wrapper cookbook to maxlab_smartd that deploys smartd for storage health monitoring. Uses experimental methods to use data bags to replace node attributes.

Maxwell Spangler maxcode@maxwellspangler.com
