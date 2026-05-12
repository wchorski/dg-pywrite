---
{"dg-publish":true,"tags":["linux","files","filesystem","zfs","pool"],"permalink":"/developer/linux/troubleshooting-slow-sluggish-read-write-speeds/","dgPassFrontmatter":true}
---

## Diagnose
```shell
top
```

The number we care about most is `60.8 wa`. This number should over around and below `10`. If this number is regularly printing above `30` or hitting `80` there is a deep problem with disk read and writes.

```shell
top - 21:47:12 up  3:05,  4 users,  load average: 2.90, 3.15, 2.95
Tasks: 351 total,   1 running, 350 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.8 us,  5.0 sy,  0.0 ni, 67.2 id, 24.8 wa,  0.0 hi,  0.3 si,  0.0 st
MiB Mem :  32056.8 total,    424.7 free,  25928.6 used,   6531.7 buff/cache
MiB Swap:   2002.2 total,   1976.2 free,     26.0 used.   6128.2 avail Mem
```

```shell
sudo dmesg -T | grep -i ata
```

This will reveal if there is any problems with SATA drives

```shell
[Tue May  5 18:42:03 2026] BIOS-e820: [mem 0x0000000087352000-0x000000008737cfff] ACPI data
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000000059000-0x000000000009ffff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000000100000-0x000000007e284017] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e284018-0x000000007e295057] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e295058-0x000000007e296017] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e296018-0x000000007e2a6857] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e2a6858-0x000000007e2a7017] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e2a7018-0x000000007e2c6857] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000007e2c6858-0x00000000832f7fff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000832f8000-0x00000000832f8fff] ACPI NVS
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000832f9000-0x0000000083342fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000083343000-0x0000000083394fff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000083395000-0x00000000838b5fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000838b6000-0x000000008701bfff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000008701c000-0x0000000087351fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000087352000-0x000000008737cfff] ACPI data
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x000000008737d000-0x0000000087b67fff] ACPI NVS
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000087b68000-0x0000000087ffefff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000088000000-0x00000000880fffff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[Tue May  5 18:42:03 2026] reserve setup_data: [mem 0x0000000100000000-0x00000008767fffff] usable
[Tue May  5 18:42:03 2026] ACPI: SSDT 0x0000000087B498B8 00036D (v01 SataRe SataTabl 00001000 INTL 20120913)
[Tue May  5 18:42:03 2026] NODE_DATA(0) allocated [mem 0x8767d5680-0x8767fffff]
[Tue May  5 18:42:03 2026] MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
[Tue May  5 18:42:03 2026] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[Tue May  5 18:42:03 2026] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[Tue May  5 18:42:03 2026] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[Tue May  5 18:42:03 2026] Memory: 32765000K/33507644K available (16384K kernel code, 2497K rwdata, 11800K rodata, 4164K init, 4920K bss, 731152K reserved, 0K cma-reserved)
[Tue May  5 18:42:04 2026] Write protecting the kernel read-only data: 28672k
[Tue May  5 18:42:04 2026] Freeing unused kernel image (rodata/data gap) memory: 488K
[Tue May  5 18:42:04 2026] libata version 3.00 loaded.
[Tue May  5 18:42:04 2026] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[Tue May  5 18:42:04 2026] ata1: SATA max UDMA/133 abar m2048@0xdf24b000 port 0xdf24b100 irq 138 lpm-pol 3
[Tue May  5 18:42:04 2026] ata2: SATA max UDMA/133 abar m2048@0xdf24b000 port 0xdf24b180 irq 138 lpm-pol 3
[Tue May  5 18:42:04 2026] ata3: SATA max UDMA/133 abar m2048@0xdf24b000 port 0xdf24b200 irq 138 lpm-pol 3
[Tue May  5 18:42:04 2026] ata4: SATA max UDMA/133 abar m2048@0xdf24b000 port 0xdf24b280 irq 138 lpm-pol 3
[Tue May  5 18:42:04 2026] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[Tue May  5 18:42:04 2026] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[Tue May  5 18:42:04 2026] ata3.00: ATA-10: WDC WD80EFPX-68C4ZN0, 81.00A81, max UDMA/133
[Tue May  5 18:42:04 2026] ata4.00: ATA-10: WDC WD80EFPX-68C4ZN0, 81.00A81, max UDMA/133
[Tue May  5 18:42:04 2026] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[Tue May  5 18:42:04 2026] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[Tue May  5 18:42:04 2026] ata2.00: ATA-10: WDC WD80EFPX-68C4ZN0, 81.00A81, max UDMA/133
[Tue May  5 18:42:04 2026] ata3.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[Tue May  5 18:42:04 2026] ata3.00: Features: NCQ-prio
[Tue May  5 18:42:04 2026] ata4.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[Tue May  5 18:42:04 2026] ata4.00: Features: NCQ-prio
[Tue May  5 18:42:04 2026] ata1.00: ATA-9: Dogfish SSD 512GB, U0205A0, max UDMA/133
[Tue May  5 18:42:04 2026] ata2.00: 15628053168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[Tue May  5 18:42:04 2026] ata2.00: Features: NCQ-prio
[Tue May  5 18:42:04 2026] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth 32), AA
[Tue May  5 18:42:04 2026] ata1.00: configured for UDMA/133
[Tue May  5 18:42:04 2026] scsi 0:0:0:0: Direct-Access     ATA      Dogfish SSD 512G 5A0  PQ: 0 ANSI: 5
[Tue May  5 18:42:04 2026] ata3.00: configured for UDMA/133
[Tue May  5 18:42:04 2026] ata4.00: configured for UDMA/133
[Tue May  5 18:42:04 2026] ata2.00: configured for UDMA/133
[Tue May  5 18:42:04 2026] scsi 1:0:0:0: Direct-Access     ATA      WDC WD80EFPX-68C 0A81 PQ: 0 ANSI: 5
[Tue May  5 18:42:04 2026] scsi 2:0:0:0: Direct-Access     ATA      WDC WD80EFPX-68C 0A81 PQ: 0 ANSI: 5
[Tue May  5 18:42:04 2026] scsi 3:0:0:0: Direct-Access     ATA      WDC WD80EFPX-68C 0A81 PQ: 0 ANSI: 5
[Tue May  5 18:42:16 2026] EXT4-fs (sda2): mounted filesystem 764994f8-7692-4316-8cb9-639cd9683c40 ro with ordered data mode. Quota mode: none.
[Tue May  5 18:44:48 2026] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[Tue May  5 20:02:36 2026] EXT4-fs (sde): mounted filesystem f2a2e77d-fd69-4fd3-b3f5-4742108f6c7d r/w with ordered data mode. Quota mode: none.
```

```shell
❯ lsblk -f
NAME   FSTYPE     FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1 vfat       FAT32          2FE5-2BC7                             506.6M     1% /boot/efi
├─sda2 ext4       1.0            764994f8-7692-4316-8cb9-639cd9683c40  251.2G    41% /
└─sda3 swap       1              0d3f6419-b0f3-4e26-abd5-d18547743eef                [SWAP]
sdb    zfs_member 5000  snowbank 9953601311402122921
└─sdb1 zfs_member 5000  snowbank 9953601311402122921
sdc    zfs_member 5000  snowbank 9953601311402122921
└─sdc1 zfs_member 5000  snowbank 9953601311402122921
sdd    zfs_member 5000  snowbank 9953601311402122921
└─sdd1 zfs_member 5000  snowbank 9953601311402122921
sde    ext4       1.0            f2a2e77d-fd69-4fd3-b3f5-4742108f6c7d    539G    36% /mnt/snowbank-BACKUP
```

```shell
zpool status -v snowbank
  pool: snowbank
 state: ONLINE
  scan: resilvered 11.1M in 00:00:01 with 0 errors on Tue May  5 16:22:22 2026
config:

        NAME            STATE     READ WRITE CKSUM
        snowbank        ONLINE       0     0     0
          raidz1-0      ONLINE       0     0     0
            snowdisk-1  ONLINE       0     0     0
            snowdisk-2  ONLINE       0     0     0
            snowdisk-3  ONLINE       0     0     0

errors: No known data errors
```