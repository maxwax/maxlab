
# maxlab CHANGELOG

# 1.1.24

* Added maxlab_base::deploy-bare-metal to policyfiles for filer, aux, central and depot.  This deploys components that provide direct hardware support on bare metal nodes but allows maxlab_base::deploy to skip deploying them within virtual machines.

# 1.1.23

* No longer tracking policyfile .lock.json files with git.

# 1.1.22

* Added new cookbook maxlab_apcupsd to monitor APC UPS equipment
* Added policyfile tk_maxlab_apcups to allow Test Kitchen testing of maxlab_apcupsd
* Minor fix to maxlab_apcupsd template to populate 'facility' config line
* Bug fix: Change maxlab_apcupsd related attribute 'daemon' to be 'facility' with value daemon.
** Modifying default/attributes.rb
** Modifying tk_maxlab_apcupsd.rb policyfile
** Modifying maxlab_node_nas_filer.rb policyfile
* Minor change to comments in config_firewall/base_firewall.maxlab.dmz data bag
* Created new config_firewall data bag base_firewall.maxlab.internal

# 1.1.21

* Add node 'fedora' at .121, A VM to let me expore and debug issues in a Fedora VM.

# 1.1.20

* Added /srv/terawd NFS share on depot.maxlab

# 1.1.19

* Add /srv/x320 share to central
* Remove access to share /srv/x320 and /srv/teraxfiles to macbooknext and macbooknextwifi

# 1.1.18

* Adding plex.maxlab as a VM for Plex Media Server
* Removing references to media.maxlab for NFS access
* Adding access for plex.maxlab for NFS access for audiovideo storage
* Moving existing config_plex data bag for media.maxlab to plex.maxlab

# 1.1.17

* Adding coalbox.maxlab to allowed share of filer's /srv/filerdata/iso/proxmox share

# 1.1.16

* Adding JSON branch in config_kickstart centos.json to allow CentOS 8.5.2111

# 1.1.15

* Re-purposing HP desktop 'media' as 'coalbox' a VM lab running Proxmox Hypervisor
* Added VM node 'exper' for experimentation

# 1.1.14

* Replacing /srv/filerdata/iso share to /srv/filerdata/iso/proxmox for dedicated Proxmox ISO storage source

# 1.1.13

* New NFS share /srv/filerdata/iso on filerdata for use by Proxmox as ISO source

# 1.1.12

* Introducing NAS server 'depot.maxlab'

# 1.1.11

* Updated names of Apple Airports to include '-wired' when on wire
* Updated MAC addresses of airport-bedroom-wire and airport-bedroom-wireless to reflect the replacement of old 1st gen airport with 2nd gen Airport Express

# 1.1.10

* Rename canon_printer canon-printer to follow standard DNS names

# 1.1.9

* Removed laptopnas node
* Removed old VM nodes 'blue', 'red, 'green', 'compare', 'graphite1', 'graphite2', 'repomanual'
* Removed old hypervisor 'lenovoflash3'

# 1.1.8

* Add new NAS 'depot.maxlab'

# 1.1.7

* Make the Canon wireless printer static IP

# 1.1.6

* Removed iPhone Xr, added iPhone 13 Pro

# 1.1.5

* Adding pfSense Firewall at .3

# 1.1.4

* Deploy lm_sensors on redhat8 and centos8 systems

# 1.1.3

* Added node entry in config_network databag for sco5.maxlab SCO Openserver vintage VM

# 1.1.2

* Remove plex from filer since Plex is now on node 'media'

# 1.1.1

* Updating MAC addresses for current network devices

# 1.1.0

* Add support for actual Red Hat Linux now that licenses are available.
* Add nodes media and central as I rebuilt lab NAS storage

# 1.0.1

* Removed nodes lenovoflash4 and lenovoflash5, not part of home lab anymore.
* Added new node 'media.maxlab' a NAS filer made out of a re-purposed HP desktop computer.

# 1.0.0

* How did I not have a CHANGELOG file for my overall maxlab provisioning?
* Adding this CHANGELOG for each change reviews.
