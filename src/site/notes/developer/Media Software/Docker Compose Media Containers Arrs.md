---
{"dg-publish":true,"permalink":"/developer/Media Software/Docker Compose Media Containers Arrs/"}
---

- [[developer/Media Software/Prowlarr\|Prowlarr]]
- [[developer/Media Software/Flaresolverr\|Flaresolverr]]
- [[developer/Media Software/Radarr\|Radarr]]
- [[developer/Media Software/Sonarr\|Sonarr]]
- [[developer/Media Software/Prowlarr\|Prowlarr]]
- [[developer/Media Software/Ladarr\|Ladarr]]
- [[developer/Media Software/qBittorrent\|qBittorrent]]
- [[developer/Home Lab/Plex.tv\|Plex.tv]]
- [[developer/Media Software/bazarr\|bazarr]]
- [[developer/Media Software/ProtonVPN\|ProtonVPN]]
- [[tore\|tore]]

## Configuration
Other tutorials I found left out a torrent downloader in the container stack. This stack includes everything but a media server (which I assume most have an already running server of i.e. [[developer/Home Lab/Plex.tv\|Plex.tv]], [[developer/Home Lab/Jellyfin\|Jellyfin]], etc.)

### Directory File Structure

My naming and structure might be confusing because I use `media` as the all containing folder instead of `data` because to me media just sounded more inline with what will live in this directory 

```bash
/mnt/VOLUME/media
├── library
│   ├── books
│   ├── movies
│   ├── music
│   └── tv
└── trnts
    ├── radarr
    └── tv-sonarr
```

`libary` is the directory a media player reads, and `trnts` is assentially [[developer/Media Software/qBittorrent\|qBittorrent]]'s "download" folder. Other tutorials have a matching set of `movies, music, tv` folders, but in my case the torrent downloader automatically created these `radarr, tv-sonarr` apps and the hardlinks continued to work sooo... 🤷‍♀️
### compose.yml
```yml
services:

  prowlarr: #indexer manager for Sonarr & Radarr
    image: ghcr.io/linuxserver/prowlarr:develop
    container_name: prowlarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - ./prowlarr:/config
    ports:
      - 9696:9696
    restart: unless-stopped
    networks:
      - this
      
  flaresolverr:
    image: ghcr.io/flaresolverr/flaresolverr:latest
    container_name: flaresolverr
    environment:
      - LOG_LEVEL=${LOG_LEVEL:-info}
      - LOG_HTML=${LOG_HTML:-false}
      - CAPTCHA_SOLVER=${CAPTCHA_SOLVER:-none}
      - TZ=$TZ
    ports:
      - "8191:8191"
    restart: unless-stopped
    networks:
      - this

  radarr: #movie search agent
    image: ghcr.io/linuxserver/radarr
    container_name: radarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - UMASK=022
    volumes:
      - ./radarr:/config
      - $MEDIADIR:/media
    ports:
      - 7878:7878
    restart: unless-stopped
    networks:
      - this

  sonarr: #TV show search agent
    image: ghcr.io/linuxserver/sonarr:latest
    container_name: sonarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - UMASK=022
    volumes:
      - ./sonarr:/config
      - $MEDIADIR:/media
    ports:
      - 8989:8989  
    restart: unless-stopped
    networks:
      - this

  lidarr:
    image: lscr.io/linuxserver/lidarr:latest
    container_name: lidarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - UMASK=022
    volumes:
      - ./lidarr:/config
      - $MEDIADIR:/media
    ports:
      - 8686:8686
    restart: unless-stopped
    networks:
      - this

  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittarrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Chicago
      - WEBUI_PORT=8080
    volumes:
      - ./qbittorrent/config:/config
      - $MEDIADIR:/media
      - ./qbittorrent/webui-cjratliff:/webui
    ports:
      - 8080:8080
      - 6881:6881
      - 6881:6881/udp
    restart: unless-stopped
    networks:
      - this

networks:
  this:
    name: arr-network
    driver: bridge
```

> [!note] I left `# proxy` notes in there. That way you could connect everything by docker's internal **DNS**, but to keep things simple, I'm just exposing the ports to the local host
### .env
```yml
PUID=1000 #change to your user's PUID
PGID=100 #change to your user's PGID
TZ=America/Chicago #change to your timezone location
MEDIADIR=/mnt/VOLUME1/media
```

> [!info](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)**

`VOLUME1` should be replaced by your path needs.

## Local DNS
before you go and link the containers up via each web UI. Check out my [[developer/Pretty URLS for Local DNS Records\|Pretty URLS for Local DNS Records]], especially if you're a [[developer/Home Lab/Pi-hole\|Pi-hole]] user.
## VPN
- [How to torrent safely with a VPN - Proton VPN Support](https://protonvpn.com/support/bittorrent-vpn/)

## Trouble Shooting
 I had an error in Sonarr/Radarr/Ectrr
 > [!error] your downloader qbittorrent does not have a path /downloads/torrents 

Looks like the paths have to be exactly the same for each container in the stack

### Anime Dubs vs Subs
I'd prefer to have an English dub of an Anime if one exists. Looks like there is a way to do it via 'Category' or 'Tags'. Another comment mentions [weighting words](https://www.reddit.com/r/sonarr/comments/iowsbb/is_there_an_easy_way_to_to_have_sonarr_get_only/g4hmcdf/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)? 

---
## Credits
- [Make Automated Torrent Media Server with Emby, Sonarr, Radarr, Prowlarr, and qBittorrent on Windows! - YouTube](https://www.youtube.com/watch?v=LD8-Qr3B2-o)
- [How to torrent safely with a VPN - Proton VPN Support](https://protonvpn.com/support/bittorrent-vpn/)
- [Configuring Prowlarr for Sonarr and Radarr in docker (pointtosource.com)](https://academy.pointtosource.com/containers/sonarr-radarr-prowlarr/)
- [Docker Guide | Servarr Wiki](https://wiki.servarr.com/docker-guide)
- [Hardlinks - Atomic Moves - TRaSH Guides (trash-guides.info)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)
- [qBittorrent Basic-Setup - TRaSH Guides (trash-guides.info)](https://trash-guides.info/Downloaders/qBittorrent/Basic-Setup/)

## Backlinks
- [[developer/Home Lab/Docker\|Docker]]