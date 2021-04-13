#
# Cookbook:: maxlab_smartd
# Recipe:: deploy
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Install smartmontools to monitor S.M.A.R.T. storage health attributes and configure smartd for monitoring.
#>
=end

# Ex: 'rhel8', 'centos7', 'fedora30'
platform_and_version = node['platform'] + node['platform_version'].split('.')[0]

case platform_and_version
  when 'redhat7', 'centos7'
    smart_pkg = 'smartmontools'
  when 'redhat8', 'centos8'
    smart_pkg = 'smartmontools'
  when 'debian10'
    smart_pkg = 'smartmontools'
end

# CENTOS OR DEBIAN
package smart_pkg do
  action :install
end

# Hold an array of constructed smartd config lines here:
smartd_config_lines = []

# Hold a single constructed smartd config line for a DEVICESCAN directive here:
devicescan_config_line = ""

# Using attibutes, for each defined device, build a branch in the smartd_config
# hash tree containing a construced smartd configuration directive.
# Ex: '/dev/sda -a -M test -m example@example.com'
# Warning: a 'DEVICESCAN' line should be last in the config file so there
# is some special handling below to ensure this happens.
node['smartd']['cfg']['devices'].each do |smart_device, smart_device_opts|

  config_line = "#{smart_device}"

  if smart_device_opts['target_email'] != ""
    config_line = config_line + " -m #{smart_device_opts['target_email']}"
  end

  if smart_device_opts['standard_health_check'] == true
    config_line = config_line + " -a"
  end

  if smart_device_opts['startup_email_test'] == true
    config_line = config_line + " -M test"
  end

  config_line = config_line + " -M exec #{smart_device_opts['notify_script']}"

  smart_device_opts['misc_options'].each do |opt_text|
    config_line = config_line + " #{opt_text}"
  end

  # Append this line to an array of config lines
  # BUT, if this is the DEVICESCAN line, it must go last, so set it aside.
  if smart_device != "DEVICESCAN"
    smartd_config_lines << config_line
  else
    devicescan_config_line = config_line
  end

end

# If we encountered one (more more) DEVICESCAN lines,
# append it now so it will be the last line in the array & last in config file
if devicescan_config_line != nil
  smartd_config_lines << devicescan_config_line
end

template '/etc/smartmontools/smartd.conf' do
  source "smartd.conf.erb"

  owner "root"
  group "root"
  mode "0744"

  variables (
    {
      smartd_config_lines: smartd_config_lines
    }
  )

  action :create
end

service "smartd" do
  action [:enable, :start]
end

tag('smartd')
