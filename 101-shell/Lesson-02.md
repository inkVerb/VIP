# Shell 101
## Lesson 2: Arguments & Variables

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit abcsed abcd`

*Note the two tabs in gedit; abcsed is open, but the file does not exist*

Ctrl + Click *this link to open in a new tab:* [abcsed-01](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-01)

*Look at the first line*

### Say "HaSHSHSH" `#`

### Say "BANG!" `!`

### Say "shebang" `#!`

## shebang

*"shebang" is what we call the* `#!` *at the start of the first line*

*Note line one with the "shebang"* `#!/bin/sh` *is what makes this file a "Shell script" that we can run or "execute"*

*Now, to our first Shell script...*

*Create abcsed as that same file we just looked at:* [abcsed-01](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-01)

*(...do this by using Copy-Paste)*

| **2** : `./abcsed`

*Note the error message*

| **3** : `ls -l`

*Note the colors of the files and letters "-rw-"*

| **4** : `chmod ug+x abcsed`

| **5** : `ls -l`

*Note the colors of the files and letters "-rw-"*

| **6** : `./abcsed a`

*Now, it works, no error*

*gedit: Reload abcd*

| **7** : `./abcsed b`

*gedit: Reload abcd*

| **8** : `./abcsed c`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-02](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-02)

| **9** : `./abcsed d z`

*gedit: Reload abcd*

| **10** : `./abcsed e z`

*gedit: Reload abcd*

| **11** : `./abcsed z j`

*gedit: Reload abcd*

| **12** : `./abcsed z j`

*gedit: Reload abcd*

| **13** : `./abcsed z j`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-03](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-03)

| **14** : `./abcsed z j`

*gedit: Reload abcd*

| **15** : `./abcsed f z`

*gedit: Reload abcd*

| **16** : `./abcsed z j`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-04](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-04)

| **17** : `echo "Apples like foo." > applefoo`

| **18** : `gedit applefoo`

| **19** : `./abcsed foo bar applefoo`

*gedit: Reload applefoo*

| **20** : `./abcsed g z abcd`

*gedit: Reload abcd*

| **21** : `./abcsed z j abcd`

*gedit: Reload abcd*

___

# The Take

- gedit can open multiple files from the terminal
- Sometimes, programmers create a Shell script or any file by copying and pasting the entire contents of the file from a webpage
- `#!` is read "shebang"
- `#!/bin/sh` on line 1 of a file makes it a Shell script
- "Running" a command in the terminal may also be called "executing" the command
- Shell scripts can't be run unless they are made "executable", usually with: `chmod ug+x SHELL-SCRIPT-FILE`
- `sed` commands can work inside a Shell script just as in a terminal
- A command is followed by "arguments", which are separated by spaces
- `$1`, `$2`, and `$3`, etc, are "arguments" that replace parts of a Shell script

___

#### [Lesson 3: Arguments & Variables Review](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-03.md)
