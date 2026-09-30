---
{"dg-publish":true,"permalink":"/developer/emulation/choosing-the-right-os-to-put-on-new-anbernic-rg-34-xx-for-a-young-kid-gift/","tags":["emulation","retro","handheld","device"],"dg-note-properties":{"tags":["emulation","retro","handheld","device"]}}
---

> [!tip] So I just found out about BaseOS with NextUI
> Still in the testing phase but will find out if it is better. Literally just doing it to make screenshots work
> - BaseOS https://github.com/pvaibhav/BaseOS
> - https://github.com/pvaibhav/NextUI
> - Auto Sync https://kyaraben.org/download/
> - First Impressions: It comes with some nice upgrades to MinUI that put it on par with fully featured OSs but there are still some drawbacks like some plugins not working. All in all it is still a very good option for power users that want a little more out of MinUI. Still It still leaves the door wide open to more configuration and Tools (something I wish i could hide away with some parental mode)

Just recently picked up a [ANBERNIC RG 34XX](https://anbernic.com/products/rg34xx?variant=46272542376193) to play *homebrew* games on. I am gifting this to a young family member so I want to make menu navigation and game launching as easy as possible and not feel locked down behind a "parental control pin code". Installing  [MinUI](https://github.com/shauninman/MinUI) over the stock Anbernic OS seems to be the right choice (perfectly explained by [Zu from Retro Handheld](https://www.youtube.com/watch?v=i7i0sFCZwrc))

> MinUI is meant to be installed over a fresh copy of the stock Anbernic firmware.
> - MinUI README.md

Most instructions say to use the same SD card that came with the system (or copy all files onto a new card). The SD card that comes with the system is *SLOW*, taking over 3 hours to copy files onto a PC. I am going to ignore the pre-loaded roms and get a fresh image from the manufacture (that does not come with roms).
## Image new SD Card
https://anbernic.com/pages/system-update (search RG 34xx and install **RG 34XX-V1.0.6-EN16GB-260526** from the drive). They also supply a rufus.exe, but I'd just recommend getting it straight from https://rufus.ie/en/#download

You will download a zip file `RG34XX-V1.0.6-EN16GB-260526.IMG.7z`. when extracting remember to remove the `.IMG` extension as directories do not like that. Inside there will be the `RG34XX-V1.0.6-EN16GB-260526.IMG` that rufus can use.

This image is made for **16gb SD Cards**. You can partition the card to retain some storage, but for me it's easier to just get the 16gb sized card for the job. After you use rufus to burn the image on the card you will see a USB Device mount itself to your PC that looks like this

```powershell
PS E:\> Get-ChildItem -Directory -Depth 0

    Directory: E:\

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----         4/20/2022   1:45 AM                EXE
d-----         4/20/2022   1:45 AM                Music
d-----         4/20/2022   1:45 AM                Video
d-----         4/20/2022   1:45 AM                Ebook
d-----         4/20/2022   1:45 AM                Emu
d-----         4/20/2022   1:45 AM                PDF
d-----         4/20/2022   2:03 AM                save
d-----        10/12/2025  10:21 AM                Roms
d-----         4/20/2022   1:59 AM                anbernic
d-----         4/20/2022   1:58 AM                .config
```
## Install MinUI

> [!note] 2 SD Cards
> I will end up using 2 cards; TF1 for OS, TF2 for rom library.

grab the latest release of MinUI from their github 

https://github.com/shauninman/MinUI/releases (I grabbed both the **base** and **extras** zip files)

Extract both zips. In the **base** zip
### Preface
> MinUI has two essential parts: an installer/updater zip archive named "MinUI.zip" and a bootstrap file or folder with names that vary by platform.

If performing an update, just drop the `MinUI.zip` to the `TF2` card.
### RG Specific

> [!warning] rg35xxplus
> The RG 34XX uses the same chipset as the RG35XX Plus so make sure to use the `rg35xxplus/dmenu.bin`

This section pertains specifically to RG35XX PLUS / RG35XX H / RG35XX 2024 / RG28XX / RG35XXSP / RG40XXH / RGCUBEXX / RG34XX / RG34XXSP

> 1. Copy `/rg35xxplus/dmenu.bin` (just the file) to the root of the "NO NAME" partition `TF1/dmenu.bin` (FAT32 with an "anbernic" folder) of the TF1 card.
> 2. Copy "MinUI.zip" (without unzipping) to the root of the TF2 card `TF2/MinUI.zip`.
> - MinUI README.md

```shell
# TF1
anbernic
...
dmenu.bin
```

 Also copy your `Bios` and `Roms` into the `TF2/` card. You're on your own with bios and roms
### Updating Any Device

> Copy `MinUI.zip` (without unzipping) to the root of the SD card containing your Roms.

```shell
# TF2
Bios
Roms
...
MinUI.zip
```
### Optional Extras

>Remember when we also downloaded  MinUI-20240120b-1-extras.zip at the beginning? This contains extra systems and emulators that are not required, but you may want these to be added to your device. These systems are Neo Geo Pocket (and Color), Pico-8, Pokemon mini, Sega Game Gear, Sega Master System, Super Game Boy, TurboGrafx-16 (and TurboGrafx-CD), and Virtual Boy. Of course, I wanted these extra systems and I am sure you do too. 
>- [retrohandhelds jalanimal](https://retrohandhelds.gg/minui-for-rg35xx-plus-and-rg35xxh-guide/)

> Insert SD Card 2 back into your computer. Now go locate where you put the  MinUI-20240120b-1-extras.zip. Just like before, you are going to unzip this file. You are going to take all the contents of that file (Bios, Emus, Saves, Tools, Roms) and copy it to the base of the SD card you just inserted. Once this is finished, you can insert this back into your device and power it on.
### Box Art
The big bummer with *MinUI* is the manual boxart adding. The MinUI github says nothing about boxart (for some reason) but [RetroGamesCorp](https://retrogamecorps.com/2025/10/24/minui-starter-guide/#Install) explains how to do it.
#### Grab png images
Find art on either of these 2 sites.
- https://thumbnails.libretro.com/  (official boxart)
- https://www.steamgriddb.com/ (assorted art / fan art)

- Images must be in `png` file format.
- Resize the images using a tool like [ImageResizer](https://imageresizer.com/) (or [this one from RedKetchup](https://redketchup.io/bulk-image-resizer)) so that they are 200px in width for 480p displays, or 300px for higher resolution displays (TrimUI Brick). You can go up to 250px and 350px respectively but I think they cut off a little too much text in the menu.
- Place the images inside of a `.res` folder within each corresponding ROM folder, and rename the image so that it exactly matches the ROM file with extension. 

```shell
TF2/Roms/Game Boy (GB)/.res/Tennis (World).gb.png
```

you can even add am image for each specific system. Like a console model, or system logo.

```shell
TF2/Roms/.res/Game Boy (GB).png
TF2/Roms/.res/Game Boy Advance (GBA).png
```
### One List of Games
For a young kid, I want to slim down the menu to just *one single* column of games. No nesting of systems per folder. Here is how to do it. 

- Download the [latest release](https://github.com/retrogamecorps/Game-View/releases) and unzip it, place the “Game View.pak” folder in your SD card’s Tools > (name of device) folder. Most of the folder names are intuitive, but others are challenging (hint: my282 = Miyoo A30, my355 = Miyoo Flip, tg5040 = TrimUI Brick).
- Put the card on your device, navigate to Tools > Game View and enable it. You can disable the setup by repeating this process.
- Optionally, put the card back into your PC and rename the Tools folder to something like Tools_off so that it won’t show in the menu.
### Custom boot Logo
> The EXTRAS file from MinUI contains a Boot logo tool; if you go into Tools and run the Bootlogo tool, by default it will replace the device’s boot logo with a MinUI boot logo. You can also make your own custom boot logo if you’d like, which I explain in my [TrimUI Brick guide](https://retrogamecorps.com/2024/12/09/my-simple-trimui-brick-setup/).

> Note that after you run this tool, it will “self-destruct” and not appear again. To make it re-appear (like if you want to run the tool again with a new image), put the card back into your PC and go to Tools > (handheld folder) > Bootlogo.pak.disabled and remove the “.disabled” portion of the folder name.

> In addition to the Bootlogo tool, you will find a tool named “Remove loading” in the Tools menu. This will remove the “loading screen” when launching the system, so you can run this one time to have a cleaner experience.
## Trying out ROCKNix
I am a big fan of [[developer/emulation/Emulation Station\|Emulation Station]], and this OS delivers. Online scraping, beautiful themes, customizable UI.

While it *doesn't* provide any parental control, it does provide the best 1:1 experience if you're looking for a *close to* native experience. This maybe a good choice for a slightly older kid who does like to tinker with tech. [RockNix](https://rocknix.org/) played these GBA games very well.

1. Kirby Amazing Mirror
2. Yoshi's Island
3. Rhythm Tengoku
4. Wario Ware Micro Games.

This OS is very similar to [Knulli](https://knulli.org/), both using [[developer/emulation/Emulation Station\|Emulation Station]] front ends. It's a tight race, but I think ROCKNix wins because of it's more performant emulation.
## My short time with MuOS
Before ROCKNix I tried out [MustardOS](https://muos.dev/). the docs were easy to follow and get setup. The theme selection was nice, and I did try out some of the kiosk/kid modes. I did find the UI to still be clunky when locking it down. I *do not* want any button combos or "this system is in kiosk mode" to appear. I want the system to not to appear to have any roadblocks for the user and make them feel restricted. 
### Locking down with a password
manually edit the file on a PC.

`TF1/MUOS/info/pass.ini`

```ini
[code]
boot=FFFFFF
launch=000000
setting=FFFFFF

[message]
boot="Uncle Will 'Now is not the time to use that'"
launch="Uncle Will 'Now is not the time to use that'"
setting="Uncle Will 'Now is not the time to use that (settings)'"
```

### Kiosk Mode

> - Separate kiosk collection is done by creating a **`kiosk`** folder within collections then enable the kiosk mode option
> - Access by pressing **`L1 + R2 + Y`** on the config option in the main menu

## The Old School Way
I have mulled around with the idea of providing an even more authentic experience. One that uses real carts, no higher level menus, and a real power switch. This would require modding an original Game Boy Advance. We will see if I ever get to it.

- [Mod Kit]( https://godofgamingshop.com/products/game-boy-advance-v5-ips-full-mod-kit?variant=40780760547386)
- [Flash Writer](https://www.aliexpress.us/item/3256812044223752.html?spm=a2g0o.productlist.main.1.f7d7WfxhWfxhCd&algo_pvid=fdc13990-dd1c-4913-babb-54a7945d7840&algo_exp_id=fdc13990-dd1c-4913-babb-54a7945d7840-0&pdp_ext_f=%7B%22order%22%3A%22156%22%2C%22eval%22%3A%221%22%2C%22fromPage%22%3A%22search%22%7D&pdp_npi=6%40dis%21USD%2135.99%2119.99%21%21%21242.05%21134.46%21%402103117b17854498492854633e0f87%2112000058514189481%21sea%21US%210%21ABX%211%210%21n_tag%3A-29910%3Bd%3Acd65c572%3Bm03_new_user%3A-29895%3BpisId%3A5000000210792318&curPageLogUid=mCKx5wxTDZ99&utparam-url=scene%3Asearch%7Cquery_from%3A%7Cx_object_id%3A1005012230538504%7C_p_origin_prod%3A)
- [Blank Carts](https://www.aliexpress.us/item/3256811355762654.html?spm=a2g0o.productlist.main.3.f7d7WfxhWfxhCd&algo_pvid=fdc13990-dd1c-4913-babb-54a7945d7840&algo_exp_id=fdc13990-dd1c-4913-babb-54a7945d7840-2&pdp_ext_f=%7B%22order%22%3A%222656%22%2C%22eval%22%3A%221%22%2C%22fromPage%22%3A%22search%22%7D&pdp_npi=6%40dis%21USD%2131.86%216.28%21%21%21214.24%2142.22%21%402103117b17854498492854633e0f87%2112000059080412156%21sea%21US%210%21ABX%211%210%21n_tag%3A-29910%3Bd%3Acd65c572%3Bm03_new_user%3A-29895%3BpisId%3A5000000210792323&curPageLogUid=oz5834z7xhnA&utparam-url=scene%3Asearch%7Cquery_from%3A%7Cx_object_id%3A1005011542077406%7C_p_origin_prod%3A)

---
## Credit
- https://retrohandhelds.gg/minui-for-rg35xx-plus-and-rg35xxh-guide/
- https://www.youtube.com/watch?v=Fyd9JR2iV9M&t=62s
- https://community.muos.dev/t/what-copies-the-kiosk-ini-to-opt-muos-config/493/4