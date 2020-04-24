# Shell 201
## Lesson 2: cd, ../.., mkdir, rm -r

Ready the CLI

`cd ~/School/VIP/201`

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

| **20** : `mkdir dirnew`

| **21** : `ls`

| **22** : `cd dirnew`

| **23** : `touch delfile`

| **24** : `ls`

| **25** : `cd ..`

*Use `touch` & `ls` with a different directory...*

| **26** : `ls dirnew`

| **27** : `touch dirnew/alsodel dirnew/alsoalso`

| **28** : `ls -l dirnew`

| **29** : `rm dirnew`

*Note the error message about directories*

*Use `-r` (Recursive) to remove directories*

| **30** : `rm -r dirnew`

| **31** : `ls`

| **32** : `cp directory cpdirnew`

*Note the error message about directories*

*Use `-r` with `cp` as well as `rm` for directories*

| **33** : `cp -r directory cpdirnew`

| **34** : `ls`

| **35** : `mv -r cpdirnew cpdir`

*Note, `mv` rejects `-r`, just use `mv` even for directories*

| **36** : `mv cpdirnew cpdir`

| **37** : `ls`

| **38** : `cd cpdir`

*Note that `.` = "current directory" and `..` = "parent directory"... even with `ls`...*

| **39** : `ls .`

| **40** : `ls ..`

| **41** : `cd ..`

| **42** : `ls .`

| **43** : `ls ..`

*These are even listed with the "all" flag (`-a`)*

| **44** : `ls -a`

___

# The Take

- `mkdir` makes a new directory this way:
  - `mkdir new-directory`
- `cd` will change the terminal's working directory this way:
  - `cd directory-to-change-to`
  - `cd ..` will move up one level in the directory tree
  - `cd ../..` will move up two levels in the directory tree
  - `cd ../directory` will move up one level in the directory tree, then into another directory from there
  - `cd directory/subdirectory` will move in two levels of a directory tree
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
- `mv` can move and change the name of a directory, same as with files
  - `mv` does not require `-r`, it will reject `-r` if you try
- `.` & `..`
  - `.` = "current directory"
  - `..` = "parent directory"

___

#### [Lesson 3: Software – apt, lsb_release](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-03.md)
