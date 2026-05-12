---
{"dg-publish":true,"tags":["linux","files","filesystem","automation"],"permalink":"/developer/linux/find-and-delete-files-and-directories-with-regex/","dgPassFrontmatter":true}
---

on my [[developer/Linux/Linux\|Linux]] system I want to delete [[developer/Home Lab/Docker\|Docker]] volumes that are not named (usually orphaned by old containers). Yes I'm aware of `docker system prune` but in this case I am working off a spare drive, recovering data way from the docker server.

```shell
ls /var/docker/volumes 

02f46cc44861538aeaff585ab54c00ea5151fc7ff25fc8bef5d4a5cb96841822 c21f96a9516ffd7a6f01354929f8251a924a04b561e7ea5c5fdb5940706b2b25 0526a83de80cc33ae3c74db52952848fc034c5dfe7975000c566103ff772ac15 c7ca1aa2f2a85836c09f9a5822b1388139996e565b2176fef33e4216c2fedc26 075e92f4af554afbb487674a6691648e470aae6ffb93e4e218083155552fbcc7 d141a4ca661f95a7d30d31ed3fcdf7be6f428da1ab3aa1c58b720440a729710b 0b87c889564cb3fdc7d88fef5b5f01c12d790f7798165f0eef08c74979c185a8 d14923870b7a84e23d70f77f97f7b75bc87fb9f3bd3ade7ac3250c5322254f09 0de3e98472bab76be3cffdc7dec70b2580f0a814ecff08ec74a7241aae473397 d2466c498c85fd2a271b7d348bb21a6c3fbbe2a05234d37df54421a6e88ab598 0e4a66ceed79251e9eba909745b02a45e3623c8bf2791862d0dfb8b6e433401b d83ac31cfb1960ef4ea1cbe4514a276576bc017f5885940d08897e9cd54491cc 0ec31be80163b27278fe7a4aa1311d54bb6a9778bd2f155caf3bed50c037d310 d9b81ffddd55035631ccd7ce860f7730b3472ad5833d5d9c52136f5195a1b3c7 17a76ada2ba1ec0573f3b044578b87063100ef7fceaa437f311fe084509b5d33 dda26cab2be6c880fb2ec1ae6596d98d287f51ac86988777d9c266f70424630c 1929ee4a97ff84eea9981e14ef5ff202a2f979d0f3c783b426f18c51e40baf4e e1fba175e38af4bd65ae7fbbbd49d16e44e1d187227914daefe5d5f0941ca28b 1d6ef17f23bc133ecc130ed33c0eeb479bcb3d61c6105902ec4b3a6d375405b1 eb79cf1ecd956ae95a583e172bcb129f77f3c156203fa90ef555d7226bccc106 214fb735f421cee0de38cc66a71a0966613689110a9e7c3453ee2fa68e5ad9f5 f3b8644c9d62a78b92d60baa7ea05d714105b86bb2e618b9dfc022b54aff3f61 24e0d456a11a4decc9726d89bb189063e5c4dacb0ac40bc90ca8f554681e6337 immich_model-cache 4b83771509a6ea6a5c77ad36d075499791f25798798ed977dbeddaced1a1bfdb metadata.db 52ddb5bbe2351929f54f223ff1c3337040e661c1360d20a4142ecc21fbc44cb4 nextcloud_aio_apache 5d46fb783a666db5bcb6152636d2a67b4fbfe13d16dc7ae65e275aacf569d54a nextcloud_aio_backup_cache 5f30dcc4ffa44f4c1c992940d8f19fc90d1b3d582d921ca5591b83a856f43118 nextcloud_aio_calcardbackup 661c5e87504bd287c389446a6dcf0bf9c8fc593bb7490be83b16fbce0a80b3c8 nextcloud_aio_database 85cadaeba71d583cf8c1c8353e31eb0587cf791a6e0af77989ce63a665526a90 nextcloud_aio_database_dump 864ec81dc840af3e5ffec5e3b8e6776ee5ca34bcbee97ba38514da3ba81192de nextcloud_aio_elasticsearch 8653a132fde3569e7b9b7c687e9f830f3a5e650a8a4225956b65b45d4595bd72 nextcloud_aio_mastercontainer 88c70df192d6ad98a198e0a00ce2df9f3c71138ddd3830b95f1a7abcb133dfa0 nextcloud_aio_nextcloud a7b9d68d735f830de25de7c1c21ed8cbc54b4be11181890d14146a7498c7d632 nextcloud_aio_redis backingFsBlockDev prometheus_prometheus-data bf22db1c3a0ab890d42a89710d6fc5fdfbbfcd6aa4ed8dde4ba2577185db60ed umami3_umami-db-data
```

Preview what would be deleted first:

```
find /var/lib/docker/volumes \  -maxdepth 1 \  -type d \  -regextype posix-extended \  -regex '.*/[a-f0-9]{64}

Then actually delete them:

```
find /var/lib/docker/volumes \  -maxdepth 1 \  -type d \  -regextype posix-extended \  -regex '.*/[a-f0-9]{64}

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

```
find /var/lib/docker/volumes \  -maxdepth 1 \  -type d \  -regextype posix-extended \  -regex '.*/[a-f0-9]{64}
```

Then actually delete them:

{{CODE_BLOCK_2}}

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}} \  -exec rm -rf {} +
```

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}}
```

Then actually delete them:

{{CODE_BLOCK_2}}

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}} \  -ok rm -rf {} \;
```
```

Then actually delete them:

{{CODE_BLOCK_2}}

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}} \  -exec rm -rf {} +
```

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}}
```

Then actually delete them:

{{CODE_BLOCK_2}}

That will keep named volumes like:

- `nextcloud_aio_database`
- `immich_model-cache`
- `prometheus_prometheus-data`

and remove only the 64-character hash dirs.

Safer alternative with confirmation:

{{CODE_BLOCK_3}}