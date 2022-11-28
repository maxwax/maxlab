# maxlab_grafana/attributes/default.rb

# Ex: 'redhat8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

case platform_and_version
when 'redhat8', 'centos8'

  # Staged download of most recent grafana server tarball
  default['grafana']['server']['tarball']['filename'] = 'grafana-latest-relative-files.tar'

  # Operate grafana server as this user/group
  default['grafana']['server']['user'] = 'grafana'
  default['grafana']['server']['group'] = 'grafana'

  # Deploy grafana to this directory
  default['grafana']['server']['deploy_dir'] = '/opt/grafana'

  # # Deploy grafana to this directory
  # default['grafana']['server']['deploy_executable'] = \
  #   "#{node['grafana']['server']['deploy_dir']}/grafana"

  # Deploy config file here
  default['grafana']['server']['config_file'] = \
    "#{node['grafana']['server']['deploy_dir']}/grafana.yml"

  # Systemd service source template file
  default['grafana']['server']['systemd-template-file'] = 'grafana.service.erb'

  # Systemd service unit file
  default['grafana']['server']['systemd-unit-file'] = 'grafana.service'

  # Path to metrics storage backend
  default['grafana']['server']['metrics_backend'] = '/metrics'

  # Path for data files
  default['grafana']['server']['metrics_dir'] = '/metrics/grafana'

  # Services required to be running for grafana server operations
  default['grafana']['server']['services'] = %w( grafana-server )

  # Firewalld service names to open for operation
  default['grafana']['server']['firewalld']['services'] = %w( )

  # Ad-hoc ports to open for operation
  default['grafana']['server']['firewalld']['ports'] = [ '3000/tcp' ]

  # Network sources to open for operation
  default['grafana']['server']['firewalld']['sources'] = []

  # # Leave blank here because we expect to override it in a policyfile
  # # If set here, the policyfile will not replace it but merge it
  # default['grafana']['server']['scrape_configs'] = {}
  #
  # # Example of what scrape_configs should contain, set in policyfile
  # default['grafana']['server']['scrape_configs_example'] =
  #   {
  #     'grafana': {
  #       'static_configs': {
  #         'targets': [ 'localhost:9105' ]
  #       }
  #     }
  #   }
  #
  # # Interval between scrapes of jobs
  # default['grafana']['server']['scrape_interval'] = '15s'
  #
  # # Interval between evaluating rules that trigger actions
  # default['grafana']['server']['evaluation_interval'] = '60s'
  #
  # # For Systemd Unit file: Config file location
  # default['grafana']['server']['WorkingDirectory'] = '/opt/grafana'
  #
  # # For Systemd Unit file: Config file location
  # default['grafana']['server']['config.file'] = '/opt/grafana/grafana.yml'
  #
  # # For Systemd Unit file: TSDB path ending in /
  # default['grafana']['server']['storage.tsdb.path'] = '/metrics/grafana/'
  #
  # # For Systemd Unit file: Retention time for metrics
  # default['grafana']['server']['tsdb.retention.time'] = '30d'

end
