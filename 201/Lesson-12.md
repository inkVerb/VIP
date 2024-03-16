# Linux 201
## Lesson 12: Filesystem Hierarchy Standard (FHS)

Ready the CLI (might not be needed)

```console
cd ~/School/VIP/201
```

- [Read more on Wikipedia](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
- [Read specs from Linux Foundation](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)

___

**`vim` and `nano` are often the best ways to edit settings files**

| **1** :$

```console
cd /
```

| **2** :$

```console
du -hsxc --exclude=proc *
```

## *"Everything in Linux is a file."*

### `/` – Root Directory

*This is the root of the Linux file system*

This is the directory containing all directories

### Settings that change

#### `/home/` — Home Directory (for normal users)

| **3** :$

```console
cd home
```

| **4** :$

```console
ls -lF
```

This is where your stuff goes. All your `Documents/` and `Downloads/` and `Desktop/` and other folders are in `/home/YourUSER/`, which is also the same as `~/` since it changes from user to user.

#### `/root/` – "Root" user Home Directory (also what `sudo` calls 'home')

This is also called "slash root", not to be confused with "the root directory" `/`

| **5** :$ *"Permission denied" ?? Sometimes it doesn't exist, depending on whether root has created it*

```console
cd ../root
```

| **6** :$

```console
ls -lF
```

This is the "home" folder where stuff is kept when the "root" user needs to do something. If you login as "root", the first directory you see in the terminal should be here, written as `~/` in the terminal.

It might contain nothing.

#### `/etc/` — Et Cetera (settings)

| **7** :$

```console
cd ../etc
```

| **8** :$

```console
ls -lF
```

This is where most system-specific settings are stored, for example Apache, PHP, MySQL and others will have there core, most fundamental settings here. As an admin, you will need to adjust settings in this directory often.

- **`.d`** (for *directory*) is a common ending for directories that hold multiple config files *for tools or services that only need one config file*
  - having multiple config files can help many ways:
    - organize
    - customize
    - override the main config file
    - include these config files in the main config file

For example:

- `/etc/apparmor.d/`
- `/etc/conf.d/`
- `/etc/cron.d/`
- `/etc/grub.d/`
- `/etc/ipsec.d/`
- `/etc/modprobe.d/`
- `/etc/pacman.d/`
- `/etc/pam.d/`
- `/etc/profile.d/`
- `/etc/sudoers.d/`

- Many files in these directories use a two-digit prefix to address `include` or `source` load priority
  - ie: `00-defaults.conf` would load before `10-defaults.conf` in the same directory
- Many different software packages and tools use this

Originally, this was the directory with all the stuff that didn't seem to belong anywhere else and was, accordingly called the *"etc" (etc)* directory. It should probably still be  called that.

This has been "[backronymed](https://unix.stackexchange.com/a/56159/315069)" as *"Editable Text Configuration"* (which makes a lot of sense) and also *"Extended Tool Chest"* (which doesn't make sense, but it's more fun).

This directory has a lot of stuff.

#### `/lost+found/` Lost & Found (corrupt-but-found files)

If the system crashes, then runs a file system check, then finds damaged files, they will go here.

Don't look here, you have better things to do.

### Read-only

#### `/boot/` – Boot files (for system boot)

| **9** :$

```console
cd ../boot
```

| **10** :$

```console
ls -lF
```

This is for stuff that helps the computer to turn on. Don't mess.

#### `/lib/` — Shared Libraries (may be used by many different applications)

| **11** :$

```console
cd ../lib
```

| **12** :$

```console
ls -lF
```

Files that go here may be occasionally be called "dependencies". Such a "library" is a set of files used by a variety of different software applications. These libraries are used quite often by graphic and media apps since many desktop media apps actually share many of the same backend tools.

#### `/bin/` — Binaries (system-wide applications)

| **13** :$

```console
cd ../bin
```

| **14** :$

```console
ls -lF
```

A "binary" is a computer program that has been "compiled" into using core computer language that humans can't read or understand. This is where programs like `sed`, `cat`, `echo`, `cp`, `ls`, `grep`, etc actually live. Most Linux commands are actually small programs that can be found in this directory, `sh` and `bash` from `#!/bin/sh` and `#!/bin/bash` included!

This is for base-system commands, this is *NOT* where installed software goes.

#### `/sbin/` — System Binaries (root only)

| **15** :$

```console
cd ../sbin
```

| **16** :$

```console
ls -lF
```

These are more basic binaries, but they are used by the system processes, not a normal part of the Shell language because most users won't use these.

### Installed Packages

#### `/usr/` — User Binaries (mostly desktop programs)

| **17** :$

```console
cd ../usr
```

| **18** :$

```console
ls -lF
```

This is where installable binaries go from installable packages. When you run `sudo apt install Something` the installed program will usually put its executable files here.

It is called the "user" directory because, for the most part, all desktop users will access binaries (programs) that have been installed to this directory.

Debian (.deb files) should install here in order to be "properly" installed.

#### `/opt/` – Optional Packages (resident aliens)

| **19** :$

```console
cd ../opt
```

| **20** :$

```console
ls -lF
```

This is where applications go when they don't follow the rules of this file system hierarchy. This is a great place to put your own software while you are being inventive.

#### `/snap/`

| **21** :$ *"No such file or directory" if you don't have any snap apps installed*

```console
cd ../snap
```

| **22** :$

```console
ls -lF
```

This is where "snap" applications are installed. Snap is different from the system Debian repository structure. It has its own install and repository structure, but is included in the Ubuntu Software Center as of Ubuntu 18.04

Snap is a more powerful way of managing apps because it runs every app in its own "container", so if it crashes it does not risk crashing the entire system

### Connected gadgets

#### `/cdrom/` – CD-ROM mount path location in days of yore and lore

| **23** :$ *"No such file or directory" if you don't have a CD in the drive, which you probably don't*

```console
cd ../cdrom
```

| **24** :$

```console
ls -lF
```

This is the classic path to the on-board CD-ROM drive

#### `/mnt/` — Mount (temporarily mount permanently connected drives)

| **25** :$

```console
cd ../mnt
```

| **26** :$

```console
ls -lF
```

This is where that Windows partition may show up if you decide to take a look at it while booted in Linux. It's also where other, non-system storage drives will appear when mounted

#### `/media/` — Removable Media (i.e. USB drives)

| **27** :$ *"No such file or directory" if you don't have a USB in the drive, which you probably don't*

```console
cd ../media
```

| **28** :$

```console
ls -lF
```

This is where USB-connected drives usually mount.

### Ever-changing

#### `/var/` — Variable Data

| **29** :$

```console
cd ../var
```

| **30** :$

```console
ls -lF
```

This usually contains...

- Log files: `log/`
- SQL databases: `lib/mysql/` (MySQL/MariaDB) or `lib/pgsql` (PostgreSQL)
- Swap: the .swp "swap file" (virtual RAM), if it is a file and not a partition

Things here can and need to change often.

This usually contains `www/` (webserver directory) for:

- Red Hat (CentOS & Fedora)
- Debian (Debian & Ubuntu)

#### `/srv/` – Service Data (data for services provided by the system)

| **31** :$

```console
cd ../srv
```

| **32** :$

```console
ls -lF
```


This is for "served" files or services by name

- `mail/` or `vmail/`
- `ftp/`
- `www/`

It is used this way on:

- Arch (& Manjaro)
- openSUSE (& SUSE)

Fedora and Debian use `/var/` for served files and leave `/srv/` empty

### Pseudo file systems

These are *pseudo* file systems, which exist in memory only

When the system is not running, these directories are empty and when running they don't take up disk space

- `/dev/`
- `/proc/`
- `/run/`
- `/sys/` 

#### `/dev/` — Devices

| **33** :$

```console
cd ../dev
```

| **34** :$

```console
ls -l
```

*Note permissions starting with `b` for "block devices" or `c` for "character devices"*

Example:

```console
brw-rw----  1 root disk ... some-block
crw--w----  1 root tty  ... some-tty
```

A bluetooth device may be in here somewhere

#### `/proc/` — Kernel & Process (files used by the kernel)

| **35** :$

```console
cd ../proc
```

| **36** :$

```console
ls -lF
```

These are essential for the most basic part of the system to function

When runninf `du` from `/` (as in command 2), it is good to add `--exclude=proc` because they don't take actual space

#### `/run/` – Running pipes & sockets (the socket drawer)

This contains "while-running" files, caches, sockets, pipes, and other files that may need to be semi-temporary, but that shouldn't be automatically deleted.

| **37** :$

```console
cd ../run
```

- This is often linked to `/var/run`
- This uses "socket" files

| **38** :$

```console
ls -lF
```

*Note permissions starting with `s` for "socket" and `p` for "pipe"*

Example:

```console
srw-rw-rw- 1 root root ... some.socket
prw------- 1 root root ... some-pipe
```

Sockets should usually kept in subdirectories of `/run/`

| **39** :$

```console
ls -lF
```

##### Sockets & `/run/` subdirectories

If you install a package that uses a socket, you may need to create the directory where the socket file lives, but the app using the socket will create the socet file by itself

So, if you have an app with a setting...

| **/etc/myapp.conf** :

```
sock=/run/myapp/myapp.socket
```

...you may need to create the directory...

```
/run/myapp/
```

...then the app will work, but...

Extra subdirectories in `/run/` are deleted on system restart

To add a subdirectory in `/run/`, tell the system to make it on boot via a file in `/etc/tmpfiles.d/`

Example:

| **/etc/tmpfiles.d/myapp.conf** :

```
d /run/myapp 0755 www www
```

You could also create the `/run/` subdirectory so the app will run without reboot

#### `/sys/` – System's virtual file (live kernel information)

| **40** :$

```console
cd /sys
```

| **41** :$

```console
ls -lF
```

This is a virtual file system, allowing normal text-file-like access to information about the system. It can contain live (virtual) text files that change as the system changes.

#### `/tmp/` — Temporary files (one-time files)

| **42** :$

```console
cd ../tmp
```

| **43** :$

```console
ls -lF
```

These eventually get deleted by the system. Usually, when you choose to "open" a file from the Internet, rather than "save" it, the file is saved here.

___

# The Take

- Directories in Linux hold different things
  - This is called "Filesystem Hierarchy Standard (FHS)"
- `/` is the beginning of all directories in the FHS
  - ***Any*** path beginning with `/` will refer to the root of the FHS!
- All home directories (with personal user stuff) are in `/home/`
- The "root" (AKA `su`) user's home is `/root/`, ***not*** `/home/root/`!
- `/bin/` holds most of the Linux/Unix commands we use all the time
- `/var/` holds
  - Logs
  - Variables
  - The `/var/lib/mysql/` MySQL database folder
- `/srv/` is for served files, like web or mail
  - `mail/`
  - `www/`
  - `ftp/`
- `/srv/` and `/var/` are often used for the same services on different Linux distros
- `/lib/` holds common libraries used by multiple apps
- `/usr/` holds the core "binary" files for most desktop apps
- Settings for apps usually reside in either:
  - `/home/$USER/.some-config-dir/` "hidden" directories that begin with a `.` in a user's home (most desktop apps)
  - `/etc/` (most non-desktop apps)
- `/etc/` holds text-controlled settings for system apps like MySQL, PHP, Python, Apache, Nginx, etc
- `/media/` is where USB drives usually mount
- `/mount/` is where internal drives (ie SATA) usually mount
- `/sbin/`, `/boot/`, `/sys/` are core operating system folders, don't touch!
- `/tmo/` is where most temporary files go, including browser downloads in progress
- `/opt/` is for software that doesn't always follow these "FHS" rules
- Pseudo directories that exist in memory only, empty when the system is not running
  - `/dev/`
  - `/proc/`
  - `/sys/`
  - `/run/`
    - `/run/` is for sockets
      - `/var/run/` is often a symlink of `/run/`
      - A socket file needs its directory to be created, the software will create the actual socket file by itself
      - Socket files often have a location setting in the `/etc/...` settings files
___

# Done! Have a cookie: ### #

Oh, what's this?

## Arch/Manjaro

| **A1** :$

```console
alsamixer
```

Don't have it yet?

| **A2** :$

```console
sudo pacman -S --noconfirm alsa-utils
```

Learn more at the [alsamixer manual page](https://linux.die.net/man/1/alsamixer)

Oh, and then there's this...

| **A3** :$

```console
sudo pacman -S --noconfirm gnome-nibbles
```

## Debian/Ubuntu

| **D1** :$

```console
alsamixer
```

Don't have it yet?

| **D2** :$

```console
sudo apt install alsamixer
```

Learn more at the [alsamixer manual page](https://linux.die.net/man/1/alsamixer)

Oh, and then there's this...

| **D3** :$

```console
sudo apt install gnome-nibbles
```

___

*Now is your best time to learn `vim` fast and easy; it thinks how Shell thinks, and it is powerfully useful*

## **Learn** :$

```console
vimtutor
```

## Next: [Linux 301: Logic](https://github.com/inkVerb/VIP/blob/master/301/README.md)
