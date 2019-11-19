# maxlab_bind CHANGELOG

Cookbook for deploying DNS service using BIND on Redhat platform Linux distributions

Created for use in my home lab, 'maxlab'.

# 0.1.2

- First working draft that deploys forward and reverse config files, a master /etc/named.conf file and leverages maxlab_firewall to open port 53/tcp for services

# 0.1.1

- Forward and reverse /var/named config files for 'maxlab' deployed

# 0.1.0

Initial draft release, working on getting recipes deploying BIND config files via templates from json data bags.
