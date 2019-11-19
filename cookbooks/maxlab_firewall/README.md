# Description

This is a base Chef cookbook to provision new Linux nodes with core firewall functionality.

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)
* oracle (>= 7.0)
* fedora (>= 30.0)

## Cookbooks:

*No dependencies defined*

# Attributes

*No attributes defined*

# Recipes

* [maxlab_firewall::base_firewalld](#maxlab_firewallbase_firewalld) - Install firewalld and use a configuration defined via data bag to configure default zone, default interface zone, etc.
* [maxlab_firewall::default](#maxlab_firewalldefault) - This recipe performs no actions.
* [maxlab_firewall::update_firewalld](#maxlab_firewallupdate_firewalld) - Using node['maxlab_firewall'] attribute as a list of services, sources and ports to configure, call 'firewall-cmd' to configure firewalld.
* maxlab_firewall::use_firewall_cookbook

## maxlab_firewall::base_firewalld

Install firewalld and use a configuration defined via data bag to configure default zone, default interface zone, etc.

## maxlab_firewall::default

This recipe performs no actions.

## maxlab_firewall::update_firewalld

Using node['maxlab_firewall'] attribute as a list of services, sources and ports to configure, call 'firewall-cmd' to configure firewalld.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x
* Fedora Linux 30+
* Oracle Linux 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
