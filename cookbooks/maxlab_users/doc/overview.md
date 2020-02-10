This is a centralized cookbook for creating users and groups on maxlab nodes.

The purpose of this is to coordinate, one place, where users and groups are created.

* One central location for all users and groups that are intentionally created
* Configured uid and gid values so they are consistent across nodes and shared storage has the same uid/gid values when files are created on different nodes.
* No hunting down where users and groups are created in a variety of cookbooks.

As of right now, applications can still create their own users and groups via rpm installs. I'll come back to that later.

# Operation

The general.rb recipe looks for data bag config_servicesets which contains the single item 'maxlab_global'.

A defined service points lists required users and groups.

Each user can be found, defined with a specific uid and gid, in data bag config_users.

Each group can be found, defined with a specific gid, in data bag config_groups.

# Long Term

I'll modify this cookbook in the future to use a function or LWRP to do this.  Right now to add a new service, the easiest way is to clone general.rb, point it to a different serviceset (service) by name, and then add any additional handling to it.  It's not ideal, but I don't want to spend too much time on this right now.

