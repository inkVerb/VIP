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

*Update the current lists (no updates are installed)*

`sudo apt update`

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
> *Update the current lists (no updates are installed)*
> 
> `apt update`
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
> `exit`
> 
___

#### [Lesson 4: ls -l, chmod](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-04.md)
