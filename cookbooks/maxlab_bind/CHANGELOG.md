# maxlab_bind CHANGELOG

Cookbook for deploying DNS service using BIND on Redhat platform Linux distributions

# 1.3.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.2.2 Don't ping BIND package Version

* Replace an old pinned bind version with 'any' text so the cookbook deploys bind without a version constraint.

# 1.2.1 Rename policyfiles

* Renaming all test kitchen policyfiles as tk_<pfile_name>

# 1.2.0 - Return to node attributes

* Convert from using data bags to node attributes for config data
* Renamed default.rb to deploy.rb
* Enable Test Kitchen development
* Enable testing with test kitchen
* Disabled config_bind data bag by renaming it obsolete_
* Removing some zones config from node['bind'] tree. Turns out they'd been moved to the config_network data_bag
* Removed Berksfile
* Add policyfiles for Test Kitchen testing
* Removed 'default' test inspec code.

# 1.1.2

* Early maxlab cookbook maxlab_bind was using 'bind_zone' instead of 'service_zone' to load network zone info.  All other cookbooks were using service_zone info, so new services/ports/sources firewall attribute code copied from maxlab_plex failed to work.
* Fix: replace one line of bind_zone = ... with service_zone = ... and all the copied code works.

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
