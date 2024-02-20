---
{"dg-publish":true,"permalink":"/developer/Linux/Debian Linux, Unable to Locate Package/","noteIcon":""}
---

## fix sources.list

```shell
sudo nano /etc/apt/sources.list
```

paste this in the file (change `bullseye` to your current version)
```shell
deb  http://deb.debian.org/debian  bullseye main
deb-src  http://deb.debian.org/debian  bullseye main
```

save and close

```shell
sudo apt update
```


---
## Credits
- [[tecmint.com)](https://www.tecmint.com/fix-unable-to-locate-package-error-in-debian-9/\|How to Fix “E: unable to locate package” Error in Debian 9 (tecmint.com)]]

## Backlinks
- [[developer/Linux/Linux\|developer/Linux/Linux]]