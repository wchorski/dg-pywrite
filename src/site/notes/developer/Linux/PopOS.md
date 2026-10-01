---
{"dg-publish":true,"permalink":"/developer/linux/pop-os/","tags":["linux"],"noteIcon":"","created":"2025-04-09T11:41:47.000-05:00","updated":"2025-04-09T11:41:47.000-05:00","dg-note-properties":{"tags":["linux"]}}
---

## Sluggish UI and or App Loading
```shell
system76-power graphics nvidia
```

## Wake On LAN
`sudo nano /etc/systemd/system/wol.service`

```shell
[Unit]  
Description=Configure Wake On LAN

[Service]  
Type=oneshot  
ExecStart=/sbin/ethtool -s INTERFACE wol g

[Install]  
WantedBy=basic.target
```

```shell
sudo systemctl daemon-reload  
sudo systemctl enable wol.service  
sudo systemctl start wol.service
```

---
## Credits
- [Wake-on-LAN (WoL) doesn't work · Issue #866 · pop-os/pop (github.com)](https://github.com/pop-os/pop/issues/866)
- [Pop OS 22.04 - extremely slow, laggy and unresponsive, what happened? : r/pop_os (reddit.com)](https://www.reddit.com/r/pop_os/comments/v1th8w/pop_os_2204_extremely_slow_laggy_and_unresponsive/)