# Shell 201
## Lesson 2: cd, ../.., mkdir, rm -r

`cd ~/Work/VIP/shell/201`

`gedit &`

`nautilus . &`
___

`mkdir directory`

`ls`

`ln -s directory dirlink`

`ls`

`ls -l`

`cd directory`

`ls`

`mkdir subdirectory`

`ls`

`touch file`

`cd ../dirlink`

`ls`

`touch subdirectory/alsofile`

`cd subdirectory`

`ls`

`cd subdirectory`

`ls`

`cd ../../directory/subdirectory`

`ls`

`cd ../..`

`ls`

`mkdir newdir`

`ls`

`rm newdir`

*Note the error message about directories*

`cd newdir`

`touch delfile`

`ls`

`cd ..`

*Use* `-r` *(RECURSIVE) to remove directories*

`rm -r newdir`

`ls`

`cp directory cpdir`

*Note the error message about directories; use* `-r` *with* `cp` *as well as* `rm` *for directories*

`cp -r directory cpdir`

`ls`

`cd cpdir`

`ls`

`cd ..`

#### [Lesson 3: su, sudo, apt update, apt upgrade, apt install, lsb_release](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-03.md)
