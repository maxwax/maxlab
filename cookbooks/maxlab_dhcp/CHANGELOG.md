# maxlab_dhcp CHANGELOG

Deploy a DHCP server

# 1.4 Multi-homed DHCP server

* Support multiple subnets in the same network id data bags
* Adding 192.168.100.0/24 subnet for vm to vm networking on hypervisor coalbox
* In DHCP server node policyfile, set hash of network_id 'maxlab' to an array of one or more subnets to support.
* Modify deploy.rb to continue to support multiple network_ids and iterate over them, but now each individual network_id (data bag config) may have more than one subnet that needs to be configured
* Add first_subnet variable so that when deploying hostnames in the first (primary) subnet, each host will be deployed as its name only, but for uniqueness, hostnames in other subnets will be deployed prefixed by the subnet's domain name such as 'vmnet-core' and 'vmnet-plex'.  This fulfills the requirement that each hostname in an dhcpd.conf file be unique regardless of subnet.

# 1.3.1

* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments
* Updated dummy data bag config_dhcp for testkitchen with test data

# 1.3.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.2.2

* deploy.rb: Stamp top of dhcpd.conf file with network and subnet name, replacing old data bag name which is not used anymore.

# 1.2.1

* Renaming all test kitchen policyfiles as tk_<pfile_name>

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
