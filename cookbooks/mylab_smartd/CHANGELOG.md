# mylab_smartd CHANGELOG

# 1.3.0 Use maxops email

* Using as a wrapper to maxlab_smartd to email maxops@maxwellspangler.com
* Commenting out some previous experimental code to use data bags to override maxlab_smartd node attributes. Right now I want mylab_smartd to use traditional node overrides of mylab_smartd, and not use data bags.
* Remove a lot of commented out but not used wrapper attributes.
* Comment out two lines of deploy.rb code to load a data bag and use it to override maxlab_smartd attributes.  Keeping them for future experimentation.

# 1.2.0 Test Kitchen and Policyfiles

* Major rework for Test Kitchen development
* Added Test Kitchen tests
* Added use of policyfiles
* Renamed from maxcomm_smartd to maxlab_smartd for consistenty. Not using the maxcomm name for 'simulated' community cookbooks, just 'maxlab' and then 'mylab_' for wrapper scripts.
* Deleted Berksfile
* Added data_bag for test kitchen vm: vagrantup.com_deploy-centos-8 (temporary)
* Using force_default not force_override to replace node attributes.

# 1.0.1

* Use policyfiles named tk_<policyfile>

# 1.0.0

This is a wrapper cookbook to the maxcomm_smartd 'community' cookbook to deploy and manage smartmontools smartd daemon.

It's got a lot of commented out code that I'm leaving in so I can experiment further with attribute precedence levels.

Currently as it stands, it really loads a data bag with config values and uses force_override to set those to replace the community default level node attributes that drive smartd.conf configuration.
