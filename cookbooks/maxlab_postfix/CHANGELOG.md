# maxlab_postfix CHANGELOG

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
