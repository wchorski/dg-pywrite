---
{"dg-publish":true,"permalink":"/developer/Windows 10/Windows 10 Clean Drive of Recovery and EFI System Partitions/","noteIcon":""}
---

The Window's **Disk Management** GUI tool prevents you from deleting *Recovery* and *EFI System* Partitions for your own safety. If you're like me, cleaning off a drive for different use, but still having a hanging *100 MB* partition on a 1tb drive just digs under your skin.

Lucky for us, there is a built in CLI tool in **Windows**. For those who are extra paranoid of deleting the wrong drive, open up the **Disk Management** GUI and you'll see which disk number to what drive.  

## TL:DR commands

Run `diskpart`

```shell
list disk
set disk NUMBER

list partition
sel partion NUMBER

delete partition override
```

## Combined Drives (Striping vs Spanning)

There's a way to combined smaller drives and be read as one big drive. This was very useful back in the day where large drives were expensive. Ask yourself this, is managing a couple 500gb / 1tb drives cause much overhead? I'd recommend keeping the drives separate as combined drives rely on each other. Meaning, if one fails the other goes down with it. If you're still gung-ho on the combo I've linked some tuts in the credits.  

---
## Credits
- [How to combine multiple hard drives into one volume on Windows 10 | Windows Central](https://www.windowscentral.com/how-create-one-large-volume-using-multiple-hard-drives-windows-10)
- [Is spanned or striped volume more safe and reliable? - Storage Devices - Linus Tech Tips](https://linustechtips.com/topic/1369788-is-spanned-or-striped-volume-more-safe-and-reliable/)
- [[tomshardware.com)](https://www.tomshardware.com/how-to/delete-efi-system-partition-windows\|How to Delete the EFI System Partition in Windows 10 or 11 ]]

## Backlinks
- [[developer/Windows 10/Microsoft Windows\|developer/Windows 10/Microsoft Windows]]