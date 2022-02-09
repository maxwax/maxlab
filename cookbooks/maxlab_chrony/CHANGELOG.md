# maxlab_chrony CHANGELOG

This file is used to list changes made in each version of the maxlab_chrony cookbook.

# 1.5.1

* Fixing some old bugs: set a list of subnets from the serve_chrony_for attribute, then set subnet_id to the first one.  The existing code was working but confusing in this regard
* Cookstyle cleanup: Remove utf-8 encoding from tests
* Cookstyle cleanup: set platform_version using .to_i.to_s
* Cookstyle cleanup: spec/unit remove Ubuntu, set Redhat 8 and Centos 8
* Cookstyle cleanup: remove long description from metadata.rb
* Cookstyle cleanup: Replacing double quotes with single quotes per Ruby style guide
* Cookstyle cleanup: Using recommended formatting for case statements
* Cookstyle cleanup: Assign variable to output of case statement

# 1.5.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbook

# 1.4.1 Rename policyfiles

* Renaming all test kitchen policyfiles as tk_<pfile_name>

# 1.4.0 - Policyfiles support

* Pulling Berksfile
* Modifying kitchen.yml to use policyfiles
* Created policyfiles in root dir for maxlab_chrony_client and maxlab_chrony_server
* Removed old, commented out code that used data bags instead of node attributes (this has been tested sufficiently now)

# 1.3.0 - Test Kitchen Support

* Added a mock node for Test Kitchen to find when searching for servers tagged ntp-server on client instances.
* Added Inspec tests for client and server
* Renamed default recipe as 'deploy' to follow best practices of making recipes verb related instead of default.
* Configured kitchen.yml with client and server test suites
* Added attributes to configure chrony to not listen on ports 123 or 323 via port and cmdport config declarations. More secure.

# 1.2.0

* Major rework: Use node attributes instead of data bag values as primary source of configuring chrony client or server instances.  Re-aligning to a more standardized practice.
* Removing references to maxlab - chrony with maxlab_chrony (underscore). Change from original name now complete.
* Enable use of Test Kitchen for development. No tests yet.
* Use role node attribute instance_chrony_config instead of chrony_config to avoid confusion with variable chrony_config within the recipe.

# 1.1.0

* Change 'service' to 'services' in firewalld rules of config_chrony data bag.
* Modify maxlab_chrony::default code to use services, ports and sources from data bag as arrays.
* New code originally from config_plex to append any array elements from the data bag to the node.normal['maxlab_firewall'] node attribute that maxlab_firewall::update_firewall will use to apply firewll changes.
* Typo in doc/overview.md spelling of 'deploys' fixed
* Removed Oracle and Fedora from doc/platforms.md and metadata since I'm not testing these platforms.
* Added supports rhel/centos to metadata.rb

# 1.0.0

* Version bump since this is now actively in use

# 0.2.0

* After deloying chrony, tag the node with either ntp-server or ntp-client

# 0.1.3

* Removing unnecessary .to_h when reading data_bag_item

# 0.1.2

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.1

* Missing changlog

# 0.1.0

Initial release.
