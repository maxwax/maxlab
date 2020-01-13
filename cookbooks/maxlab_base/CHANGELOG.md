# maxlab-base CHANGELOG

This file is used to list changes made in each version of the maxlab-base cookbook.

# 1.1.0

* Version bump to 1.0 since this is stable and .1 for these features I'm adding:

* Relocated os files such as /etc/profile from templates/default under templates/osver such as templates/rhel8.  This will let me deploy unique files for each os ver and support Debian in addition to RHEL.

* Removed code that used config_base data bags and looped through config_base contents in order to find a hash tree branch for the node's os + ver such as 'rhel8' or 'centos7'

* Added support to replace config_base with config_os_table (to identify that a centos8 node can be treated as rhel8)

* Added support to replace config_base with config_os using exactly the same data bag contents, so minimal code change.  config_os data bag has one data bag item per os+ver, while config_base tried to associate many os+ver tree branches into one data bag item. Yuck.





# 0.1.1

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.0

* Initial Release
