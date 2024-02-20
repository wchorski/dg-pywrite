---
{"dg-publish":true,"permalink":"/developer/Home Assistant/Send SSH commands via script/","noteIcon":""}
---

#homeassistant #linux 

1. in HA terminal `ssh-keygen`
2. `cp /root/.ssh /config/ssh`
3. include this in beginning of `shell_command` -> `ssh -i /config/ssh/id_rsa -o 'StrictHostKeyChecking=no' username@remote_IP 'touch newfile.txt'`

---
## Credits
- [[https://siytek.com/home-assistant-shell/#:~:text=When executing shell commands in Home Assistant%2C the,integration comes when you combine it with SSH.\|https://siytek.com/home-assistant-shell/#:~:text=When executing shell commands in Home Assistant%2C the,integration comes when you combine it with SSH.]]

## Backlinks
- [[developer/Home Lab 🏠/Home Assistant\|developer/Home Lab 🏠/Home Assistant]]