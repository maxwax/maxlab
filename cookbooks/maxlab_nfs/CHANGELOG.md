# maxlab_nfs CHANGELOG

# 1.0.2

* Obtain configuration data bag via role set instance id not labname+hostname.

# 1.0.1

* Commented out code that was used to create mount point nodes on test VMs.  Shouldn't be used on production systems.

# 1.0.0

* First version, works on a fresh VM node
* Using node attributes for firewalld ports/sources/services instead of a databag.
