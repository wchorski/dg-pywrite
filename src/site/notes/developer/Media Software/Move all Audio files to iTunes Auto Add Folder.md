---
{"dg-publish":true,"permalink":"/developer/media-software/move-all-audio-files-to-i-tunes-auto-add-folder/","noteIcon":"","created":"2026-10-11T22:54:00.000-05:00","updated":"2026-10-11T22:54:00.000-05:00","dg-note-properties":{}}
---

```bash
#!/bin/bash
# mv-to-auto-add-to-library-dir.sh

set -e

DIR="/Users/splitskream/Music/downloads"
AUTO_LIBRARY_DIR="/Volumes/edata/iMusicLibrary/iTunes Media/Automatically Add to Music.localized"

cd "$DIR" || exit 1
[ -d "$AUTO_LIBRARY_DIR" ] || { echo "Destination not mounted, aborting."; exit 1; }

while IFS= read -r -d '' FILE; do
    NAME=$(basename "$FILE")

    if [ -f "$AUTO_LIBRARY_DIR/$NAME" ]; then
        echo "Already exists: $NAME"
        echo "Skipping..."
        continue
    fi

    echo ""
    echo "==="
    echo "moving: $FILE"

    mv "$FILE" "$AUTO_LIBRARY_DIR/"
    echo "DONE: $NAME"
done < <(find . -type f -name "*.m4a" -print0)

echo "=== All file moves complete. ==="
```