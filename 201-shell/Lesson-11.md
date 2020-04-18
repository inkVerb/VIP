# Shell 201
## Lesson 11: netstat -natu, tcpdump, man, info

Ready the CLI

`cd ~/School/VIP/201`

___

### `netstat -natu` & `sudo tcpdump`

| **1** : `netstat -natu`

*This gives a list of all network connections*

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** : `su Username`
___

| **2** : `sudo tcpdump`

*Note the ongoing list of network activity*

*Ctrl + C will close the dump*

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** : `exit`
___

### `man` & `info`

*FYI, this is a great tool to change settings from the terminal: `gsettings`*

| **3** : `man gsettings`

*This is a how-to manual for a terminal program that manages settings for the desktop environment*

*Press Q to quit*

*You can use `man` or `info`*

| **4** : `info gsettings`

*Press Q to quit*

*The `man` and `info` tools are useful for many things*

*Consider `lsb_release` which shows detailed information about your current Linux distribution*

| **5** : `man lsb_release`

| **6** : `info lsb_release`

| **7** : `man tcpdump`

| **8** : `info tcpdump`

| **9** : `man netstat`

| **10** : `info netstat`

| **11** : `man grep`

| **12** : `info grep`

| **13** : `man sed`

| **14** : `info sed`

| **15** : `man echo`

| **16** : `info echo`

| **17** : `man imagemagick`

*...but not always...*

| **18** : `info imagemagick`

*Note `imagemagick` changes images from the terminal, learn to use at:*
- [www.imagemagick.org/Usage](http://www.imagemagick.org/Usage/)

___

# The Take

- `netstat` displays network connections to your machine (including Internet)
- `tcpdump` also displays network connections, but at a `root` level and updates live
  - This is useful for finding hackers, but anti-hacking is beyond the scope of this lesson
- `tcpdump` can only be run as root, `sudo tcpdump`
- `man` & `info` are the "help" tools for most terminal apps, packages, and Linux commands
  - **Q** will quit both
  - Not every package has the information for `man` & `info`, but most do

___

#### [Lesson 12: more, less, head, tail, sort, tac, diff, nano, vi](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-12.md)
