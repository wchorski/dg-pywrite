---
{"dg-publish":true,"permalink":"/developer/mac-os/50-mac-os-terminal-tips-and-tricks/","noteIcon":""}
---

describe_the_problem


find password of previously connected wifi
```shell
security find-generic-password -wa "coffee-shop-wifi"
```

keep mac awake
```
caffeinate
```

cmd ctrl shift 4 - save screenshot to clipboard

use finger print id for sudo password
```
sudo nano /etc/pam.d/sudo

# add
auth sufficient pam_tid.so
```

---
## Credits
- [[the last one is CRAZY!) - YouTube](https://www.youtube.com/watch?v=qOrlYzqXPa8\|50 macOS Tips and Tricks Using Terminal (the last one is CRAZY!) - YouTube]]

## Backlinks
- 