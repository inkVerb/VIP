# Shell 201
## Lesson 10: COMMAND > FILE, pwd, uname, who, w

`cd ~/School/VIP/shell/201`

___

| **1** : `mkdir comdump`

| **2** : `cd comdump`

| **3** : `ls`

*Remember this...*

| **4** : `top -n 1 -b`

*Put it in a file...*

| **5** : `top -n 1 -b > top.file`

| **6** : `ls`

| **7** : `gedit top.file`

| **8** : `top -n 1 -b > top.file`

*gedit: Reload top.file*

*Note the file contents changed*

| **9** : `ps aux`

| **10** : `ps aux > psaux.file`

| **11** : `ls`

| **12** : `gedit psaux.file`

*Some other useful commands...*

| **13** : `pwd`

*Whoah, that's where you are!*

| **14** : `pwd > pwd.file`

| **15** : `gedit pwd.file`

| **16** : `uname`

*eXcellent operationg system, I might add*

| **17** : `uname > uname.file`

| **18** : `who`

*That's you*

| **19** : `who > who.file`

| **20** : `w`

*That's you with a lot more info*

| **21** : `w > w.file`

| **22** : `ls`

| **23** : `ls > ls.file`

| **24** : `ls`

| **25** : `gedit ls.file`

*You can even output `ls` into a file!*

| **26** : `ls ..`

*Now output that other directory's contents into a file*

| **27** : `ls .. > ls.file`

*gedit: Reload ls.file*

*...or into another directory*

| **28** : `mkdir -p outputs`

| **29** : `ls outputs`

| **30** : `ls .. > outputs/ls.file`

| **31** : `ls outputs`

*That's in the directory you just made*

| **32** : `gedit outputs/ls.file`

___

# The Take

- STDOUT output of many terminal commands can be sent to a file by adding `> outputfile` to the end of the command
 - This includes: `ls`, `df`, `who`, `pwd`, `ps aux`, `top`, and many more
- *Note that `> outputfile` would overwrite the output file; `>> outputfile` would append the output file*
- "PWD" stands for "present working directory"
  - `pwd` displays the PWD
- `who` displays the current user and most recent login time
- `w` displays uptime, some load information, and user info from `who`
- `uname` verifies that you are using Linux by outputting "Linux", just in case you forgot

___

#### [Lesson 11: netstat -natu, tcpdump, man, info](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-11.md)
