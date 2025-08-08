---
{"dg-publish":true,"permalink":"/developer/docker/reset-password-on-duplicati-container/","tags":["docker","docker-compose","backup","container"],"created":"2025-05-01T13:11:27.336-05:00","updated":"2025-04-29T14:16:50.000-05:00"}
---

## Password lockout after upgrade
when upgrading Duplicati, the UI is now locked behind a password. Using the official container `image: duplicati/duplicati:latest` I used this in my `compose.yml` file.

```yml
services:
    image: duplicati/duplicati:latest
    environment:
      SETTINGS_ENCRYPTION_KEY: "supersecretkey"
      DUPLICATI__WEBSERVICE_PASSWORD: "NEWPASSWORD"
      CLI_ARGS: "--webservice-password=NEWPASSWORD"
```

After spinning down and up the container, I the login page would not accept my new password

> [!note] Using either env as well as a combination of `DUPLICATI__WEBSERVICE_PASSWORD` and `CLI_ARGS` did not do the trick.

## Using LinuxServerIO Container
While I'd rather stay on the official container hosted by Docker Hub, I opted for the linuxserver container because the `CLI_ARGS: "--webservice-password=NEWPASSWORD"` actually set a new password.

## Moving back to Official container
You can temporarly use the linuxserverio container to make this password switch and go back to using the OG container, but there is one extra step

> [!warning] LinuxServerIO saves database in seperate location `config/Duplicati-server.sqlite`

I noticed the database `Duplicati-server.sqlite` is stored in a different place between offical and LSIO. with a little bit of copy and paste I was able to migrate the database with new password and configs

```shell
## copy old official container db to LSIO location
sudo cp data/Duplicati/Duplicati-server.sqlite config/

## -- spin up LSIO container and test new password. 
## if new password works spin down container and switch to official image

## overwrite old db with updated password db
sudo cp config/Duplicati-server.sqlite data/Duplicati/Duplicati-server.sqlite 
```

## Fresh install
I did attempt a fresh install of the official image and was prompted via container logs the password reset link IF I didn't set `DUPLICATI__WEBSERVICE_PASSWORD`. This link did not show if the database already existed.

## Questions
Is there a way to run `duplicati-server` if i `docker exec -it duplicati-app /bin/bash`, example: 

```shell
root@3320390eecec:/# duplicati-server --webservice-password=NEWPASSWORD
```

---

## Cred
- https://docs.duplicati.com/detailed-descriptions/duplicati-access-password#change-password-from-the-server
- https://docs.linuxserver.io/images/docker-duplicati/
- https://github.com/duplicati/duplicati/issues/6189
- https://forum.duplicati.com/t/not-able-to-log-into-webgui-after-changing-password/13962
- https://github.com/duplicati/duplicati/issues/6108
- https://forum.duplicati.com/t/forgot-password/20551