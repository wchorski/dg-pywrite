---
{"dg-publish":true,"tags":["linux","debian","terminal"],"permalink":"/developer/linux/rotate-terminal-orientation-on-headless-no-gui-desktop-server/","dgPassFrontmatter":true}
---

I have a headless Debian server that I recently ran a monitor. I prefer to have the monitor rotate 90 degrees so it is in a portrait view. This makes for easier reading of many short lines with more vertical space. Here's how to do it.

Rotation values:
- `0` = normal
- `1` = 90° clockwise
- `2` = upside down
- `3` = 90° counterclockwise

```shell
## test. this should instantly rotate the image
echo 3 | sudo tee /sys/class/graphics/fbcon/rotate

## make it persistant
sudo nano /etc/default/grub
```

```conf
GRUB_CMDLINE_LINUX="fbcon=rotate:3"
```

```shell
sudo update-grub
sudo reboot
```

You'll still see the normal horizontal rotation until you get to the login screen