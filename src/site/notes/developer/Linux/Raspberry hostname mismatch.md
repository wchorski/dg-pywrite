---
{"dg-publish":true,"permalink":"/developer/Linux/Raspberry hostname mismatch/","tags":["linux","network","DNS"],"created":"2025-01-08T10:52:57.000-06:00","updated":"2025-01-08T10:52:57.000-06:00"}
---


```shell
cat /etc/hostname
cat /etc/hosts
```

Look for any differences. In my case the last line in `/etc/hosts` was `127.0.1.1       mypc-name` and I needed to change it to match the output from `/etc/hostname`

---
## Credit
- https://forums.raspberrypi.com/viewtopic.php?t=276036