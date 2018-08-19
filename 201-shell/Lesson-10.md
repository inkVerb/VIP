# Shell 201
## Lesson 10: COMMAND > FILE, pwd, uname, who, w

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`
___

`mkdir comdump`

`cd comdump`

`ls`

`top -n 1 -b > top.file`

`ls`

`gedit top.file`

`top -n 1 -b > top.file`

*gedit: Reload top.file*

*Note the file contents changed*

`ps aux > psaux.file`

`ls`

`gedit psaux.file`

*Some other useful commands...*

`pwd`

*Whoah, that's where you are!*

`pwd > pwd.file`

`gedit pwd.file`

`uname`

*eXcellent operationg system, I might add*

`uname > uname.file`

`who`

*That's everyone*

`who > who.file`

`w`

*That's everyone with a lot more info*

`w > w.file`

`ls`

`ls > ls.file`

`ls`

`gedit ls.file`

*You can even output* `ls` *into a file!*

`ls ..`

*Now output that other directory's contents into a file*

`ls .. > ls.file`

*gedit: Reload ls.file*

*...or into another directory*

`mkdir -p outputs`

`ls outputs`

`ls .. > outputs/ls.file`

`ls outputs`

*That's in the directory you just made*

`gedit outputs/ls.file`

*All done, get ready for the next lesson*

`cd ..`

#### [Lesson 11: netstat -natu, tcpdump, man, info](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-11.md)
