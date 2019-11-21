# Description

This cookbook depoys a DHCP on Red Hat 7.x and 8.x systems

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

*No platforms defined*

## Cookbooks:

* maxlab_firewall

# Attributes

*No attributes defined*

# Recipes

* [maxlab_dhcp::default](#maxlab_dhcpdefault) - The default recipe performs no actions.
* [maxlab_dhcp::deploy](#maxlab_dhcpdeploy) - Deploy a DHCP server.

## maxlab_dhcp::default

The default recipe performs no actions.

## maxlab_dhcp::deploy

Deploy a DHCP server.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x
* Fedora Linux 30+
* Oracle Linux 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
