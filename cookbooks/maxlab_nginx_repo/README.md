# Description

Simple deploy of nginx to serve home lab repository needs

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)

## Cookbooks:

* maxlab_firewall

# Attributes

*No attributes defined*

# Recipes

* [maxlab_nginx_repo::default](#maxlab_nginx_repodefault) - The deploy recipe takes no actions.
* [maxlab_nginx_repo::deploy](#maxlab_nginx_repodeploy) - Deploy a simple instance of nginx to serve basic files via HTTP in maxlab.

## maxlab_nginx_repo::default

The deploy recipe takes no actions.

## maxlab_nginx_repo::deploy

Deploy a simple instance of nginx to serve basic files via HTTP in maxlab.

# License and Maintainer

Maintainer:: Maxwell Spangler (<maxcode@maxwellspangler.com>)



License:: All Rights Reserved
