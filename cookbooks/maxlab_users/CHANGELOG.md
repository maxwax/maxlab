# maxlab_users CHANGELOG

# 1.2.0

* Add general_kitchen.rb recipe to create users with uid/gid values +1000 so user can be created in Test Kitchen VMs and not interfere with users like vagrant/1000.  This was to support maxlab_nfs which can't create a directory and set its user or group unless those user/groups exist first.
* Enable development with Test Kitchen
* Enable testing with Test Kitchen
* Enable policyfiles for Test Kitchen
* Rename default test, suite as 'general_kitchen'
* Update documentation

# 1.1.0

* Tag the node as having standard users with tag 'users-general'

# 1.0.1

* Documentation update
* Adding comment to general recipe.
* Adding README.md Documentation
* Adding doc directory files

# 1.0.0

* Initial release
