# Description

This cookbook depoys an NTP client or server using the Chrony daemon on Red Hat 7.x and 8.x systems

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

*No platforms defined*

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['chrony']['packages']['rhel']['8']['chrony']` - Chrony packages for Red Hat Linux 8. Defaults to `[ ... ]`.
* `node['chrony']['packages']['rhel']['7']['chrony']` - Chrony packages for Red Hat Linux 7. Defaults to `[ ... ]`.

# Recipes

* maxlab_chrony::default
* [maxlab_chrony::deploy](#maxlab_chronydeploy) - Configure the Chrony NTP client in a standard fashion.

## maxlab_chrony::deploy

Configure the Chrony NTP client in a standard fashion.

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x
* Fedora Linux 30+
* Oracle Linux 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
