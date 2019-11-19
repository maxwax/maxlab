# Description

This cookbook depoys DNS via the bind (named) daemon on Red Hat 7.x and 8.x systems

# Requirements


## Chef Client:

* chef (>= 13.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)
* oracle (>= 7.0)
* fedora (>= 30.0)

## Cookbooks:

* maxlab_firewall

# Attributes

* `node['bind']['packages']['rhel']['8']['bind']` - BIND package for Red Hat 8. Defaults to `32:9.11.4-17.P2.el8_0.1`.
* `node['bind']['packages']['rhel']['8']['bind-utils']` - bind-utils package for Red Hat 8. Defaults to `32:9.11.4-17.P2.el8_0.1`.
* `node['bind']['packages']['rhel']['7']['bind']` - bind package for Red Hat 7. Defaults to `32:9.11.4-9.P2.el7`.
* `node['bind']['packages']['rhel']['7']['bind-utils']` - bind-utils package for Red Hat 7. Defaults to `32:9.11.4-9.P2.el7`.
* `node['maxwell']` - Something. Defaults to `something`.

# Recipes

* [maxlab_bind::default](#maxlab_binddefault)
* [maxlab_bind::deploy](#maxlab_binddeploy)

## maxlab_bind::default

The default recipe performs no actions

## maxlab_bind::deploy

Deploy DNS services using bind

A Redhat based Linux distribution using firewall-cmd such as
* Red Hat Linux 7.x or 8.x
* CentOS 7.x or 8.x
* Fedora Linux 30+
* Oracle Linux 7.x or 8.x


Maxwell Spangler maxcode@maxwellspangler.com
