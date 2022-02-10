# maxlab_postfix CHANGELOG

# 1.3.1

* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle cleanup: Remove block comments

# 1.3.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.2.1 Support Red Hat Linux

* Identify Red Hat Linux as 'redhat' not 'rhel'

# 1.2.0

* Use chef-vault to deploy /etc/postfix/sasl_passwd safely
* Update Test Kitchen to use local unencrypted (non-git) data bag files to construct /etc/postfix/sasl_passwd.
* Add Test Kitchen tests for the creation of /etc/postfix/sasl_passwd and /etc/postfix/sasl_passwd.db
* metadata.rb: Include recipe 'chef-vault'
* policyfile tk_maxlab_postfix_server.rb: Include recipe 'chef-vault'

# 1.1.0

* Enable Test Kitchen development
* Enable Test Kitchen tests
* Enable policyfiles
* Switch from data bag to node attributes for configuration basics
* Replace 'setgit_group' typo with 'setgid_group' in main.cf template file.
* Identify unique configuration via 'instance_config_postfix' not 'config_postfix' attribute for consistency with other cookbooks.

# 1.0.0

Initial release.
