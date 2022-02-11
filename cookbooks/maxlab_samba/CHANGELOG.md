# maxlab_samba CHANGELOG

# 1.3.1

* Modifed server to recognize when testing in Test Kitchen and skip attempting to start the nmb service which doesn't like vagrant networking at the moment.
* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments

# 1.3.0

* Updated kitchen.yml to use maxlab-centos-chef vagrant base box
* Using consistent test directory names
* Removing obsolete policyfiles from nodes and test kitchen functionality no longer used
* Service nmb can't start in vagrant's VM because it needs the 192.168.9.0/24 network, so this currently fails in vagrant.   Future work needed, moving on for now.

# 1.2.4 Use 'redhat' not 'rhel'

* Replaced 'rhel' with 'redhat' in attribute file OS detection.

# 1.2.3 Support Red Hat Linux

* Identify Red Hat Linux as 'redhat' not 'rhel'

# 1.2.2

* Removing code to attempt to avoid starting samba if running in Test Kitchen. Need a better way to handle this later.

# 1.2.1

* policyfiles: Add instance_type attribute to policyfiles noting whether the node is 'testkitchen' or 'node'.  Testkitchen means a networking config that will allow samba to start in a Test Kitchen VM and should be verified.  Node means a networking config for a real node which won't allow samba to start and run within Test Kitchen.
* server.rb: Only attempt to start samba of instance_type is 'testkitchen'

# 1.2.0

* Enable Test Kitchen development
* Enable Test Kitchen tests
* Enable policyfiles
* Use 'kitchen' policyfile and data bag to test running services within Test Kitchen.
* Select data bag using instance_config_samba value from policyfile. Adding instance_ to old config_samba instance name.

# 1.1.0

* Tag the node as being a samba-server

# 1.0.2

* Cosmetic: List newer OS before older in attributes/default.rb file

# 1.0.1

* Documentation update:
* attributes updated to add comment for packages attributes
* Period added to recipe description so doc script includes it on README.md

# 1.0.0

* Initial release, tested on fresh VM and two NAS filer nodes.
