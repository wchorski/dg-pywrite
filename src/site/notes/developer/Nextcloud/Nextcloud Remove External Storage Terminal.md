---
{"dg-publish":true,"permalink":"/developer/nextcloud/nextcloud-remove-external-storage-terminal/","tags":["docker","nextcloud","bash","shell","smb"],"created":"2025-04-15T18:58:55.869-05:00","updated":"2025-04-12T11:36:30.000-05:00"}
---

I mounted a [[developer/Linux/SAMBA Share\|SAMBA Share]] share to my nextcloud in hopes that I could share a large media library to family and friends without having to process all files through Nextcloud. 

2 reasons this wasn't a good idea
1. Did not update. Upon mount, any new files added or deleted where not updated in the file cache of nextcloud
2. Unable to unmount drive via GUI

Let's fix the 2nd problem via terminal

These commands were issued from inside a docker container, so they command syntax will look different if you’re using the terminal (as discussed previously) or if you are using a different image base in your docker container.

### List ALL of the mount points as the root user

```bash
root@mydockercontainer# su -c "php /var/www/html/occ files_external:list -a" -s /bin/sh www-data
+----------+-------------+-------------------------------------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
| Mount ID | Mount Point | Storage                             | Authentication Type   | Configuration                                                                                            | Options | Applicable Users | Applicable Groups | Type     |
+----------+-------------+-------------------------------------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
| 2        | /BoxDotCom  | WebDAV                              | Username and password | host: "dav.box.com\/dav", root: "NextCloud", secure: true, user: "emai1@local.com", password: "***"      |         | user1            |                   | Personal |
| 3        | /GDrive     | Unknown storage backend googledrive | OAuth2                | configured: "true", client_id: "xxxxxx...al.com", client_secret: "***", token: "***"                     |         | user2            |                   | Personal |
+----------+-------------+-------------------------------------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
```

### Pick out your ID from the results

I choose number three which is associated with the provider type and user that is having the issue.

### Delete the mount and confirm when prompted

```bash
root@mydockercontainer# su -c "php /var/www/html/occ files_external:delete 3" -s /bin/sh www-data
+----------+-------------+-------------------------------------+---------------------+--------------------------------------------------------------------------------------+---------+------------------+-------------------+
| Mount ID | Mount Point | Storage                             | Authentication Type | Configuration                                                                        | Options | Applicable Users | Applicable Groups |
+----------+-------------+-------------------------------------+---------------------+--------------------------------------------------------------------------------------+---------+------------------+-------------------+
| 3        | /GDrive     | Unknown storage backend googledrive | OAuth2              | configured: "true", client_id: "xxxxxx...al.com", client_secret: "***", token: "***" |         | user2            |                   |
+----------+-------------+-------------------------------------+---------------------+--------------------------------------------------------------------------------------+---------+------------------+-------------------+
Delete this mount? [y/N] y
```

### List ALL of the mount points again to ensure it’s gone

```bash
root@mydockercontainer# su -c "php /var/www/html/occ files_external:list -a" -s /bin/sh www-data
+----------+-------------+---------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
| Mount ID | Mount Point | Storage | Authentication Type   | Configuration                                                                                            | Options | Applicable Users | Applicable Groups | Type     |
+----------+-------------+---------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
| 2        | /BoxDotCom  | WebDAV  | Username and password | host: "dav.box.com\/dav", root: "NextCloud", secure: true, user: "email@local.com", password: "***"      |         | user1            |                   | Personal |
+----------+-------------+---------+-----------------------+----------------------------------------------------------------------------------------------------------+---------+------------------+-------------------+----------+
```

### Go back to the browser and verify that the issue is fixed

I was also able to go into the client sync at this point and force a sync which cleared away the red x and errors I was experiencing.

---
## Credits
- https://help.nextcloud.com/t/cant-remove-external-mount/10124/11