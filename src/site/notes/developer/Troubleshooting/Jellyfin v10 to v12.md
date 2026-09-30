---
{"dg-publish":true,"tags":["media","server","selfhosted","docker"],"permalink":"/developer/troubleshooting/jellyfin-v10-to-v12/","dgPassFrontmatter":true,"dg-note-properties":{"tags":["media","server","selfhosted","docker"]}}
---

What a nightmare upgrading and trying to fix SQLite errors for [[developer/Home Lab/Jellyfin\|Jellyfin]]

Here is a small sample of me going through the motions on how to get this going again.

I ran a separate [[Debian\|Debian]] container to poke around with SQL. The following is my conversation with Claude... While my thoughts on AI are mixed, this actually repaired my database. 

----

**1. SQL container:**

bash

```bash
docker compose stop jellyfin

docker run --rm -it -v ./config/data:/data debian:bookworm-slim bash -c "apt-get update && apt-get install -y sqlite3 && bash"
cd /data
```

**2. Find every column across the entire database that might hold a date, and check each for this exact corruption pattern (character 14 is `2` instead of `:`):**

bash

```bash
sqlite3 jellyfin.db "SELECT m.name AS tbl, p.name AS col FROM sqlite_master m JOIN pragma_table_info(m.name) p WHERE m.type='table' AND p.name LIKE '%Date%';" > /tmp/date_columns.txt
cat /tmp/date_columns.txt
```

**3. Run this loop to both count and fix every one of those columns in one pass:**

bash

```bash
while IFS='|' read -r tbl col; do
  count=$(sqlite3 jellyfin.db "SELECT COUNT(*) FROM \"$tbl\" WHERE SUBSTR(\"$col\",14,1) = '2' AND LENGTH(\"$col\") >= 19;")
  if [ "$count" != "0" ]; then
    echo "Fixing $count rows in $tbl.$col"
    sqlite3 jellyfin.db "UPDATE \"$tbl\" SET \"$col\" = SUBSTR(\"$col\",1,13) || ':' || SUBSTR(\"$col\",15) WHERE SUBSTR(\"$col\",14,1) = '2' AND LENGTH(\"$col\") >= 19;"
  fi
done < /tmp/date_columns.txt
```

**4. Verify nothing's left:**

bash

```bash
while IFS='|' read -r tbl col; do
  sqlite3 jellyfin.db "SELECT '$tbl.$col: ' || COUNT(*) FROM \"$tbl\" WHERE SUBSTR(\"$col\",14,1) = '2' AND LENGTH(\"$col\") >= 19;"
done < /tmp/date_columns.txt
```

All should say `: 0`.

**5. Final integrity check, then exit and restart:**

bash

```bash
sqlite3 jellyfin.db "PRAGMA integrity_check;"
exit
docker compose up
```

This should clear out every remaining instance of this specific corruption in one shot rather than the migration finding them 10,000 rows at a time.

**That said** — if you'd rather just cut your losses, starting over is a completely reasonable call, especially after this many rounds. Here's what that actually looks like, and the honest tradeoff:

- Your media files on disk are **completely untouched** by any of this — nothing you've done affects them.
- Deleting `jellyfin.db` and letting Jellyfin recreate it means: full re-scan of all libraries (can take a while depending on library size), loss of watch history/watched status, favorites, playlists, and user accounts (you'd recreate your 2 users).
- Steps: stop the container, delete `jellyfin.db`, `jellyfin.db-shm`, `jellyfin.db-wal` from `/config/data` (keep your `.corrupt` and `backup_dbfiles` copies elsewhere just in case), then start Jellyfin fresh and re-add your libraries.