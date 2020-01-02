# maxlab_pxe CHANGELOG

# 0.1.2

* Ensure that images directory (for kernel and initrd files) exists and is created if not as an isolated resource
* Separate from above, if this directory is empty, then download a tar file and seed it with images.

# 0.1.1

* Added recipe images.rb - creates and populates /var/lib/tftpboot/images with Linux kernel and initrd files as well as netboot tools like Clonezilla
* Added recipe syslinux - installs syslinux PXE menu files

# 0.1.0

* Draft release
