# Description

This cookbook deploys the CyberPower powerpanel software to monitor CyberPower Uninterrupable Power Supply (UPS) units.

# Requirements

* The CyberPower UPS must be connected to this node using a USB cable.

## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* See attributes file for details

# Recipes

* [maxlab_powerpanel::default](##maxlab_default) - This recipe performs no actions.
* [maxlab_powerpanel::deploy](##maxlab_deploy) - Deploy, configure and start the pwrstatd daemon.

## maxlab_powerpanel::default

This recipe performs no actions.

## maxlab_powerpanel::deploy

Deploy apcupsd and configure it to monitor a single attached APC Uninterrupable Power Supply (UPS) unit.

Maxwell Spangler maxcode@maxwellspangler.com
