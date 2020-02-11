# Description

Deploy PXE boot files (syslinux pxe menus and Linux kickstart install files).

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

* maxlab_tftp_server

# Attributes

*No attributes defined*

# Recipes

* [maxlab_pxe::default](#maxlab_pxedefault) - This recipe performs no actions.
* [maxlab_pxe::deploy](#maxlab_pxedeploy) - Deploy PXE files: Kickstart files for Linux distributions, PXE menus for all.
* [maxlab_pxe::images](#maxlab_pxeimages)
* [maxlab_pxe::syslinux](#maxlab_pxesyslinux)

## maxlab_pxe::default

This recipe performs no actions.

## maxlab_pxe::deploy

Deploy PXE files: Kickstart files for Linux distributions, PXE menus for all.

## maxlab_pxe::images

Deploy Linux Distribution images (kernel and initrd files) to support PXE boots

## maxlab_pxe::syslinux

Deploy syslinux package PXE files used to support netbooting / PXE menus

Maxwell Spangler maxcode@maxwellspangler.com
