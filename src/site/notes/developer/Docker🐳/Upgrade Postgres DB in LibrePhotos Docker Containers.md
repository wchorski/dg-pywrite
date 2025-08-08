---
{"dg-publish":true,"permalink":"/developer/docker/upgrade-postgres-db-in-libre-photos-docker-containers/","created":"2025-08-06T21:31:28.753-05:00","updated":"2025-08-06T12:47:58.000-05:00"}
---

```shell
cd docker/librephotos

docker compose down

## could also be called just `db`
docker compose up librephotos_db

## in another terminal
## docker is the `dbUser` set in .env
docker exec -it librephotos_db pg_dumpall -U docker > pg_dump_v13.sql

docker compose stop librephotos_db
## or just quit out of running container (if you didnt `-d`)
docker compose down

## move old data to safe location and create fresh directory of same route
sudo mv /mnt/cache/librephotos-data/db/data-postgres /mnt/cache/librephotos-data/db/data-postgres-BACKUP-13

sudo mkdir /mnt/cache/librephotos-data/db/data-postgres

git pull

## In the new docker-compose.yml from the repo the db named changed to `db`
docker compose up db

## import the database into the new shiny postgres 17
docker exec -i db psql -U docker -d librephotos < pg_dump_v13.sql
```