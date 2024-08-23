---
{"dg-publish":true,"permalink":"/developer/Linux/Debian Linux, Unable to Locate Package/","created":"2024-02-29T22:19:56.054-06:00","updated":"2024-03-01T00:19:21.000-06:00"}
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
- [How to Fix “E: unable to locate package” Error in Debian 9 (tecmint.com)](https://www.tecmint.com/fix-unable-to-locate-package-error-in-debian-9/)

## Backlinks
- [[developer/Linux/Linux\|Linux]]