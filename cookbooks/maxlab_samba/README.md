# Description

This cookbook deploys NFS server or client services on maxlab nodes.

Note: For security reasons, samba users (and passwords) must be created manually via

```bash
smbpasswd -a <user>
```

This could be automated, but since I'm sharing cookbooks on git, I'll keep this simple and manual for now.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['samba']['packages']` - Packages required to support this service. Defaults to `[ ... ]`.
* `node['samba']['services']` - Services required to be running for samba server operations. Defaults to `[ ... ]`.
* `node['samba']['firewalld']['services']` - Firewalld service names to open for operation. Defaults to `[ ... ]`.
* `node['samba']['firewalld']['ports']` - Ad-hoc ports to open for operation. Defaults to `[ ... ]`.
* `node['samba']['firewalld']['sources']` - Network sources to open for operation. Defaults to `[ ... ]`.

# Recipes

* [maxlab_samba::default](#maxlab_sambadefault) - This recipe performs no actions.
* [maxlab_samba::server](#maxlab_sambaserver) - Deloy a basic SAMBA file server.

## maxlab_samba::default

This recipe performs no actions.

## maxlab_samba::server

Deloy a basic SAMBA file server.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
