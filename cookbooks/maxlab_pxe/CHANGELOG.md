# maxlab_pxe CHANGELOG

# 1.3.0

* Introducing ks-centos-8-interactive.rb template to generate a kickstart file that allows a lightly guided, but manuall installation process.
* Added centos_stream OS branch in config_pxe pxeconfig databag for Centos Stream to be on its own menu

# 1.2.3

* Remove 'install' from kickstart script (deprecated)
* Add 'poweroff' command so it reboots automatically.  Could do 'reboot' but it will just PXE again, so lets stop it, adjust the boot order, then let the user manually start.

# 1.2.2 Replace 'rhel' with 'redhat'

* Replace 'rhel' with 'redhat' when setting attributes related to OS.

# 1.2.1

* Removed chef-vault related debugging statements

# 1.2.0

* Use chef-vault to include root password in kickstart file
* kitchen.yml: When testing with test kitchen, use unencrypted, non-git local data bag files.

# 1.1.3

* Replace references to tftp_server with 'tftp'.
* Depend on maxlab_tftp not maxlab_tftp_server

# 1.1.2 Updated docs

* Updated faulty overview.md copy & pasted from DNS cookbook.
* Re-generated README.md main doc file.

# 1.1.1 cmp instead of eq

* Modify two tests to use 'cmp' operator instead of 'eq'

# 1.1.0

* Rename default.rb recipe as deploy for consistency with other cookbooks.
* Adding support for Test Kitchen development
* Adding support for test kitchen tests
* Adding support for policyfiles
* Removing Berksfile
* Removing local default tests
* Add test that various /repo/kickstart directories exists
* Add test that various pxe boot (syslinux) files exit
* Test whether tftp client can get pxelinux.0 from localhost tftp service
* Test whether firewalld has opened tftp service
* template kickstart/ks-centos8.erb: Replace node['global'] previously found in maxlab environment with node['env']['maxlab'] policyfiles environment
* Recipe changed from default to deploy


# 1.0.0

* Version bump to 1.0.0 now that we're in production use.
* Removed Oracle and Fedora linux from metadata.rb since I don't test them.

# 0.2.0

* Tag the node as a pxe-server after deploying services

# 0.1.6

* Removing unnecessary .to_h when reading data_bag_item
* Removed lots of no longer needed puts debugging statements that were required during development.

# 0.1.5

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.4

* Changing sort order on major/minor versions so highest (most recent) is shown on top of PXE menus, and older versions show towards bottom.

# 0.1.3

* Backing out changes from 0.1.2 that only untared images/ the directory was empty. This isn't a good way of doing things. I need to just rework this to manage all the files in there with Chef directly, or more likely, park an rpm somewhere and install that.  That'll give me controls and versioning of the image directory contents.

# 0.1.2

* Ensure that images directory (for kernel and initrd files) exists and is created if not as an isolated resource
* Separate from above, if this directory is empty, then download a tar file and seed it with images.

# 0.1.1

* Added recipe images.rb - creates and populates /var/lib/tftpboot/images with Linux kernel and initrd files as well as netboot tools like Clonezilla
* Added recipe syslinux - installs syslinux PXE menu files

# 0.1.0

* Draft release
