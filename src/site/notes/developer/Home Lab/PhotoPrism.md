---
{"dg-publish":true,"permalink":"/developer/Home Lab/PhotoPrism/","dgPassFrontmatter":true}
---

#pictures #selfhosted

> [!quote] [PhotoPrism](https://photoprism.app/)
>  Browse Your Life in Pictures

An open source, self hosted solution for services like [iCloud](https://www.icloud.com/) | [Google Photos](https://photos.google.com/). don't be afraid of the `compose.yml`. You'll only need to change 
- `<username>`, 
- `<passwordForAppLogin>`, 
- `<strongpassword>`, 
- `PHOTOPRISM_SITE_URL`  -> the local IP will be fine, as I use a reverse proxy to point app outward
- `<localStorage>` -> I grab photos from Nextcloud, but you can point the volume to whatever local storage

## connections


## installation 
1. `compose.yml` via [[developer/Home Lab/Docker\|Docker]]
```yml
version: '3.5'


  photoprism:
    ## Use photoprism/photoprism:preview for testing preview builds:
    image: photoprism/photoprism:latest
    restart: unless-stopped
    depends_on:
      - mariadb
    ## Only enable automatic restarts once your installation is properly
    ## configured as it otherwise may get stuck in a restart loop,
    ## see https://docs.photoprism.org/getting-started/faq/#why-is-photoprism-getting-stuck-in-a-restart-loop
    # restart: unless-stopped
    security_opt:
      - seccomp:unconfined
      - apparmor:unconfined
    ## Run as a specific, non-root user (see https://docs.docker.com/engine/reference/run/#user):
    # user: "1000:1000"
    ports:
      - "2343:2343" # HTTP port (host:container)
    environment:
      PHOTOPRISM_ADMIN_PASSWORD: <passwordForAppLogin>          # PLEASE CHANGE: Your initial admin password (min 4 characters)
      PHOTOPRISM_SITE_URL: "http://192.168.0.100"  # Public server URL incl http:// or https:// and /path, :port is optional
      PHOTOPRISM_ORIGINALS_LIMIT: 5000               # File size limit for originals in MB (increase for high-res video)
      PHOTOPRISM_HTTP_COMPRESSION: "gzip"            # Improves transfer speed and bandwidth utilization (none or gzip)
      PHOTOPRISM_HTTP_PORT: "2343"
      PHOTOPRISM_DEBUG: "false"                      # Run in debug mode (shows additional log messages)
      PHOTOPRISM_PUBLIC: "false"                     # No authentication required (disables password protection)
      PHOTOPRISM_READONLY: "false"                   # Don't modify originals directory (reduced functionality)
      PHOTOPRISM_EXPERIMENTAL: "false"               # Enables experimental features
      PHOTOPRISM_DISABLE_CHOWN: "false"              # Disables storage permission updates on startup
      PHOTOPRISM_DISABLE_WEBDAV: "false"             # Disables built-in WebDAV server
      PHOTOPRISM_DISABLE_SETTINGS: "false"           # Disables Settings in Web UI
      PHOTOPRISM_DISABLE_TENSORFLOW: "false"         # Disables all features depending on TensorFlow
      PHOTOPRISM_DISABLE_FACES: "false"              # Disables facial recognition
      PHOTOPRISM_DISABLE_CLASSIFICATION: "false"     # Disables image classification
      PHOTOPRISM_DARKTABLE_PRESETS: "false"          # Enables Darktable presets and disables concurrent RAW conversion
      PHOTOPRISM_DETECT_NSFW: "false"                # Flag photos as private that MAY be offensive (requires TensorFlow)
      PHOTOPRISM_UPLOAD_NSFW: "true"                 # Allow uploads that MAY be offensive
      # PHOTOPRISM_DATABASE_DRIVER: "sqlite"         # SQLite is an embedded database that doesn't require a server
      PHOTOPRISM_DATABASE_DRIVER: "mysql"            # Use MariaDB 10.5+ or MySQL 8+ instead of SQLite for improved performance
      PHOTOPRISM_DATABASE_SERVER: "mariadb:3306"     # MariaDB or MySQL database server (hostname:port)
      PHOTOPRISM_DATABASE_NAME: "photoprism"         # MariaDB or MySQL database schema name
      PHOTOPRISM_DATABASE_USER: "photoprism"         # MariaDB or MySQL database user name
      PHOTOPRISM_DATABASE_PASSWORD: "<strongpassword>"       # MariaDB or MySQL database user password
      PHOTOPRISM_SITE_TITLE: "PhotoPrism | <username>"
      PHOTOPRISM_SITE_CAPTION: "Finally Getting Around to all those pictures"
      PHOTOPRISM_SITE_DESCRIPTION: ""
      PHOTOPRISM_SITE_AUTHOR: "<username>"
      ## Set a non-root user, group, or custom umask if your Docker environment doesn't support this natively:
      # PHOTOPRISM_UID: 1000
      # PHOTOPRISM_GID: 1000
      # PHOTOPRISM_UMASK: 0000
      ## Enable TensorFlow AVX2 support for modern Intel CPUs (requires starting the container as root):
      # PHOTOPRISM_INIT: "tensorflow-amd64-avx2"
      ## Hardware video transcoding config (optional):
      # PHOTOPRISM_FFMPEG_BUFFERS: "64"              # FFmpeg capture buffers (default: 32)
      # PHOTOPRISM_FFMPEG_BITRATE: "32"              # FFmpeg encoding bitrate limit in Mbit/s (default: 50)
      # PHOTOPRISM_FFMPEG_ENCODER: "h264_v4l2m2m"    # Use Video4Linux for AVC transcoding (default: libx264)
      # PHOTOPRISM_FFMPEG_ENCODER: "h264_qsv"        # Use Intel Quick Sync Video for AVC transcoding (default: libx264)
      # PHOTOPRISM_INIT: "intel-graphics tensorflow-amd64-avx2" # Enable TensorFlow AVX2 & Intel Graphics support
      HOME: "/photoprism"
    ## Hardware devices for video transcoding and machine learning (optional):
    # devices:
    #  - "/dev/video11:/dev/video11" # Video4Linux (h264_v4l2m2m)
    #  - "/dev/dri/renderD128:/dev/dri/renderD128" # Intel GPU
    #  - "/dev/dri/card0:/dev/dri/card0"
    working_dir: "/photoprism"
    volumes:
      ## The *originals* folder contains your original photo and video files (- "[host folder]:/photoprism/originals"):
      - "/mnt/uasis5/nextcloud/data/<localStorage>/files/pictures:/photoprism/originals"
      ## Multiple folders can be made accessible by mounting them as subfolders of /photoprism/originals:
      # - "/mnt/Family:/photoprism/originals/Family"    # [folder 1]:/photoprism/originals/[folder 1]
      # - "/mnt/Friends:/photoprism/originals/Friends"  # [folder 2]:/photoprism/originals/[folder 2]
      ## You may mount an *import* folder from which files can be transferred to *originals* (optional):
      # - "~/Import:/photoprism/import"
      ## Cache, session, thumbnail, and sidecar files will be created in the *storage* folder (never remove):
      - "/mnt/uasis5/nextcloud/data/<localStorage>/files/.photoprism/storage:/photoprism/storage"
## Database Server (recommended)
  ## see https://docs.photoprism.org/getting-started/faq/#should-i-use-sqlite-mariadb-or-mysql
  mariadb:
    restart: unless-stopped
    image: mariadb:10.6
    security_opt:
      - seccomp:unconfined
      - apparmor:unconfined
    command: mysqld --transaction-isolation=READ-COMMITTED --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --max-connections=512 --innodb-rollback-on-timeout=OFF --innodb-lock-wait-timeout=120
    volumes:
      - "/home/icicle/docker/photoprism/iMomma/db:/database" # Never remove
    environment:
      MYSQL_ROOT_PASSWORD: <strongpassword>
      MYSQL_DATABASE: photoprism
      MYSQL_USER: photoprism
      MYSQL_PASSWORD: <passwordExtrastrenth>
      
## Watchtower upgrades services automatically (optional)
  ## see https://docs.photoprism.org/getting-started/updates/#watchtower
  #
  # watchtower:
  #   restart: unless-stopped
  #   image: containrrr/watchtower
  #   environment:
  #     WATCHTOWER_CLEANUP: "true"
  #     WATCHTOWER_POLL_INTERVAL: 7200 # Checks for updates every two hours
  #   volumes:
  #     - "/var/run/docker.sock:/var/run/docker.sock"
  #     - "~/.docker/config.json:/config.json" # Optional, for authentication if you have a Docker Hub account
networks:
  default:
    external:
      name: nginx-prox-mgmt-3_default

```