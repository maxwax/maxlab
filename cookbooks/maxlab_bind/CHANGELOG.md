# maxlab_bind CHANGELOG

Cookbook for deploying DNS service using BIND on Redhat platform Linux distributions

# 1.1.1

* Forgot to change the data bag's firewall's 'service' field to 'services'.

# 1.1.0

* Change 'service' to 'services' in firewalld rules of config_bind data bag.
* Modify maxlab_bind::default code to use services, ports and sources from data bag as arrays.
* New code originally from config_plex to append any array elements from the data bag to the node.normal['maxlab_firewall'] node attribute that maxlab_firewall::update_firewall will use to apply firewll changes.
* Typo in doc/overview.md spelling of 'deploys' fixed
* Removed Oracle and Fedora from doc/platforms.md and metadata since I'm not testing these platforms.

# 1.0.0

* Version bump, this is now in active use.

# 0.2.0

* Tag the node with 'dns-server' once services are provisioned.

# 0.1.4

* Removing unnecessary .to_h when reading data_bag_item

# 0.1.3

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.2

- First working draft that deploys forward and reverse config files, a master /etc/named.conf file and leverages maxlab_firewall to open port 53/tcp for services

# 0.1.1

- Forward and reverse /var/named config files for 'maxlab' deployed

# 0.1.0

Initial draft release, working on getting recipes deploying BIND config files via templates from json data bags.
