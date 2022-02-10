# maxlab_nginx_repo CHANGELOG

# 1.3.1

* Cookstyle cleanup, move list of root directories into a variable and act against that. better readability and no cookstyle complaints.
* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments

# 1.3.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.2.0 Kitchen dev and policyfiles

* Enable development with Test Kitchen
* Enable testing with test kitchen
* Remove Berksfile
* Add policyfile for test kitchen
* Rename default.rb recipe to deploy.rb
* Changed data_bag config_nginx_repo to obsolete_

# 1.1.0

* Change 'service' to 'services' in firewalld rules of config_nginx_repo data bag.
* Modify maxlab_nginx_repo::default code to use services, ports and sources from data bag as arrays.
* New code originally from config_plex to append any array elements from the data bag to the node.normal['maxlab_firewall'] node attribute that maxlab_firewall::update_firewall will use to apply firewll changes.

# 1.0.0

* Version bump as this cookbook is now in production use.

# 0.2.0

* Tag the node with nginx-repo, nginx-server and http-server to indicate services deployed via this cookbook

# 0.1.2

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.1

* Reworking how configuration files for a listening server/port are setup.
* Added variables to config_nginx_repo data bag and now populate /etc/nginx.conf.d/maxlab_repo.conf using Chef remplate.  Fixing up some past quick and dirty work.
* Put a guard around executing selinux commands to change the SELinux context of nginx content directories. Want to make sure we don't change a top level system dir by accident in the future.

# 0.1.0

* Initial cookbook
* Created in a rush to get a simple http server running on a node via Chef in order to serve HTTP files for PXE installs.
* Future work will attempt to leverage the community nginx cookbooks
