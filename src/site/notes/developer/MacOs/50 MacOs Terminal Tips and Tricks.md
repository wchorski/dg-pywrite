---
{"dg-publish":true,"permalink":"/developer/MacOs/50 MacOs Terminal Tips and Tricks/","created":"2024-02-29T22:19:56.075-06:00","updated":"2024-06-04T15:45:11.000-05:00"}
---

## find password of previously connected wifi
```shell
security find-generic-password -wa "coffee-shop-wifi"
```

## keep mac awake
```
caffeinate
```

## save screenshot to clipboard
```bash
cmd ctrl shift 4 
```

## use finger print id for sudo password
```
sudo nano /etc/pam.d/sudo

# add
auth sufficient pam_tid.so
```

---
## Credits
- [the last one is CRAZY!) - YouTube](https://www.youtube.com/watch?v=qOrlYzqXPa8)
- [[developer/MacOs/index\|index]]