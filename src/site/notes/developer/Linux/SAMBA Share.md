---
{"dg-publish":true,"permalink":"/developer/Linux/SAMBA Share/"}
---

[link](https://pimylifeup.com/raspberry-pi-samba/#:~:text=Connect to Raspberry Pi Samba Server Mac 1,enter both the username and password... See More.)

```shell
sudo apt-get update 
sudo apt-get upgrade
```

```shell
sudo apt-get install samba samba-common-bin
```

`mkdir /home/pi/shared`

```shell
sudo nano /etc/samba/smb.conf
```

`smb.conf`
```
[SHARE]
path = /mnt/HDDVOLUME
writeable=Yes
create mask=0777
directory mask=0777
public=no
```

`sudo smbpasswd -a pi`


## make file share for single user
```shell
sudo addgroup smbgrp
sudo useradd smbuser -G newsmbgrp
smbpasswd -a smbuser

sudo mkdir -p /samba/smbuser
sudo chmod -R 0770 /samba/smbuser
sudo chown root:smbgrp /samba/smbuser
```

`sudo systemctl restart smbd`

---
## Credits 
- 

## Backlinks
- [[developer/Linux/Linux\|Linux]]