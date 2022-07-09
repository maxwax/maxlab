# maxlab_nfs CHANGELOG

# 1.2.2

* Minor change to test for plex node NFS client ensuring that /net/av exists.
** Obsolete anyway, but cleanup, still.

# 1.2.1

* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments

# 1.2.0

* Updating kitchen.yml to use common tests in default and plex
* Added directory_tree attribute to config_nfs_client.  Directories defined here will be created on a node to support NFS client mount points.
* Modified kitchen.yml to use maxlab-centos-chef vagrant base box

# 1.1.0

* Add code to append NFS mount points to /etc/fstab

# 1.0.0

* Cloned maxlab_nfs and turning it into maxlab_nfs_client
* Checking in initial base code but without code to create /etc/fstab entry for NFS share.
