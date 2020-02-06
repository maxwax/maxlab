# Description

This cookbook deploys smartmontools including the smartd daemon.

It configures and enables smartd to monitor storage devices' S.M.A.R.T. health attributes and alert on failure indicating values.

This cookbook simulates a community cookbook and in my lab I use the 'mylab_smartd' wrapper cookbook to customize it for my home lab, 'maxlab'.

# Requirements


## Chef Client:

* chef (>= 14.0) ()

## Platform:

* redhat (>= 7.0)
* centos (>= 7.0)

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['smartd']['cfg']['devices']['DEVICESCAN']['target_email']` - Send health reports to this list of email addresses. Defaults to `example@example.com`.
* `node['smartd']['cfg']['devices']['DEVICESCAN']['standard_health_check']` - Configure standard health check parameter -H ?. Defaults to `true`.
* `node['smartd']['cfg']['devices']['DEVICESCAN']['startup_email_test']` - Configure smartd to send a test email each time it is restarted ?. Defaults to `true`.
* `node['smartd']['cfg']['devices']['DEVICESCAN']['notify_script']` -  Defaults to `/usr/libexec/smartmontools/smartdnotify`.
* `node['smartd']['cfg']['devices']['DEVICESCAN']['misc_options']` - Append these misc smartd directives to this device or a 'DEVICESCAN' entry. Defaults to `[ ... ]`.

# Recipes

* [maxlab_smartd::default](#maxlab_smartddefault) - This recipe performs no actions.
* [maxlab_smartd::deploy](#maxlab_smartddeploy) - Install smartmontools to monitor S.M.A.R.T.

## maxlab_smartd::default

This recipe performs no actions.

## maxlab_smartd::deploy

Install smartmontools to monitor S.M.A.R.T. storage health attributes and configure smartd for monitoring.

Maxwell Spangler maxcode@maxwellspangler.com
