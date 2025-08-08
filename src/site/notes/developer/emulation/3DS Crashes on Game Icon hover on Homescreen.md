---
{"dg-publish":true,"permalink":"/developer/emulation/3-ds-crashes-on-game-icon-hover-on-homescreen/","tags":["homebrew","nintendo","bug","crash"],"created":"2025-06-28T10:49:36.893-05:00","updated":"2025-06-17T12:10:19.000-05:00"}
---

I had a strange bug that would crash my 3DS when hovering over a game title (in this case New Super Mario Bros 2).

This also caused other problems such as 
1. Checkpoint crash on load
2. System Settings Crash on Data Management Load

I only identified the problem because I could see the game's icon right before I put the cursor (or tapped) the icon.

I had to enter godmode (hold `start` while powering on) and manage the titles. Going through my SD card's titles I did not see a title named "New Super Mario Bros 2". In a small panic I realized each game has a game ID

By visiting the [hshop](https://hshop.erista.me/t/19263)I was able to look up the title's name and get it's `Title ID`. In the list of Titles that godmode gave me I was able to hunt down the bad title and delete it.

#todo 
- [ ] add screenshot

phew... Now I'm able to manage my save data and browse my home screen without catastrophy.  