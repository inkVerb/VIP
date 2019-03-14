# Shell 201
## Lesson 2: cd, ../.., mkdir, rm -r

`cd ~/School/VIP/shell/201`

___

| **1** : `mkdir directory`

| **2** : `ls`

| **3** : `ln -s directory dirlink`

| **4** : `ls`

| **5** : `ls -l`

| **6** : `cd directory`

| **7** : `ls`

| **8** : `mkdir subdirectory`

| **9** : `ls`

| **10** : `touch file`

| **11** : `cd ../dirlink`

| **12** : `ls`

| **13** : `touch subdirectory/alsofile`

| **14** : `cd subdirectory`

| **15** : `ls`

| **16** : `cd ../../directory/subdirectory`

| **17** : `ls`

| **18** : `cd ../..`

| **19** : `ls`

| **20** : `mkdir newdir`

| **21** : `ls`

| **22** : `rm newdir`

*Note the error message about directories*

| **23** : `cd newdir`

| **24** : `touch delfile`

| **25** : `ls`

| **26** : `cd ..`

*Use* `-r` *(RECURSIVE) to remove directories*

| **27** : `rm -r newdir`

| **28** : `ls`

| **29** : `cp directory cpdir`

*Note the error message about directories; use* `-r` *with* `cp` *as well as* `rm` *for directories*

| **30** : `cp -r directory cpdir`

| **31** : `ls`

| **32** : `cd cpdir`

| **33** : `ls`

| **34** : `cd ..`

___

# The Take

-

___

#### [Lesson 3: su, sudo, apt update, apt upgrade, apt install, lsb_release](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-03.md)
