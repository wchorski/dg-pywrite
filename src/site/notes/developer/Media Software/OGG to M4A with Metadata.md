---
{"dg-publish":true,"permalink":"/developer/media-software/ogg-to-m4-a-with-metadata/","noteIcon":"","created":"2026-10-09T13:07:44.000-05:00","updated":"2026-10-09T13:07:44.000-05:00","dg-note-properties":{}}
---

If you download your music in `.ogg` format and want to convert to `.m4a` and carry over all it's metadata (song, album, artwork, year, genre, etc)

> [!tip] Requirements
> does require python library `mutagen`

```bash
#!/bin/bash
# convert-ogg-to-m4a.sh

DIR="/Users/splitskream/Music/downloads"
FIXER="/Users/splitskream/bin/m4a-tools/fix_m4a_metadata.py"
PYTHON="/Users/splitskream/bin/m4a-tools/venv/bin/python"

cd "$DIR" || exit 1

# Recursively find every .ogg (case-insensitive), null-delimited for safe filenames
while IFS= read -r -d '' FILE; do

    OUTPUT="${FILE%.*}.m4a"

    echo ""
    echo "======================================"
    echo "Converting:"
    echo "$FILE"
    echo "======================================"

    # Skip if the m4a already exists
    if [ -f "$OUTPUT" ]; then
        echo "Already exists:"
        echo "$OUTPUT"
        echo "Skipping..."
        continue
    fi

    #
    # Step 1: Convert audio
    #
    if ! ffmpeg \
        -nostdin \
        -y \
        -i "$FILE" \
        -map 0:a \
        -map "0:v?" \
        -c:a aac \
        -profile:a aac_low \
        -b:a 320k \
        -c:v copy \
        -disposition:v attached_pic \
        "$OUTPUT"; then
        echo "FFmpeg failed:"
        echo "$FILE"
        rm -f "$OUTPUT"   # clean up any partial output
        continue
    fi

    #
    # Step 2: Fix iTunes metadata atoms
    #
    echo "Fixing metadata..."

    if ! "$PYTHON" "$FIXER" "$FILE" "$OUTPUT"; then
        echo "Metadata fixing failed:"
        echo "$OUTPUT"
        echo "Keeping original OGG"
        continue
    fi

    #
    # Step 3: Delete original
    #
    echo "Removing original:"
    echo "$FILE"
    rm "$FILE"

    echo "DONE:"
    echo "$OUTPUT"
# If you also want it to handle other formats (.flac, .opus, .wav), you can extend the find with
# \( -iname '*.ogg' -o -iname '*.flac' -o -iname '*.opus' \)
done < <(find . -type f -iname '*.ogg' -print0)

echo ""
echo "All conversions complete."
```

`/Users/splitskream/bin/m4a-tools/fix_m4a_metadata.py`

```python
#!/usr/bin/env python3

import sys
from mutagen.oggvorbis import OggVorbis
from mutagen.mp4 import MP4


if len(sys.argv) != 3:
    print("Usage: fix_m4a_metadata.py input.ogg output.m4a")
    sys.exit(1)


ogg_file = sys.argv[1]
m4a_file = sys.argv[2]


print(f"Reading metadata:")
print(f"  {ogg_file}")

print(f"Writing metadata:")
print(f"  {m4a_file}")


ogg = OggVorbis(ogg_file)
m4a = MP4(m4a_file)


def copy_first(src, dst):
    """
    Copy a single-value Vorbis comment into an MP4 atom.
    """
    if src in ogg and ogg[src]:
        m4a[dst] = ogg[src][0]


# -------------------------
# Standard iTunes metadata
# -------------------------

copy_first("title", "\xa9nam")            # Title
copy_first("artist", "\xa9ART")           # Artist
copy_first("album", "\xa9alb")            # Album
copy_first("album_artist", "aART")        # Album Artist
copy_first("date", "\xa9day")             # Year
copy_first("genre", "\xa9gen")            # Genre
copy_first("comment", "\xa9cmt")          # Comment


# -------------------------
# Track number
# -------------------------

if "track" in ogg:

    track = int(ogg["track"][0])

    total = 0
    if "tracktotal" in ogg:
        total = int(ogg["tracktotal"][0])

    m4a["trkn"] = [(track, total)]


# -------------------------
# Disc number
# -------------------------

if "disc" in ogg:

    disc = int(ogg["disc"][0])

    total = 0
    if "disctotal" in ogg:
        total = int(ogg["disctotal"][0])

    m4a["disk"] = [(disc, total)]


# -------------------------
# ISRC
# -------------------------

if "isrc" in ogg:

    m4a["----:com.apple.iTunes:ISRC"] = [
        ogg["isrc"][0].encode("utf-8")
    ]


# -------------------------
# Spotify metadata
# -------------------------

for tag in [
    "trackid",
    "uri",
]:

    if tag in ogg:

        m4a[
            f"----:com.apple.iTunes:{tag}"
        ] = [
            ogg[tag][0].encode("utf-8")
        ]


# -------------------------
# Lyrics
# -------------------------

if "lyrics" in ogg:

    m4a["\xa9lyr"] = ogg["lyrics"][0]


# -------------------------
# Save
# -------------------------

m4a.save()

print("Metadata fixed successfully.")
```