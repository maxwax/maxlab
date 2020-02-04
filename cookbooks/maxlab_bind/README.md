# Description

Deploy a basic, internal only DNS server for homelab network 'maxlab'.

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['bind']['packages']['rhel']['8']['bind']` - BIND package for Red Hat 8. Defaults to `32:9.11.4-26.P2.el8`.
* `node['bind']['packages']['rhel']['8']['bind-utils']` - bind-utils package for Red Hat 8. Defaults to `32:9.11.4-26.P2.el8`.
* `node['bind']['packages']['rhel']['7']['bind']` - bind package for Red Hat 7. Defaults to `32:9.11.4-9.P2.el7`.
* `node['bind']['packages']['rhel']['7']['bind-utils']` - bind-utils package for Red Hat 7. Defaults to `32:9.11.4-9.P2.el7`.
* `node['bind']['firewall']['firewalld']['services']` - Allow these services via firewalld. Defaults to `[ ... ]`.
* `node['bind']['firewall']['firewalld']['ports']` - Allow these ports via firewalld. Defaults to `[ ... ]`.
* `node['bind']['firewall']['firewalld']['sources']` - Allow these sources via firewalld. Defaults to `[ ... ]`.
* `node['bind']['config_network_ids']` - Networks to be supported with this bind installation. Defaults to `[ ... ]`.
* `node['bind']['subnet']` - Service DNS on this subnet. Defaults to `192.168.9.0`.
* `node['bind']['network_prefix']` - Network prefix. Defaults to `192.168.9`.
* `node['bind']['network_mask']` - Network mask as number of bits. Defaults to `24`.
* `node['bind']['domain_name']` - Domain name (for DNS config file). Defaults to `maxlab`.
* `node['bind']['acl']` - Allow dns requests on this network. Defaults to `192.168.9.0/24`.
* `node['bind']['listen_on_port_ipv4']` - Listen on this IPv4 port. Defaults to `53`.
* `node['bind']['config_listen_on_address_ipv4']` - Listen on this IPv4 address. Use 'ipaddress' for auto-configure to each node. Defaults to `ipaddress`.
* `node['bind']['listen_on_address_ipv4']` - Listen on this IPv4 specific address (if not auto configured above). Defaults to ``.
* `node['bind']['listen_on_port_ipv6']` - Listen on this IPv6 port. Defaults to `53`.
* `node['bind']['config_listen_on_address_ipv6']` - Listen on this IPv6 address. Use 'ipaddress' for auto-configure to each node. Defaults to `ipaddress`.
* `node['bind']['listen_on_address_ipv6']` - Listen on this IPv6 specific address (if not auto configured above). Defaults to ``.
* `node['bind']['allow_query']` - Allow queries from this network. Defaults to `192.168.9.0/24`.
* `node['bind']['recursion']` - Allow DNS recursion to root level servers. Defaults to `yes`.
* `node['bind']['dnssec_enable']` - Enable/Disable dnssec. Defaults to `yes`.
* `node['bind']['dnssec_validation']` - Enable/disable dnssec validation. Defaults to `yes`.
* `node['bind']['crypto_policies']` - Enable/disable crypto policies - RHEL default. Defaults to `false`.
* `node['bind']['crypto_policies_file']` - Crypto policies file. Defaults to `/etc/crypto-policies/back-ends/bind.config`.
* `node['bind']['forwarders']` - Forward DNS requests to these DNS servers. Defaults to `[ ... ]`.

# Recipes

* [maxlab_bind::default](#maxlab_binddefault)
* [maxlab_bind::deploy](#maxlab_binddeploy) - Deploy DNS services using bind.

## maxlab_bind::default

This cookbook performs no actions

## maxlab_bind::deploy

Deploy DNS services using bind.

Maxwell Spangler maxcode@maxwellspangler.com
