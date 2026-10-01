---
{"dg-publish":true,"permalink":"/developer/windows-10/windows-10-drive-format-via-terminal/","tags":["windows","microsoft"],"noteIcon":"","created":"2026-09-16T10:46:30.000-05:00","updated":"2026-09-16T10:46:30.000-05:00","dg-note-properties":{"tags":["windows","microsoft"]}}
---

```
diskpart
```

- Next, type the command below and hit Enter:

```
list disk
```

The command will list all the hard drives on your computer.

- Next, type the command below and hit Enter:

```
select disk 3
```

Here, disk 3 is the flash drive plugged into the system. Be sure to select the number that corresponds to the flash drive inserted in your system.

- Next, type the command below and hit Enter:

```
 list partition
```

The command will list all the partitions on the USB flash drive.

- Next, type the command below and hit Enter:

```
 select partition 1
```

In this case, we assume partition 1 is the partition we want to delete. Make sure to select the number that corresponds to the partition on your flash drive.

- Finally, type the command below and hit Enter:

```
delete partition
```

---
## Credit
- https://www.thewindowsclub.com/delete-volume-option-is-greyed-out-for-usb-flash-drive
- [[developer/Windows 10/Windows Index\|Windows Index]]