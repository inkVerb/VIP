# Linux 601
## Lesson 7: Disk & Partitioning

### [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)

___

# The Chalk
## Important Terms
- **Physical drives** can be held in your hand and plugged into a computer via SATA, NVMe, mSATA, or USB ports
- **Partition tables** are created with `fdisk`, formerly using **MBR**, but should use **GPT** on machines made after 2010
- **Partitions** are large sections of a disk created with `fdisk`, listed on the disk's partition table, unformatted and empty
- **Filesystems** are formatted partitions of different types, such as **ext4**, **FAT32**, **swap**, **NTFS**, etc
- **Virtual Filesystem** is a software layer that interacts directly with the physical disk; most filesystems use this so apps can operate easily

## Inodes
- Every file has one **inode**
- Hard vs soft links
  - Hard link: both files share the same **inode**
  - Soft link: points to other file, each with its own **inode**
- Every **inode** has:
  - Inode number
  - Permissions
  - Ownership
  - Size
  - Any hardlink info
  - Timestamps
    - Access
    - Modified contents
    - Changed inode info
- In the filesystem **directory**
  - **Filename** with matching **inode** number
- `ls -i` to output files with matching **inode** numbers

## Partition Tables
- `fdisk` creates partition tables (MBR or GPT) and their partitions
  - Partitions created with `fdisk` are later formatted to NTFS, etx4, swap, or other filesystem types with `mkfs.*` and `mk*` commands
  - Whether formatted with `mkfs.*` or not, these partitions are often called "**physical volumes**"
- MBR (Master Boot Record)
  - From MSDOS era, created in 1983
  - Max partition size: 2TB
  - 4 "primary" partitions max
    - "Extended" partition: More than 4 partitions requires one be an "extended" partition
    - "Logical" partition: each partition in the extended partition, 15 logical partitions max
  - Head size: 512 bytes
    - 446 byte boot record
    - 64 byte partition table, 16 bytes per entry, 4 entries max
      - Active bit
      - Start address in CHS format (Cylinder-Head-Sectors)
      - Partition type code (`LVM`, `ntfs`, `ext4`, `swap`, etc)
      - End address in CHS format
      - Number of sectors in partition
    - 2 byes at end with value "`0x55AA`" (AKA 'magic number', 'signature word', 'end of sector marker')
- GPT (GUID Partition Table)
  - Based on UEFI (Unified Extensible Firmware Interface), developed in the late 1990s by Intel
  - Max partition size: 2<sup>33</sup>TB
  - 128 "primary" partitions max
    - No need for extended or logical partitions
  - Head size: 33 sectors
    - Two copies: beginning and end of disk
    - Protective MBR: 512 bytes (for backward MBR-system compatibility)
    - Primary GPT header: 512 bytes
    - Partitions entries starting with 1: 128 bytes each
    - Partitions
    - Duplicate partition entries starting with 1: 128 bytes each
    - Secondary GPT header: 512 bytes

## Filesystems
- **FAT32 (File Allocation Table 32 bit cluster entries)**
  - Format command: `mkfs.fat -F 32 /dev/sdb1`
  - Created August 1996 by Microsoft to replace FAT16 (1984)
  - Volume max: 2TB
  - File max: 4GB
  - Used for `/boot/efi` partition when installing Linux
  - Used on many USB drives, but not required
- **ntfs**
  - Format command: `mkntfs /dev/sdb1`
  - Created 1993 for Windows NT
  - Journaling file system with three file allocation tables
  - Volume max: 8PB (1PB = 1024TB)
  - File max: 16TB
  - Supports ACLs, encryption, transparent compression
  - Very usable by Linux, but not fully preferred by the Linux kernel, especially for Linux to reside on
- **ext4**
  - Format command: `mkfs.ext4 /dev/sdb1`
  - Created Christmas Day 2008 to replace ext3 for Linux
  - Journaling filesystem
  - Can host swap files
  - Volume max: 1EB (1EB = 1024PB)
  - File max: 16TB
  - Extents: group of contiguous blocks
  - Blocks: 4KB default size, can be any size not larger than one page of RAM (4KB on x86 systems)
  - Checksum: journal and avoid I/O waiting
  - Timestamps: nanoseconds
  - Layout:
    - Block Group 0 (unused, reserved for boot sectors, etc)
    - Superblock (1st block, AKA block 0)
      - Mount count and its max for filesystem check (otherwise 180 days at least)
      - Filesystem block size (sets max count of blocks, superblocks, inodes)
      - Blocks per group
      - Free Block count
      - Free Inode count
      - OS ID
      - *This superblock is redundantly copied in multiple block groups*
    - Group Descriptors (copy of 1st block used for FS checks)
    - Data Block Bitmap
    - Inode Bitmap
    - Inode Table (in blocks)
    - Data Blocks (in blocks)
  - Tools
    - `dumpe2fs` (output FS info for ext2/3/4 volumes)
      - `dumpe2fs /dev/sdb1`
      - `dumpe2fs /dev/sdb1 | grep superblocks`
    - `tune2fs` (adjust FS parameters for ext2/3/4 volumes)
      - `tune2fs -c 28 /dev/sdb1` (change FS check mount count)
      - `tune2fs -c 10 /dev/sdb1` (change FS time `interval-between-checks`)
      - `tune2fs -l /dev/sdb1` (list superblock and parameters; abbreviated output from `dumpe2fs`)
- **btrfs ("Better Filesystem")**
  - Format command: `mkfs.btrfs /dev/sdb1`
  - Created 2007 to provide "better" convenience for Linux
  - Journaling filesystem
  - **Cannot** host swap files without a subvolume `sudo btrfs subvolume create @swap`
  - Volume max: 16EiB (1EiB = 1.152EB)
  - File max: 16EiB
  - Newer and rapidly developing
  - Supposedly easy to resize live
  - Fragmentation can become an issue as of 2024
- **LMV (Logical Volume Manager)**
  - Purpose
    - Extends physical disks and partitions (volumes) with separate "extended" physical disks
    - Back up volumes
    - Easily resize volumes by annexing parts of other physical volumes
    - Encrypt multiple volumes with one password
    - Can contain multiple partitions using different types of filesystems
  - Elaboration in another section of this lesson
- **swap** (Virtual RAM in Linux)
  - Format command: `mkswap /dev/sdb1`
  - Windows uses a managed "pager file" instead of swap
- **Pseudo-Filesystems (Reside only in RAM)**
  - proc
  - sysfs
  - devfs
  - debugfs

## Data Duplicator Tool
- `dd` Disk/Data/Device Duplicator: copies raw data
  - The `if=` input source almost always must be in `/dev/` folder
  - Only duplicates raw data 
  - This command is useful for low-level copies such as: backing up low-level system data like an MBR, creating empty files for swap or NBD serving, overwriting a disk, copying a damaged partition for later recovery, or even copying an entire partition table or physical drive, etc
- `dd` is a copy process that copies direct data
- It skips some of the file system interaction
- It can be used to create a large empty file, such as for a swap file
- It reads `/dev/urandom` and writes to `/dev/null` unless told to write somewhere else, like a swap file
- Swap creation example: `dd if=/dev/zero of=/var/swap.img bs=2M count=1024` (2 GB empty swap file)
  - `if=` input file
  - `of=` output file
  - `bs=` block size
  - `count=` number of blocks
  - `conv=fdatasync` verify proper flush caching, for burning to a device from `.iso` file
  - `status=progress` for watching pots boil
- Other examples:
  - `dd if=/dev/sda of=/dev/sdb` - Backup/restore `sda` to `sdb`
  - `dd if=/dev/sda of=sda.img` - Backup `sda` to an `.img` file
  - `dd if=/dev/sda1 of=sda1.img` - Backup the `sda1` partition to an `.img` file
  - `dd if=sda1.img of=/dev/sda10` - Restore the `sda1` partition from an `.img` file
  - `dd if=/dev/cdrom of=cddrive.iso bs=2048` Copy CD-ROM to `.iso` file
  - `dd if=some_file.iso of=/dev/sdf bs=4M conv=fdatasync status=progress` (burn `.iso` file to USB at `/dev/sdf`)
- `dd` doesn't understand directories, only raw data from devices and output to either devices or `.img`/`.iso` files

## Information
### Files
- `ls` list file attributes
  - `ls -lh ~/` list home folder long format human readable
  - `ls -a` list current directory all (including hidden) files
- `ln` link
  - `ln -s` symbolic link (not hard link)
  - `ln -n` no-deference
  - `ln -f` force suppress most error messages

### Second Extended Filesystem
- Four namespaces
  - User
  - Trusted
  - Secutiry (SELinux)
  - System (Access Control Lists)
- File Flags
  - `a` Append-only: only append (`>>`)
  - `A` no `atime` update: access time will not be modified
  - `d` no-Dump: ignored by `dump`, useful for swap or cache files
  - `e` uses Extents for mapping blocks; cannot be removed via `chattr`
  - `E` Enctrypted
  - `i` Immutable: no modification allowed, even by `root`, no link, delete, rename; `su`/`root` can change this
  - `s` When deleted, blocks are zeroed
  - `u` Undelete allowed by user, contents saved on delete
- Tools
  - `lsattr` list attributes
  - `chattr` change attributes
    - Command Flags
      - `-R` recursive
      - `-V` verbose
      - `-f` force suppress most error messages
      - `-v` set file version number
      - `-p` set file project number

### Size
- `du` Directory Use (permissions-relevant)
  - `-h` Human-readable, ie: G, M, K, etc
  - `-s` only Size of parent directories, not subdirectories
  - `-x` eXclude other file systems, such as other mounted drives
  - `-c` Calculate total
  - **Permissions matter!**
    - For `/` you need `sudo` or run as root with `su`
  - Standard command:
    - **`du -shcx *`**
- `df` Disk Filesystem use (of mounted filesystems/partitions only)
  - `-h` Human-readable (default)
  - `-k` liKe blocks (1 block = 1 kilobyte)
  - `-T` list Type
  - `df` (each disk)
  - `df .` (current disk)

### Block Volumes
- `lsblk` (list block volumes, including dev path)
    - `lsblk -f` (also label, UUID, size, use)
- `blkid /dev/sda1` (get UUID of `/dev/sda1`)
- `ls -lh /dev/disk/by-uuid/`

## Partitioning
- Changes & status
  - `partprobe -s` Inform OS of partition table changes
    - Update OS with new partition info, but reboot is more reliable
  - `cat /proc/partitions` live partitions for OS
  - `fdisk -l /dev/sda` (only display partition info, non-interactive, same as `p` within the menues)
- MBR & GPT Tools
  - `fdisk /dev/sda` (interactive)
    - `m` help Menu
    - `p` Partition table info *(includes pending changes)*
    - `g` new GPT partition table
    - `o` new DOS partition table *(same as MBR)*
    - `n` New partition
    - `d` Delete partition
    - `t` change partition Type
    - `w` Write and exit
    - `q` Quit without changes
  - `sfdisk` (non-interactive)
- GPT fdisk Tools
  - `gdisk` (interactive)
  - `sgdisk` (non-interactive)
- GNU Tools
  - `parted` (CLI)
  - `gparted` (GUI)

### Create Partitions
1. **Create a new partition table and partitions on the physical disk**
- `m` for help to understand the interactive commands (both `fdisk` and `gdisk`)
- You may follow along graphically in GParted
- This assumes a physical disk at least 447G or larger
- **Via `fdisk`**
```console
sudo fdisk /dev/sdb
```
  - GPT (preferred)
    - `g` <key>Enter</key>
    - Create partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` <key>Enter</key> or whatever size you want, on final partition <key>Enter</key> for default
        - On second-last partition, swap being final, `-16G` would use everything but the last 16G
      - ? `y` <key>Enter</key> if asked to remove the signature (overwriting a existing filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - `w` (write changes and move on) or `q` (quit and abort, if this was just an exercise)
  - MBR (legacy)
    - `o` <key>Enter</key> (DOS is the same as MBR for partition tables)
    - Create partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default `p` for primary partition)
        - Or `e` *Note **MBR logical partitions** (in an **extended container**) are not the same as **LVM logical volumes***
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` <key>Enter</key> or whatever size you want, on final partition <key>Enter</key> for default
        - On second-last partition, swap being final, `-16G` would use everything but the last 16G
      - ? `y` <key>Enter</key> if asked to remove the signature (overwriting a existing filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - Change a partition type to Linux swap?
      - `t`
      - ? <key>Enter</key> if asked (default, the partition we just created or enter a preferred partition number)
        - It is good practice for Linux swap to be the last partition made, at the end of the disk, in which case you would use the default here anyway
      - ? `L` <key>Enter</key> will list type choices (if you are curious)
        - `19` for Linux swap
        - `swap` alias for Linux swap
        - FYI code `83` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `19` or `swap`, <key>Enter</key>
    - Change a partition type for NTFS or FAT32?
      - *Note any type will work with for NTFS or FAT32, this is moot and merely being excessively finicky*
        - *Being excessively finicky, if you are preparing a recovery partition or EFI partition for Windows, you might consider researching other Microsoft partition types*
      - `t` <key>Enter</key>
      - ? <key>Enter</key> if asked (default, the partition we just created or enter a preferred partition number)
        - It is good practice for Linux swap to be the last partition made, at the end of the disk, in which case you would use the default here anyway
      - ? `L` <key>Enter</key> will list type choices (if you are curious)
        - `11` for Microsoft basic data
        - FYI code `83` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `11` <key>Enter</key>
    - `w` <key>Enter</key> (write changes and move on) or `q` <key>Enter</key> (quit and abort, if this was just an exercise)
- **Via `gdisk`**
```console
sudo gdisk /dev/sdb
```
  - GPT (only option)
    - `o` <key>Enter</key>
    - `y` <key>Enter</key>
    - Create partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` <key>Enter</key> or whatever size you want, on final partition <key>Enter</key> for default
        - On second-last partition, swap being final, `-16G` would use everything but the last 16G
      - ? `L` <key>Enter</key> <key>Enter</key> will list type choices (if you are curious)
        - FYI code `8300` is for Linux filesystem (the default type)
        - FYI code `8200` is for Linux swap
        - FYI code `0700` is for Microsoft basic data (NTFS & FAT32)
      - <key>Enter</key> (default `8300` Linux filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - `w` <key>Enter</key> (write changes and move on) or `q` <key>Enter</key> (quit and abort, if this was just an exercise)
2. **Format the partitions just made**
Any of the one-line commands will work in the **Formatting** section

### Formatting
- `mkfs`: #
  - Use the extension for the drive type
    - Get an easy list: `ls -lh /bin/mkfs*`
  - `mkfs.ext4 /dev/sdb1`
  - `mkfs.btrfs /dev/sdb1`
  - `mkfs.fat -F32 /dev/sdb1` (for FAT 32, such as EFI boot partition)
  - `mkntfs /dev/sdb1` (`/bin/mkfs.ntfs -> /bin/mkntfs`, not on Arch)
  - `mkswap /dev/sdb1` (`/bin/mkfs.swap -> /bin/mkswap`, not on Arch)

### Mounting
- `fstab` automatic mounts at boot
  - `<file system>`
    - `/dev/sdb1`
    - `UUID=s0me-l0ng-n0mb3r` (find via `lsblk -f` or `blkid /dev/sdb1`)
    - `tmpfs` for temp filesystem managed by the system
    - `inkisaverb.com:/publicdir` for network filesystems
  - `<mount point>`
    - Any existing directory
    - `/mnt/mydrive`
    - `/`
    - `/home`
    - `/boot/efi` for the 300M FAT32 boot partition
    - `/tmp`
    - `none` for swap
  - `<type>`
    - `ntfs`
    - `ext4`
    - `tmpfs`
    - `vfat` for all FAT systems including FAT32
    - `swap`
    - `nfs` Network File System (NFS)
    - `bind` serves as a hard link
  - `<options>`
    - `umask=0077` for `/boot/efi`, learn about `umask` in [Lesson 6](https://github.com/inkVerb/vip/blob/master/601/Lesson-06.md)
    - `defaults,noatime` most normal filesystems
    - `defaults,noatime,mode=1777` `tmpfs`
    - `noatime` same as `lsatt` `A`, don't log access timestamp to files when not modified, this can same I/O cost
    - `rw` read-write
    - `rsize=8192,wsize=8192,timeo-14,intr` for network filesystems like NFS
    - `noauto` in case a drive isn't yet available at mount time (ie NFS)
    - `netdev` specifically for network drives
    - `nofail` do not report errors of device does not exist
    - `bind` for `bind` types
    - `bootwait` boot up will hold up for this filesystem to be available
    - `nobootwait` boot up will not wait for this filesystem to be available
    - `optional` ignore if type is not known at boot time
    - `showthrough` can be mounted before its parent becomes available
    - `x-systemd` options
      - `x-systemd.automount` use the `automount` facility
      - `x-systemd.automount.device-timeout=5` timeout after 5 seconds if device is not available
      - `x-systemd.automount.idle-timeout=60` unmount if device is not used for 60 seconds
      - `x-systemd.required-by=php-fpm.service` make sure this filesystem is mounted before starting the `php-fpm` service
  - `<dump> <pass>` (should dump? | fsck k priority during startup?)
    - `0 2` common for `/boot/efi`, `/home` and other mount points
    - `0 1` for root mount point `/`
    - `0 0` for `tmpfs` and `nfs`
  - Examples
```
<file system>           <mount point>    <type>  <options>                <dump> <pass>
UUID-ABCD-1234          /boot/efi        vfat    umask=0077               0      2
UUID=s0me-l0ng-n0mb3r   /                ext4    defaults,noatime         0      1
/dev/sdb2               /home            ext4    defaults,noatime         0      2
/dev/sdc1               /mnt/bigstuff    ntfs    defaults,noatime,nofail  0      2
/mnt/bigstuff/jesse     /home/jesse/big  bind    defaults,bind            0      0
/mnt/bigstuff/louis     /home/louis/big  bind    defaults,bind            0      0
tmpfs                   /tmp             tmpfs   defaults,noatime,mode-1777  0 0
inkisaverb.com:/pubdir  /mnt/ink-pub     nfs     netdev,noauto,rsize=8192,wsize=8192,timeo-14,intr  0 0
```
- `mount` #
  - The mount point directory must exist
    - If the mount point directory contains files, they will be inaccessible until unmounted
  - `mount` shows mounted filesystems
  - `mount /dev/sdb2 /home` mounts the `/home` folder
  - `mount -t ext4 /dev/sdb5 /mnt/mydrive` specifying the `ext4` type is only needed if OS doesn't understand the filesystem type
  - `mount UUID=s0me-l0ng-n0mb3r /mnt/mydrive`
  - `mount LABEL=Thumbstick /mnt/thumbdrive`
  - `mount inkisaverb.com:/publicdir /mnt/netdir`
  - `mount -o remount,rw /` remounts the root filesystem as read-write (in case it was read-only)
  - `mount -o remount,ro /dev/sdb4` remounts the sdb4 filesystem as read-only (in case it was read-write)
  - `mount -a` mounts all filesystems listed in `/etc/fstab`
- `umount` unmounts a filesystem
  - Note there is no `un` in `umount`, a common oversight
  - `umount /dev/sdb4` (device)
  - `umount /home` (mount point)
- `automount` (not on Arch)
- `findmnt` outputs the `/etc/fstab`-formatted mount entry for the argued device
  - `findmnt /dev/sdb1`

### Partition Backup & Restore
- The Master Boot Record is only the first 512 bytes, so making a `dd` copy of the first 512 bytes (`bs=512 count=1`) will copy the MBR perfectly
  - MBR backup: `dd if=/dev/sdb of=mbrbackup bs=512 count=1`
  - MBR restore: `sudo dd if=mbrbackup of=/dev/sdb bs=512 count=1`
- Overwrite a partition with zeros: `dd if=/dev/zero of=/dev/sdb1 bs=4096 status=progress`
- GPT tool: `sudo sgdisk -O /dev/sdb` or `sudo sgdisk -p /dev/sdb`

## LMV (Logical Volume Manager)
- `man lvm` shows all tools (including `vgcreate`, `pvcreate`, etc, which simlink back to `/sbin/lvm`)
  - `ls -l /bin/gv*`
  - `ls -l /bin/pv*`
- `ls -l /sbin/lv*` shows LVM tools in addition to `lvm`
- **Physical volumes** are partitions adopted by an LVM
  - Created with `fdisk`, possibly formatted with tools like `mkfs.*`
  - Tools: (link back to `/bin/lvm`)
    - `pvcreate` adopts a partition to become a physical volume
    - `pvdisplay` lists physical volumes in use
    - `pvmove` moves data between physical volumes in the same group
    - `pvremove` removes a partition from a physical volume
- **Volume group (VG)** are physical volumes, even on different disks, pooled into one
  - Behaves, in a way, like a virtual disk
  - Tools: (link back to `/bin/lvm`)
    - `vgcreate` creates a volume group
    - `vgextend` grows a volume group
    - `vgreduce` shrinks a volume group
- **Logical volumes (LV)** are partitions created from a logical volume group
  - Filesystems (ie etx4, swap, etc) reside on logical volumes, one per volume
  
### Create LVM
1. **Create a new partition table and partitions on the physical disk**
- `m` for help to understand the interactive commands (both `fdisk` and `gdisk`)
- You may follow along graphically in GParted
- This assumes a physical disk at least 447G or larger
- **Via `fdisk`**
```console
sudo fdisk /dev/sdb
```
  - GPT (preferred)
    - `g` <key>Enter</key>
    - Create type-LVM partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` <key>Enter</key> or on final partition <key>Enter</key> for default (you want 4 or 5 total)
      - ? `y` <key>Enter</key> if asked to remove the signature (overwriting a existing filesystem)
      - `t` <key>Enter</key>
      - ? <key>Enter</key> if asked (default, the partition we just created with `n`)
      - ? `L` <key>Enter</key> will list type choices (if you are curious)
        - `43` for type-LVM
        - `lvm` alias for type-LVM
        - FYI code `20` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `43` or `lvm`,  <key>Enter</key>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` (write changes and move on) or `q` (quit and abort, if this was just an exercise)
  - MBR (legacy)
    - `o` (DOS is the same as MBR for partition tables)
    - Create type-LVM partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default `p` for primary partition)
        - Or `e` *Note **MBR logical partitions** (in an **extended container**) are not the same as **LVM logical volumes***
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` <key>Enter</key> or on final partition <key>Enter</key> for default (you want 3 or 4 total)
      - ? `y` <key>Enter</key> if asked to remove the signature (overwriting a existing filesystem)
      - `t` <key>Enter</key>
      - ? <key>Enter</key> if asked (default, the partition we just created with `n`)
      - ? `L` <key>Enter</key> will list type choices (if you are curious)
        - `8e` for type-LVM
        - `lvm` alias for type-LVM
        - FYI code `83` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `8e` or `lvm`,  <key>Enter</key>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` <key>Enter</key>, `y` <key>Enter</key> (write changes and move on) or `q` <key>Enter</key> (quit and abort, if this was just an exercise)
- **Via `gdisk`**
```console
sudo gdisk /dev/sdb
```
  - GPT (only option)
    - `o` <key>Enter</key>
    - `y` <key>Enter</key>
    - Create type-LVM partition
      - `n` <key>Enter</key>
      - <key>Enter</key> (default next available partition number)
      - <key>Enter</key> (default next available sector)
      - `+100G` or on final partition <key>Enter</key> for default (you want 4 or 5 total)
      - ? `L` <key>Enter</key> <key>Enter</key> will list type choices (if you are curious)
        - `8e00` for type-LVM
        - FYI code `8300` is the default type (Linux filesystem)
      - `8e00` <key>Enter</key>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` <key>Enter</key> (write changes and move on) or `q` <key>Enter</key> (quit and abort, if this was just an exercise)
- ***Note:*** *Normally we do this on more than one physical disk*
  - *We would repeat this on drives like `/dev/sdc`, etc*
  - *This example only uses one physical drive to demonstrate the commands*

- *Note you could skip step 1 and directly run `pvcreate /dev/sdb` (step 2) without a partition table from `fdisk` or `gdisk`, but then another OS like Windows or Mac might view the `sdb` disk as "available space" to create a partition on, thus destroying your LVM framework; creating this partition table in step 1 prevents that*

- You may need to reboot or run partprobe before changes register with the kernel

| **partbrobe** :#

```console
partprobe -s
```

...or if you still can't proceed in step 2...

| **reboot** :

```console
reboot
```

2. **Create physical volumes from the partitions just made**
- Get a list of devices to use

| **list blocks** :#

```console
lsblk
```

- We will use all four from an output list like so:
```
sdb
├─sdb1
├─sdb2
├─sdb3
├─sdb4
└─sdb5
```

- Adopt each as **physical volumes**

| **adopt** :# (single args)

```console
pvcreate /dev/sdb1
pvcreate /dev/sdb2
```

| **adopt** :# (or multiple args)

```console
pvcreate /dev/sdb3 /dev/sdb4 /dev/sdb5
```

- ? *You may be asked to wipe an existing filesystem signature, like ext4, NTFS, swap, etc, if the disk was formatted before beginning; choose yes `y`*

3. **Pool those physical volumes into one unified logical volume**

- Create the volume group, here called "volgrp" (you can replace `volgrp` with any name you want)

| **create volume group** :#

```console
vgcreate -s 16M volgrp /dev/sdb1
```

- *This created the device `'volgrp` at `/dev/volgrp`, where the logical volumes we eventually mount will go*

- *Note the `-s 16M` flag and arg in `vgcreate -s 16M`*
  - *This is **physical extant size**, which you can [read more about here](https://unix.stackexchange.com/a/664525/315069)*
  - *These are the smallest units that LVM uses to manage the volumes*
  - *The default is `1M`, which is usually okay*
  - *You want larger extants if you use **LVM snapshots** because:*
    - *Snapshots record changes per extant*
    - *(Smaller extants = more extants = more meta data recorded in keeping LVM snapshots = more I/O & space cost)*

- You can delete the volume group with `vgremove`

| **remove volume group** :#

```console
vgremove volgrp
```

- Create the same volume group, but argue multiple physical volumes in one line

| **create volume group with multiple PV args** :#

```console
vgcreate -s 16M volgrp /dev/sdb1 /dev/sdb2
```

- Extend the "volgrp" volume group to include the other physical volumes

| **extend volume group** :#

```console
vgextend volgrp /dev/sdb3
```

| **extend volume group with multiple PV args** :#

```console
vgextend volgrp /dev/sdb4 /dev/sdb5
```

- Create the "thislvm" logical volume from "volgrp"
  - Size here is 420G, but any size within the drive limit is allowed

| **create logical volume** :#

```console
lvcreate -L 420G -n thislvm volgrp
```

- *Note this created the device `thislvm` at `/dev/volgrp/thislvm`, which we can now mount*

- You can delete the locigal volume with `lvremove`

| **remove logical volume** :#

```console
lvremove /dev/volgrp/thislvm
```

- Get a glance at our system again:

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1
├─sdb2
├─sdb3
├─sdb4
└─sdb5
```

- Create the "thislvm" logical volume again from "volgrp"
  - Size here is 220G so we have space left over to work with

| **create logical volume with 220G** :#

```console
lvcreate -L 220G -n thislvm volgrp
```

- *If asked to wipe an existing signature, choose yes `y`*

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1              ...  part
│ └─volgrp-thislvm  ...  lvm
├─sdb2              ...  part
│ └─volgrp-thislvm  ...  lvm
├─sdb3              ...  part
│ └─volgrp-thislvm  ...  lvm
├─sdb4              ...  part
└─sdb5              ...  part
```

- *You can see which physical volumes are used by the logical volume*
  - *PVs `sdb4` and `sdb5` are not currently being used, but they could be*

- *Graphical representation of the volume group:*

```
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|  Volume Group
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |  Physical Volumes
|_____********* Logical Volume 220G *************________s p a c e___l e f t___o v e r____|  Logical Volume
|                                                                                         |
|-----------------------------------------------------------------------------------------|
```

  - *Only 220G are used, but somewhere through the full VG, all the physical volumes total to 447G available*
  - *PVs `sdb1`, `sdb2`, `sdb3`, `sdb4`, and `sdb5` are "swimming" somewhere, pooled together in the volume group, not really knowing what data is on which PV*
  - *In total, only 220G of their collective 447G are actually being used from the `lvcreate` command*

- Format the volume to ext4 (or any other filesystem you may want instead)
  - Notice the path resulting from the names we chose: `/dev/volgrp/thislvm`

| **format logical volume** :#

```console
mkfs.ext4 /dev/volgrp/thislvm
```

- Make a directory and mount it to that directory
  - We called it the same `/thislvm`, but the directory could be any other name and in any other directory

| **mount logical volume** :#

```console
mkdir /thislvm
mount /dev/volgrp/thislvm /thislvm
```

- Be sure to add this line to `/etc/fstab` for your next reboot

| **fstab entry** :

```
/dev/volgrp/thislvm /thislvm ext4 defaults 1 2
```

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
├─sdb2              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
├─sdb3              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
├─sdb4              ...  part
└─sdb5              ...  part
```

- ***Note `thislvm` is mounted now!***
  - *If you wanted to do any maintenance or work on LV `thislvm` in the following steps, it is best to unmount it with `umount` first*

4. **Manage the logical volume**

- Display all physivcal info, then only for sdb1

| **display PV** :#

```console
pvdisplay
pvdisplay /dev/sdb1
```

- Display all volume group info, then specifically for the volume group "volgrp"

| **display VG** :#

```console
vgdisplay
vgdisplay /dev/volgrp
```

- Display all logical volume info, then specifically for the logical volume "thislvm"

| **display LV** :#

```console
lvdisplay
lvdisplay /dev/volgrp/thislvm
```

- ***Unmount the LV so we can do maintenance work***

| **unmount** :#

```console
umount /thislvm
```

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1
│ └─volgrp-thislvm
├─sdb2
│ └─volgrp-thislvm
├─sdb3
│ └─volgrp-thislvm
├─sdb4
└─sdb5
```

- Resize the logical volume

| **resize LV** :#

```console
lvresize -r -L 200G /dev/volgrp/thislvm
```

- *You may be asked if you want to unmount the volume first; choose yes `y`*

- Grow the logical volume +10G relatively

| **grow LV** :#

```console
lvresize -r -L +10G /dev/volgrp/thislvm
```

- *You may be asked if you want to unmount the volume first; choose yes `y`*

- Relocate any contents from one physical volume (ie `/dev/sdb3`) elsewhere in the logical volume
  - `pvmove` then `pvremove`
    - *This shoves over the content to empty the physical volume so it can then be removed from the volume group*
- *Graphical representation of `pvmove` then `pvremove`:*

```
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |
|_____********* Logical Volume 210G ************_________s p a c e___l e f t___o v e r____|
|                                                                                         |
| # pvmove /dev/sdb3                       [changes below]                                |
|                                                                                         |
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |
|_____********* Logical Volume 210G *** xNOTxUSINGxxxxxx ************___space_left_over___|
|                                                                                         |
| # pvremove /dev/sdb3                       [changes below]                              |
|                                                                                         |
|------------------------- LVM Volume Group volgrp (347G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     xxxxxxxxxxxx     sdb4-PV-100G     sdb5-PV-47G     |
|_____********* Logical Volume 210G *** xCANNOTxUSExxxxx ************___space_left_over___|
|                                                                                         |
|-----------------------------------------------------------------------------------------|
```
  - *The chart above illustrates how `pvremove` basically "shoves" the content of that PV over to other space available in the larger VG*

- Move a physical volume (ie `/dev/sdb3`) content elsewhere in the volume group

| **move PV content** :#

```console
pvmove /dev/sdb3
```

- *This command may take several minutes because the logical volume is basically re-organizing the shape, like moving a partition*
- *There may be an "insufficient free space" error if the volume group does not have enough unused space left over*
  - *If that happens, then shrink the logical volume with `lvresize` at least as much as the size of the physical volume, then try again*

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1
│ └─volgrp-thislvm
├─sdb2
│ └─volgrp-thislvm
├─sdb3
├─sdb4
│ └─volgrp-thislvm
└─sdb5
```

- Now remove that physical volume (ie `/dev/sdb3`) from its "volgrp" volume group altogether

| **reduce VG** :#

```console
vgreduce volgpr /dev/sdb3
```

- Now we could add that PV back to the VG, even though the VG already has an LV

| **extend volume group again** :#

```console
vgextend volgpr /dev/sdb3
```

- *Graphical representation of the current volume group:*

```
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |
|_____********* Logical Volume 210G *** xNOTxUSINGxxxxxx ************___space_left_over___|
|                                                                                         |
|-----------------------------------------------------------------------------------------|
```

5. **Take LVM snapshots**

- *Snapshots for LVM don't capture the entire disk, only the changes, like snapping a point in time to refer back to*
  - *These changes are called "deltas"*
  - *Deltas are recorded per extant*
  - *Extants are the smallest unit of management throughout the volume group*
  - *Extant size is defined by the `-s` flag in, say, `vgcreate -s 16M`*

- *Graphical representation of current LVM with snapshot:*
  - *COW = Copy On Write (part of what the snapshot needs to do its work)*

```
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |
|         snapshot         snapshot         snapshot         snapshot                     | Snapshots on each PV they record for
|_____********* Logical Volume 210G *** COW xxxxxxxxxxxx ************___space_left_over___|
|                                                                                         |
|-----------------------------------------------------------------------------------------|
```

- Create a snapshot without persistent size
  - *`-s` for snapshot*
  - *`-n` for the name'*
  - *`-l 128` for size of 128 extants (extant size was determined with the `-s` flag in `vgcreate -s ...`)*

| **create snapshot** :#

```console
lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
```

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1
│ └─volgrp-thislvm-real
│   └─volgrp-thislvm
│   └─volgrp-thesnap
├─sdb2
│ └─volgrp-thislvm-real
│   └─volgrp-thislvm
│   └─volgrp-thesnap
├─sdb3
│ └─volgrp-thesnap-cow
│   └─volgrp-thesnap
├─sdb4
│ └─volgrp-thislvm-real
│   └─volgrp-thislvm
│   └─volgrp-thesnap
└─sdb5
```

  - *Note `sdb3` still isn't being used because we did `pvmove /dev/sdb3`*
    - *Instead, the COW area of the snapshot is there because it is the first available space*
  - *If we had not done `pvmove /dev/sdb3`, things would look like this:*

```
|------------------------- LVM Volume Group volgrp (447G available) ----------------------|
|                                                                                         |
|     sdb1-PV-100G     sdb2-PV-100G     sdb3-PV-100G     sdb4-PV-100G     sdb5-PV-47G     |
|         snapshot         snapshot         snapshot         snapshot                     |
|_____********* Logical Volume 210G *************COW____________________space_left_over___|
|                                                                                         |
|-----------------------------------------------------------------------------------------|
```

```
sdb
├─sdb1
│ └─volgrp-thislvm-real
│   └─volgrp-thislvm
│   └─volgrp-thesnap
├─sdb2
│ └─volgrp-thislvm-real
│   └─volgrp-thislvm
│   └─volgrp-thesnap
├─sdb3
│ ├─volgrp-thislvm-real
│ │ └─volgrp-thislvm
│ │ └─volgrp-thesnap
│ └─volgrp-thesnap-cow
│   └─volgrp-thesnap
├─sdb4
└─sdb5
```

- Mount the snapshot so you can read from it (read-only of course)

| **mount snapshot** :#

```console
mkdir /thesnap
mount -o ro /dev/volgrp/thesnap /thesnap
```

- *Now you can add files and other data to the snapshot*
  - *While mounted, the snapshot will not continue backups*
  - *What you add to the snapshot will not change after you unmount it*

- Unmount the snapshot so it can resume its work

| **unmount snapshot** :#

```console
umount /thesnap
```

- Remove the snapshot

| **remove snapshot** :#

```console
lvremove /dev/volgrp/thesnap
```

- Look at what changed

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1
│ └─volgrp-thislvm
├─sdb2
│ └─volgrp-thislvm
├─sdb3
├─sdb4
│ └─volgrp-thislvm
└─sdb5
```

6. **Restore Snapshots (Merge)**

- Mount the LV

| **mount** :#

```console
mount /dev/volgrp/thislvm /thislvm
```

- See the LV mounted

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
├─sdb2              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
├─sdb3              ...  part
├─sdb4              ...  part
│ └─volgrp-thislvm  ...  lvm  /thislvm
└─sdb5              ...  part
```

- Add some files and see them

| **create files** :#

```console
touch /thislvm/one /thislvm/two
```

| **list files** :#

```console
ls /thislvm
```

| **add file content** :#

```console
echo "I am one two" > /thislvm/echoed
```

| **cat file content** :#

```console
cat /thislvm/echoed
```

- Create a snapshot

| **create snapshot** :#

```console
lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
```

- *Note the current point in time has been recorded, any new or changed files will be logged as new in the snapshot so they can be reverted*

- See the snapshot there

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm  /thislvm
│   └─volgrp-thesnap    ...  lvm
├─sdb2                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm  /thislvm
│   └─volgrp-thesnap    ...  lvm
├─sdb3                  ...  part
│ └─volgrp-thesnap-cow  ...  lvm
│   └─volgrp-thesnap    ...  lvm
├─sdb4                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm  /thislvm
│   └─volgrp-thesnap    ...  lvm
└─sdb5                  ...  part
```

| **create more files** :#

```console
touch /thislvm/three /thislvm/four
```

| **list more files** :#

```console
ls /thislvm
```

| **add more file content** :#

```console
echo "I am three four" >> /thislvm/echoed
```

| **cat more file content** :#

```console
cat /thislvm/echoed
```

- Send the snapshot merge command

| **merge snapshot** :#

```console
lvconvert --mergesnapshot /dev/volgrp/thesnap
```
  - Output:

```
  Delaying merge since origin is open.
  Merging of snapshot volgrp/thesnap will occur on next activation of volgrp/thislvm.
```

- Unmount the partition

| **unmount** :#

```console
umount /thislvm
```

- Deactivate the LV (`-an` = "active no")

| **deactivate** :#

```console
lvchange -an /dev/volgrp/thislvm
```

- Reactivate the LV (`-ay` = "active yes")

| **reactivate** :#

```console
lvchange -ay /dev/volgrp/thislvm
```

- See the snapshot gone!

| **list blocks** :

```console
lsblk
```

  - Output: (may vary)

```
sdb
├─sdb1                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm
├─sdb2                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm
├─sdb3                  ...  part
├─sdb4                  ...  part
│ └─volgrp-thislvm-real ...  lvm
│   └─volgrp-thislvm    ...  lvm
└─sdb5                  ...  part
```

- *Note the snapshot is gone because the snapshot merged*

- Re-mount the LV

| **mount** :#

```console
mount /dev/volgrp/thislvm /thislvm
```

- Take a tour

| **list files** :#

```console
cd /thislvm
ls
cat echoed
```

- *Note that all changes since the snapshot was taken are gone, we back to only "one" and "two"*

7. **Delete the LVM**

- Remove the volume group

| **remove volume group** :#

```console
vgremove volgrp
```

- *If you get errors, probably from some complex mistake, just continue on to `pvremove` all included physical volumes with the `--force` flag two times*

- Remove the physical volumes from LVM

| **remove physical volumes from LVM** :#

```console
pvremove /dev/sdb1 /dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5
```

...or...

| **remove PVs with force** :#

```console
pvremove /dev/sdb1 /dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 --force --force
```

## Swap
- Can be partition or file
- **Swap file**: (2G swap file)
```bash
swapoff /var/swap.img
touch /var/swap.img
chmod 600 /var/swap.img
dd if=/dev/zero of=/var/swap.img bs=2M count=1024
mkswap /var/swap.img
swapon /var/swap.img
```
  - This only works on ext4
- **Swap file on btrfs** filesystems need a different method
  - btrfs does not allow snapshots on disks that contain a swap file
  - Read [the long method to creating a swap file on btrfs](https://askubuntu.com/a/1206161/880404) if you want to anyway
  - It is better to use a swap partition with btrfs
- **Swap partition**:
  - Presuming a partition `/dev/sdb5`, preferrably at the end of the disk for easier resizing
```bash
mkswap /dev/sdb5
```
  - The system will automatically use it on boot
- Use swap now or turn it off now:
  - `swapon`
  - `swapoff` 

## Repair
- `fsck`
  - It is best to unmount a filesystem (via `umount`) before running `fsck`, but not required for read-only mode (`-n`)
  - `-n` read-only mode to check a mounted filesystem
  - `-t ext4` or `-t ntfs` etc, if OS doesn't understand the filesystem type, but usually not needed
  - `touch /forcefsck` will force an `fsck` on all `/etc/fstab` listed filesystems at next startup, then `/forcefsck` will be removed after success
    - This is handy to check the `/` before it is mounted

### Extra Disk Recover Packages
- `testdisk`
  - Undelete files from FAT, NTFS, and ext2
  - Recover lost or problematic partitions
  - Works with almost any filesystem type
    - NTFS
    - FAT32
    - ext4
    - btrfs
    - swap
    - LVM
    - Linux Raid
    - many more
- `photorec` (from the `testdisk` package on Arch)
  - Recovers damaged or deleted photo images
- `ext4magic`
  - Undelete from ext3 and ext4

## I/O
- Writing to and from a disk can cause an input-output pileup
- Tools: (Arch Linux needs packages: `sysstat`, `iotop`, `bonnie++`)
  - `iostat` - monitor I/O by disk devices
    - `-m` megabites
    - `-x` details
  - `iotop` - current I/O usage, must run as `root`
    - `-o` only processes doing I/O
  - `fuser /some/path` find out which user is using a part of the filesystem
- Stress test tools
  - `bonnie++` tests writing to file systems
    - Output report packages: `boncsv2html`, `boncsv2txt`
    - Run as root requires `-u 0`
    - If `-d` not specified for destination write, current path must be writable
    - Eg: `bonnie++ -u 0 -n 0 -f -b -r 150 -d /tmp/`
      - `-u 0` run as root
      - `-n 0` no file creation tests
      - `-f` no per character I/O tests
      - `-b` do `fsync` after every write, flushing to disk and no writing to cache
      - `-r 150` use only 150M or RAM
      - `-d /tmp/` destination: `/tmp/`
  - `fs_mark`
    - Download: [sourceforge.net/projects/fsmark/](http://sourceforge.net/projects/fsmark/)
    - Arch Linux: `glmark2` package
    - Fedora: `glibc-static` package
    - SUSE: `glibc-devel-static` package
    - Debian: `fsmark` package
    - Example:
      - `fs_mark -d /tmp -n 1000 -s 10240`
        - `-d /tmp` destination `/tmp`
        - `-n 1000` 1,000 files
        - `-s 1024` 10M each file size
    - Monitor with `iostat`
      - `iostat 1 10`

## Network Block Devices (NBD)
### What Is NBD?
- NBD is a module in the kernel
  - Command to use the NBD module: `sudo modprobe nbd`
  - That module makes all of this work...
- NBD is often how a cloud system mounts a large "block storage" drive device to our virtual machine for a cloud service like Linode, Vultr, or DigitalOcean, which then we sysadmin-customers simply see as `/dev/nbd0` etc
  - Go into your Linode / Vultr / DigitalOcean control panel and buy some block storage drive space to attach to your virtual machine
  - Then their website will instruct you to look for `/dev/nbd0` etc on your virtual machine
  - It was actually NBD that put it there for you to use

### How NBD Works
- **A local blob as `/dev/nbd0` or `/dev/nbd1` etc points to a remote device over the network**
- A Network Block Device is a blob in the local `/dev/` folder
  - This appears much like a partition or filesystem
  - Remember with Linux, *"everything is a file"*
- This NBD local blob points to a remote device on another machine available through the network
  - The remote device can be many things:
    - Hard disk
    - Partition
    - Disk image, like an .iso file
    - Single file (text, photo, audio file, tarball, etc)
    - Virtual machine (as its entire mounted filesystem)
    - USB drive
    - CD-ROM or DVD drive
    - Mouse
    - Barometer
    - Methane gas detector that you pub into your remote Raspberry Pi on the network as a practical joke
    - Piece of hardware you can interact with by editing files
    - Executable program you can run on the local machine
- The network connection between the local blob and remote device can use
  - TCP/IP
  - Unix sockets

### Different NBD Tools & Linux Distros
- `nbd-client` & `nbd-server` 
  - CentOS/Fedora  (`nbd` package)
  - Debian/Ubuntu (`nbd-client` & `nbd-server` packages)
  - Arch (`nbd` package)
  - [NBD GitHub Repo](https://github.com/NetworkBlockDevice/nbd) (all distros)
- `nbdkit` package: plugins for building various, unconventional NBD servers
  - CentOS/Fedora
  - Debian/Ubuntu
  - Arch (AUR)
- xNBD: Debian
  - `xnbd-client` & `xnbd-server` packages
- `qemu`: various tools for compatability layers (packages depend on which tool)
  - CentOS/Fedora
  - Debian/Ubuntu
  - Arch
- Default NBD server port is `10809`
- Examples:

| **/etc/nbd-server/config** : at 192.168.0.5

```
[generic] # required
        user = nbd
        group = nbd
[foo] # whatever name
        exportname = /path/to/foo/file # only required setting
[exportrofile]
        exportname = /path/to/read/only/file # only required setting
        authfile =  # left empty to allow from all
        readonly = true
        port = 881188
[exportzerodd] # export an empty dd-made file that resets on each run
        exportname = /path/to/some/empty/file # only required setting
        authfile = /path/to/some/empty/authfile # file that contains allowed IP addresses and ports per line as: some.ip.addr.here/port
        timeout = 30
        filesize = 10000000
        readonly = false
        multifile = false
        copyonwrite = false
        prerun = dd if=/dev/zero of=%s bs=1k count=500
        postrun = rm -f %s
```

| **Start server** : default config (`/etc/nbd-server/config`)

```console
sudo nbd-server
```

| **Start server** : custom config

```console
sudo nbd-server -C /etc/nbd-server/myconfig.conf
```

| **Client connects to 'foo'** :

```console
sudo nbd-client -N foo 192.168.0.5 /dev/nbd0
```

| **Client connects to 'exportrofile'** : redundantly specify default port `10809`

```console
sudo nbd-client -N exportrofile 192.168.0.5 10809 /dev/nbd1
```

| **Client connects to 'exportzerodd'** :

```console
sudo nbd-client -N exportzerodd 192.168.0.5 881188 /dev/nbd2
```

___

#### [Lesson 8: Packages](https://github.com/inkVerb/vip/blob/master/601/Lesson-09.md)