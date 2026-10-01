---
{"dg-publish":true,"permalink":"/developer/linux/raspberry-hostname-mismatch/","tags":["linux","network","DNS"],"noteIcon":"","created":"2025-04-09T11:32:53.000-05:00","updated":"2025-04-09T11:32:53.000-05:00","dg-note-properties":{"tags":["linux","network","DNS"]}}
---


```shell
cat /etc/hostname
cat /etc/hosts
```

Look for any differences. In my case the last line in `/etc/hosts` was `127.0.1.1       mypc-name` and I needed to change it to match the output from `/etc/hostname`

---
## Credit
- https://forums.raspberrypi.com/viewtopic.php?t=276036