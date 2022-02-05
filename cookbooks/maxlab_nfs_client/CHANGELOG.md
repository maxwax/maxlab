# maxlab_nfs CHANGELOG

# 1.2.0

* Updating kitchen.yml to use common tests in default and plex
* Added directory_tree attribute to config_nfs_client.  Directories defined here will be created on a node to support NFS client mount points.
* Modified kitchen.yml to use maxlab-centos-chef vagrant base box

# 1.1.0

* Add code to append NFS mount points to /etc/fstab

# 1.0.0

* Cloned maxlab_nfs and turning it into maxlab_nfs_client
* Checking in initial base code but without code to create /etc/fstab entry for NFS share.
