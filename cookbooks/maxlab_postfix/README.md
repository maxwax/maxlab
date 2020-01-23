# Description

This cookbook deploys a postfix email relay so my internal maxlab nodes can route mail properly.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['postfix']['packages']` - Packages required to support this service. Defaults to `[ ... ]`.
* `node['postfix']['services']` - Services required to be running for postfix server operations. Defaults to `[ ... ]`.
* `node['postfix']['firewalld']['services']` - Firewalld service names to open for operation. Defaults to `[ ... ]`.
* `node['postfix']['firewalld']['ports']` - Ad-hoc ports to open for operation. Defaults to `[ ... ]`.
* `node['postfix']['firewalld']['sources']` - Network sources to open for operation. Defaults to `[ ... ]`.

# Recipes

* maxlab_postfix::default
* [maxlab_postfix::deploy](#maxlab_postfixdeploy) - Deploy a basic maxlab internal postfix email relay.

## maxlab_postfix::deploy

Deploy a basic maxlab internal postfix email relay.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
