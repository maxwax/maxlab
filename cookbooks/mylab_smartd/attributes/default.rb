# mylab_smartd attributes

#
# To configure custom monitoring for sepcific devices, copy the default
# lines below for DEVICESCAN, paste them above the DEVICESCAN lines and
# specify specific devices such as '/dev/sda' instead of DEVICESCAN
#

# <> Send health reports to this list of email addresses. Ex: example@example.com,user@company.com
force_override['smartd']['cfg']['devices']['DEVICESCAN']['target_email'] = "maxops@maxwellspangler.com"

# COMMENTED OUT to demonstrate that some or all attributes found in the community cookbook maxcomm_smartd can be overridden here.

# # <> Configure standard health check parameter -H ?
# node.force_override['smartd']['cfg']['devices']['DEVICESCAN']['standard_health_check'] = true
#
# # <> Configure smartd to send a test email each time it is restarted ?
# node.force_override['smartd']['cfg']['devices']['DEVICESCAN']['startup_email_test'] = true
#
# # <> Set the default smartmontools notification script for each OS
# case node['platform_family']
#   when 'rhel'
#     node.force_override['smartd']['cfg']['devices']['DEVICESCAN']['notify_script'] = "/usr/libexec/smartmontools/smartdnotify"
#   when 'debian'
#     node.force_override['smartd']['cfg']['devices']['DEVICESCAN']['notify_script'] = "/usr/libexec/smartmontools/smartdnotify"
# end
#
# # <> Append these misc smartd directives to this device or a 'DEVICESCAN' entry
# node.force_override['smartd']['cfg']['devices']['DEVICESCAN']['misc_options'] = [
#     "-n standby,10,q"
# ]
