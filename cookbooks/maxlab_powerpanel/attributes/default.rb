# maxlab_powerpanel/attributes/default.rb

# URL that provides the rpm
default['powerpanel']['url'] = 'https://dl4jz3rbrsfum.cloudfront.net/software'

# Filename to download and install
default['powerpanel']['filename'] = 'PPL_64bit_v1.4.1.rpm'

# Version we should install
default['powerpanel']['version'] = '1.4.1'

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].to_i.to_s

default['powerpanel']['packages'] = case platform_and_version
                                    when 'redhat7', 'centos7'
                                      [ 'powerpanel' ]
                                    when 'redhat8', 'centos8'
                                      [ 'powerpanel' ]
                                    end

#  Services required to be running for NFS server operations
default['powerpanel']['services'] = [ 'pwrstatd' ]

# These attributes are used to deploy the pwrstatd.conf configuration file
# See the powerpanel documentation and pwrstatd.conf config file for more info
default['powerpanel']['config']['powerfail_delay']        = 60
default['powerpanel']['config']['powerfail_active']       = 'yes'
default['powerpanel']['config']['powerfail_cmd_path']     = '/etc/pwrstatd-powerfail.sh'

default['powerpanel']['config']['powerfail_duration']     = 0
default['powerpanel']['config']['powerfail_shutdown']     = 'yes'
default['powerpanel']['config']['lowbatt_threshold']      = 35
default['powerpanel']['config']['runtime_threshold']      = 300
default['powerpanel']['config']['lowbatt_active']         = 'yes'
default['powerpanel']['config']['lowbatt_cmd_path']       = '/etc/pwrstatd-lowbatt.sh'
default['powerpanel']['config']['lowbatt_duration']       = 0
default['powerpanel']['config']['lowbatt_shutdown']       = 'yes'
default['powerpanel']['config']['enable_alarm']           = 'yes'
default['powerpanel']['config']['shutdown_sustain']       = 600
default['powerpanel']['config']['turn_ups_off']           = 'yes'
default['powerpanel']['config']['ups_polling_rate']       = 3
default['powerpanel']['config']['ups_retry_rate']         = 10
default['powerpanel']['config']['prohibit_client_access'] = 'no'
default['powerpanel']['config']['allowed_device_nodes']   = ''
default['powerpanel']['config']['hibernate']              = 'no'
default['powerpanel']['config']['cloud_active']           = 'no'
default['powerpanel']['config']['cloud_account']          = ''

default['powerpanel']['config']['enable_logger']          = true
default['powerpanel']['config']['log_month']              = '*'
default['powerpanel']['config']['log_day']                = '*'
default['powerpanel']['config']['log_hour']               = '12'
default['powerpanel']['config']['log_minute']             = '0'
