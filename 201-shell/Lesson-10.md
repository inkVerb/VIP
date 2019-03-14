# Shell 201
## Lesson 10: COMMAND > FILE, pwd, uname, who, w

`cd ~/School/VIP/shell/201`

___

| **1** : `mkdir comdump`

| **2** : `cd comdump`

| **3** : `ls`

| **4** : `top -n 1 -b > top.file`

| **5** : `ls`

| **6** : `gedit top.file`

| **7** : `top -n 1 -b > top.file`

*gedit: Reload top.file*

*Note the file contents changed*

| **8** : `ps aux > psaux.file`

| **9** : `ls`

| **10** : `gedit psaux.file`

*Some other useful commands...*

| **11** : `pwd`

*Whoah, that's where you are!*

| **12** : `pwd > pwd.file`

| **13** : `gedit pwd.file`

| **14** : `uname`

*eXcellent operationg system, I might add*

| **15** : `uname > uname.file`

| **16** : `who`

*That's everyone*

| **17** : `who > who.file`

| **18** : `w`

*That's everyone with a lot more info*

| **19** : `w > w.file`

| **20** : `ls`

| **22** : `ls > ls.file`

| **23** : `ls`

| **24** : `gedit ls.file`

*You can even output* `ls` *into a file!*

| **25** : `ls ..`

*Now output that other directory's contents into a file*

| **26** : `ls .. > ls.file`

*gedit: Reload ls.file*

*...or into another directory*

| **27** : `mkdir -p outputs`

| **28** : `ls outputs`

| **29** : `ls .. > outputs/ls.file`

| **30** : `ls outputs`

*That's in the directory you just made*

| **31** : `gedit outputs/ls.file`

*All done, get ready for the next lesson*

| **32** : `cd ..`

___

# The Take

-

___

#### [Lesson 11: netstat -natu, tcpdump, man, info](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-11.md)
