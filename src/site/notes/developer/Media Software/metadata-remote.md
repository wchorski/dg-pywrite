---
{"dg-publish":true,"tags":["music","metadata","tags","genre","media","library","songs"],"permalink":"/developer/media-software/metadata-remote/","dgPassFrontmatter":true}
---

Never have I found a self hosted app that helps a niche problem yet so elegantly in every way.

https://github.com/wow-signal-dev/metadata-remote

![screenshot](https://github.com/wow-signal-dev/metadata-remote/blob/main/screenshots/main-interface.png)

Most of the music I download already has proper title, artist, album, year tags (although there are a handful of outliers). It's the **GENRE** tag that seems to always be left out. 

As a Mobile DJ I rely on genre tags heavily when sorting and finding music to build playlists with. Not only does it find a handful of suggested genre tags to fill, it still allows you to click or type in your preferred text. This is a godsend for someone like me who likes to flip around their genre tags (i.e. "Deep House" would be "House Deep" in my library as I like to order things from **Big to Small**)
## Barrier to Entry
I must warn you that in order to benefit from this tech you will need to learn [[developer/Home Lab/Docker\|Docker]]. Even if you're not an IT wiz it's still worth learning for cool apps like these. 
## How to I use it?
I would still be wary of letting this app peer over your entire library. Any newly downloaded music goes through a *washing* faze. They live in my `/downloads/tunes` folder. That is where I point **metadata-remote** to. I run through the UI via the browser and then drag the the files into my iTunes (or I guess we call it *Apple Music* now?)

We all know how clunky navigating Apple's Music app UI. 