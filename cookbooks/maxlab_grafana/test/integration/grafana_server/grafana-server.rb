# Inspec test for recipe maxlab_grafana::grafana-server

describe yum.repo('grafana') do

  it { should exist }
  it { should be_enabled }

end

describe directory('/var/lib/grafana') do

  it { should exist }
  its('owner') { should cmp 'grafana' }
  its('group') { should cmp 'grafana' }
  its('mode') { should cmp '0755' }

end

describe file('/var/lib/grafana/grafana.db') do

  it { should exist }
  its('owner') { should cmp 'grafana' }
  its('group') { should cmp 'grafana' }

end

describe directory('/var/log/grafana') do

  it { should exist }
  its('owner') { should cmp 'grafana' }
  its('group') { should cmp 'grafana' }
  its('mode') { should cmp '0755' }

end

describe service('grafana-server') do

  it { should be_installed }
  it { should be_enabled }
  it { should be_running }

end

describe command('curl localhost:3000') do

  its('stdout') { should match /.*(Found).*/ }
  its('exit_status') { should cmp 0 }

end
