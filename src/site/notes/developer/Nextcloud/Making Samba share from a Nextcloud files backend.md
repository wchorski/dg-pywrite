---
{"dg-publish":true,"permalink":"/developer/nextcloud/making-samba-share-from-a-nextcloud-files-backend/","tags":["nextcloud","smb","network","data"],"created":"2025-08-07T09:41:32.017-05:00","updated":"2025-08-07T09:56:56.337-05:00"}
---

it's dangerous work messing with [[developer/Home Lab/Nextcloud\|Nextcloud]]'s files outside of it's client. (i.e, through a file explorer or terminal). Here I'll show you how to do it the safe way.
## The Goal
My goal is to get **Server A's** (which hosts Nextcloud and photos) [[developer/Linux/SAMBA Share\|SAMBA Share]] mounted onto **Server B** which hosts my [[developer/Home Lab/LibrePhotos\|LibrePhotos]] app. **Server B** is dedicated to all things serving media (It's the machine with a decent GPU)
## Permissions
Setting up Nextcloud's AIO docker container, this makes all files owned by the `www-data` user and group. So I need to create a samba credentials to match
### **Server A**
```shell
sudo smbpasswd -a www-data
## enter and remember password
sudo smbpasswd -e www-data
```

`sudo nano /etc/samba.conf`
```conf
[photos_share]  
path=/mnt/storage/nextcloud-aio/data/myuser/files/pictures  
writeable=yes  
create mask=0755  
directory mask=0755  
public=no  
valid users = www-data
```

```shell
sudo systemctl restart smbd
```
### **Server B**
```shell
sudo nano /root/.smbcreds_www-data
```

```.creds
user=www-data
password=**********
```

`sudo nano /etc/fstab`
```txt
//SERVER_A/photos_myuser /mnt/nextcloud_photos/photos_share cifs credentials=/root/.smbcreds_www-data  0 0
```

```shell
sudo systemctl daemon-reload
sudo mount -av
ls /mnt/nextcloud_photos/photos_share
## you should see server A's files listed here on Server B
```

---
## Credit
- https://www.claudiokuenzler.com/blog/1160/unable-mount-cifs-share-error-permission-denied-failed-return-code-13
- https://www.baeldung.com/linux/smb-samba-mount-options