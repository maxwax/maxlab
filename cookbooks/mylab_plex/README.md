# Description

Experimental wrapper cookbook for maxlab_plex.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall
* maxlab_plex

# Attributes

* `node['plex']['firewall']['firewalld']['services']` - Allow these services via firewalld. Defaults to `[ ... ]`.
* `node['plex']['firewall']['firewalld']['ports']` - Allow these ports via firewalld. Defaults to `[ ... ]`.
* `node['plex']['firewall']['firewalld']['sources']` - Allow these sources via firewalld. Defaults to `[ ... ]`.
* `node['plex']['network']` - service plex to this network. Defaults to `maxlab`.
* `node['plex']['subnet']` - service plex to this subnet. Defaults to `192.168.9.0`.
* `node['plex']['owner']` - Operate plex as this user. Defaults to `plex`.
* `node['plex']['group']` - Operate plex as this group. Defaults to `plex`.
* `node['plex']['mode']` - Deploy config files with this mode. Defaults to `0655`.
* `node['plex']['package_name']` - Install this package. Defaults to `plexmediaserver`.
* `node['plex']['service_name']` - Operate this service name. Defaults to `plexmediaserver`.
* `node['plex']['directories']` - Ensure these directories are created. Defaults to `[ ... ]`.

# Recipes

* [mylab_plex::default](#mylab_plexdefault) - This recipe performs no actions.
* [mylab_plex::deploy](#mylab_plexdeploy) - Wrapper recipe for maxlab_plex::depoy.

## mylab_plex::default

This recipe performs no actions.

## mylab_plex::deploy

Wrapper recipe for maxlab_plex::depoy.

Maxwell Spangler maxcode@maxwellspangler.com
