# Inspec test for recipe maxlab_prometheus::node_exporter

# Basic tests to ensure Node Exporter is deployed

describe directory('/opt/prometheus') do

  it { should exist }
  its('owner') { should cmp 'prometheus' }
  its('group') { should cmp 'prometheus' }
  its('mode') { should cmp '0755' }

end

describe file('/opt/prometheus/prometheus.yml') do

  it { should exist }
  its('owner') { should cmp 'prometheus' }
  its('group') { should cmp 'prometheus' }

end

describe service('prometheus') do

  it { should be_installed }
  it { should be_enabled }
  it { should be_running }

end

describe command('curl localhost:9090') do

  its('stdout') { should match /.*(Found).*/ }
  its('exit_status') { should cmp 0 }

end
