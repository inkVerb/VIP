# Shell 201
## Lesson 11: netstat -natu, tcpdump, man, info

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`
___

### `netstat -natu` & `sudo tcpdump`

`netstat -natu`

*This gives a list of all network connections*

### For a "sudoer" who can use `sudo`

`sudo tcpdump`

*Note the ongoing list of network activity*

*Ctrl + C will close the dump*

### For an administrator to use `su`
> ___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
> 
> `su` *input the password*
> 
> `tcpdump`
> 
> *Note the ongoing list of network activity*
> 
> *Ctrl + C will close the dump*
> 
> `exit`
> ___

### `man` & `info`

*FYI, this is a great tool to change settings from the terminal:* `gsettings`

`man gsettings`

*This is a how-to manual for a terminal program that manages settings for the desktop environment*

*Press Q to quit*

*You can use* `man` *or* `info`

`info gsettings`

*Press Q to quit*

*The* `man` *and* `info`*tools are useful for many things*

*Consider* `lsb_release` *which shows detailed information about your current Linux distribution*

`man lsb_release`

`info lsb_release`

`man tcpdump`

`info tcpdump`

`man netstat`

`info netstat`

`man grep`

`info grep`

`man sed`

`info sed`

`man echo`

`info echo`

`man imagemagick`

`info imagemagick`

*...but not always*

*Note* `imagemagick` *changes images from the terminal, learn to use at:*
- [www.imagemagick.org/Usage](http://www.imagemagick.org/Usage/)

#### [Lesson 12: more, less, head, tail, sort, diff, nano, vi](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-12.md)
