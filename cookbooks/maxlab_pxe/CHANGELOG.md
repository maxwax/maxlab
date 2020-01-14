# maxlab_pxe CHANGELOG

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
