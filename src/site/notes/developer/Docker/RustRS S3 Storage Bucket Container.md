---
{"dg-publish":true,"tags":["docker","docker-compose","s3","storage"],"permalink":"/developer/docker/rust-rs-s3-storage-bucket-container/","dgPassFrontmatter":true}
---

- https://github.com/rustfs/rustfs 
- https://hub.docker.com/r/rustfs/rustfs 

## Make directories 
```shell 
sudo mkdir -p /mnt/snowbank/s3/data 
sudo chgrp -R 10001 /mnt/snowbank/s3 
sudo chmod -R 770 /mnt/snowbank/s3 
```

## Compose
I like to stick my passwords in an `.env` file

```shell
nano .env
```

```env
RUSTFS_SECRET_KEY=****
# list of domains allowed seperated by comma
RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS= 
```

```shell
nano compose.yml
```

This is a modified version of the repo example https://github.com/rustfs/rustfs/blob/main/docker-compose.yml

```yml
services:
  # RustFS main service
  rustfs:
    security_opt:
      - no-new-privileges:true
    image: rustfs/rustfs:1.0.0-beta.2
    container_name: rustfs-server
    # build:
    #   context: ./source-code/.
    #   dockerfile: Dockerfile.source
    #   args:
    #     TARGETPLATFORM: linux/amd64
    ports:
      - 9000:9000 # S3 API port
      - 9001:9001 # Console port
    environment:
      - RUSTFS_VOLUMES=/data
      - RUSTFS_ADDRESS=0.0.0.0:9000
      - RUSTFS_CONSOLE_ADDRESS=0.0.0.0:9001
      - RUSTFS_CONSOLE_ENABLE=true
      - RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS=${RUSTFS_CONSOLE_CORS_ALLOWED_ORIGINS}
      # SECURITY: these defaults are public and well-known. Override before
      # exposing the listener beyond localhost.
      - RUSTFS_ACCESS_KEY=storage_admin
      - RUSTFS_SECRET_KEY=${RUSTFS_SECRET_KEY}
      - RUSTFS_OBS_LOGGER_LEVEL=info
      - RUSTFS_TLS_PATH=/opt/tls
      # - RUSTFS_OBS_ENDPOINT=http://otel-collector:4318
    volumes:
      - /mnt/snowbank/s3/data:/data
      - ./logs:/app/logs
      # TLS configuration directory.
      # Place at least:
      # - /opt/tls/ca.crt
      # - /opt/tls/rustfs_cert.pem
      # - /opt/tls/rustfs_key.pem
      - ./certs/:/opt/tls
      # Permission baseline:
      # - default RustFS runtime user is 10001:10001
      # - ensure host mounts are writable by that user, or run with host-matched user
    networks:
      - rustfs-network
      - nginx-prox-mgmt-3_default
    restart: unless-stopped
    healthcheck:
      # Production strict TLS example (SAN/FQDN aligned, no `-k`):
      # curl -f --cacert /opt/tls/ca.crt --resolve rustfs-a.example.com:9000:127.0.0.1 https://rustfs-a.example.com:9000/health
      # curl -f --cacert /opt/tls/ca.crt --resolve rustfs-a.example.com:9001:127.0.0.1 https://rustfs-a.example.com:9001/rustfs/console/health
      test:
        - CMD
        - sh
        - -c
        - curl -f http://127.0.0.1:9000/health && curl -f
          http://127.0.0.1:9001/rustfs/console/health
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    # depends_on:
    #   otel-collector:
    #     condition: service_started
    #     required: false

networks:
  rustfs-network:
    driver: bridge
  ## attach to proxy manager for ssl certs
  nginx-prox-mgmt-3_default:
    external: true
```
## Wordpress Plugin Setup
[[developer/Wordpress/Use S3 Uploads in-place of Wordpress media directory\|Use S3 Uploads in-place of Wordpress media directory]]

#todo 
- [ ] [[developer/Home Lab/Nextcloud\|Nextcloud]] integration
- [ ] integrate metrics (with prometheus piped to grafana)