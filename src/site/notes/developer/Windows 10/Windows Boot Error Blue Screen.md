---
{"dg-publish":true,"permalink":"/developer/windows-10/windows-boot-error-blue-screen/","noteIcon":""}
---

Nothing like getting home from a full day of work to boot up your home [[developer/Windows 10/Microsoft Windows\|developer/Windows 10/Microsoft Windows]] 10 PC and see the blue screen of death.


![attachments/Recovery-Blue-Screen-Error-0x0000185-1 2.jpg|Recovery-Blue-Screen-Error-0x0000185-1](/img/user/attachments/Recovery-Blue-Screen-Error-0x0000185-1%202.jpg)

This particular situation was because of a corrupted UEIF partition. With a bit of digging I found this [video tutorial](https://www.youtube.com/watch?v=CZ17JrgFFhw)from **CyberCPU Tech** that saved my bacon.

## Create Installation USB 
Before anything, you must create [a Bootable Windows 10 USB Drive](https://www.howtogeek.com/787937/how-to-make-a-bootable-windows-10-usb-drive/). Meaning you'll need a working computer to fix the broken one. This Bootable USB will get you into the console and and fix the corrupted partition. Get the the download [directly from Microsoft](https://support.microsoft.com/en-us/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d)

## Boot from USB
I'll also assume you know how to boot from this newly created USB install media. Assume your computer will continue to attempt to boot from the bad drive until you tell your computer to [boot from the USB instead](https://www.digitalcitizen.life/boot-your-windows-10-pc-usb-flash-drive/)

## Media Creation Tool
After you pick your language, you'll end up at this window
![attachments/Windows-Repair-computer 1.png|Windows-Repair-computer](/img/user/attachments/Windows-Repair-computer%201.png)

Continue through the menu with **Troubleshoot -> Command Prompt**. You could attempt the **Startup Repair** option and hope for the best, but I assume you already tried that.

## Terminal
Now you should have a console open like below

```
X:\Sources>
```

Run `bcdedit` and give that a look through. This isn't necessary for the fix, but seeing what changes could help you understand what went wrong.

Now I'm gonna rattle off the commands used to look at the disk parts and fix the partitions

```shell
# run the diskpart cli tool
diskpart

# see what disks are availabe
list disk
# select the disk that you insalled Windows on. 
# if you don't know, you may have to turn off the
# machine and remove all drives other than the Windows drive
# you're attempting to fix
sel disk 0

# look for the UEFI partion.
# It won't have a drive `ltr`, FAT32, 100MB
list vol
sel vol 1
# assign it to an arbitrary letter 
# (one that isn't being) used by another drive
assign letter=v

format V: /fs:fat32
bcdboot c:\windows /s v: /f UEFI

# Volume Label can be set to nothing by pressing 'Enter'
```

---
## Credits
- [Windows 10 and 11 Wont Boot, How To Fix UEFI Partition - YouTube](https://www.youtube.com/watch?v=CZ17JrgFFhw)

## Backlinks
- 