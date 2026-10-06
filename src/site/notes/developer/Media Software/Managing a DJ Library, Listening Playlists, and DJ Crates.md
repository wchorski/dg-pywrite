---
{"dg-publish":true,"permalink":"/developer/media-software/managing-a-dj-library-listening-playlists-and-dj-crates/","noteIcon":"","created":"2026-10-03T14:10:29.000-05:00","updated":"2026-10-03T14:10:29.000-05:00","dg-note-properties":{}}
---

I've used iTunes for many years, and was happy with using it for playlists, burning CDs, loading my iPod, and running parties. The future has brought many new useful technologies and (unwelcome) updates.

Here is my stack I use today
- Apple Music on Macbook M1
- [[developer/Media Software/Navidrome\|Navidrome]] for personal remote/local streaming
- Serato / Rekordbox 
	- Natively reads Apple Music or *iTunes* library. 

I HATE Apple Music's UI, for 2 big reasongs 
1. the GIANT header it puts on playlists, shrinking the availble view space for the songs
2. horizontal scroll shifting when editing fields. May seem like a small gripe but when you need to edit 100s of rows and have to rescroll after every edit is a *NIGHTMARE*

Here is my new proposed stack that retains the Music.app integrations, adds a better metadata tag editor (powered up with modern features), and doesn't change the server setup.

```txt
             DOWNLOAD MUSIC
                    │
                    ▼
        Music "Automatically Add" folder
                    │
                    ▼
             ┌──────────────────────┐
             │      MUSIC.APP       │
             │                      │
             │ playlists            │
             │ library              │
             │ organization         │
             └──────────┬───────────┘
                        │
                 files are linked
                        │
                        ▼
             ┌──────────────────────┐
             │        YATE          │
             │                      │
             │ bulk tag editing     │
             │ artwork              │
             │ MusicBrainz          │
             │ Discogs               │
             │ Beatport              │
             │ scripting            │
             └──────────┬───────────┘
                        │
                  actual files
                        │
                        ▼
                  your DJ library
                        │
                  ┌─────┴──────┐
                  ▼            ▼
              Rekordbox     Navidrome
                              ↑
                            rsync
```

Still considering adding https://navibeat.app/macos into this mix so I can create/edit playlists that sync across devices multi-directionally instead of only have this one-way flow of building and syncing playlists. That means I would looks DJ Software integration, but dragging and dropping the playlist into a crate isn't really that bad.

I use https://www.symfonium.app/ for my Android phone music playing. This syncs nicely with Navidrome and I'm able to like songs and create small playlists on the go for later inspiration. But it's a pain when I want to add a song to an existing playlist that I originally created on the macbook.

## Using Yate
- Link to Apple App (sometimes happens automatically, if "Unlink Apple from App App" is in white, your hooked up)
- add `.../iTunes Media/Music` to your YATE directory 
- show "Creation Date" column to show most recently added and sort
- 