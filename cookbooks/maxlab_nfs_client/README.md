# Description

This cookbook enables a Linux system to be an NFS client.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['nfs_client']['packages']` - Packages required to deploy an NFS server. Defaults to `[ ... ]`.
* `node['nfs']['services']` - Services required to be running for NFS server operations. Defaults to `[ ... ]`.

# Recipes

* [maxlab_nfs::default](#maxlab_nfsdefault) - This recipe performs no actions.
* [maxlab_nfs::server](#maxlab_nfsserver) - Deploy a very basic NFS server that support NFSv3 or NFSv4 services.

## maxlab_nfs::default

This recipe performs no actions.

## maxlab_nfs::server

Deploy a very basic NFS server that support NFSv3 or NFSv4 services.

Maxwell Spangler maxcode@maxwellspangler.com
