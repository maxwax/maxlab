# Description

This is a base Chef cookbook to provision new Linux nodes with core firewall functionality.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

*No dependencies defined*

# Attributes

*No attributes defined*

# Recipes

* mylab_firewall::default
* [mylab_firewall::sample_firewall](#mylab_firewallsample_firewall) - Open some services, ports and sources when testing maxlab_firewall with Test Kitchen.

## mylab_firewall::sample_firewall

Open some services, ports and sources when testing maxlab_firewall with Test Kitchen.

Maxwell Spangler maxcode@maxwellspangler.com
