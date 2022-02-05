# maxlab_apcupsd CHANGELOG

# 1.2.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.1.0

* Deploy log-apc-ups-stats script to log UPS battery stats periodically
* Configure cron job to run log-apc-ups-stats periodically
* Updates to InSpec testing to test for script and cronjob to exist
* Update to policyfiles to supply attributes supporting script and cronjob

# 1.0.0

* Cloned maxlab_nfs_client and turning it into maxlab_apcupsd
* Moved configuration values from data bag to policyfile as attribute in order to experiment with using this to configure a cookbook.
* Outfitted with Inspec tests and got all tests passing in Test Kitchen
* First version ready for production testing
