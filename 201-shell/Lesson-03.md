# Shell 201
## Lesson 3: su, sudo, apt update, apt upgrade, apt install, lsb_release

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`

___

*Check the Linux version info*

`lsb_release -a`

*Get just the number*

`lsb_release -r -s`

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
> 
> `su USERNAME`
>
___

*See the list of all available packages*

`sudo apt list`

*Update the current lists (no updates are installed)*

`sudo apt update`

*If there is a problem, usually fix it with* `--fix-missing`

`sudo apt update --fix-missing`

*See what can be upgraded on your machine*

`sudo apt list --upgradable`

*Upgrade (install updates)*

`sudo apt upgrade` *If updates are available, you will need to press Y, then Enter*

*Install the* `git` *package*

`sudo apt install git` *Unless it is installed already, you will need to press Y, then Enter*

*You can install more than one package...*

*Install the* `curl` `net-tools` `htop` `odt2txt` `pandoc` `rename` and `pwgen` *packages* (the command `netstat` comes from the package `net-tools`)

`sudo apt install -y curl net-tools htop odt2txt pandoc rename pwgen` *Use* `-y` *so you DO NOT need to press Y, then Enter*

### For an administrator to use `su`
> 
___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
> 
> `su` *input the password*
> 
> *As the* `su` *(root) user, you DO NOT need to use* `sudo` *at the start of your commands*
> 
> *See the list of all available packages*
> 
> `sudo apt list`
> 
> *Update the current lists (no updates are installed)*
> 
> `sudo apt update`
> 
> *If there is a problem, usually fix it with* `--fix-missing`
> 
> `sudo apt update --fix-missing`
> 
> *See what can be upgraded on your machine*
> 
> `sudo apt list --upgradable`
> 
> *Upgrade (install updates)*
> 
> `apt upgrade` *If updates are available, you will need to press Y, then Enter*
> 
> `apt install git` *Unless it is installed already, you will need to press Y, then Enter*
> 
> *You can install more than one package...*
> 
> *Install the* `curl` `net-tools` `htop` `odt2txt` `pandoc` `rename` and `pwgen` *packages* (the command `netstat` comes from the package `net-tools`)
> 
> `apt install -y curl net-tools htop odt2txt pandoc rename pwgen` *Use* `-y` *so you DO NOT need to press Y, then Enter*
> 
___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> `exit`
> 
___

#### [Lesson 4: ls -l, chmod](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-04.md)
