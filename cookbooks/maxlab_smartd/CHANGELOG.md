# maxlab_smartd CHANGELOG

# 1.3.1

* Modify case that sets packages related to smartmon tools to have multiple OS sharing the same condition when the value is the same. Cookstyle did not like redhat=smartmontools,centos=smartmontools due to repetition.
* Cookstyle cleanup: Replace double quotes with single quotes as recommended
* Cookstyle cleanup: remove utf8 encoding on tests
* Cookstyle cleanup: Add Redhat 8, Centos 8, remove Ubuntu from spec file
* Cookstyle cleanup: Use node['platform_version'].to_i.to_s
* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Remove non-standard comment syntax #<>
* Cookstyle clenaup: Remove block comments

# 1.3.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# Add default smartd package

* Added else to OS case statement that selects package to install

# 1.2.1 Support Red Hat Linux

* Use 'redhat' not 'rhel' to identify Red Hat Linux.

# 1.2.0 Test Kitchen and Policyfiles

* Major rework for Test Kitchen development
* Added Test Kitchen tests
* Added use of policyfiles
* Renamed from maxcomm_smartd to maxlab_smartd for consistenty. Not using the maxcomm name for 'simulated' community cookbooks, just 'maxlab' and then 'mylab_' for wrapper scripts.
* Deleted Berksfile
* Added data_bag for test kitchen vm: vagrantup.com_deploy-centos-8 (temporary)

# 1.1.0

* After deploying smartd, tag the node with 'smartd' so we know its monitored.

# 1.0.0

Initial release.

* Used this cookbook to simulate a 'community' cookbook.  It still has some commented out debug statements left in the code so that I can enable them in the future if I see things that don't look right.
