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

*If there is a problem, usually fix it with `--fix-missing`*

| **5** : `sudo apt update --fix-missing`

*See what can be upgraded on your machine*

| **6** : `sudo apt list --upgradable`

*Upgrade (install updates)*

| **7** : `sudo apt upgrade` If updates are available, you will need to press Y, then Enter*

*Install the `git` package*

| **8** : `sudo apt install git` Unless it is installed already, you will need to press Y, then Enter*

*Install `cowsay`*

| **9** : `sudo apt install cowsay` Unless it is installed already, you will need to press Y, then Enter*

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `rename` and `pwgen` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*

| **10** : `sudo apt install -y curl net-tools htop odt2txt dos2unix pandoc rename pwgen` *Use `-y` so you DO NOT need to press Y, then Enter*

### For an administrator to use `su`
>
___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
>
> | **11** : `su` input the password*
>
> *As the `su` (root) user, you DO NOT need to use `sudo` at the start of your commands*
>
> *See the list of all available packages*
>
> | **12** : `sudo apt list`
>
> *Update the current lists (no updates are installed)*
>
> | **13** : `sudo apt update`
>
> *If there is a problem, usually fix it with `--fix-missing`
>
> | **14** : `sudo apt update --fix-missing`
>
> *See what can be upgraded on your machine*
>
> | **15** : `sudo apt list --upgradable`
>
> *Upgrade (install updates)*
>
> | **16** : `apt upgrade` If updates are available, you will need to press Y, then Enter*
>
> *Install the `git` package*
>
> | **17** : `apt install git` Unless it is installed already, you will need to press Y, then Enter*
>
> *Install `cowsay`*
>
> | **18** : `apt install cowsay` Unless it is installed already, you will need to press Y, then Enter*
>
> *You can install more than one package...*
>
> *Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `rename` and `pwgen` packages*
> - *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*
>
> | **19** : `apt install -y curl net-tools htop odt2txt dos2unix pandoc rename pwgen` *Use `-y` so you DO NOT need to press Y, then Enter*
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

1. `sudo apt install PACKAGE` Yes, just install the listed package again*
2. `sudo apt full-upgrade`

___

# The Take

- `lsb_release -a` outputs information about the current version of Linux
- `lsb_release -r -s` will only output the basic version number
- `sudo apt list` outputs a list of *all* packages that can be installed with `apt`
- `sudo apt list --upgradable` outputs installed packages that have new versions available
- `sudo apt update` will update the `list`, including new versions available
- `sudo apt upgrade` will "upgrade" (install updates) for packages with new versions available
- `sudo apt install` will install a new package this way:
  - `sudo apt install package-to-install`
- `-y` will tell `apt` to automatically answer "yes" rather than prompting
  - eg:`sudo apt install -y cowsay`
- *Note `sudo apt remove package-to-remove` will remove (uninstall) a package*
## Ways to fix some problems
- `sudo apt update --fix-missing` can fix some problems
- With the **"some packages were held back"** error message , these might fix the problem:
  - `sudo apt full-upgrade`
  - `sudo apt install held-back-package` (install it again)

___

#### [Lesson 4: ls -1, ls -l, chmod](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-04.md)
