# maxlab_samba CHANGELOG

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
