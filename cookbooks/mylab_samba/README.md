# Description

Deploy a basic instance of nginx that serves static files use in PXE booting.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall
* maxlab_samba

# Attributes

*No attributes defined*

# Recipes

* [mylab_samba::default](#mylab_sambadefault) - This recipe performs no actions.
* [mylab_samba::server](#mylab_sambaserver) - Wrapper to maxlab_samba::server.

## mylab_samba::default

This recipe performs no actions.

## mylab_samba::server

Wrapper to maxlab_samba::server.

Maxwell Spangler maxcode@maxwellspangler.com
