# Attributes file for maxlab_nginx_repo

#<> Allow these services via firewalld
default['nginx_repo']['firewall']['firewalld']['services'] = [ "http" ]
#<> Allow these ports via firewalld
default['nginx_repo']['firewall']['firewalld']['ports'] = []
#<> Allow these sources via firewalld
default['nginx_repo']['firewall']['firewalld']['sources'] = []

#<> service nginx to this network
default['nginx_repo']['network'] = 'maxlab'
#<> service nginx to this subnet
default['nginx_repo']['subnet'] = '192.168.9.0'

#<> Deploy and operate nginx as this owner
default['nginx_repo']['owner'] = 'nginx'
#<> Deploy and operate nginx as this group
default['nginx_repo']['group'] = 'nginx'
#<> Deploy and operate nginx config files with this file mode
default['nginx_repo']['mode'] = '0755'

#<> Serve files in this root directory
default['nginx_repo']['servers']['repo']['root_dir'] = '/repo'
#<> Serve files via IPv4 on this port
default['nginx_repo']['servers']['repo']['listen_port_ipv4'] = '80'
#<> Serve files via IPv6 on this port
default['nginx_repo']['servers']['repo']['listen_port_ipv6'] = '[::]:80'
#<> Serve as this hostname
default['nginx_repo']['servers']['repo']['server_name'] = 'server-centos-8.vagrantup.com'
#<> Include these config files
default['nginx_repo']['servers']['repo']['include_config_files'] = '/etc/nginx/default.d/*.conf'
#<> Root file directory location on local filesystem
default['nginx_repo']['servers']['repo']['locations']['repo']['location'] = '/'
#<> Index files within each directory?
default['nginx_repo']['servers']['repo']['locations']['repo']['location_options'] = [ 'autoindex on;' ]
#<> Handling of 4xx errors
default['nginx_repo']['servers']['repo']['error_pages']['4xx']['result_code'] = '404 /404.html'
#<> Location of 40x.html file
default['nginx_repo']['servers']['repo']['error_pages']['4xx']['location'] = '/40x.html'
#<> Handling of 5xx errors
default['nginx_repo']['servers']['repo']['error_pages']['4xx']['result_code'] = '500 502 503 504 /50x.html'
#<> Location of 50x.html file
default['nginx_repo']['servers']['repo']['error_pages']['4xx']['location'] = '/50x.html'

#<> Number of worker processes
default['nginx_repo']['worker_processes'] = 'auto'
#<> Log for errors
default['nginx_repo']['error_log'] = '/var/log/nginx/error.log'
#<> PID file
default['nginx_repo']['pid_file'] = '/run/nginx.pid'
#<> Number of connections per worker
default['nginx_repo']['worker_connections'] = 1024
#<> Log file for recording access requests
default['nginx_repo']['access_log'] = '/var/log/nginx/access.log'
#<> Send files without copying to nginx buffer first?
default['nginx_repo']['sendfile'] = 'on'
#<> Sendfile related optimization: Send HTTP response headers immediately after the file's data has been obtained by sendfile()
default['nginx_repo']['tcp_nopush'] = 'on'
#<> Disable Nagle's algorithm, an optimization from the past for small packets.
default['nginx_repo']['tcp_nodelay'] = 'on'
#<> Keep connections on the server side open for this many seconds
default['nginx_repo']['keepalive_timeout'] = 65
#<> Set the maximum size of types hash tables.
default['nginx_repo']['types_hash_max_size'] = 2048
