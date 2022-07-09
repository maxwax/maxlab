# maxlab_prometheus/attributes/default.rb

# Ex: 'redhat8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

case platform_and_version
when 'redhat8', 'centos8'

  #
  # Server attributes
  #

  # Staged download of most recent Prometheus server tarball
  default['prometheus']['server']['tarball']['filename'] = 'prometheus-latest-relative-files.tar'

  # Operate prometheus server as this user/group
  default['prometheus']['server']['user'] = 'prometheus'
  default['prometheus']['server']['group'] = 'prometheus'

  # Deploy prometheus to this directory
  default['prometheus']['server']['deploy_dir'] = '/opt/prometheus'

  # Deploy prometheus to this directory
  default['prometheus']['server']['deploy_executable'] = \
    "#{node['prometheus']['server']['deploy_dir']}/prometheus"

  # Deploy config file here
  default['prometheus']['server']['config_file'] = \
    "#{node['prometheus']['server']['deploy_dir']}/prometheus.yml"

  # Systemd service source template file
  default['prometheus']['server']['systemd-template-file'] = 'prometheus.service.erb'

  # Systemd service unit file
  default['prometheus']['server']['systemd-unit-file'] = 'prometheus.service'

  # Path to metrics storage backend
  default['prometheus']['server']['metrics_backend'] = '/metrics'

  # Path for data files
  default['prometheus']['server']['metrics_dir'] = '/metrics/prometheus'

  # Services required to be running for prometheus server operations
  default['prometheus']['server']['services'] = %w( prometheus )

  # Firewalld service names to open for operation
  default['prometheus']['server']['firewalld']['services'] = %w( )

  # Ad-hoc ports to open for operation
  default['prometheus']['server']['firewalld']['ports'] = [ '9090/tcp' ]

  # Network sources to open for operation
  default['prometheus']['server']['firewalld']['sources'] = []

  # Leave blank here because we expect to override it in a policyfile
  # If set here, the policyfile will not replace it but merge it
  default['prometheus']['server']['scrape_configs'] = {}

  # Example of what scrape_configs should contain, set in policyfile
  default['prometheus']['server']['scrape_configs_example'] =
    {
      'prometheus': {
        'static_configs': {
          'targets': [ 'localhost:9105' ]
        }
      }
    }

  # Interval between scrapes of jobs
  default['prometheus']['server']['scrape_interval'] = '15s'

  # Interval between evaluating rules that trigger actions
  default['prometheus']['server']['evaluation_interval'] = '60s'

  # For Systemd Unit file: Config file location
  default['prometheus']['server']['WorkingDirectory'] = '/opt/prometheus'

  # For Systemd Unit file: Config file location
  default['prometheus']['server']['config.file'] = '/opt/prometheus/prometheus.yml'

  # For Systemd Unit file: TSDB path ending in /
  default['prometheus']['server']['storage.tsdb.path'] = '/metrics/prometheus/'

  # For Systemd Unit file: Retention time for metrics
  default['prometheus']['server']['tsdb.retention.time'] = '30d'

  #
  # Node exporter attributes
  #

  # Staged download of most recent Prometheus node_exporter tarball
  default['prometheus']['node_exporter']['tarball']['filename'] = 'node-exporter-latest-relative-files.tar'

  # Operate prometheus server as this user/group
  default['prometheus']['node_exporter']['user'] = 'prometheus'
  default['prometheus']['node_exporter']['group'] = 'prometheus'

  # Deploy prometheus to this directory
  default['prometheus']['node_exporter']['deploy_dir'] = '/opt/node_exporter'

  # Deploy prometheus to this directory
  default['prometheus']['node_exporter']['deploy_executable'] = \
    "#{node['prometheus']['node_exporter']['deploy_dir']}/node_exporter"

  # Systemd service source template file
  default['prometheus']['node_exporter']['systemd-template-file'] = 'node-exporter.service.erb'

  # Systemd service unit file
  default['prometheus']['node_exporter']['systemd-unit-file'] = 'node-exporter.service'

  # For Systemd Unit file: Config file location
  default['prometheus']['node_exporter']['WorkingDirectory'] = '/opt/node_exporter'

  # Services required to be running for prometheus node_exporter operations
  default['prometheus']['node_exporter']['services'] = %w( node-exporter )

  # Firewalld service names to open for operation
  default['prometheus']['node_exporter']['firewalld']['services'] = %w( )

  # Ad-hoc ports to open for operation
  default['prometheus']['node_exporter']['firewalld']['ports'] = [ '9100/tcp' ]

  # Network sources to open for operation
  default['prometheus']['node_exporter']['firewalld']['sources'] = []

end
