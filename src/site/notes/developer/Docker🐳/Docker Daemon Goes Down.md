---
{"dg-publish":true,"permalink":"/developer/Docker🐳/Docker Daemon Goes Down/","tags":["docker","docker-compose"],"created":"2024-04-28T22:04:35.768-05:00","updated":"2024-04-30T21:29:20.000-05:00"}
---

> Job for docker.service failed because the control process exited with error code. See "systemctl status docker.service" and "journalctl -xe" for details.

I removed the file `/etc/docker/daemon.json` and started it with sudo systemctl start docker and it worked!!
## Credits
- [Failed to start Docker Application Container Engine - Stack Overflow](https://stackoverflow.com/questions/49110092/failed-to-start-docker-application-container-engine)