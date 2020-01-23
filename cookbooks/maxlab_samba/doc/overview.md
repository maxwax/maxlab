This cookbook deploys NFS server or client services on maxlab nodes.

Note: For security reasons, samba users (and passwords) must be created manually via

```bash
smbpasswd -a <user>
```

This could be automated, but since I'm sharing cookbooks on git, I'll keep this simple and manual for now.
