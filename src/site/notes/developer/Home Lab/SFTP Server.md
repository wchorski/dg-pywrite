---
{"dg-publish":true,"permalink":"/developer/home-lab/sftp-server/","noteIcon":"","created":"2026-10-02T11:53:16.000-05:00","updated":"2026-10-02T11:53:16.000-05:00","dg-note-properties":{}}
---

## Check for Exiting groups or users
```shell
getent group sftp_group  
sftp_group:x:1001:william_sftp,gary_sftp
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
Match Group sftp_group
    ChrootDirectory /mnt/STORAGE/sftp/%u
    ForceCommand internal-sftp -d /upload
    AllowTcpForwarding no
    X11Forwarding no
```

```sh
sudo systemctl restart ssh
# or 
sudo systemctl restart sshd
```

This configuration:

- Applies to users in the `sftp_group` group
- Restricts them to their own directory under `/mnt/STORAGE/sftp/[username]`
- Forces them to use SFTP only (no SSH shell access)
- Disables TCP forwarding and X11 forwarding for security
### Step 4: Create the SFTP user group
```shell
sudo groupadd sftp_group
```
### Step 5: Create the SFTP base directory
```shell
sudo mkdir -p /mnt/STORAGE/sftp
sudo chmod 701 /mnt/STORAGE/sftp
```

### Step 6: Create a user and set up their directory

```shell
# Create the user (or use an existing one)
sudo useradd -m USER_SFTP_NAME
sudo passwd USER_SFTP_NAME

# Add the user to the sftp_group group
sudo usermod -aG sftp_group USER_SFTP_NAME

# Create and configure their SFTP directory
sudo mkdir -p /mnt/STORAGE/sftp/USER_SFTP_NAME
sudo mkdir -p /mnt/STORAGE/sftp/USER_SFTP_NAME/upload

# Set ownership
sudo chown root:root /mnt/STORAGE/sftp/USER_SFTP_NAME
sudo chown USER_SFTP_NAME:USER_SFTP_NAME /mnt/STORAGE/sftp/USER_SFTP_NAME/upload

# Set permissions
sudo chmod 755 /mnt/STORAGE/sftp/USER_SFTP_NAME
sudo chmod 700 /mnt/STORAGE/sftp/USER_SFTP_NAME/upload
```

## Test
```sh
getent group sftp_group
# output
sftp_group:x:1001:USER_SFTP_NAME

sudo sshd -t
# no output is good
sudo systemctl restart ssh
```

on remote client

```sh
sftp USER_SFTP_NAME@SERVER.IP
```