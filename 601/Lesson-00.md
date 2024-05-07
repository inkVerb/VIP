# Linux 601
## Lesson 0: POSIX & Lesson Layout

### Cheat Sheets

These are helpful for installing network simulation tools on Arch or Manjaro

- [CISCO Packet Tracer](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Packet-Tracer.md)
- [Oracle VirtualBox](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md)

___

## The Chalk
### *The Chalk* Instructions Precede *The Keys* Commands
- In units *101-501*, lessons began with explanation and commands to demonstrate, then ended with *The Take*
  - The *Linux 601* unit will not follow this format
- SysAdmin lessons are primarily conceptual and secondarily practice
- These conceptual lessons will begin with *The Chalk*, then follow in a *The Keys* section
- *The Chalk* explains history, packages, programs, usage, theory, and implementation
- *The Keys* are practice commands to reinforce teachings from *The Chalk*
  - Practice commands for SysAdmins who already understand them
  - Intended to be manually typed into the terminal as practice for real world or examination of SysAdmin work
  - These commands are intended to be examples only
  - You should be able to type varied versions of these from memory
  - You should understand these commands
- *The Keys* commands flow with *The Chalk* and you can follow along with two browser tabs or windows
- *The Keys* terminal exercises are meant to be repeated many times so using the information from *The Chalk* becomes second-nature

### POSIX
- POSIX standards are published by the [OpenGroup](https://www.opengroup.org/posix-systems)
  - [2008](https://pubs.opengroup.org/onlinepubs/9699919799/)
  - [2017](https://pubs.opengroup.org/onlinepubs/9699919799/)
  - Install POSIX `man` pages package:
    - Arch package: `posix`
    - Debian package: `manpages-posix-dev`
    - OpenSUSE package: `man-pages-posix`
    - RedHat/CentOS: install manually
- [POSIX (Portable Operating System Interface)](https://en.wikipedia.org/wiki/POSIX) is the [standard](https://stackoverflow.com/a/1780614/10343144) for Unix-like (incl Linux) users, scripting, interfaces, operations, etc
- It is set by the [IEEE (Institute of Electrical and Electronics Engineers)](https://www.ieee.org/)
- All Linux scripts, file formats, and user settings should be [POSIX-compliant](https://superuser.com/questions/322601/) before being released as a Linux package or distro
- In SysAdmin work, the term POSIX will come up, so know that it refers to "proper Unix/Linux"
- Reputable Unix/Linux programmers will concern themselves with POSIX compliance
  - Nearly every package or program we install was developed by people who spent a lot of time making sure their software was POSIX-compliant
  - Full POSIX compliance rules are part of separate research or certification and are not covered in this course
- POSIX compliance examples:
  - For shell scripts: `#!/bin/sh` is not POSIX-compliant; `#!/bin/bash` is POSIX-compliant
  - `source` is not a POSIX-compliant way to "include" files in a script; POSIX-compliance uses dot-space (`. `) at the start of the line
  - A "user" can be almost anything; a "POSIX user" is a registered user on a Unix/Linux operating system with log in credentials, permissions, groups, etc
  - The Filesystem Hierarchy Standard (FHS) is used in [Linux and Unix, but not part of POSIX compliance](https://unix.stackexchange.com/questions/98751), see ([201 Lesson 12: FHS](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md))

### Daemons: `*d` Suffix
- In unit [201 Lesson 12: FHS](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md), we saw how `/etc/SERVICE.d/` would be a directory containing multiple config files for a given service
- Many cloud services have tools for a client and a server
  - Nextcloud
  - WebDAV
  - Email
  - LDAP
  - SSH
  - FTP
  - Countless others
- The server software is often called a **daemon**
- While many client configs reside in `/etc/` as, say, `SERVICE`, the server configs may have a `d` appended to the end of the files or directories
- A good example of this is the `ssh` service, which we will learn more about in [Lesson 9: PAM & Cloud](https://github.com/inkVerb/vip/blob/master/601/Lesson-09.md)
  - SSH client configs: `/etc/ssh_config` & `/etc/ssh_config.d/`
  - SSH server configs: `/etc/sshd_config` & `/etc/sshd_config.d/`
- Seeing a service with both names of, say, `SERVICE` and `SERVICEd` can make it easy to know whether you are woring wiht the `SERVICE` client or with the `SERVICEd` daemon/server

### User Prompts: **#** or **$** in CLI Instructions
- In many Linux instructions, including these lessons, a hash (**#**) symbol precedes many commands, either on the preceding line or the same line
- **#** indicates that a command must be run as `root`
  - Either use `su` to login as the `root` user and work at a `root` **#** prompt
    - **`sudo -i` = `su`** - If `su` can't be accessed (vis SELinux), `sudo -i` enters `root` if *you* are in the `wheel` group, as on CentOS often used for SELinux
  - Or use `sudo` in front of each command
- **$** indicates that a command must be run as a normal user
  - This is why a dollar sign (**$**) preceded terminal commands in *Linux 101-501* units
- If unspecified, it might not matter using as `root` or a normal user
  - It can be important to run as a normal user for compiling programs such as with `make`; *always compile as a normal user, never `root`*
  - While we don't compile in this *Linux 601* unit, a SysAdmin must bear in mind that **$** (user) vs **#** (`root`) prompts matter
- These lessons don't add `sudo` to all commands run as `root` because you may or may not already be logged in as `root` depending on your situation
  - Generally, working from a **#** `root` prompt is considered "bad", but not necessarily always—especially not for SysAdmins
- Not all commands make this specification (in these lessons or in other Linux instruction sites), so be aware that you may need to run some commands as `root` even when there is no `sudo` or preceding hash (**#**) in the line commands you see

___

### OPTIONAL: If you did Linux 201, but on a different machine
>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **TS1** :$
>
```console
su Username
```
>
> Arch/Manjaro:
>
> | **TA1** :$
>
```console
sudo pacman -Syy
```
>
> | **TA2** :$
>
```console
sudo pacman -S --noconfirm curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc texlive-core pwgen unzip
```
>
> Debian/Ubuntu:
>
> | **TD1** :$
>
```console
sudo apt update
```
>
> | **TD2** :$
>
```console
sudo apt install -y curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc pwgen unzip
```
>
> RedHat/CentOS:
>
> | **TC1** :$
>
```console
sudo dnf update
```
>
> | **TC2** :$
>
```console
sudo dnf install -y curl cowsay dialog git net-tools htop dos2unix pwgen unzip redhat-lsb-core
```
> Currently thest are broken and will not work on CentOS: `odt2txt pandoc`
>
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **TS2** :$
>
```console
exit
```
>

___

# The Take

- Your machine is up to speed with the necessary packages installed

## POSIX
- The standard for "proper Unix/Linux"

## Daemons
- When software has both a client and server, `d` may be placed on the end of files and directories to identify the server configs, not the client configs
- Eg: with SSH:
  - SSH client configs: `/etc/ssh_config` & `/etc/ssh_config.d/`
  - SSH server configs: `/etc/sshd_config` & `/etc/sshd_config.d/`

## Presume to Know:
- `find` - [101 Lesson 9: find](https://github.com/inkVerb/vip/blob/master/101/Lesson-09.md)
  - `find . -iname '*henry*'` - find all files containing "henry", ignore case
    - `-name` - case-sensitive
    - `-type d`, `-type f` only file or directory
- `grep` - [101 Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101/Lesson-10.md)
  - `grep "find me" *`
  - `some command | grep "find me"`
- Linux Filesystem Hierarchy Standard (FHS) [201 Lesson 12: FHS](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md)
___

#### [Lesson 1: Boot & System Init](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md)
