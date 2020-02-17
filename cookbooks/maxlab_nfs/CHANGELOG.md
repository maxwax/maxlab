# maxlab_nfs CHANGELOG

# 1.2.2

* Added not_if guard to NOT create an NFS mount point if it already exists.  Found that Chef trying to manage an NFS directory on a mounted, existing filesystem may attempt to reset the SELinux file context of all files on each mounted filesystem. Hoping that this means: Make the directory if it does NOT exist, otherwise, don't touch it.

# 1.2.1

* Do not recursively create NFS mount directories

# 1.2.0

* Enable Test Kitchen development
* Enable policyfiles
* Use attribute instance_config_nfs instead of config_nfs to identify a node's NFS configuration data bag
* Added enabled true/false to data bag NFS mount points.  Only manage mount points that are enabled.
* Add NFS mount points if they don't exist.
* Added owner/group/mode to NFS mount points data bag tree banches
* Rename data bag files for config_nfs to match data bag ids. Required for Test Kitchen.


# 1.1.0

* After deloying NFS, tag the node as an NFS server

# 1.0.2

* Obtain configuration data bag via role set instance id not labname+hostname.

# 1.0.1

* Commented out code that was used to create mount point nodes on test VMs.  Shouldn't be used on production systems.

# 1.0.0

* First version, works on a fresh VM node
* Using node attributes for firewalld ports/sources/services instead of a databag.
