# # encoding: utf-8

# Inspec test for recipe mylab_plex::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('plexmediaserver') do
  it { should be_installed }
end

describe directory('/var/lib/plexmediaserver/Library/Application Support/Plex Media Server') do
  it { should exist }
  its('owner') { should cmp 'plex' }
  its('group') { should cmp 'plex' }
  its('mode') { should cmp '0755' }
end

describe file('/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Preferences.xml') do
  it { should exist }
  its('owner') { should cmp 'plex' }
  its('group') { should cmp 'plex' }
end

describe service('plexmediaserver') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('curl -I localhost:32400') do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match (/.*(200\ OK).*/) }
end
