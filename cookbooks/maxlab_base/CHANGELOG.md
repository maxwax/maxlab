# maxlab_base CHANGELOG

# 1.7

* New recipe deploy_svc_base, a quick clone of deploy but instead of using a config_os data bag for configuration values to drive the work, use a config_base data bag with configuration values related to the node's service irregardless of the node's OS.  Primary example: Deploy extra av files on av service nodes.
* Introduce sw_install_commands to data bag to execute Python pip or Ruby gem install commands
* Added databag config_base kitchen_testing_maxlab for local kitchen testing config to drive deploy_svc_base recipe.

# 1.6.3

* New code to deploy default_scripts_generic starting with file cron-backup-history.
* Deploy cron jobs for user 'maxwell' and 'root' to execute cron-backup-history to archive $HOME/.bash_history_eternal
* Moved policyfile for Test Kitchen use from policyfiles directory to cookbook directory.
* Added tests to ensure cronjobs for maxwell and root include cron-backup-history command
* Modified .gitignore to ignore Policyfile*.lock.json
* Added cron_jobs section to data bags config_os for centos8, redhat6, 7, and 8

# 1.6.2

* Renaming attribute default_scripts to default_os_scripts to reflect that it is OS specific.
* Renaming attribute default_scripts_bare_metal to default_os_scripts_bare_metal to reflect that it is OS specific.
* Introducing default_scripts_generic for scripts that are files in the cookbook maxlab_base that are deployed without templating and across all Linux distributions and versions.  No need to be a template.

# 1.6.1

* Updating shell-history script to match history options used on personal workstation. Mostly $HOME/.bash_history_eternal not $HOME/.bash_history, etc.

# 1.6.0

* Removed template directories for os debian, redhat7 and redhat6 since they are not supported and not tested.  Obsolete

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
