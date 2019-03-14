# Shell 201
## Lesson 3: su, sudo, apt update, apt upgrade, apt install, lsb_release

`cd ~/School/VIP/shell/201`

___

*Check the Linux version info*

| **1** : `lsb_release -a`

*Get just the number*

| **2** : `lsb_release -r -s`

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> `su USERNAME`
>
___

*See the list of all available packages*

| **3** : `sudo apt list`

*Update the current lists (no updates are installed)*

| **4** : `sudo apt update`

*If there is a problem, usually fix it with* `--fix-missing`

| **5** : `sudo apt update --fix-missing`

*See what can be upgraded on your machine*

| **6** : `sudo apt list --upgradable`

*Upgrade (install updates)*

| **7** : `sudo apt upgrade` *If updates are available, you will need to press Y, then Enter*

*Install the* `git` *package*

| **8** : `sudo apt install git` *Unless it is installed already, you will need to press Y, then Enter*

*Install* `cowsay`

| **9** : `sudo apt install cowsay` *Unless it is installed already, you will need to press Y, then Enter*

*You can install more than one package...*

*Install the* `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `rename` and `pwgen` *packages* (the command `netstat` comes from the package `net-tools`)

| **10** : `sudo apt install -y curl net-tools htop odt2txt dos2unix pandoc rename pwgen` *Use* `-y` *so you DO NOT need to press Y, then Enter*

### For an administrator to use `su`
>
___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
>
> | **11** : `su` *input the password*
>
> *As the* `su` *(root) user, you DO NOT need to use* `sudo` *at the start of your commands*
>
> *See the list of all available packages*
>
> | **12** : `sudo apt list`
>
> *Update the current lists (no updates are installed)*
>
> | **13** : `sudo apt update`
>
> *If there is a problem, usually fix it with* `--fix-missing`
>
> | **14** : `sudo apt update --fix-missing`
>
> *See what can be upgraded on your machine*
>
> | **15** : `sudo apt list --upgradable`
>
> *Upgrade (install updates)*
>
> | **16** : `apt upgrade` *If updates are available, you will need to press Y, then Enter*
>
> *Install the* `git` *package*
>
> | **17** : `apt install git` *Unless it is installed already, you will need to press Y, then Enter*
>
> *Install* `cowsay`
>
> | **18** : `apt install cowsay` *Unless it is installed already, you will need to press Y, then Enter*
>
> *You can install more than one package...*
>
> *Install the* `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `rename` and `pwgen` *packages* (the command `netstat` comes from the package `net-tools`)
>
> | **19** : `apt install -y curl net-tools htop odt2txt dos2unix pandoc rename pwgen` *Use* `-y` *so you DO NOT need to press Y, then Enter*
>
___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> | **20** : `exit`
>
___

**Tip:** If you ever get an `apt upgrade` message with something like "some packages were held back", here are two easy fixes that often work:

1. `sudo apt install PACKAGE` *Yes, just install the listed package directly*
2. `sudo apt full-upgrade`

___

# The Take

-

___

#### [Lesson 4: ls -l, chmod](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-04.md)
