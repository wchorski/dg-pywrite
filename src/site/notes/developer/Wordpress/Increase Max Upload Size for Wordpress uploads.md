---
{"dg-publish":true,"permalink":"/developer/wordpress/increase-max-upload-size-for-wordpress-uploads/","tags":["Wordpress","data","upload","limit","config","docker"],"noteIcon":"","created":"2026-05-11T22:20:33.000-05:00","updated":"2026-05-11T22:20:33.000-05:00","dg-note-properties":{"tags":["Wordpress","data","upload","limit","config","docker"]}}
---

> [!note] Docker Container
> This document explains some docker knowledge (like exec into a container's shell). You can ignore these if you deploy to bare metal

```shell
docker exec -it wp-williamusic-wordpress /bin/bash

# root@b082e6c9c8f4:/var/www/html
php -i | grep upload_max_filesize
upload_max_filesize => 2M => 2M
```

```shell
nano ./php/uploads.ini
```

```ini
upload_max_filesize = 512M
post_max_size = 512M
memory_limit = 512M
max_execution_time = 300
max_input_time = 300
```

```shell
nano compose.yml
```

```yml
services:
  wordpress:
    volumes:
      - ./php/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
```

```shell
docker compose down
docker compose up -d
```

> [!tip] Rebuild or Pull new Image
> If the config isn't taking, you may need to rebuild the image or just pull for latest update.

```shell
# root@b082e6c9c8f4:/var/www/html - docker wp container
php -i | grep upload_max_filesize
upload_max_filesize => 512M => 512M
```


---
## Credit
- https://stackoverflow.com/questions/42983276/wordpress-docker-wont-increase-upload-limit#54013100