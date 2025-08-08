---
{"dg-publish":true,"permalink":"/developer/home-lab/sftp-server/","created":"2025-04-09T22:16:16.075-05:00","updated":"2025-05-14T10:56:38.000-05:00"}
---

## Exiting groups or users
```shell
❯ getent group sftp-users  
sftp-users:x:1001:william_sftp,gary_sftp
```

1. `sftp` is the group
2. `william_sftp,gary_sftp` are the members separated by commas

SFTP-only users often have restricted shells. You can check users with their assigned shells:

```shell
❯ grep -v "/bin/false\|/usr/sbin/nologin" /etc/passwd | grep "sftp"
william_sftp:x:1001:1002::/home/william_sftp:/bin/sh
```

This looks for users that might have "sftp" in their username or configuration but don't have the standard restricted shells.

## Create
```shell
sudo apt update
sudo apt upgrade
sudo apt install openssh-server
sudo nano /etc/ssh/sshd_config
```

```txt
## find and replace
Subsystem sftp internal-sftp
...
# SFTP configuration
Match Group sftp-users
    ChrootDirectory /mnt/STORAGE/sftp/%u
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
```

```
sudo systemctl restart sshd
sudo systemctl restart ssh
```

This configuration:

- Applies to users in the "sftp-users" group
- Restricts them to their own directory under `/mnt/STORAGE/sftp/[username]`
- Forces them to use SFTP only (no SSH shell access)
- Disables TCP forwarding and X11 forwarding for security
### Step 4: Create the SFTP user group
```shell
sudo groupadd sftp-users
```
### Step 5: Create the SFTP base directory
```shell
sudo mkdir -p /mnt/STORAGE/sftp
sudo chmod 701 /mnt/STORAGE/sftp
```

### Step 6: Create a user and set up their directory

```shell
# Create the user (or use an existing one)
sudo useradd -m sftpuser1
sudo passwd sftpuser1

# Add the user to the sftp-users group
sudo usermod -aG sftp-users sftpuser1

# Create and configure their SFTP directory
sudo mkdir -p /sftp/sftpuser1
sudo mkdir -p /sftp/sftpuser1/upload

# Set ownership
sudo chown root:root /sftp/sftpuser1
sudo chown sftpuser1:sftpuser1 /sftp/sftpuser1/upload

# I don't see the need to nest another `uploads` folder and just give permission to the user's username folder
sudo chown root:root /sftp
sudo chown sftpuser1:sftpuser1 /sftp/sftpuser1

# Set permissions
sudo chmod 755 /sftp/sftpuser1
sudo chmod 700 /sftp/sftpuser1/upload
```