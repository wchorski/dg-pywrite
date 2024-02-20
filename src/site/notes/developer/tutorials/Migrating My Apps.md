---
{"dg-publish":true,"permalink":"/developer/tutorials/Migrating My Apps/","noteIcon":""}
---

I've been having problems with my [[developer/Hardware/Pi4\|developer/Hardware/Pi4]] freezing up because of the [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] install. There are all sorts of reasons why [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] would lock up the Pi. Resulting in my **DNS and DHCP** server via [[developer/Home Lab 🏠/Pi-hole\|developer/Home Lab 🏠/Pi-hole]] and VPN via [[developer/Home Lab 🏠/PiVPN\|developer/Home Lab 🏠/PiVPN]]  to go down (not good). 

> [[home-assistant.io)](https://www.home-assistant.io/installation/linux\|!warning]]
> This way of running Home Assistant will require the most of you. It also has strict requirements you need to follow.
> 
> Unless you really need this installation type, you should install Home Assistant OS (this can also be a [[https://www.home-assistant.io/installation/linux#install-home-assistant-operating-system\|https://www.home-assistant.io/installation/linux#install-home-assistant-operating-system]]), or [[https://www.home-assistant.io/installation/linux#install-home-assistant-container\|https://www.home-assistant.io/installation/linux#install-home-assistant-container]].

As you can see from the warning, It was dead on. Honestly, the struggles of keeping [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] updated has really exercised my Linux knowledge but my [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] has grown and requires more and I'm getting tired of fighting the errors. Plus, not loosing **DNS and DHCP** from [[developer/Home Lab 🏠/Pi-hole\|developer/Home Lab 🏠/Pi-hole]] and remote access via [[developer/Home Lab 🏠/PiVPN\|developer/Home Lab 🏠/PiVPN]] when [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]] acts up will be a nice weight off my shoulders. 

It's time to move to Home Assistant Operating System aka Hass.os

## Backup apps and OS
currently my [[developer/Hardware/Pi4\|developer/Hardware/Pi4]] runs
- [[developer/Home Lab 🏠/Pi-hole\|developer/Home Lab 🏠/Pi-hole]]
- [[developer/Home Lab 🏠/PiVPN\|developer/Home Lab 🏠/PiVPN]]
- [[developer/Home Lab 🏠/Hyperion\|developer/Home Lab 🏠/Hyperion]]
- [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]]
- [[developer/Home Lab 🏠/Glances\|developer/Home Lab 🏠/Glances]]
- [[developer/Home Lab 🏠/DuckDNS\|developer/Home Lab 🏠/DuckDNS]]
- probably forgetting something else...

#todo 
- [x] pi-hole config
- [x] pivn config
- [x] hyperion config
- [x] home assistant config
- [x] duckdns config?
- [x] system img backup

## Restore configs
### pi-hole
- through app's GUI "Teleporter"

### PiVPN
On Linux, copy the config from the Raspberry Pi to a target directory on your local machine:
`sudo cp backupconfigs/whatever.conf ~/configs/whatever.conf`

### Hyperion
- through app's GUI "General Settings > Import/Export Configuration"

### Home Assistant
- through app's GUI "Backups > Restore"

## New Pi4 2gb
#todo
- [x] burn clean Raspberry OS Lite 64bit 
- [x] install pi-hole & config
- [x] install pivpn & config
- [x] install glances 
- [x] install duckdns
- [x] install Hyperion