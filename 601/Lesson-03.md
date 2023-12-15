# Linux 601
## Lesson 3: Disk & Partitioning

Ready the CLI

```console
cd ~/School/VIP/601
```

___

### I. Section 1

| **1** :$

```console
command 1
```


___

# The Take
## Filesystems
- LMV
- ext4
- btrfs
- swap
## Information
- `du` (directory space use)
  - `du -h` (human-readable ie: G, M, K, etg)
  - `du -s` (only size of parent directories, not  subdirectories)
  - `du -x` (eXclude other file systems, such as other mounted drives)
  - `du -c` (calculate total)
- `df` (disk file system use)
  - `df -h` (each disk)
  - `df -h .` (current disk)
- `lsblk` (list block volumes, including dev path)
    - `lsblk -f` (also label, UUID, size, use)
- `blkid /dev/sda1` (get UUID of `/dev/sda1`)
- `ls -l /dev/disk/by-uuid/`
## Partitioning
- `fdisk /dev/sda` (interactive)
## Formatting
- Use the extension for the drive type
  - Get an easy list: `ls /usr/bin/mkfs*`
- `mkfs.ext4 /dev/sda1`
- `mkfs.btrfs /dev/sda1`
- `mkfs.ntfs /dev/sda1` (`-> /usr/bin/mkntfs`)
- `mkfs.swap /dev/sda1`

### Swap
- Example: (2G swap file)
```bash
swapoff /var/swap.img
touch /var/swap.img
chmod 600 /var/swap.img
dd if=/dev/zero of=/var/swap.img bs=2M count=1024
mkswap /var/swap.img
swapon /var/swap.img
```
## Managing & Mounting
- `fstab`
- `mount`
- `umount`

## I/O
- Writing to and from a disk can cause an input-output pileup
- Tools: (Arch Linux needs packages: `sysstat`, `iotop`, `bonnie++`)
  - `iostat` - monitor I/O by disk devices
    - `-m` megabites
    - `-x` details
  - `iotop` - current I/O usage, must run as `root`
    - `-o` only processes doing I/O
- Stress test tools
  - `bonnie++` - tests writing to file systems
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
```
___

#### [Lesson 4: Kernel](https://github.com/inkVerb/vip/blob/master/601/Lesson-04.md)