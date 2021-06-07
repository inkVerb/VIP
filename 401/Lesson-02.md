# Shell 401
## Lesson 2: netstat -natu, tcpdump, man, info

Ready the CLI

`cd ~/School/VIP/401`

___

### `netstat -natu` & `sudo tcpdump`

| **1** :$

```console
netstat -natu
```

*This gives a list of all network connections*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
___

| **2** :$

```console
sudo tcpdump
```

*Note the ongoing list of network activity*

*<kbd>Ctrl</kbd> + <kbd>C</kbd> will close the dump*

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
___

*View current port connections & addresses*

| **3** :$

```console
ss -tln
```

### `man` & `info`

*FYI, this is a great tool to change settings from the terminal: `gsettings`*

| **4** :$

```console
man gsettings
```

*This is a how-to manual for a terminal program that manages settings for the desktop environment*

*Press Q to quit*

*You can use `man` or `info`*

| **5** :$

```console
info gsettings
```

*Press Q to quit*

*The `man` and `info` tools are useful for many things*

*Consider `lsb_release` which shows detailed information about your current Linux distribution*

| **5** :$

```console
man lsb_release
```

| **6** :$

```console
man tcpdump
```

| **7** :$

```console
man netstat
```

| **8** :$

```console
man grep
```

| **9** :$

```console
man sed
```

| **10** :$

```console
man echo
```

| **11** :$

```console
man imagemagick
```

*...but not always...*

| **12** :$

```console
info imagemagick
```

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

#### [Lesson 3: Cron Daemon & $PATH Variable](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)
