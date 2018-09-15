# Shell 101
## Lesson 5: Combine & Pipe Commands into Variables

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`gedit applefoo`

`cat applefoo`

`sed -i "s/bar/foo/" applefoo`

*gedit: Reload applefoo*

`cat applefoo`

`sed "s/foo/bar/" applefoo`

`ls`

`sed -e "s/foo/bar/g" applefoo > newapplefoo`

`ls`

`cat newapplefoo`

`rm newapplefoo`

`ls`

`cat applefoo`

`sed "s/foo/bar/" applefoo`

*Now we see what* `cat` *and* `sed` *do, "pipe" the output of* `cat` *into* `sed`

`cat applefoo | sed "s/foo/bar/"`

`echo $(cat applefoo | sed "s/foo/bar/")`

`` echo `cat applefoo | sed "s/foo/bar/"` ``

`echo $DESKTOP_SESSION`

`printenv DESKTOP_SESSION`

`dpkg --print-architecture`

*You can set output of any terminal command as if it is a variable using:* `$(...)` or `` `...` ``

`echo $(printenv DESKTOP_SESSION)`

`` echo `printenv DESKTOP_SESSION` ``

`echo $(dpkg --print-architecture)`

`` echo `dpkg --print-architecture` ``

`gedit comboshell`

*Create comboshell as this:* [comboshell-01](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-01)

`chmod ug+x comboshell`

`./comboshell applefoo foo bar`

`./comboshell abcd jjjjjjjjj "Apple likes to say abcdefghi and "`

`./comboshell abcd j " zz"`

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-06.md)
