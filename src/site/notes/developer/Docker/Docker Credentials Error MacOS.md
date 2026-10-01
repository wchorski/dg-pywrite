---
{"dg-publish":true,"permalink":"/developer/docker/docker-credentials-error-mac-os/","tags":["MacOs","docker","error","troubleshooting"],"noteIcon":"","created":"2026-05-09T09:51:08.000-05:00","updated":"2026-05-09T09:51:08.000-05:00","dg-note-properties":{"tags":["MacOs","docker","error","troubleshooting"]}}
---

## The Error
```bash
docker compose build

## permission denied
```

```shell
sudo docker compose build

## This error happened
=> ERROR [backend internal] load metadata for docker.io/library/node:20-  0.1s
------
 > [backend internal] load metadata for docker.io/library/node:20-alpine:
------
failed to solve: node:20-alpine: failed to resolve source metadata for docker.io/library/node:20-alpine: error getting credentials - err: exit status 1, out: ``
```
## The Fix
```shell
sudo chown -R $(whoami) ~/.docker
```
---
## Credit
- [macos - open /Users/[user]/.docker/buildx/current: permission denied on macbook? - Stack Overflow](https://stackoverflow.com/questions/75686903/open-users-user-docker-buildx-current-permission-denied-on-macbook)