# maxlab_base CHANGELOG

# 1.5.3

Adding 'kitchen_testing_maxlab: true' to .kitchen.yml and checking in current cookbook version.

# 1.5.2

* Don't deploy each repo_package package if it is already installed. Save chef-client execution time.
* Don't execute repo_config_commands such as subscribing to RHEL repos if the repo appears to already exist and be enabled. Saves a lot of time.

# 1.5.1

* Cookstyle cleanup: Remove long description from metadata.rb
* Cookstyle cleanup: Lots of empty lines removed, meh.
* Cookstyle cleanup: Modify spec file to use Centos 8, add redhat 8
* Cookstyle cleanup: Construct platform using to_i.to_s on version
* Cookstyle cleanup: remove unrequired encoding spec on test file


# 1.5.0

* Modified kitchen.yml to use maxlab-centos-chef vagrant base box
* Renamed test files for consistency with other cookbooks

# 1.4.0

* Modify test to check for installation of netcat instead of nmap-ncat.  Related to bug related to SSH tunneling. https://bugzilla.redhat.com/show_bug.cgi?id=2024007
* The default deploy recipe now deploys base components not related to direct hardware support.
* The new deploy-bare-metal recipe is an additional recipe to run on bare metal nodes that deploys components that support direct hardware access, ex: lm_sensors for temperature monitoring.
* Created Test Suites default and bare-metal, reorganized files accordingly.

# 1.3.0

* Enable Test Kitchen development
* Enable Test Kitchen tests
* Enable policyfiles use
* Delete Berksfile
* Update docuemntation

# 1.2.0

* Deploy all base packages with one package resource not one per package. Much faster.

# 1.1.0

* Version bump to 1.0 since this is stable and .1 for these features I'm adding:

* Relocated os files such as /etc/profile from templates/default under templates/osver such as templates/rhel8.  This will let me deploy unique files for each os ver and support Debian in addition to RHEL.

* Removed code that used config_base data bags and looped through config_base contents in order to find a hash tree branch for the node's os + ver such as 'rhel8' or 'centos7'

* Added support to replace config_base with config_os_table (to identify that a centos8 node can be treated as rhel8)

* Added support to replace config_base with config_os using exactly the same data bag contents, so minimal code change.  config_os data bag has one data bag item per os+ver, while config_base tried to associate many os+ver tree branches into one data bag item. Yuck.

* The config_base code required looping to attempt to find an osver configuration it could use and if it didn't find it, it would error out? What was I thinking. Glad this is removed. Nuts to have this in there in the first place.  Novice code.  Yuck.

* Code diff looks more significant than it is due to removing looping and removing indenting on much of the actual code.

# 0.1.1

* Using ::default instead of ::deploy across all cookbooks.

# 0.1.0

* Initial Release
