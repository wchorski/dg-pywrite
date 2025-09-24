---
{"dg-publish":true,"tags":["media","music"],"permalink":"/developer/media-software/zotify/","dgPassFrontmatter":true}
---

## Docker How to

### Docker Build
I had to add the git dependency to the `Dockerfile` at line

`RUN apk --update add ffmpeg git` for it to build without errors

```shell
docker build -t zotify .
```
### run.sh
>[!warning] Do not create directory manually
>Let Docker create the `/mnt/media/zotify` directory


```bash
#!/bin/bash                  
## $1 allows to directly input url i.e. `./run.sh http://****`
docker run --rm \                                       
	-v "/mnt/media/zotify:/root/Music" \
	-v "/home/username/docker/zotify-googolFork/env/config:/root/.config/zotify" \
	-p "4381:4381" \
	-it zotify python3 -m zotify $1
	#-it zotify /bin/sh
```
### Authenticate
> [!error] Username Password Login doesn't work
> I've been using this fork of zotify by [Googolplexed0](https://github.com/Googolplexed0/zotify) to authenticate via magic link.

1. Input your username (email)
2. open link in browser (where you are already logged into same account)
3. "Continue to the App" button
4. `http://127.0.0.1:4381/login?code=***` change to server's IP directly in address bar and press enter

Changing `REDIRECT_ADDRESS` to my server's hostname or IP caused an invalid link. I just had to manually change `127.0.0.1` to my server's hostname/IP (in browser's address bar) after clicking spotify auth link.
## Commands 
```shell
docker run --rm -v "$PWD/Zotify Music:/root/Music/Zotify Music" -v "$PWD/Zotify Podcasts:/root/Music/Zotify Podcasts" -it zotify /bin/sh

/app # python3 -m zotify --help
```

## Troubleshooting

### zsh 
```shell
zotify https://open.spotify.com/track/7ICNV0qtWVWvSmoFxQcU7g?si=1a2e7e43c3a44098

zsh: no matches found: https://open.spotify.com/track/7ICNV0qtWVWvSmoFxQcU7g?si=1a2e7e43c3a44098
```

This is a shell escaping issue with zsh (Z shell). The problem occurs because zsh interprets the `?` and `&` characters in the URL as special shell characters for pattern matching.

#### 1. Quote the URL
Wrap the URL in quotes to prevent zsh from interpreting special characters:
```
zotify "https://open.spotify.com/track/7ICNV0qtWVWvSmoFxQcU7g?si=1a2e7e43c3a44098"
```

#### 3. Remove the tracking parameter
The `?si=...` part is just Spotify's tracking parameter and isn't needed for downloading:
```
zotify https://open.spotify.com/track/7ICNV0qtWVWvSmoFxQcU7g
```

---
## Credit
- https://github.com/zotify-dev/zotify
- https://github.com/Googolplexed0/zotify
- https://github.com/zotify-dev/zotify/issues/126
- https://github.com/Googolplexed0/zotify/issues/20