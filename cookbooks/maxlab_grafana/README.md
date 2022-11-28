# Description

This cookbook deploys a simple Grafana dashboard server.

Maxwell Spangler maxcode@maxwellspangler.com

# Requirements

## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['grafana']['server']` - Attributes related to Grafana server deployment

# Recipes

* [maxlab_grafana::server](#maxlab_grafana::server) - Deploy a basic Grafana server

# kitchen_testing_maxlab

Basic testing is available via Test Kitchen.  Much of it is verifying functionality provided by the Grafana rpm package and not the Chef cookbook that deploys Grafana.

## `$ kitchen test grafana-server`

* Ensures grafana repository be_installed
# Ensures grafana package installed
# Ensures /var/lib/grafana directory created
# Ensures /var/lib/grafana.db database exists
# Ensures the grafans-server service is enabled and running
# Ensures that a grafana-server responds with 'Found' on localhost:3000
