# Description

Deploy a basic, internal only DNS server for homelab network 'maxlab'.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_dhcp
* maxlab_firewall

# Attributes

*No attributes defined*

# Recipes

* [mylab_dhcp::default](#mylab_dhcpdefault) - This recipe performs no actions.
* [mylab_dhcp::deploy](#mylab_dhcpdeploy) - Wrapper recipe for maxlab_dhcp::deploy.

## mylab_dhcp::default

This recipe performs no actions.

## mylab_dhcp::deploy

Wrapper recipe for maxlab_dhcp::deploy.

Maxwell Spangler maxcode@maxwellspangler.com
