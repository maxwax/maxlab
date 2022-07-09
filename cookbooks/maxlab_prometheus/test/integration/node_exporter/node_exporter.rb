# Inspec test for recipe maxlab_prometheus::server

# Basic tests that a Prometheus server is deployed

describe group('prometheus') do

  it { should exist }

end

describe user('prometheus') do

  it { should exist }

end

describe directory('/opt/node_exporter') do

  it { should exist }
  its('owner') { should cmp 'prometheus' }
  its('group') { should cmp 'prometheus' }
  its('mode') { should cmp '0755' }

end

describe service('node-exporter') do

  it { should be_installed }
  it { should be_enabled }
  it { should be_running }

end

describe command('curl localhost:9100') do

  its('stdout') { should match /.*(Node Exporter).*/ }
  its('exit_status') { should cmp 0 }

end
