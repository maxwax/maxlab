# Description

This cookbook deploys NFS server or client services on maxlab nodes.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['nfs']['packages']` - Packages required to deploy an NFS server. Defaults to `[ ... ]`.
* `node['nfs']['services']` - Services required to be running for NFS server operations. Defaults to `[ ... ]`.
* `node['nfs']['firewalld']['services']` - Firewalld service names to open for operation. Defaults to `[ ... ]`.
* `node['nfs']['firewalld']['ports']` - Ad-hoc ports to open for operation. Defaults to `[ ... ]`.
* `node['nfs']['firewalld']['sources']` - Network sources to open for operation. Defaults to `[ ... ]`.
* `node['nfs']['firewall_ports']` -  Defaults to `[ ... ]`.

# Recipes

* [maxlab_nfs::server](#maxlab_nfsserver) - Deploy a very basic NFS server that support NFSv3 or NFSv4 services.

## maxlab_nfs::server

Deploy a very basic NFS server that support NFSv3 or NFSv4 services.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
