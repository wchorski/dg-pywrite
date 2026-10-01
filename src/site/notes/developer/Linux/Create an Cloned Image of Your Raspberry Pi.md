---
{"dg-publish":true,"permalink":"/developer/linux/create-an-cloned-image-of-your-raspberry-pi/","tags":["linux","hardware"],"noteIcon":"","created":"2025-04-09T11:28:41.000-05:00","updated":"2025-04-09T11:28:41.000-05:00","dg-note-properties":{"tags":["linux","hardware"]}}
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