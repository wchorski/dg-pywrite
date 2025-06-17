---
{"dg-publish":true,"tags":["MacOs","mac","Apple","windows"],"permalink":"/developer/mac-os/mac-osx-drive-format-via-terminal/","dgPassFrontmatter":true}
---

I was moving data between a Macbook and Windows PC. For some reason the USB worked on the Windows PC but wouldn't **Initialize** in MacOS making the drive unreadable. 

Making matters worse, attempting to reconnect the drive back to the Windows machine asked for repair / reformat of the drive.

> [!warning] GUI Formatting Tools
> Both the Windows and Mac built in disk utilities GUI tools either did not respond or did not fix the problem in a persisting way.

## Tried on Windows First
I attempted to format the drive with Windows `DISKPART` but that didn't work [[developer/Windows 10/Windows 10 Drive Format via Terminal\|Windows 10 Drive Format via Terminal]]

## MacOs diskutil

First, look at the partition table by running this command:

```
diskutil list
```

You should see something like this:

```
/dev/disk6 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     Apple_partition_scheme                        *4.1 GB     disk6
   1:        Apple_partition_map                         4.1 KB     disk6s1
   2:                  Apple_HFS                         2.7 MB     disk6s2
                    (free space)                         4.1 GB     -
```

The partition we want to change is `/dev/disk1`.

We want to change the device to an MBR-formatted FAT32 partition. To do that, run this command:

```
diskutil eraseDisk FAT32 "DT8GB" /dev/disk6
```

where _`NAME`_ is the name you want to give to the disk.

**Output**
```
Started erase on disk6
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk6s2 as MS-DOS (FAT32) with name DT8GB
512 bytes per physical sector
/dev/rdisk6s2: 14915088 sectors in 1864386 FAT32 clusters (4096 bytes/cluster)
bps=512 spc=8 res=32 nft=2 mid=0xf8 spt=32 hds=255 hid=411648 drv=0x80 bsec=14944256 bspf=14566 rdcl=2 infs=1 bkbs=6
Mounting disk
Finished erase on disk6
```

As mentioned in the comments, you cannot put square brackets into the volume's name lest things mess up. To avoid having everything fail, simply ensure that there are no square brackets in the FAT32 volume's new name.

Note: The _`NAME`_ can fail if not UPPERCASE in many cases.

---
## Credit
- https://superuser.com/questions/527657/how-do-you-format-a-2-gb-sd-card-to-fat32-preferably-with-disk-utility