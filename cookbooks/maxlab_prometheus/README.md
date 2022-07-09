# Description

This cookbook is a quick and dirty deployment of Prometheus time series database metrics servers and Prometheus Node Exporter services to publish metrics to Prometheus.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 8.0)
* centos (>= 8.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['prometheus']['server']` - Attributes related to Prometheus server deployment
* `node['prometheus']['node_exporter']` - Attributes related to Prometheus Node Exporter deployment

# Recipes

* [maxlab_prometheus::server](#maxlab_prometheus::server) - Deploy a basic Prometheus server
* [maxlab_prometheus::node_exporter](#maxlab_prometheus::node_exporter) - Deploy a baisc Prometheus Node Exporter

Maxwell Spangler maxcode@maxwellspangler.com
