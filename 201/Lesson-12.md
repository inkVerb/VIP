# Shell 201
## Lesson 12: File System Hierarchy (FSH)

Ready the CLI (might not be needed)

`cd ~/School/VIP/201`

___

**`vim` and `nano` are often the best ways to edit settings files**

| **1** :$ `cd /`

| **2** :$ `ls`


*This is the root of the Linux file system.*

### `/` – Root Directory

This is the directory of all directories.

### Settings that change

#### `/home/` — Home Directory (for normal users)

| **3** :$ `cd home`

| **4** :$ `ls`

This is where your stuff goes. All your `Documents/` and `Downloads/` and `Desktop/` and other folders are in `/home/YourUSER/`, which is also the same as `~/` since it changes from user to user.

#### `/root/` – "Root" user Home Directory (also what `sudo` calls 'home')

| **5** :$ `cd ../root` "Permission denied" ?? Sometimes it doesn't exist, depending on whether root has created it*

| **6** :$ `ls`

This is the "home" folder where stuff is kept when the "root" user needs to do something. If you login as "root", the first directory you see in the terminal should be here, written as `~/` in the terminal.

It might contain nothing.

#### `/etc/` — Et Cetera (settings)

| **7** :$ `cd ../etc`

| **8** :$ `ls`

This is where most system-specific settings are stored, for example Apache, PHP, MySQL and others will have there core, most fundamental settings here. As an admin, you will need to adjust settings in this directory often.

Originally, this was the directory with all the stuff that didn't seem to belong anywhere else and was, accordingly called the *"etc" (etc)* directory. It should probably still be  called that.

This has been "[backronymed](https://unix.stackexchange.com/a/56159/315069)" as *"Editable Text Configuration"* (which makes a lot of sense) and also *"Extended Tool Chest"* (which doesn't make sense, but it's more fun).

This directory has a lot of stuff.

#### `/lost+found/` Lost & Found (corrupt-but-found files)

If the system crashes, then runs a file system check, then finds damaged files, they will go here.

Don't look here, you have better things to do.

### Read-only

#### `/boot/` – Boot files (for system boot)

| **9** :$ `cd ../boot`

| **10** :$ `ls`

This is for stuff that helps the computer to turn on. Don't mess.

#### `/lib/` — Shared Libraries (may be used by many different applications)

| **11** :$ `cd ../lib`

| **12** :$ `ls`

Files that go here may be occasionally be called "dependencies". Such a "library" is a set of files used by a variety of different software applications. These libraries are used quite often by graphic and media apps since many desktop media apps actually share many of the same backend tools.

#### `/bin/` — Binaries (system-wide applications)

| **13** :$ `cd ../bin`

| **14** :$ `ls`

A "binary" is a computer program that has been "compiled" into using core computer language that humans can't read or understand. This is where programs like `sed`, `cat`, `echo`, `cp`, `ls`, `grep`, etc actually live. Most Linux commands are actually small programs that can be found in this directory, `sh` and `bash` from `#!/bin/sh` and `#!/bin/bash` included!

This is for base-system commands, this is *NOT* where installed software goes.

#### `/sbin/` — System Binaries (root only)

| **15** :$ `cd ../sbin`

| **16** :$ `ls`

These are more basic binaries, but they are used by the system processes, not a normal part of the Shell language because most users won't use these.

### Installed Packages

#### `/usr/` — User Binaries (mostly desktop programs)

| **17** :$ `cd ../usr`

| **18** :$ `ls`

This is where installable binaries go from installable packages. When you run `sudo apt install Something` the installed program will usually put its executable files here.

It is called the "user" directory because, for the most part, all desktop users will access binaries (programs) that have been installed to this directory.

Debian (.deb files) should install here in order to be "properly" installed.

#### `/opt/` – Optional Packages (resident aliens)

| **19** :$ `cd ../opt`

| **20** :$ `ls`

This is where applications go when they don't follow the rules of this file system hierarchy. This is a great place to put your own software while you are being inventive.

#### `/snap/`

| **21** :$ `cd ../snap`

| **22** :$ `ls`

This is where "snap" applications are installed. Snap is different from the system Debian repository structure. It has its own install and repository structure, but is included in the Ubuntu Software Center as of Ubuntu 18.04.

Snap is a more powerful way of managing apps because it runs every app in its own "container", so if it crashes it does not risk crashing the entire system.

### Connected gadgets

#### `/cdrom/` – CD-ROM mount path location in days of yore and lore

| **23** :$ `cd ../cdrom`

| **24** :$ `ls`

This is the classic path to the on-board CD-ROM drive.

#### `/dev/` — Devices

| **25** :$ `cd ../dev`

| **26** :$ `ls`

A bluetooth device may be in here somewhere.

#### `/mnt/` — Mount (temporarily mount permanently connected drives)

| **27** :$ `cd ../mnt`

| **28** :$ `ls`

This is where that Windows partition may show up if you decide to take a look at it while booted in Linux. It's also where other, non-system storage drives will appear when mounted

#### `/media/` — Removable Media (i.e. USB drives)

| **29** :$ `cd ../media`

| **30** :$ `ls`

This is where USB-connected drives usually mount.

### Ever-changing

#### `/var/` — Variable Data

| **31** :$ `cd ../var`

| **32** :$ `ls`

This usually contains...

- `log/` for log files.
- `email/` or `mail/` or `vmail/` for email
- the .swp "swap file" (virtual RAM), if it is a file and not a partition

Things here can and may need to change often.

This usually contains `www/` (webserver directory) for:

- Red Hat (CentOS & Fedora)
- Debian (Debian & Ubuntu)

#### `/srv/` – Service Data (data for services provided by the system)

| **33** :$ `cd ../srv`

| **34** :$ `ls`

This contains `www/` (webserver directory) for:

- Arch
- Suse

#### `/run/` – Running processes (a place to keep stuff that won't get deleted)

| **35** :$ `cd ../run`

| **36** :$ `ls`

This is where some applications put their own "while-running" files, caches, and other files that may need to be semi-temporary, but that shouldn't be automatically deleted.

#### `/proc/` — Kernel & Process (files used by the kernel)

| **37** :$ `cd ../proc`

| **38** :$ `ls`

These are essential for the most basic part of the system to function.

#### `/sys/` – System's virtual file (live kernel information)

| **39** :$ `cd /sys`

| **40** :$ `ls`

This is a virtual file system, allowing normal text-file-like access to information about the system. It can contain live (virtual) text files that change as the system changes.

#### `/tmp/` — Temporary files (one-time files)

| **41** :$ `cd ../tmp`

| **42** :$ `ls`

These eventually get deleted by the system. Usually, when you choose to "open" a file from the Internet, rather than "save" it, the file is saved here.

___

# The Take

- Directories in Linux hold different things
  - This is called "File System Hierarchy (FSH)"
- `/` is the beginning of all directories in the FSH
  - ***Any*** path beginning with `/` will refer to the root of the FSH!
- All home directories (with personal user stuff) are in `/home/`
- The "root" (AKA `su`) user's home is `/root/`, ***not*** `/home/root/`!
- `/bin/` holds most of the Linux/Unix commands we use all the time
- `/var/` holds
  - Logs
  - The `/var/www/` "web" folder used by Apache and Nginx web servers
  - The `/var/lib/mysql/` MySQL database folder
  - Email folders
- `/lib/` holds common libraries used by multiple apps
- `/usr/` holds the core "binary" files for most desktop apps
- Settings for apps usually reside in either:
  - `/home/$USER/.some-config-dir/` "hidden" directories that begin with a `.` in a user's home (most desktop apps)
  - `/etc/` (most non-desktop apps)
- `/etc/` holds text-controlled settings for system apps like MySQL, PHP, Python, Apache, Nginx, etc
- `/media/` is where USB drives usually mount
- `/mount/` is where internal drives (ie SATA) usually mount
- `/sbin/`, `/boot/`, `/proc/`, `/srv/`, `/sys/` are core operating system folders, don't touch!
- `/tmo/` is where most temporary files go, including browser downloads in progress
- `/opt/` is for software that doesn't always follow these "FSH" rules

___

# Done! Have a cookie: ### #

Oh, what's this?

| **D1** :$ `alsamixer`

Don't have it yet?

| **D2** :$ `sudo apt install alsamixer`

*Some older Linux distros not supported*

Learn more at the [alsamixer manual page](https://linux.die.net/man/1/alsamixer)

Oh, and then there's this...

| **D3** :$ `sudo apt install gnome-nibbles`

___

*Now is your best time to learn `vim` fast and easy; it thinks how Shell thinks, and it is powerfully useful*

## **Learn** :$ `vimtutor`

## Next: [Shell 301: Logic](https://github.com/inkVerb/VIP/blob/master/301/README.md)
