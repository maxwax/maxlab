# maxlab_base CHANGELOG

# 1.3.0

* Enable Test Kitchen development
* Enable Test Kitchen tests
* Enable policyfiles use
* Delete Berksfile
* Update docuemntation

# 1.2.0

* Deploy all base packages with one package resource not one per package. Much faster.

# 1.1.0

* Version bump to 1.0 since this is stable and .1 for these features I'm adding:

* Relocated os files such as /etc/profile from templates/default under templates/osver such as templates/rhel8.  This will let me deploy unique files for each os ver and support Debian in addition to RHEL.

* Removed code that used config_base data bags and looped through config_base contents in order to find a hash tree branch for the node's os + ver such as 'rhel8' or 'centos7'

* Added support to replace config_base with config_os_table (to identify that a centos8 node can be treated as rhel8)

* Added support to replace config_base with config_os using exactly the same data bag contents, so minimal code change.  config_os data bag has one data bag item per os+ver, while config_base tried to associate many os+ver tree branches into one data bag item. Yuck.

* The config_base code required looping to attempt to find an osver configuration it could use and if it didn't find it, it would error out? What was I thinking. Glad this is removed. Nuts to have this in there in the first place.  Novice code.  Yuck.

* Code diff looks more significant than it is due to removing looping and removing indenting on much of the actual code.

# 0.1.1

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.0

* Initial Release
