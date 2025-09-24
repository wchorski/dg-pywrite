---
{"dg-publish":true,"permalink":"/developer/emulation/switch-homebrew/","dgPassFrontmatter":true}
---

[Getting Started - NH Switch Guide (hacks.guide)](https://switch.hacks.guide/)

## updating
- hacker's [guide](https://switch.hacks.guide/extras/updating)
- check nintendo's latest version number - [site](https://en-americas-support.nintendo.com/app/answers/detail/a_id/22525/~/nintendo-switch-system-update-information#current)
- see if atmosphere supports [latest version](https://github.com/Atmosphere-NX/Atmosphere/releases)
### Errors
https://switch.hacks.guide/extras/updating#missioncontrol-crash
![attachments/missioncontrolcrash1.Chg5lu43-1.jpg](/img/user/attachments/missioncontrolcrash1.Chg5lu43-1.jpg)

> This happens due to your current version of [MissionControl](https://switch.hacks.guide/homebrew/mission-control.html) not being compatible with your currently installed Atmosphère version. If there is a newer version of MissionControl available for your currently installed Atmosphère version, you should update to that newer version if you wish to keep using MissionControl. If not, you can fix this crash by navigating to `sd:/atmosphere/contents` and deleting the folder named `010000000000bd00`, which will uninstall MissionControl.