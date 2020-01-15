# mylab_smartd CHANGELOG

# 1.0.0

This is a wrapper cookbook to the maxcomm_smartd 'community' cookbook to deploy and manage smartmontools smartd daemon.

It's got a lot of commented out code that I'm leaving in so I can experiment further with attribute precedence levels.

Currently as it stands, it really loads a data bag with config values and uses force_override to set those to replace the community default level node attributes that drive smartd.conf configuration.
