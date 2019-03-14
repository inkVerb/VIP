# Shell 201
## Lesson 1: cp, mv, ln -s, rm

`cd ~/School/VIP/shell/201`

___

| **1** : `echo FILE-1 >> file1`

| **2** : `ls`

| **3** : `cat file1`

| **4** : `cp file1 file2`

| **5** : `ls`

| **6** : `cat file2`

| **7** : `gedit file1 file2`

| **8** : `cp file1 file3`

| **9** : `ls`

| **10** : `mv file3 file4`

| **11** : `ls`

| **12** : `ln -s file4 file5`

| **13** : `ls`

*Note file5 is a different color because it is a symlink*

| **14** : `ls -l`

*Note file5 points to file4, indicating where the symlink leads*

*You can also use list-long on only the link to see where it points*

| **15** : `ls -l file5`

*Let's take a peek*

| **16** : `gedit file4 file5`

| **17** : `echo FILE-5 >> file5`

*gedit: Reload file4 & file5*

*Note both file4 and file5 say the same thing*

| **18** : `echo SILLY-FILE5 >> file5`

*gedit: Reload file4 & file5*

| **19** : `echo INTO-FILE4 >> file4`

*gedit: Reload file4 & file5*

| **20** : `ln -s file4 file6`

| **21** : `ls`

| **22** : `ls -l`

| **23** : `cat file6`

| **24** : `gedit file6`

*Note file6 is the same as file4 & file5*

| **25** : `rm file6`

| **26** : `ls`

| **27** : `ls -l`

*Note file4 remains*

| **28** : `rm file4`

| **29** : `ls`

| **30** : `ls -l`

*Note file5 is "broken"*

| **31** : `touch file4`

| **32** : `cat file4`

*gedit: Reload file4 & file5*

| **33** : `ls -l`

*Note file5 is no longer broken, but file4 has changed*

*gedit: Save file6*

| **34** : `ls`

| **35** : `cat file6`

___

# The Take

-

___

#### [Lesson 2: cd, ../.., mkdir, rm -r](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-02.md)
