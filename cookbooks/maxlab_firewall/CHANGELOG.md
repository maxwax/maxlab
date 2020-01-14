# maxlab_firewall CHANGELOG

This file is used to list changes made in each version of the maxlab_firewall cookbook.

# 1.1.3

* Removing more debugging statements.

# 1.1.2

* Removing debug statements. Too noisy while I try to do other development work.

# 1.1.1

* Bug fix: When adding ports, each port resource needs a unique name. Copy & paste error had it using source name.
* Had single quotes around resource definitions for services, sources and ports, so resources never resolved their #{variable} values to become uniquely named resources. Replaced with double quotes.

# 1.1.0

* Bumping version up since I'm actively using this as a 1.0, adding .1 for this feature
*

# 0.1.1

* Removing unnecessary .to_h when reading data_bag_item

# 0.1.0

Initial release.
