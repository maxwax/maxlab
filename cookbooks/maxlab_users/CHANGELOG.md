# maxlab_users CHANGELOG

# 1.4.0

* Refactored code to be cleaner and perform the following
* Pay attention to the serviceset attribute defined in a policyfile to determine what serviceset applies to a node. From that get a list of users and groups required to be deployed.
* Create any groups defined by the serviceset for services on this node.
* Create any users defined by the serviceset for services on this node.
* Ensure users are also members of non-primary groups when required.

# 1.3.1

* Modify base recipe general.rb to handle test kitchen and non test kitchen cases so I can eliminate the redundant test kitchen only recipe general_kitchen.rb
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

# 1.2.3

* Ensure we create a user's home directory.

# 1.2.2

* Bug fix, now make /home/<username> correctly for each normal user.

# 1.2.1

* Make a home directory for the users we make!  Not required for many users created just for services, but hard to login as a default non-root user without a home.

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
