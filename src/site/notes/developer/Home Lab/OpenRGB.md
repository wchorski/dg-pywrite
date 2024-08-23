---
{"dg-publish":true,"permalink":"/developer/Home Lab/OpenRGB/","created":"2024-03-13T20:41:46.395-05:00","updated":"2024-03-14T21:56:30.000-05:00"}
---

## Install

I run Mint 21 Venessa (aka Ubuntu Jammy). So installing **OpenRGB** wasn't as strait forward as `sudo apt install openrgb`

[How To Install OpenRGB On Ubuntu 22.04 | 20.04 LTS | Itsubuntu.com](https://itsubuntu.com/install-openrgb-on-ubuntu-22-04-20-04-lts/)

```shell

sudo add-apt-repository ppa:thopiekar/openrgb

sudo apt update -y

sudo apt install openrgb -y

openrgb --version

sudo apt autoremove openrgb --purge
sudo add-apt-repository --remove ppa:thopiekar/openrgb
```

## Backlinks
- [[developer/Home Lab/Home Lab 🏠\|Home Lab 🏠]]