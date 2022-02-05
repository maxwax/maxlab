# maxlab_nfs CHANGELOG

# 1.3.0

* Update recipe server.rb to create directories that support NFS share mount points.  Another effort to help provision fresh nodes that need some manual attention before the full chef run.
* Updated recipe server.rb to create NFS mount points when executing in Test Kitchen.  This allows full automated testing using these directories as mock directories for real storage.
* Created InSpec default recipe for common testing, then individual InSpec tests for node specific NFS shares found on aux, central, depot and filer.
* Updated kitchen.yml to perform InSpec tests from multiple files, a common default/ directory of tests and per-node specific tests.
* Created policyfiles for Test Kitchen testing for depot and central nodes
* Removed policyfiles for laptopnas and testing vm testred.


# 1.2.5

* Removed entires in kitchen.yml referring to old test VMs (testred, laptopnas)
* Relying on new vagrant base box maxlab-centos-chef with Chef installed
* Updated config_nfs data bag for filer to remove old nodes not in use: lenovoflash1, lenovoflash2, media, spare, etc
* Trying out 'recursive: true' on creating directories for NFS mount points.
- I think this will be a problem later, so we'll use it for now because it works nicely with Test kitchen
* Removed config_nfs data bags for obsolete nodes media, testred, spare,
* Renamed policyfiles related to maxlab_nfs test kitchen testing from primary, auxillary to filer and aux to more directly line up with the nodes they test.

# 1.2.4

* Adding package 'mdmadm' for RAID
* Adding package 'cryptsetup' for LUKS storage encryption
* Recognize OS as 'redhat' not 'rhel' when setting attributes

# 1.2.3

* For filesystems defined in the config_nfs data bag but disabled, deploy them in /etc/exports commented out. This will let me manually uncomment them to use an external USB drive without the overhead of Chef.

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
