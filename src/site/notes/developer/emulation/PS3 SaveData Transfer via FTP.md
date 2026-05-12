---
{"dg-publish":true,"tags":["homebrew","jailbreak","gaming","backups"],"permalink":"/developer/emulation/ps-3-save-data-transfer-via-ftp/","dgPassFrontmatter":true}
---

## Official Sony Backup Restore
- https://www.youtube.com/watch?v=bdFrEpfFPDo&t=873s

I've attempted this before and had it working. Over time strange stuffed happened. The biggest being controllers not working wirelessly. This was after upgrading to a larger SSD. I would pop in the old HDD and the controllers would work wirelessly. This told me it wasn't the Bluetooth failing but some other strange glitch.

## Backup on CFW over FTP
- https://www.youtube.com/watch?v=ebqj41R6Ggo

> [!note] Custom Firmware
> Assuming you've already have [CFW](https://consolemods.org/wiki/PS3:Getting_Started) installed on your PS3, and using [MultiMan](https://www.psx-place.com/resources/multiman.530/) or [WebMan](https://www.psx-place.com/resources/webman-mod.11/) to run the FTP server

### What File Tool to Use
I've used both WinSCP and native Windows Explorer. I've found using WinSCP more helpful when moving lots of files/directories at once as it will retry and reconnect when dropped. Native Windows Explorer is really convenient if you're just moving a single `.pkg` file or maybe just a folder or 2. But be warned...
### Don't bother using FTP
I know what the title says. I'm not changing it for those who do land on it looking for a solution. FTP is *SLOW*, even if you have both devices hooked up to the network via ethernet. With MutliMan, just use the file browser and copy files over to a SSD connected by USB. This will be MUCH faster. A 200gb transfer took over 6 hours (and would need multiple retrys) compared to a 3 hours through USB. The USB will show up in the file browser as `dev_usb000`
## If you plan on a Partial Backup
My first biggest pitfall was only backing-up partial data. I initially like to start with a small set of data first so I know it works, then continue with the rest. What I didn't understand was that game saves and game data live in the same folder. If I didn't copy over everything then it would look like I have missing costumes, tracks, karts, custom levels. Some games even start you fresh as if it's a completely new save file. 

This is very apparent for titles like [LittleBigPlanet](https://littlebigplanet.fandom.com/wiki/LittleBigPlanet_2) 1 & 2, as well as [ModNation Racers](https://modnationracers.fandom.com/wiki/ModNation_Racers_Wiki) which has savedata for level progression and a separate "Game Data Utility" for user created content (such as costume designs, built levels, customized karts, etc.)
## ModNation Racers
I was looking in `/dev_hdd0/savedata` and `/dev_hdd0/<USER_ID>/savedata` but I've learned **Game Data Utility** lives in with `/dev_hdd0/<USER_ID>/game` with all other installed packages.

I looked to the **nopaystation** browser to find what ModNation Racer's Game ID was `NPUA80535`. Didn't realize the Blue-ray disc would have a different Game ID than the PSN release. 

When I tried to copy the disc to my internal drive I got a note `BCUS98167-[ModNation Racers] to internal HDD? `. Then I realized I should look into my `/dev_hdd0/<USER_ID>/game` and low and behold

```
/dev_hdd0/<USER_ID>/game/BCUS98167_UCC
```

And I know damn well sure that `UCC` stands for "User Created Content". I could have spared myself the headache and just backed up the whole `/game` directory. This whole explanation is to help anybody else who tried to mod their PS3 in an *efficient* way like me. 
## renew the license via PSN
Some titles still showed "renew the license via PSN". I'm pretty sure these were game shares I downloaded on different accounts. An old trick that is now biting me now years later. Not sure what fixed it, but I think it was booting into Safe Mode and "rebuilding the database" a 2nd time. Didn't have to verify the game on PSN. 

### Fake User

---
## Credit
- https://www.reddit.com/r/ps3homebrew/comments/mu7ern/backuprestore_dev_flash_via_ftp/
- https://www.reddit.com/r/ps3homebrew/comments/8ld0ul/restore_saves_with_filezilla/
- [TUTORIAL How to Activate Fake Save Data Owner on Rebug CFW](https://wololo.net/talk/viewtopic.php?t=45813)
- https://www.psx-place.com/resources/4-84-2-rebug-rex-cobra-8-1-cfw.1229/
- https://www.reddit.com/r/rpcs3/comments/oijb6o/mod_nation_racer_custom_content_issue/
- file:///G:/downloads_external/PS3%20Manual%20Backup%20(2020-04-19).pdf