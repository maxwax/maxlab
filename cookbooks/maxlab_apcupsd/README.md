# Description

This cookbook deploys the apcupsd daemon to monitor APC Uninterrupable Power Supply (UPS) units.

# Requirements

* The APC UPS must be connected to this node using a USB cable.

## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['apcupsd']['packages']` - Packages required to deploy an apcupsd daemon. Defaults to `[ apcupsd ]`.
* `node['apcupsd']['services']` - Services required to be running for UPS monitoring. Defaults to `[ apcsupd ]`.
* `node['apcupsd']['firewalld']['services']` - Network services (understood by firewall-cmd) that need to be allowed for network access to apcsupd. Defaults to `[ ... ]`.
* `node['apcupsd']['firewalld']['ports']` - Network ports (specified by port number) that need to be allowed for network access to apcsupd. Defaults to `[ 3551 ]`.
* `node['apcupsd']['firewalld']['sources']` - Network sources (clients)  that need to be allowed for network access to apcsupd. Defaults to `[ ... ]`.

* `node['instance_config_apcupsd']['instance']` - Define in a policyfile that calls this cookbook to specify a unique instance configuration of apcupsd. (Previously critical for selecting a data bag with config valus, less required when using node attributes to set these config values.)

* `node['apcupsd']['config']['sysadmin']` - "Email address to receive emails in response to power events. 'root' for local system root user, user@fqdn to leverage the systems email delivery system to send outside this node." Used in the apccontrol script that responds to power events.

* `node['apcupsd']['config']['upsname']` - "A unqiue name for the UPS (apcupsd.conf config)"
* `node['apcupsd']['config']['upscable']` - "The type of UPS communications cable (apcupsd.conf config)"
* `node['apcupsd']['config']['upstype']` - "The type of UPS (apcupsd.conf config)"
* `node['apcupsd']['config']['device']` - "Device in /dev used to communicate with the UPS (apcupsd.conf config)"
* `node['apcupsd']['config']['polltime']` - "Interval in seconds to check UPS stats (apcupsd.conf config)"
* `node['apcupsd']['config']['lockfile']` - "Path to lock file for apcupsd (apcupsd.conf config)"
* `node['apcupsd']['config']['scriptdir']` - "Directory containing apccontrol and event scripts (apcupsd.conf config)"
* `node['apcupsd']['config']['pwrfaildir']` - "Directory to write powerfail flag file (apcupsd.conf config)"
* `node['apcupsd']['config']['nologindir']` - "Directory to write nologin file (apcupsd.conf config)"
* `node['apcupsd']['config']['onbatterydelay']` - "Delay in seconds after a power fail event before acting on it (apcupsd.conf config)"
* `node['apcupsd']['config']['batterylevel']` - "Shutdown the system if the battery level is under this percent threshold (apcupsd.conf config)"
* `node['apcupsd']['config']['minutes']` - "Shutdown the system if the number of minutes on power remaining is under this threshold (apcupsd.conf config)"
* `node['apcupsd']['config']['timeout']` - "Shutdown the system if on battery power for this many minutes (apcupsd.conf config)"
* `node['apcupsd']['config']['annoy']` - "Send a message to users via wall reporting power failure status (apcupsd.conf config)"
* `node['apcupsd']['config']['annoydelay']` - "Interval between sending messages to users via wall (apcupsd.conf config)"
* `node['apcupsd']['config']['nologon']` - "Enable to prevent users from logging on during power failure events (apcupsd.conf config)"
* `node['apcupsd']['config']['killdelay']` - "See config file (apcupsd.conf config)"
* `node['apcupsd']['config']['netserver']` - "Enable apcupsd's network service for client access (apcupsd.conf config)"
* `node['apcupsd']['config']['nisip']` - "Listen on this IP address for incoming network clients. 0.0.0.0 for any incoming address. (apcupsd.conf config)"
* `node['apcupsd']['config']['nisport']` - "Listen on this TCP power for clients (apcupsd.conf config)"
* `node['apcupsd']['config']['eventsfile']` - "Write events to this log file(apcupsd.conf config)"
* `node['apcupsd']['config']['eventsfilemax']` - "Prune the log file after it reaches this size in KB (apcupsd.conf config)"

# Recipes

* [maxlab_apcupsd::default](##maxlab_default) - This recipe performs no actions.
* [maxlab_apcupsd::deploy](##maxlab_deploy) - Deploy, configure and start the apcups daemon.

## maxlab_apcupsd::default

This recipe performs no actions.

## maxlab_apcupsd::deploy

Deploy apcupsd and configure it to monitor a single attached APC Uninterrupable Power Supply (UPS) unit.

Maxwell Spangler maxcode@maxwellspangler.com
