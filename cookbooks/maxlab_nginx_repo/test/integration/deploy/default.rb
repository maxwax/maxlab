# # encoding: utf-8

# Inspec test for recipe maxlab-tftp-server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('nginx') do
  it { should be_installed }
end

describe file('/etc/nginx/nginx.conf') do
  it { should exist }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/nginx/conf.d/maxlab-repo.conf') do
  it { should exist }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('mode') { should cmp '0644' }
end

describe directory('/repo/') do
  it { should exist }
  its('owner') { should cmp 'nginx' }
  its('group') { should cmp 'nginx' }
  its('mode') { should cmp '0755' }
  its('selinux_label') { should cmp 'unconfined_u:object_r:httpd_sys_content_t:s0' }
end

describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('curl -I localhost') do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match (/.*(200\ OK).*/) }
end
