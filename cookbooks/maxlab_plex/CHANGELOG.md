# maxlab_plex CHANGELOG

Maintain a Plex media server in the maxlab environment.

# 1.2.1

* Replace code to install or upgrade plex with code to :install,:upgrade and let the package resource figure it out.
* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments

# 1.2.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Modified tests for consistent naming with other cookbooks

# 1.1.2

* Adding Plex specific ports to open in firewalld

# 1.1.1

* Removed unused Policyfile.rb

# 1.1.0

* Enable Test Kitchen development
* Enable Test Kitchen tests
* Enable policyfiles
* When plex is not installed, deploy the plex Linux repo and then install it.
* When plex is already installed, upgrade it.
* Use node attributes not a data bag to deploy plex.
* Marked data bag config_plex with obsolete_

# 1.0.2

* Change tag from 'plex-media-server' to 'plex' for nodes with it deployed.

# 1.0.1

* Fix code still referencing 'service' within config_plex's data bag's firewall section. Just changing to 'services' to be consistent with 'ports' and 'sources'.

# 1.0.0

* Initial release.
