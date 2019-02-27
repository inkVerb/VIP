# Shell 201
## Lesson 11: netstat -natu, tcpdump, man, info

`cd ~/School/VIP/shell/201`



___

### `netstat -natu` & `sudo tcpdump`

| **1** : `netstat -natu`

*This gives a list of all network connections*

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **2** : `su USERNAME`
>
___

| **3** : `sudo tcpdump`

*Note the ongoing list of network activity*

*Ctrl + C will close the dump*

### For an administrator to use `su`
>
___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
>
> | **4** : `su` *input the password*
>
> | **5** : `tcpdump`
>
> *Note the ongoing list of network activity*
>
> *Ctrl + C will close the dump*
>
___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> | **6** : `exit`
>
___

### `man` & `info`

*FYI, this is a great tool to change settings from the terminal:* `gsettings`

| **7** : `man gsettings`

*This is a how-to manual for a terminal program that manages settings for the desktop environment*

*Press Q to quit*

*You can use* `man` *or* `info`

| **8** : `info gsettings`

*Press Q to quit*

*The* `man` *and* `info`*tools are useful for many things*

*Consider* `lsb_release` *which shows detailed information about your current Linux distribution*

| **9** : `man lsb_release`

| **10** : `info lsb_release`

| **11** : `man tcpdump`

| **12** : `info tcpdump`

| **13** : `man netstat`

| **14** : `info netstat`

| **15** : `man grep`

| **16** : `info grep`

| **17** : `man sed`

| **18** : `info sed`

| **19** : `man echo`

| **20** : `info echo`

| **21** : `man imagemagick`

| **22** : `info imagemagick`

*...but not always*

*Note* `imagemagick` *changes images from the terminal, learn to use at:*
- [www.imagemagick.org/Usage](http://www.imagemagick.org/Usage/)

#### [Lesson 12: more, less, head, tail, sort, diff, nano, vi](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-12.md)
