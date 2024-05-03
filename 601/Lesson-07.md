# Linux 601
## Lesson 7: Disk & Partitioning

### [VIP/Cheat-Sheets: File Size, Binary, Hexadecimal](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Sizes-Binary-Hex.md)

___

# The Chalk
## Important Terms
- **Physical drives** can be held in your hand and plugged into a computer via SATA, NVMe, mSATA, or USB ports
- **Partition tables** are created with `fdisk` & `gdisk`, formerly using **MBR**, but should use **GPT** on machines made after 2010
- **Partitions** are large sections of a disk created with `fdisk` & `gdisk`, listed on the disk's partition table, unformatted and empty
- **Filesystems** are formatted partitions of different types, such as **ext4**, **FAT32**, **swap**, **NTFS**, **BTRFS**, etc
- **Virtual Filesystem** is a software layer that interacts directly with the physical disk; most filesystems use this so apps can operate easily

## I/O Tools
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

## Disk Types
### Connection Cables
- **SCSI (Small Computer Systems Interface)**
  - First developed in 1979
  - A broad range of cables, plug types, and speeds
  - Range from:
  - Narrow (standard SCSI)
    - 8 bit bus
    - 5MB/second
  - Wide (ultra-wide SCSI-3)
    - 16 bit bus
    - 160MB/second
- **IDE (Integrated Drive Electronics) & EIDE (Enhanced IDE)**
  - Used 1991-2012
  - A kind of SCSI device
  - Main internal disk connectors
  - Obsolte
- **SATA (Serial Advanced Technology Attachment)**
  - First released in 2003
  - A kind of SCSI device
  - Replaced IDE drives
  - Smaller cable (7 pins)
  - Native hot swapping
  - Fast & efficient data transfer
  - eSATA was a SATA "next generation" dream that failed
  - mSATA usually connects to the motherboard without a cable
- **USB (Universal Serial Bus)**
  - A kind of SCSI device
  - Can connect any drive (flash, HDD, SSD, SATA adapters, FDD [floppy disk drive] etc)
  - External
- **NVMe (Non-Volatile Memory Express)**
  - *NOT* a kind of SCSI device
  - Faster connection between SSD media and the motherboard
  - Usually connects to the motherboard without a cable
### Drive Media
- **FDD (Floppy Disk Drive)**
  - The disk itself is floppy, but nearly comes in a sleve
  - The sleve for the 3.5 inch is harder
  - Older FDs were 8 inch, then 5.25 inch
  - The 2.5 inch FD was a "next generation" dream that failed
- **HDD (Hard Disk Drive)**
  - Hard, spinning disk, using rotating platters and a magnetic head
  - Rotation speed affects performance
  - Formerly connected with IDE, not SATA
- **Flash drive**
  - Crafted using "**flash**" technology, borrowed from RAM's physical architecture
  - No moving parts
  - Often used in USB "thumb" drives
  - Similar tech, but not the same as SSD
- **SD (Secure Digital)**
  - Uses flash technology
  - Different sizes
  - Used in cameras, smartphones, game consoles, and other mobile computing machines
  - Uses the dedicated "SD slot" connection port
- **SSD (Solid State Drive)**
  - Uses flash technology
  - No moving parts, no rotating disk
  - Connects with SATA or NVMe

## Inodes
- Every file has one **inode**
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
- The filesystem **directory** has:
  - **Filename** with corresponding **inode** number
  - `ls -i` to output files with corresponding **inode** numbers
  - Hard vs soft links
    - Hard link: both files share the same **inode**
    - Soft link: points to other file, each with its own **inode**
  - Create your own example:

| **inode example** :$

```console
touch one          # original file
ln one two         # hard link
ls -i              # same inode
touch three        # original file
ln -s three four   # symbolic link
ls -i              # unique inodes
rm one three       # break links
ls -i              # same inodes as before, though originals deleted
rm two four        # cleanup
```

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
  - The `if=` input source almost always must be in `/dev/` folder or an `.img` file
  - Only duplicates raw data, it does not understand filesystems, directories, or mount points
  - Only works with `/dev/` devices and/or `.img` files, [not directories nor mount points](https://unix.stackexchange.com/a/659102/315069); directories can be done, [but it is complicated](https://askubuntu.com/a/909144/880404)
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

### Extended Filesystem
- `ext2`, `ext3`, `ext4`
- Four file attribute namespaces
  - User
  - Trusted
  - Secutiry (viz SELinux)
  - System (Access Control Lists)
- File attribute flags
  - `a` append-only: only append (forces `>>`)
  - `A` no `atime` update: access time will not be modified
  - `c` compress automatically by kernel
  - `C` no COW (copy on write)
  - `d` no-Dump: ignored by `dump`, useful for swap or cache files
  - `D` write changes synchronously
  - `e` uses Extents for mapping blocks; cannot be removed via `chattr`
  - `E` enctrypted
  - `F` path lookup is case-sensitive; can only be added to empty directories
  - `i` immutable: no modification allowed, even by `root`, no link, delete, rename; `su`/`root` can change this
  - `I` directory indexted via hashed trees; `chattr` can't set, but `lsattr` can show
  - `j` same as `data=journal` mount option, all data written to journal before writing file itself; mounting with `data=journal` is redundant
  - `m` exclude file from compression (when per-file compression supported)
  - `N` data is stored inline with the inode itself; `chattr` can't set, but `lsattr` can show
  - `P` directory enforces hierarchical structure for project IDs; can be added to directories only
  - `s` when deleted, blocks are zeroed
  - `S` same as `sync` mount option, changes written cynchronously to disk
  - `t` no tail-merging (for partial block at end of file merged with other files)
  - `T` top of directory hierarchy; can be added to directories only
  - `u` Undelete allowed by user, contents saved on delete
  - `x` use DAX (direct access) mode if kernel supports; override with `dax=never` mount option
  - `V` fs-verity enabled; unwriteable, all data verified against croptographic hash of entire contents; `chattr` can't set, but `lsattr` can show
- Tools
  - `lsattr` list attributes
  - `chattr` change attributes
    - Command Flags
      - `-R` recursive
      - `-V` verbose
      - `-f` force suppress most error messages
      - `-v` set file version number
      - `-p` set file project number
  - Examples:#
    - `lsattr`
    - `lsattr somefile`
    - `chattr -RVf +aAdeisu somefile`
    - `chattr -V =dsu somefile`
    - `chattr -f -aAei somefile`

### Size
- `du` Directory Use (permissions-relevant)
  - For specific directory, default `.`
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
  - Standard command:
    - **`df -Th`**

### Block Volumes
- `lsblk` (list block volumes, including dev path)
    - `lsblk -f` (filesystem type, label, UUID, size, use)
- :# `blkid /dev/sda1` (get UUID of `/dev/sda1`)
- `ls -lh /dev/disk/by-uuid/`

## Partitioning
- Changes & status
  - `partprobe -s` Inform OS of partition table changes
    - Update OS with new partition info, but reboot is more reliable
  - `cat /proc/partitions` live partitions for OS
  - `fdisk -l /dev/sda` (only display partition info, non-interactive, same as `p` within the menus)
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
- `fdisk` & `gdisk`: `m` for help to understand the interactive commands
- You may follow along graphically in GParted (using 'Refresh...')
- This assumes a physical disk at least 447G or larger
- **Via `fdisk`**
```console
sudo fdisk /dev/sdb
```
  - GPT (preferred)
    - `g` <kbd>Enter</kbd>
    - Create partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` <kbd>Enter</kbd> or whatever size you want, on final partition <kbd>Enter</kbd> for default
        - On second-last partition, swap being final, `-16G` would use everything but the last 16G
      - ? `y` <kbd>Enter</kbd> if asked to remove the signature (overwriting a existing filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - `w` (write changes and move on) or `q` (quit and abort, if this was just an exercise)
  - MBR (legacy)
    - `o` <kbd>Enter</kbd> (DOS is the same as MBR for partition tables)
    - Create partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default `p` for primary partition)
        - Or `e` *Note **MBR logical partitions** (in an **extended container**) are not the same as **LVM logical volumes***
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` <kbd>Enter</kbd> or whatever size you want, on last partition <kbd>Enter</kbd> for default
        - On second-last partition, swap being last, `-16G` would use everything but the last 16G
      - ? `y` <kbd>Enter</kbd> if asked to remove the signature (overwriting a existing filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - Change a partition type to Linux swap?
      - `t` <kbd>Enter</kbd> (for type)
      - ? <kbd>Enter</kbd> if asked (default, the partition we just created or enter a preferred partition number)
        - It is good practice for Linux swap to be the last partition made, at the end of the disk, in which case you would use the default here anyway
      - ? `l` <kbd>Enter</kbd> will list type choices (if you are curious)
      - `19` or `swap`, <kbd>Enter</kbd>
    - Change a partition type for NTFS or FAT32?
      - *Note any type will work with for NTFS or FAT32, this is moot and merely being excessively finicky*
        - *Being excessively finicky, if you are preparing a recovery partition or EFI partition for Windows, you might consider researching other Microsoft partition types*
      - `t` <kbd>Enter</kbd> (for type)
      - `p` <kbd>Enter</kbd> (for partition list)
      - ? Input partition number <kbd>Enter</kbd> if asked (default if most recently created partition)
        - It is good practice for Linux swap to be the last partition made, at the end of the disk, in which case you would use the default here anyway
      - ? `l` <kbd>Enter</kbd> will list type choices (if you are curious)
        - `11` for Microsoft basic data
      - `11` <kbd>Enter</kbd>
    - Change an existing partition type to anything non-Linux?
      - `p` <kbd>Enter</kbd> (for partition list)
      - `t` <kbd>Enter</kbd> (for type)
      - ? Input partition number <kbd>Enter</kbd> if asked
      - ? `l` <kbd>Enter</kbd> will list type choices (if you are curious)
        - FYI code `83` (alias `linux`) is for Linux filesystem (the default type)
        - FYI code `19` (alias `swap`) is for Linux swap
        - FYI code `44` (alias `lvm`) is for Linux LVM
        - FYI code `11` is for Microsoft basic data (NTFS & FAT32)
    - `w` <kbd>Enter</kbd> (write changes and move on) or `q` <kbd>Enter</kbd> (quit and abort, if this was just an exercise)
- **Via `gdisk`**
```console
sudo gdisk /dev/sdb
```
  - GPT (only option)
    - `o` <kbd>Enter</kbd>
    - `y` <kbd>Enter</kbd>
    - Create partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` <kbd>Enter</kbd> or whatever size you want, on last partition <kbd>Enter</kbd> for default
        - On second-last partition, swap being last, `-16G` would use everything but the last 16G
      - ? `l` <kbd>Enter</kbd> <kbd>Enter</kbd> will list type choices (if you are curious)
        - FYI code `8300` is for Linux filesystem (the default type)
        - FYI code `8200` is for Linux swap
        - FYI code `8e00` is for Linux LVM
        - FYI code `0700` is for Microsoft basic data (NTFS & FAT32)
      - <kbd>Enter</kbd> (default `8300` Linux filesystem)
      - *Repeat these **Create partition** instructions until the disk is full*
    - `w` <kbd>Enter</kbd> (write changes and move on) or `q` <kbd>Enter</kbd> (quit and abort, if this was just an exercise)
2. **Format the partitions just made**
Any of the one-line commands will work in the **Formatting** section

### Formatting
- `mkfs`:#
  - Use the extension for the drive type
    - Get an easy list: `ls -lh /bin/mkfs*`
  - `mkfs.ext4 /dev/sdb1`
  - `mkfs.btrfs /dev/sdb1`
  - `mkfs.fat -F32 /dev/sdb1` (for FAT 32, such as EFI boot partition)
  - `mkntfs /dev/sdb1` (`/bin/mkfs.ntfs -> /bin/mkntfs`, not on Arch)
  - `mkswap /dev/sdb1` (`/bin/mkfs.swap -> /bin/mkswap`, not on Arch)

### Mounting
- `/etc/fstab` file contains automatic mounts at boot
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
    - `umask=0077` for `/boot/efi` *(we learn about `umask` in [Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md))*
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
  - `<dump> <pass>` (should dump? | `fsck` priority during startup?)
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
  - `ls -l /bin/gv* | wc -l`
  - `ls -l /bin/pv* | wc -l`
- `ls -l /sbin/lv*` shows LVM tools in addition to `lvm`
- **Physical volumes** are partitions adopted by an LVM
  - Created with `fdisk` or `gdisk`
    - `fdisk` type `44` or `lvm`
    - `gdisk` type `8e00` or `lvm`
  - Tools: (link back to `/bin/lvm`)
    - `pvcreate` adopts a partition to become a physical volume
    - `pvdisplay` lists physical volumes in use
    - `pvmove` moves data between physical volumes in the same group
    - `pvremove` removes a partition from a physical volume
- **Volume groups (VG)** are physical volumes, even on different disks, pooled into one
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
    - `g` <kbd>Enter</kbd>
    - Create type-LVM partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` <kbd>Enter</kbd> or on final partition <kbd>Enter</kbd> for default (you want 4 or 5 total)
      - ? `y` <kbd>Enter</kbd> if asked to remove the signature (overwriting a existing filesystem)
      - `t` <kbd>Enter</kbd>
      - ? <kbd>Enter</kbd> if asked (default, the partition we just created with `n`)
      - ? `L` <kbd>Enter</kbd> will list type choices (if you are curious)
        - `44` for type-LVM
        - `lvm` alias for type-LVM
        - FYI code `20` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `44` or `lvm`,  <kbd>Enter</kbd>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` (write changes and move on) or `q` (quit and abort, if this was just an exercise)
  - MBR (legacy)
    - `o` (DOS is the same as MBR for partition tables)
    - Create type-LVM partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default `p` for primary partition)
        - Or `e` *Note **MBR logical partitions** (in an **extended container**) are not the same as **LVM logical volumes***
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` <kbd>Enter</kbd> or on final partition <kbd>Enter</kbd> for default (you want 3 or 4 total)
      - ? `y` <kbd>Enter</kbd> if asked to remove the signature (overwriting a existing filesystem)
      - `t` <kbd>Enter</kbd>
      - ? <kbd>Enter</kbd> if asked (default, the partition we just created with `n`)
      - ? `L` <kbd>Enter</kbd> will list type choices (if you are curious)
        - `8e00` for type-LVM
        - `lvm` alias for type-LVM
        - FYI code `83` (alias `linux`) is the default type (Linux filesystem), which it already is
      - `8e00` or `lvm`,  <kbd>Enter</kbd>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` <kbd>Enter</kbd>, `y` <kbd>Enter</kbd> (write changes and move on) or `q` <kbd>Enter</kbd> (quit and abort, if this was just an exercise)
- **Via `gdisk`**
```console
sudo gdisk /dev/sdb
```
  - GPT (only option)
    - `o` <kbd>Enter</kbd>
    - `y` <kbd>Enter</kbd>
    - Create type-LVM partition
      - `n` <kbd>Enter</kbd>
      - <kbd>Enter</kbd> (default next available partition number)
      - <kbd>Enter</kbd> (default next available sector)
      - `+100G` or on final partition <kbd>Enter</kbd> for default (you want 4 or 5 total)
      - ? `L` <kbd>Enter</kbd> <kbd>Enter</kbd> will list type choices (if you are curious)
        - `8e00` for type-LVM
        - FYI code `8300` is the default type (Linux filesystem)
      - `8e00` <kbd>Enter</kbd>
      - *Repeat these **Create type-LVM partition** instructions until there are 4 partitions and the disk is full*
    - `w` <kbd>Enter</kbd> (write changes and move on) or `q` <kbd>Enter</kbd> (quit and abort, if this was just an exercise)
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

| **create logical volume** :#

```console
lvcreate -L 420G -n thislvm volgrp
```

- *Note this created the device `thislvm` at `/dev/volgrp/thislvm`, which we can now mount*
  - *Size here is `420G`, but any size within the drive limit is allowed*

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
vgdisplay volgrp
vgs
vgs volgrp
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

- Resize the logical volume to an absolute size of `200G`

| **resize LV** :#

```console
lvresize -r -L 200G /dev/volgrp/thislvm
```

- *You may be asked if you want to unmount the volume first; choose yes `y`*

- Grow the logical volume `+10G` relatively

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

| **remove PV availability** :#

```console
pvremove /dev/sdb3
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

5. **Merge LVM groups**

- Remove that physical volume (ie `/dev/sdb3`) from its "volgrp" volume group

| **reduce VG** :#

```console
vgreduce volgpr /dev/sdb3
```

| **display VG** :#

```console
vgdisplay
vgdisplay volgrp
vgs
vgs volgrp
```

- *Now we could:*
  - *Use `fdisk` or `gdisk` to re-partition the space on `/dev/sdb3` to have many partitions*
  - *Format and use `/dev/sdb3` as its own partition*
  - *Use `vgcreate` to make a new volume group with only `/dev/sdb3` in that group*
    - *We'll do this...*

- Create a new volume group

| **new VG** :#

```console
vgcreate newgrp /dev/sdb3
```

| **display VGs** :#

```console
vgdisplay
vgdisplay volgrp
vgdisplay newgrp
vgs
vgs volgrp
vgs newgrp
```

- *Now, we could:*
  - *Add other volumes to the LVM group `newgrp` with `vgextend newgrp /dev/sdxX`*
    - *If they exist, which they probably don't because we didn't make them*
  - *Create a logical volume with `lvcreate -L 100G -n thatlvm newgrp`*
  - *Merge `newgrp` with `volgrp`*
    - *We'll do this...*

- First, deactivate all volume groups, whether they need it or not
  - `-an`: "active = no"

| **deactive volume groups** :#

```console
vgchange -an volgrp
vgchange -an newgrp
```

| **display VGs** :#

```console
vgs
```

- Merge volume group `newgrp` into volume group `volgrp`

| **merge volume groups** :#

```console
vgmerge volgrp newgrp
```

| **display VG** :#

```console
vgs
```

- Finally, reactivate the volume group remaining
  - `-ay`: "active = yes"

| **reactive volume group** :#

```console
vgchange -ay volgrp
```

6. **Take LVM snapshots**

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

7. **Restore Snapshots (Merge)**

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

7. **delete the LVM**

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
- **Swap file** # (2G swap file)
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

## Network Block Devices (NBD)
### What Is NBD?
- NBD is a module in the kernel
  - Command to use the NBD module: `sudo modprobe nbd`
  - That module makes all of this work...
- NBD is often how a cloud system mounts a large "block storage" drive device to our virtual machine for a cloud service like Linode, Vultr, or DigitalOcean, which then we sysadmin-customers simply see as `/dev/nbd0` etc
  - Go into your Linode / Vultr / DigitalOcean control panel and buy some block storage drive space to attach to your virtual machine
  - Then their website will instruct you to look for `/dev/nbd0` etc on your virtual machine
  - It may have been NBD that put it there for you to use

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
  - Arch: `nbd` package
  - OpenSUSE: `nbd` package
  - RedHat/CentOS: `nbd` package
  - Debian/Ubuntu: `nbd-client` & `nbd-server` packages
  - [NBD GitHub Repo](https://github.com/NetworkBlockDevice/nbd) (all distros)
- `nbdkit` package: plugins for building various, unconventional NBD servers
  - Arch (AUR)
  - RedHat/CentOS
  - Debian/Ubuntu
- xNBD: Debian
  - `xnbd-client` & `xnbd-server` packages
- `qemu`: various tools for compatability layers (packages depend on which tool)
  - RedHat/CentOS
  - Debian/Ubuntu
  - Arch
- Default NBD server port is `10809`
- Examples:

| **create empty files as dummy devices** :#

```console
dd if=/dev/urandom of=/export/foo bs=1M count=256
dd if=/dev/urandom of=/export/exportrofile bs=1M count=512
dd if=/dev/urandom of=/export/exportzerodd bs=1M count=768
```

- *Those three "devices" are fake; empty files we would treat the same as a mouse or DVD drive, or anything such in `/dev/`*

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

| **start server** :# default config (`/etc/nbd-server/config`)

```console
nbd-server
```

| **start server** :# custom config

```console
nbd-server -C /etc/nbd-server/myconfig.conf
```

| **client connects to 'foo'** :#

```console
nbd-client -N foo 192.168.0.5 /dev/nbd0
```

| **client connects to 'exportrofile'** :# redundantly specify default port `10809`

```console
nbd-client -N exportrofile 192.168.0.5 10809 /dev/nbd1
```

| **client connects to 'exportzerodd'** :#

```console
nbd-client -N exportzerodd 192.168.0.5 881188 /dev/nbd2
```

- *Remember, these are "devices", not "drives"*
  - *You can't format them*
  - *You can't `mount` them*

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

- **These commands should be attempted on a practice machine with a separate, expendible, and empty drive attached**
  - Do not use a VM with an attached virtual drive since the formatting and partitioning commands will wear heavily on the hypervisor's system disk (probably the machine you have VirtualBox installed on)
  - Beware that the machine you use could be permanently damaged if you type `/dev/sdx` incorrectly, which is why a separate pactice machine is strongly recommended, not any mission-critical machine
- These commands use `/dev/sdx`; but make sure you use the correct device name to avoid erasing your data
- `fdisk` & `gdisk` are interactive and require that you follow instructions from The Chalk

| **info** :$

```console
ls -i
ls -l
du -shx .
du -shx *
df -h
```

| **extended attributes** :$

```console
cd 
mkdir test
cd test
touch one two three
lsattr
sudo chattr -Vf +aAdeisu one
lsattr
sudo chattr =isu two
lsattr
sudo chattr -e three
lsattr
ls
rm one two
ls
rm three
ls
sudo chattr =e *
rm one two
ls
```

| **partitioning** :$

```console
cd /mnt
sudo mkdir one two three four

sudo fdisk /dev/sdx # create at least 5 partitions
# g # greate new partition table GPT
# n # create new partition
sudo partprobe -s
sudo mkfs.ext4 /dev/sdx1
sudo mkfs.btrfs /dev/sdx2
sudo mkfs.fat -F32 /dev/sdx3
sudo mkntfs /dev/sdx4
sudo mkswap /dev/sdx5
lsblk -f
sudo blkid /dev/sdx1
sudo mount /dev/sdx1 /mnt/one
sudo mount /dev/sdx2 /mnt/two
sudo mount /dev/sdx3 /mnt/three
sudo mount /dev/sdx4 /mnt/four
sudo swapon /dev/sdx5
cd /mnt/one
du -shx .
df -h
cd /mnt
sudo umount /mnt/one
sudo umount /mnt/two
sudo umount /mnt/three
sudo umount /mnt/four
sudo swapoff /dev/sdx5

sudo gdisk /dev/sdx # create at least 5 partitions
sudo mkfs.ext4 /dev/sdx1
sudo mkfs.btrfs /dev/sdx2
sudo mkfs.fat -F32 /dev/sdx3
sudo mkntfs /dev/sdx4
sudo mkswap /dev/sdx5
lsblk -f
sudo mount UUID=sdx1-l0ng-n0mb3r /mnt/one
sudo mount UUID=sdx2-l0ng-n0mb3r /mnt/two
sudo mount UUID=sdx3-l0ng-n0mb3r /mnt/three
sudo mount UUID=sdx4-l0ng-n0mb3r /mnt/four
sudo swapon UUID=sdx5-l0ng-n0mb3r
cd /mnt/one
du -shx .
df -h
cd /mnt
sudo umount /mnt/one
sudo umount /mnt/two
sudo umount /mnt/three
sudo umount /mnt/four
sudo swapoff /dev/sdx5

cd /mnt
sudo rm -rf one two three four
```

| **/etc/fstab entries** :

```console
cat <<EOF >> ~/fstab.practice
UUID=s0me-l0ng-n0mb3r   /boot/efi      vfat    umask=0077 0 2 
UUID=s0me-l0ng-n0mb3r   /              ext4    defaults,noatime 0 1
/dev/sdx1               /home          btrfs   defaults,noatime,nofail 0 1
/dev/nvme0n1p1          /mnt/ssd       ext4    defaults,noatime,nofail,x-systemd.automount 0 0
/dev/nvme0n1p2          /mnt/hdd       ext4    defaults,noatime,nofail,x-systemd.automount.device-timeout 0 0
/var/swap.img           none           swap    sw 0 0
/dev/volgrp/thislvm     /thislvm       ext4    defaults 1 2
EOF
```

| **LVM** :$

```console
# Choose fdisk or gdisk below

sudo fdisk /dev/sdx
# Create 5 partitions
# sdx3 & sdx4 at 5G is wise so pvmove takes less time
# t # change type
# Type 44 or lvm

sudo gdisk /dev/sdx
# Create 5 partitions
# sdx3 & sdx4 at 5G is wise so pvmove takes less time
# n # new partition
# Type 8e00 or lvm

# Choose either fdisk or gdisk above

partprobe -s
# reboot?

# Create the LVM partitions
lsblk
sudo pvcreate /dev/sdx1
sudo pvcreate /dev/sdx2
sudo pvcreate /dev/sdx3 /dev/sdx4 /dev/sdx5

# Create the volume group
sudo vgcreate -s 16M volgrp /dev/sdx1 /dev/sdx2
ls -l /dev/volgrp
lsblk
sudo vgextend volgrp /dev/sdx3 /dev/sdx4 /dev/sdx5
ls -l /dev/volgrp
lsblk

# Create the logical volume
lsblk
sudo lvcreate -L 420G -n thislvm volgrp
ls -l /dev/volgrp
lsblk

# Management practice
sudo lvremove /dev/volgrp/thislvm
sudo lvcreate -L 320G -n thislvm volgrp

sudo mkfs.ext4 /dev/volgrp/thislvm
lsblk -f
sudo lvresize -r -L 350G /dev/volgrp/thislvm
sudo lvresize -r -L +70G /dev/volgrp/thislvm
sudo lvresize -r -L 440G /dev/volgrp/thislvm

sudo pvmove /dev/sdx3
sudo vgreduce volgrp /dev/sdx3
sudo pvremove /dev/sdx3
sudo pvcreate /dev/sdx3
sudo vgextend volgrp /dev/sdx3
sudo pvmove /dev/sdx4

sudo vgreduce volgrp /dev/sdx3 /dev/sdx4
sudo pvremove /dev/sdx3 /dev/sdx4
sudo pvcreate /dev/sdx3 /dev/sdx4
sudo vgcreate -s 16M newgrp /dev/sdx3 /dev/sdx4
sudo vgs
sudo vgdisplay
sudo vgs newgrp
sudo vgs volgrp
sudo vgdisplay newgrp
sudo vgdisplay volgrp
sudo vgchange -an newgrp
sudo vgchange -an volgrp
sudo vgmerge volgrp newgrp
sudo change -ay volgrp

sudo vgremove volgrp
sudo vgcreate -s 16M volgrp /dev/sdx1
sudo vgextend volgrp /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5

sudo pvremove /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5 --force --force
sudo pvcreate /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5

# Remove to proceed
sudo lvremove /dev/volgrp/thislvm
sudo vgremove volgrp
sudo pvremove /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5 --force --force

# Create a smaller logical volume
sudo pvcreate /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5
lsblk -f
sudo lvcreate -L 220G -n thislvm volgrp
ls -l /dev/volgrp
lsblk -f

# Format the drive
sudo mkfs.ext4 /dev/volgrp/thislvm

# Mount
sudo mkdir /mnt/thislvm
lsblk -f
sudo mount /dev/volgrp/thislvm /mnt/thislvm
lsblk -f

# LVM management
sudo pvdisplay
sudo pvdisplay /dev/sdx1

sudo vgdisplay
sudo vgdisplay /dev/volgrp

sudo lvdisplay
sudo lvdisplay /dev/volgrp/thislvm

lsblk -f
sudo umount /mnt/thislvm
lsblk -f

df -h
sudo lvresize -r -L 200G /dev/volgrp/thislvm
df -h
sudo lvresize -r -L +10G /dev/volgrp/thislvm
df -h

lsblk -f
df -h
sudo pvmove /dev/sdx3
lsblk -f
df -h
sudo pvremove /dev/sdx3
df -h
lsblk
sudo vgreduce volgpr /dev/sdx3
sudo vgextend volgpr /dev/sdx3

# LVM snapshots

lsblk -f
sudo lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
lsblk -f

sudo mkdir /mnt/thesnap
sudo mount -o ro /dev/volgrp/thesnap /mnt/thesnap
lsblk -f
cd /mnt/thesnap
ls
ls -l

sudo umount /mnt/thesnap
lsblk -f
sudo lvremove /dev/volgrp/thesnap

sudo mount /dev/volgrp/thislvm /mnt/thislvm
lsblk -f
sudo touch /mnt/thislvm/one /mnt/thislvm/two
ls /mnt/thislvm
echo "I am one two" > /mnt/thislvm/echoed
cat /mnt/thislvm/echoed
sudo lvcreate -s -n thesnap -l 128 /dev/volgrp/thislvm
lsblk -f
sudo touch /mnt/thislvm/three /mnt/thislvm/four
ls /mnt/thislvm
sudo echo "I am three four" >> /mnt/thislvm/echoed
cat /mnt/thislvm/echoed
sudo lvconvert --mergesnapshot /dev/volgrp/thesnap
# Re-activate
sudo umount /mnt/thislvm
sudo lvchange -an /dev/volgrp/thislvm # active no
sudo lvchange -ay /dev/volgrp/thislvm # active yes
lsblk -f
mount /dev/volgrp/thislvm /mnt/thislvm
cd /mnt/thislvm
ls
cat echoed

sudo vgremove volgrp
sudo pvremove /dev/sdx1 /dev/sdx2 /dev/sdx3 /dev/sdx4 /dev/sdx5 --force --force
```

| **swap file** :$

```console
sudo swapoff /var/swap.img
sudo touch /var/swap.img
sudo chmod 600 /var/swap.img
sudo dd status=progress if=/dev/zero of=/var/swap.img bs=2M count=1024
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
```

| **disk monitoring & recovery** :$

```console
iostat
iostat -mx
iostat 1 10
sudo iotop
sudo iotop -o
sudo bonnie++ -u 0 -n 0 -f -b -r 150 -d /tmp/
```

| **NBD** :$

```console
# Enable kernel module
sudo modprobe nbd

# Configs and process
vim /etc/nbd-server/config
sudo nbd-server
sudo nbd-server -C /etc/nbd-server/config
sudo mkdir /export
sudo touch /export/foo
sudo touch /export/export1
sudo touch /export/otherexport

# Create the files that will be mounted to the NBD
sudo dd if=/dev/urandom of=/export/foo bs=1M count=128 status=progress
sudo dd if=/dev/urandom of=/export/export1 bs=1M count=128 status=progress
sudo dd if=/dev/urandom of=/export/otherexport bs=1M count=128 status=progress

# Server configs
cat <<EOF >> /etc/nbd-server/config
[generic]
user = nbd 
group = nbd
[foo]
exportname = /export/foo
EOF

cat <<EOF >> /etc/nbd-server/config
[generic]
user = nbd 
group = nbd
[export1]
exportname = /export/export1
EOF

cat <<EOF >> /etc/nbd-server/config
[generic]
user = nbd 
group = nbd
[otherexport]
exportname = /export/otherexport
EOF

# Start the NBD server
nbd-server
ip a # User your NIC IP addresses to replace 192.168.0.9 below

# On client
## It won't work without a network, still type for practice
sudo nbd-client -N foo 192.168.0.9 10809 /dev/nbd0
sudo nbd-client -N export1 192.168.0.9 10809 /dev/nbd1
sudo nbd-client -N otherexport 192.168.0.9 10809 /dev/nbd2

# Remove kernel module
sudo modprobe -r nbd
```

___

#### [Lesson 8: Packages](https://github.com/inkVerb/vip/blob/master/601/Lesson-08.md)