# maxlab_plex CHANGELOG

Maintain a Plex media server in the maxlab environment.

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
