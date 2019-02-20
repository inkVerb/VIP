# Shell 401
## Lesson 2: File System Hierarchy (FSH)
___

`cd /`

`ls`

`nautilus . &` *Follow along in the file browser through this lesson.*

*This is the root of the Linux file system.*

### `/` – Root Directory

This is the directory of all directories.

### Settings that change

#### `/home/` — Home Directory (for normal users)

`cd home`

`ls`

This is where your stuff goes. All your `Documents/` and `Downloads/` and `Desktop/` and other folders are in `/home/YOURUSER/`, which is also the same as `~/` since it changes from user to user.

#### `/root/` – "Root" user Home Directory (also what `sudo` calls 'home')

`cd ../root`

`ls`

This is the "home" folder where stuff is kept when the "root" user needs to do something. If you login as "root", the first directory you see in the terminal should be here, written as `~/` in the terminal.

It might contain nothing.

#### `/etc/` — Et Cetera (settings)

`cd ../etc`

`ls`

This is where most system-specific settings are stored, for example Apache, PHP, MySQL and others will have there core, most fundamental settings here. As an admin, you will need to adjust settings in this directory often.

Originally, this was the directory with all the stuff that didn't seem to belong anywhere else and was, accordingly called the *"et cetera" (etc.)* directory. It should probably still be  called that.

This has been "[backronymed](https://unix.stackexchange.com/a/56159/315069)" as *"Editable Text Configuration"* (which makes a lot of sense) and also *"Extended Tool Chest"* (which doesn't make sense, but it's more fun).

This directory has a lot of stuff.

#### `/lost+found/` Lost & Found (corrupt-but-found files)

`cd ../lost+found`

`ls`

If the system crashes, then runs a file system check, then finds damaged files, they will go here.

Don't look here, you have better things to do.

### Read-only

#### `/boot/` – Boot files (for system boot)

`cd ../boot`

`ls`

This is for stuff that helps the computer to turn on. Don't mess.

#### `/lib/` — Shared Libraries (may be used by many different applications)

`cd ../lib`

`ls`

Files that go here may be occasionally be called "dependencies". Such a "library" is a set of files used by a variety of different software applications. These libraries are used quite often by graphic and media apps since many desktop media apps actually share many of the same backend tools.

#### `/bin/` — Binaries (system-wide applications)

`cd ../bin`

`ls`

A "binary" is a computer program that has been "compiled" into using core computer language that humans can't read or understand. This is where programs like `sed`, `cat`, `echo`, `cp`, `ls`, `grep`, et cetera actually live. Most Linux commands are actually small programs that can be found in this directory, `sh` and `bash` from `#!/bin/sh` and `#!/bin/bash` included!

This is for base-system commands, this is *NOT* where installed software goes.

#### `/sbin/` — System Binaries (root only)

`cd ../sbin`

`ls`

These are more basic binaries, but they are used by the system processes, not a normal part of the Shell language because most users won't use these.

### Installed Packages

#### `/usr/` — User Binaries (mostly desktop programs)

`cd ../usr`

`ls`

*Peek in this directory:*

`cd bin`

`ls`

This is where installable binaries go from installable packages. When you run `sudo apt install SOMETHING` the installed program will usually put its executable files here.

It is called the "user" directory because, for the most part, all desktop users will access binaries (programs) that have been installed to this directory.

Debian (.deb files) should install here in order to be "properly" installed.

`cd ..`

#### `/opt/` – Optional Packages (resident aliens)

`cd ../opt`

`ls`

This is where applications go when they don't follow the rules of this file system hierarchy. This is a great place to put your own software while you are being inventive.

#### `/snap/`

`cd ../snap`

`ls`

This is where "snap" applications are installed. Snap is different from the system Debian repository structure. It has its own install and repository structure, but is included in the Ubuntu Software Center as of Ubuntu 18.04.

Snap is a more powerful way of managing apps because it runs every app in its own "container", so if it crashes it does not risk crashing the entire system.

### Connected gadgets

#### `/cdrom/` – CD-ROM mount path location in days of yore and lore

`cd ../cdrom`

`ls`

This is the classic path to the on-board CD-ROM drive.

#### `/dev/` — Devices

`cd ../dev`

`ls`

A bluetooth device may be in here somewhere.

#### `/mnt/` — Mount (temporarily mount permanently connected drives)

`cd ../mnt`

`ls`

This is where that Windows partition may show up if you decide to take a look at it while booted in Linux. It's also where other, non-system storage drives will appear when mounted

#### `/media/` — Removable Media (i.e. USB drives)

`cd ../media`

`ls`

This is where USB-connected drives usually mount.

### Ever-changing

#### `/var/` — Variable Data

`cd ../var`

`ls`

This usually contains `www/` (website files on a webserver) and `log/` for log files.

This is also where email may be stored in `email/` or `mail/` or `vmail/` or something like that.

This is usually where the .swp "swap file" (virtual RAM) goes, if it is a file and not a partition.

Things here can and may need to change often.

#### `/srv/` – Service Data (data for services provided by the system)

`cd ../srv`

`ls`

This is another place the `www/` directory can go, or where a server will keep shared/served files to make them available on a local network.

#### `/run/` – Running processes (a place to keep stuff that won't get deleted)

`cd ../run`

`ls`

This is where some applications put their own "while-running" files, caches, and other files that may need to be semi-temporary, but that shouldn't be automatically deleted.

#### `/proc/` — Kernel & Process (files used by the kernel)

`cd ../proc`

`ls`

These are essential for the most basic part of the system to function.

#### `/sys/` – System's virtual file (live kernel information)

`cd /sys`

`ls`

This is a virtual file system, allowing normal text-file-like access to information about the system. It can contain live (virtual) text files that change as the system changes.

#### `/tmp/` — Temporary files (one-time files)

`cd ../tmp`

`ls`

These eventually get deleted by the system. Usually, when you choose to "open" a file from the Internet, rather than "save" it, the file is saved here.

### What's important?

Here are some of the more "important" directories to remember, at first:

- `/home/`
- `/bin/`
- `/lib/`
- `/etc/`
- `/usr/`
- `/opt/`
- `/mnt/`
- `/media/`
- `/dev/`
- `/var/`
- `/tmp/`

#### [Lesson 3: Cron Daemon](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-03.md)
