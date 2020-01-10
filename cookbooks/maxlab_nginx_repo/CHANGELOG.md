# maxlab_nginx_repo CHANGELOG

# 0.1.2

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.1

* Reworking how configuration files for a listening server/port are setup.
* Added variables to config_nginx_repo data bag and now populate /etc/nginx.conf.d/maxlab_repo.conf using Chef remplate.  Fixing up some past quick and dirty work.
* Put a guard around executing selinux commands to change the SELinux context of nginx content directories. Want to make sure we don't change a top level system dir by accident in the future.

# 0.1.0

* Initial cookbook
* Created in a rush to get a simple http server running on a node via Chef in order to serve HTTP files for PXE installs.
* Future work will attempt to leverage the community nginx cookbooks
