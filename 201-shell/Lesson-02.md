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

*Use `touch` & `ls` with a different directory...*

| **27** : `ls newdir`

| **28** : `touch newdir/alsodel newdir/alsoalso`

| **29** : `ls -l newdir`

*Use* `-r` *(RECURSIVE) to remove directories*

| **30** : `rm -r newdir`

| **31** : `ls`

| **32** : `cp directory cpdir`

*Note the error message about directories; use* `-r` *with* `cp` *as well as* `rm` *for directories*

| **33** : `cp -r directory cpdir`

| **34** : `ls`

| **35** : `cd cpdir`

| **36** : `ls`

| **37** : `cd ..`

___

# The Take

- `mkdir` makes a new directory this way:
  - `mkdir new-directory`
- `mkdir` can also make a directory inside of the present working directory
- `cd` will change the terminal's working directory this way:
  - `cd directory-to-change-to`
  - `cd ..` will move up one level in the directory tree
  - `cd ../..` will move up two levels in the directory tree
  - `cd ../directory` will move up one level in the directory tree, then into another directory from there
  - `cd directory/subdirectory` will move in two levels of a directory
  - `cd ../../directory` will move up two levels in the directory tree, then into another directory from there
- `ls` can list other directories these ways:
  - `ls path/to/dir`
  - `ls -l path/to/dir`
- `touch` can create one or many files in different directories this way:
  - `touch directory/path/touchfile`
  - `touch directory/path/touchone diralso/path/touchtwo`
- `rm -r` removes a directory this way:
  - `rm -r directory-to-remove`
- `cp -r` copies a directory this way:
  - `cp -r source-directory directory-copy`
- *Note: `mv` can also move and change the name of a directory, same as with files*

___

#### [Lesson 3: su, sudo, apt update, apt upgrade, apt install, lsb_release](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-03.md)
