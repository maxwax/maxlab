# maxlab_smartd CHANGELOG

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
