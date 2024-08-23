---
{"dg-publish":true,"permalink":"/developer/Linux/SAMBA Share/","created":"2024-02-29T22:19:56.071-06:00","updated":"2024-03-05T22:57:56.260-06:00"}
---


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

```bash
sudo systemctl restart smbd
```

---
## Credits 
- [How to Setup a Raspberry Pi Samba Server - Pi My Life Up](https://pimylifeup.com/raspberry-pi-samba/#:~:text=Connect)
## Backlinks
- [[developer/Linux/Linux\|Linux]]