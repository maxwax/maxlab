# maxlab_bind CHANGELOG

Cookbook for deploying DNS service using BIND on Redhat platform Linux distributions

Created for use in my home lab, 'maxlab'.

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
