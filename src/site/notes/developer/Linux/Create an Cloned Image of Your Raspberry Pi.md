---
{"dg-publish":true,"permalink":"/developer/Linux/Create an Cloned Image of Your Raspberry Pi/","tags":["linux","hardware"],"created":"2024-03-05T22:12:54.643-06:00","updated":"2025-01-21T22:58:11.122-06:00"}
---

## External Drive
You'll want an external thumb drive or [[developer/Linux/NAS\|NAS]] by [[developer/Linux/Mount a Drive in Linux Terminal\|Mounting a Drive]] that has twice or more storage than your Raspberry Pi's **SD Card** capacity

Here I've mounted the **Network Mount** to `network_mount` inside my user folder so I don't have to deal with funky permissions
```bash
sudo dd if=/dev/mmcblk0 of=/home/USERNAME/network_mount/pibackup/pi4-24_March_05.img bs=1M
```
## Shrink and Zip

Grab this easy to use library

```bash
wget https://raw.githubusercontent.com/Drewsif/PiShrink/master/pishrink.sh
sudo chmod +x pishrink.sh
sudo mv pishrink.sh /usr/local/bin
```

```bash
cd /home/USERNAME/network_mount/pibackup
sudo pishrink.sh -z pi4-24_March_05.img
```

---
## Credit
- [How to Back Up Your Raspberry Pi as a Disk Image | Tom's Hardware (tomshardware.com)](https://www.tomshardware.com/how-to/back-up-raspberry-pi-as-disk-image)