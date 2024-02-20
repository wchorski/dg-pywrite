---
{"dg-publish":true,"permalink":"/developer/home-lab/glances/","noteIcon":""}
---


> [[nicolargo.github.io)](https://nicolargo.github.io/glances/\|!info]]
> Glances is a cross-platform system monitoring tool written in Python.

### connections
- [[developer/[Home Assistant](developer/Home Lab 🏠/Home Assistant.md\|Home Assistant]].md)

### installation on Linux
```shell
sudo apt-get install glances
```

## as a System Service
```shell
nano /etc/systemd/system/glancesweb.service
```

`glancesweb.service` → change `User` to your current user 
```shell
[Unit]
Description = Glances in Web Server Mode
After = network.target

[Service]
User = spearmint
ExecStart = /usr/bin/glances  -w  -t  5

[Install]
WantedBy = multi-user.target
```

```shell
[Unit]
Description = Glances in Web Server Mode
After = network.target

[Service]
User = pi4
ExecStart = /usr/local/bin/glances  -w  -t  5

[Install]
WantedBy = multi-user.target
```

enable and test 
```shell
sudo systemctl enable glancesweb.service
sudo systemctl start glancesweb.service
sudo systemctl status glancesweb.service
```

### installation on Windows
install `.exe` at [Download Python | Python.org](https://www.python.org/getit/)
run `pip install glances` & `pip install bottle`

### Home Assistant Addons Glances to Influxdb
- [InfluxDB, Grafana, Glances & IDE in Home Assistant within 15 minutes! - YouTube](https://www.youtube.com/watch?v=m9qIqq104as&t=2s)


## helpful links
[[maketecheasier.com)](https://www.maketecheasier.com/glances-monitor-system-ubuntu/\|How to Use Glances to Monitor System On Ubuntu (maketecheasier.com)]]
[[https://www.tecmint.com/glances-monitor-remote-linux-in-web-server-mode/#:~:text=Run Glances in Web Server Mode as a,start and view its status as follows. \|https://www.tecmint.com/glances-monitor-remote-linux-in-web-server-mode/#:~:text=Run Glances in Web Server Mode as a,start and view its status as follows. ]]