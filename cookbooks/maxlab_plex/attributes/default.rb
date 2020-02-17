# Attributes file for maxlab_plex

#<> Allow these services via firewalld
default['plex']['firewall']['firewalld']['services'] = [ "http" ]
#<> Allow these ports via firewalld
default['plex']['firewall']['firewalld']['ports'] = [ "32400/tcp", "1900/udp", "3005/tcp", "5353/udp", "8324/tcp", "32410/udp", "32412/udp", "32413/udp", "32414/udp", "32469/tcp"]
#<> Allow these sources via firewalld
default['plex']['firewall']['firewalld']['sources'] = []

#<> service plex to this network
default['plex']['network'] = 'maxlab'
#<> service plex to this subnet
default['plex']['subnet'] = '192.168.9.0'

#<> Operate plex as this user
default['plex']['owner'] = 'plex'
#<> Operate plex as this group
default['plex']['group'] = 'plex'
#<> Deploy config files with this mode
default['plex']['mode'] = '0655'

#<> Install this package
default['plex']['package_name'] = 'plexmediaserver'
#<> Operate this service name
default['plex']['service_name'] = 'plexmediaserver'

#<> Ensure these directories are created
default['plex']['directories'] = [
  "/srv/audiovideo/Video/Buddhism",
  "/srv/audiovideo/Video/Movies/Unwatched",
  "/srv/audiovideo/Video/Television",
  "/srv/audiovideo/Video/youtube",
  "/srv/audiovideo/Music",
  "/srv/avarchive/ApD",
  "/srv/avarchive/Classic",
  "/srv/avarchive/Classic-Watched",
  "/srv/avarchive/Documentary",
  "/srv/avarchive/Watched"
]
