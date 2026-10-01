---
{"dg-publish":true,"permalink":"/developer/home-assistant/send-ssh-commands-via-script/","noteIcon":"","created":"2025-04-09T11:29:51.000-05:00","updated":"2025-04-09T11:29:51.000-05:00","dg-note-properties":{}}
---

#homeassistant #linux 

1. in HA terminal `ssh-keygen`
2. `cp /root/.ssh /config/ssh`
3. include this in beginning of `shell_command` -> `ssh -i /config/ssh/id_rsa -o 'StrictHostKeyChecking=no' username@remote_IP 'touch newfile.txt'`

---
## Credits
- [link](https://siytek.com/home-assistant-shell/#:~:text=When executing shell commands in Home Assistant%2C the,integration comes when you combine it with SSH.)

## Backlinks
- [[developer/Home Lab/Home Assistant\|Home Assistant]]