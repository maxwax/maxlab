# maxlab_dhcp CHANGELOG

Deploy a DHCP server

# 1.2.0 Test Kitchen and Nodes

* Enable Test Kitchen for development
* Enable test kitchen tests
* Move basic things from data bags to node attributes
* Move from Berksfile to policyfiles
* Removed default test scripts
* Added new testkitchen data bag to simulate 

# 1.1.0

* Change 'service' to 'services' in firewalld rules of config_dhcp data bag.
* Modify maxlab_bind::default code to use services, ports and sources from data bag as arrays.
* New code originally from config_plex to append any array elements from the data bag to the node.normal['maxlab_firewall'] node attribute that maxlab_firewall::update_firewall will use to apply firewall changes.

# 1.0.0

* Version bump to 1.0.0 as this is now in production use

# 0.2.0

* Tag the node with 'dhcp-server' after deploying this service.

# 0.1.3

* Removing unnecessary .to_h when reading data_bag_item

# 0.1.2

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.1

First initial working release

# 0.1.0

Draft Release
