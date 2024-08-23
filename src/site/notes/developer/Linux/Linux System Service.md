---
{"dg-publish":true,"permalink":"/developer/Linux/Linux System Service/","tags":["linux"],"created":"2024-02-29T22:19:56.062-06:00","updated":"2024-03-01T00:20:31.000-06:00"}
---



Let’s create a file called ` /etc/systemd/system/rot13.service`
```shell
[Unit]
Description=ROT13 demo service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/bin/env php /path/to/server.php

[Install]
WantedBy=multi-user.target
```

set your actual username after `User=`
set the proper path to your script in `ExecStart=`
That’s it. We can now start the service:

```shell
systemctl start rot13
```

And automatically get it to start on boot:

```shell
systemctl enable rot13
```

---

## Credits
- [link](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6#:~:text=1 The program. Let’s create a small server,that it will always work as you )
## index
- [[developer/developer_box📦\|developer_box📦]]