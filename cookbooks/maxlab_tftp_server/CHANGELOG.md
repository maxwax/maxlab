# maxlab_tftp_server CHANGELOG

# 1.2.0

* Enable Test Kitchen development
* Enable test kitchen testing
* Enable policyfiles
* Add doc files
* Update README.md
* Delete Berksfile

# 1.1.0

* Change 'service' to 'services' in firewalld rules of config_tftp_server data bag.
* Modify maxlab_tftp_server::default code to use services, ports and sources from data bag as arrays.
* New code originally from config_plex to append any array elements from the data bag to the node.normal['maxlab_firewall'] node attribute that maxlab_firewall::update_firewall will use to apply firewll changes.
* Removed Oracle from doc/platforms.md and metadata since I'm not testing these platforms.

# 1.0.0

* Version bump since I'm actively using this in production.

# 0.2.0

* Tag the node with 'tftp-server' after deploying the service

# 0.1.1

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.0

Initial release; Able to deploy a working tftp server. Not polished yet.
