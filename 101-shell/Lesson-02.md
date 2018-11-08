# Shell 101
## Lesson 2: Arguments & Variables

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`gedit abcsed abcd`

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

`./abcsed`

*Note the error message*

`ls -l`

*Note the colors of the files and letters "-rw-"*

`chmod ug+x abcsed`

`ls -l`

*Note the colors of the files and letters "-rw-"*

`./abcsed a`

*Now, it works, no error*

*gedit: Reload abcd*

`./abcsed b`

*gedit: Reload abcd*

`./abcsed c`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-02](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-02)

`./abcsed d z`

*gedit: Reload abcd*

`./abcsed e z`

*gedit: Reload abcd*

`./abcsed z j`

*gedit: Reload abcd*

`./abcsed z j`

*gedit: Reload abcd*

`./abcsed z j`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-03](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-03)

`./abcsed z j`

*gedit: Reload abcd*

`./abcsed f z`

*gedit: Reload abcd*

`./abcsed z j`

*gedit: Reload abcd*

*Update abcsed to this:* [abcsed-04](https://github.com/inkVerb/vip/blob/master/101-shell/abcsed-04)

`echo "Apples like foo." > applefoo`

`gedit applefoo`

`./abcsed foo bar applefoo`

*gedit: Reload applefoo*

`./abcsed g z abcd`

*gedit: Reload abcd*

`./abcsed z j abcd`

*gedit: Reload abcd*

#### [Lesson 3: Arguments & Variables Review](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-03.md)
