# Linux 601
## Lesson 0: 601

### Cheat Sheets

These are helpful for installing network simulation tools on Arch or Manjaro

- [CISCO Packet Tracer](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Packet-Tracer.md)
- [Oracle VirtualBox](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md)

___

## The Chalk
### User Prompts: **#** or **$** in CLI Instructions
- In many Linux instructions, including these lessons, a hash (**#**) symbol precedes many commands, either on the preceding line or the same line
- **#** indicates that a command must be run as `root`
  - Either use `su` to login as the `root` user and work at a `root` **#** prompt
  - Or use `sudo` in front of each command
- **$** indicates that a command must be run as a normal user
  - This is why a dollar sign (**$**) preceded terminal commands in *Linux 101-501* units
- If unspecified, it might not matter using as `root` or a normal user
  - It can be important to run as a normal user for compiling programs such as with `make`; *always compile as a normal user, never `root`*
  - While we don't compile in this *Linux 601* unit, a SysAdmin must bear in mind that **$** (user) vs **#** (`root`) prompts matter
- These lessons don't add `sudo` to all commands run as `root` because you may or may not already be logged in as `root` depending on your situation
  - Generally, working from a **#** `root` prompt is considered "bad", but not necessarily always—especially not for SysAdmins
- Not all commands make this specification (in these lessons or in other Linux instruction sites), so be aware that you may need to run some commands as `root` even when there is no `sudo` or preceding hash (**#**) in the line commands you see

### *The Chalk* Instructions Precede Commands
- In units *101-501*, lessons began with commands, then ended with *The Take*
  - The *Linux 601* unit will not follow this format
- SysAdmin lessons are primarily conceptual and secondarily practice
- These conceptual lessons will begin with *The Chalk*, then commands may or may not follow in a *The Type* section
  - *The Type* commands are intended to be manually typed into the terminal as practice for real world or examination of SysAdmin work
    - These commands are intended to be examples only
    - You should be able to type varied versions of these from memory

___

## Prepare

| **1** :$

```console
mkdir -p ~/School/VIP/601
```

>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **PS1** :$

```console
su Username
```

Arch/Manjaro:

| **PA1** :$

```console
sudo pacman -Syy
```

| **PA2** :$

```console
sudo pacman -S --noconfirm openssh
```

Debian/Ubuntu:

| **PD1** :$

```console
sudo apt update
```

| **PD2** :$

```console
sudo apt install -y openssh
```

CentOS/Fedora:

| **PC1** :$

```console
sudo dnf update
```

| **PC2** :$

```console
sudo dnf install -y openssh
```

> Optional: IF you logged in as a "sudoer", now exit
>
> | **PS2** :$

```console
exit
```

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
> CentOS/Fedora:
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

## Presume to Know:
- `find` - [101 Lesson 9: find](https://github.com/inkVerb/vip/blob/master/101/Lesson-09.md)
  - `find . -iname '*henry*'` - find all files containing "henry", ignore case
    - `-name` - case-sensitive
    - `-type d`, `-type f` only file or directory
- `grep` - [101 Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101/Lesson-10.md)
  - `grep "find me" *`
  - `some command | grep "find me"`
- Linux Filesystem Hierarchy Standard (FHS) [201 Lesson 12: grep](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md)
___

#### [Lesson 1: Boot & System Init](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md)
