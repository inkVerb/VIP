# Linux 601
## Lesson 12: Backup & System Rescue

# The Chalk
## Backup
1. *Everything breaks; it's not **if**, but **when***
  - There are two types of drives:
    - Drives that *have* failed
    - Drives that *will* fail
2. Backups can make migration easier
  - Routine backup can create the migration payload
  - Backup processes do the legwork of migration coding in advance

### Backup Priorities
- Certainly:
  - Business data (ie: database)
  - Created content (ie: database)
  - Database
  - System configs (if manually configured)
  - Software (if manually installed and )
  - User files
- Maybe:
  - Spooling directories (printer, mail, etc)
  - Logs (`/var/log/`, et al)
- Probably not:
  - Software (if easily/automatically installed)
  - System configs (if automatically configured)
  - `/tmp/` because it is temporary by definition
- Certainly not:
  - Pseudofiles (`/proc/`, `/dev/`, `/sys/`)
  - Swap

### Archives
- Media and storage lifetime
  - Magnetic tapes: 10-30 years
  - CDs and DVDs: 3-10 years
  - Hard Disks: 2-5 years
- Lifetime is affected by:
  - Environmental conditions
  - Quality
  - Hardware/software compatability to read the data

### Backup Methods
- Full: copy all files
- Incremental: Backup only changed files from last full backup
- Differential: Backup only changes per backup level
- User: Only backup files in the user directory

### Backup Strategies
- Backup schedul example
  1. Disk 1 for full backup on Monday
  2. Disk 2-5 for full backup Tuesday-Friday
  3. Disk 6 for full backup next Monday
  4. Disk 2-5 for incremental backup changes Tuesday-Friday
  5. Disk 1 overwrite new full backup on Monday (if Disk 6 is finished)
  6. Disk 6 moves off site for catastrophic disaster
  7. Switch Disks 1 and 6 every Monday after they finish their full back ups

### Backup Utilities
- `tar` - "ball" up many files into one "tarball" (for faster upload/download and file compression prep)
- `cpio` - file archive tool that can include symlinks etc
- `gzip`. `bzip2` & `xz` compress `.tar` files
- `dd` "direct data"; can copy entire partitions and disks (including partition tables)
- `rsync` synchronizes directories across networks
- `dump` & `restore` old, read from filesystem directly; require same filesystem for restore; we have newer alternatices
- `mt` query and position tapes before backup and restore

#### `tar` Tape Archive *(not only for tapes)*
- For extended usage, see [201 Lesson 7: tar, xz, zip, gzip, bzip2](https://github.com/inkVerb/vip/blob/master/201/Lesson-07.md)
- `tar cf /source /place/archive.tar` create `archive.tar` from `/source` directory
- `tar Jcf /source /place/archive.txz` archive and compress with `xz`
- `tar xfp /place/archive.tar` extract, (`p` preserve permissions, should be default anyway)

#### `dd` Device Duplicator
- `dd` was introduced in [Lesson 7: Disk & Partitioning](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)
  - `dd if=/dev/sda of=/dev/sdb` - Backup `sda` to `sdb`
  - `dd if=/dev/sda of=sda.img` - Backup `sda` to an `.img` file
  - `dd if=/dev/sda1 of=sda1.img` -Backup the `sda1` partition to an `.img` file
- The use of `dd` on full devices (in `/dev/`) is another reason to mount each Linux FHS in `/` to a separate partition

#### `rsync` Remote Sync
- Checks small chunks, then only copies differences in the chunks
- `rsync [options] source destination`
- Examples
  - `rsync backup.txz remoteuser@my.backup.host.tld:/home/remoteuser/ownsthis/`
  - `rsync -r backup/folder remoteuser@my.backup.host.tld:/home/remoteuser/ownsthis/` (recursive)
- Flags:
  - `-r` - Recursive (for copying directories)
  - `--dry-run` - Don't actually do anything, only test if the operation would work
  - `--delete` - Delete in destination folder if not in local folder
  - `--delete-delay` - Mark for delete, but delay actual deletion until copy operation finishes
  - More about delete-related flags on [SuperUser](https://superuser.com/a/156702/942694)

#### Backup Software
- **Amanda**: (Advanced Maryland Automatic Network Disk Archiver), uses `tar` and `dump`, but configurable; usually Enterprise Linux distros
- **Bacula**: auto backup on heterogeneous networks, for experienced admins; usually Enterprise Linux distros
- **Clonezilla**: disk cloning, make and deploy disk images; two versions: Live and SE; supports OS other than Linux

## System Rescue
- *Repairs a damaged Linux installation by helping you get into the filesystem where you can do work*
  - This allows an admin to solve problems like a broken GRUB loader or catastrophically damaged `/etc/` directory, corrupted filesystem, etc
  - Recovery may not fully save the system, but at least allow you to access essential files or attempt repairing the filesystem
- Rescue is done one of two ways:
  1. Boot from damaged machine with `rescue` or `emergency` options in the **kernel command** (GRUB menue can help)
  2. Boot from an attached Linux `.iso` image, such as USB (or CD/DVD) or an "attached image" on virtual machines and servers
    - *Plug a Linux USB into the damaged machine and boot from that*

### 1. Rescue via Booting Linux on the Machine
*This boots with `rescue` or `emergency` in the **kernel command** (starts with `linux` in GRUB, seen after boot at `/proc/cmdline`)*

- Do this either:
  1. From some GRUB menu options with "rescue" or "emergency" or similar in the option label
  2. Modify the GRUB command to boot in "emercengy" mode...

#### Emergency or Rescue Mode
- In emergency mode
  - The installed filesystem is read-only
  - `init` never runs
  - Useful if `init` is the problem
  - The filesystem is read-only
- In rescue mode
  - Some system services start
  - This is a "single-user" mode, having started some of the `init` targets
  - The filesystems try to mount
  - `root` access without password
- Boot in emergency or rescue mode:
  1. Select an entry from the GRUB menu
  2. Press <key>E</key> for "edit"
    - If you don't like what you see, press <key>Esc</key> and return to step 1 to select a menu item you like more in step 2
  3. Add the word `emercengy` or `rescue` to the kernel command line in the config file
  4. Press <key>F10</key> or other instructions to boot
- Once booted, you can work your SysAdmin magic

### 2. Boot from Attached `.iso` or Plugged Linux USB

#### Tools Available via Attached Linux `.iso` Image
*Booting from a live Linux image makes common tools available, which we have covered elsewhere...*

- Disk:
  - `fdisk`
  - `mkfs`
  - `mdadm` (RAID)
  - `lvcreate`
  - `pvcreate`
  - `vgcreate`
- Network:
  - `host`
  - `ifconfig`
  - `ipconfig`
  - `traceroute`
  - `route`
  - `mtr`
  - `ftp`
  - `scp`
  - `ssh`
- System management:
  - `chroot`
  - `update-grub`
  - `ps`
  - `kill`
  - `rpm`
  - `dnf`
  - `apt-get`
  - `pacman`
  - `dd`
  - `tar`
  - `gzip`
  - `mkdir`
  - `ls`
  - `cp`
  - `mv`
  - `rm`
  - `cat`
  - `vim`
  - `nano`

#### Create Linux Install/Rescue USB:
  1. Download your Linux `.iso` image for your distro
  2. Burn it to a USB
    - On Linux with `sudo dd bs=4M if=my_linux_dl_image.iso of=/dev/sdX conv=fdatasync status=progress`
      - `sdX` is the USB device found with `lsblk`
      - `my_linux_dl_image.iso` is the Linux `.iso` image you downloaded
    - Or use `livecd-tools` or `liveusb-creator` packages to help do it for you
    - Or for many non-Arch/non-Manjaro distros use your own Linux, Windows, or Mac machine to run [UNetbootin](https://unetbootin.github.io/)
    - Windows and Mac also have tools to burn an `.iso` image to a USB such as [Rufus](https://rufus.ie/)

#### Puppeting a the Dead Linux Machine: `chroot`
- *One OS can puppet another OS*
  - OS-A is dead on the machine
  - OS-B is running from a plugged USB, already booted
    - *Plug a Linux USB, <key>F12</key>/<key>Esc</key> etc boot menu, choose the USB*
  - OS-B runs and manages files on dead OS-A disks *as if* it was OS-A

| **chroot machine from USB** : OS-B #

```console
lsblk
mkdir /mnt/sysimage
mount /dev/sdX /mnt/sysimage
chroot /mnt/sysimage
```
  - *`sdX` (`mount` line) is the device hosting the root directory of dead machine OS-A found with `lsblk`*
    - *More mounting may be needed if root Linux folders are on multiple partitions, then just use `mkdir` and `mount` to recreate the normal FHS as you normally would after the `mount` line and before `chroot` line*
  - Thus OS-A `/` is at OS-B `/mnt/sysimage`
  - Your terminal from OS-B becomes the puppet master of the OS-A puppet dead machine with this `chroot` command: #
    - `chroot /mnt/sysimage`
    - Then you have access to work your SysAdmin magic
- This almost always happens automatically behind the scenes when installing mainstream Linux distros
  - This helps get the new OS get "moved in and arrange the furniture" when being installed (ie device drivers, user credentials, etc)
  - `chroot` is used manually when installing Arch
- This is often called a "chroot-ed" environment
- `chroot` is a standard start for fixing things on a broken Linux installation, including to repair GRUB (per [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md))
- Some commands allow non-chroot-ed access, ie SUSE/CentOS # `rpm -ivh --force --root=/mnt/sysimage /mnt/source/Packages/somepackage.rpm`

___

# The Type

```console

```

___

# Done! Have a cookie: ### #

It's time to go to [The Linux Foundation](https://training.linuxfoundation.org/) and get certified

Search for the *Linux Foundation Certified System Administrator (LFCS)* certification
