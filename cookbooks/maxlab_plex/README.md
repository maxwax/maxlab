# Description

This cookbook deploys the Plex media server.

* Plex will install at /var/lib/plexmediaserver with plex:plex ownership.
* Unmount any manually created dedicated filesystem created at this mount point before running this cookbook.
* After this cookbook deploys Plex, copy /var/lib/plexmediaserver/Library to the dedicated filesystem and mount it in place.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall
* selinux_policy

# Attributes

*No attributes defined*

# Recipes

* [maxlab_plex::default](#maxlab_plexdefault) - Maintan a Plex media server operating environment.

## maxlab_plex::default

Maintan a Plex media server operating environment.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
