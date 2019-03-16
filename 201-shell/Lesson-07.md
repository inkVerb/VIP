# Shell 201
## Lesson 7: tar, xz, zip, gzip, bzip2

`cd ~/School/VIP/shell/201`

___

*Compression cheat-sheet:* [VIP: tar-gzip-bzip2-zip-xz](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/tar-gzip-bzip2-zip-xz)

*First some prep*

| **1** : `mkdir compress`

## Part I: `zip` `tar` `xz`

| **2** : `ls -l`

| **3** : `unzip vrk.zip`

| **4** : `ls -l`

*What a strange name, "vrk-master"*

| **5** : `mv vrk-master vrk`

| **6** : `ls -l`

*That zip file was strange, let's delete it*

| **7** : `rm vrk.zip`

| **8** : `ls -l`

### zip `zip -r file.zip dir`; `unzip file.zip`

| **9** : `zip -r vrk.zip vrk`

| **10** : `ls -l`

*You can see the* `vrk` *directory*

*This time, unzip it to the* `compress` *directory*

| **11** : `unzip vrk.zip -d compress/`

| **12** : `cp vrk.zip compress/`

| **13** : `cd compress`

| **14** : `ls -l`

*It works, but we don't need this extra* `vrk` *directory; delete it*

| **15** : `rm -r vrk`

| **16** : `cd ..`

### tar (Tape ARchive) `tar -cvf file.tar dir`; `tar -xvf file.tar`

*Note* `-c` *is for "Create";* `-v` *is for "Verbose";* `-f` *is for "File"*

| **17** : `tar -cvf vrk.tar vrk`

| **18** : `ls -l`

| **19** : `cp vrk.tar compress/`

| **20** : `cd compress`

| **21** : `ls -l`

*Note* `vrk.tar` *is not compressed, larger than* `vrk.zip`

*Note* `-x` *is for "eXtract";* `-v` *is for "Verbose";* `-f` *is for "File"*

| **22** : `tar -xvf vrk.tar`

| **23** : `ls -l`

| **24** : `rm -r vrk`

### xz `xz file`; `xz -d file.xz`

| **25** : `xz vrk.tar`

| **26** : `ls -l`

*Note it replaced the original file* `vrk.tar`

*Note* `-d` *is for "Decompress"*

| **27** : `xz -d vrk.tar.xz`

| **28** : `ls -l`

*Note the .tar.xz file is gone*

*Now you would normally want to untar it*

| **29** : `tar -xf vrk.tar`

| **30** : `ls -l`

*Create the .tar.xz file without removing the original using* `-c`

| **31** : `xz -c vrk.tar > vrk.tar.xz`

| **32** : `ls -l`

*Compare types*

*Note which files are larger and smaller: .tar .zip .tar.xz*

### Combine tar & xz into one command

| **33** : `rm vrk.tar.xz`

| **34** : `ls -l`

*Note without* `-v` *for "Verbose" it is nice and quiet*

| **35** : `tar -cf - vrk | xz > vrk.tar.xz`

*Breakdown:*
- `-c` *"Create" something new*
- `-f` *"File" output filename will be specified*
- `-` *placeholder where the output tarball filename normally goes, i.e.* `vrk.tar`
- `vrk` *the tarball content source, here one directory, being tarred up*
- `|` *"pipe" (send) that output to whatever comes next*
- `xz` *the next command, using* `xz` *compression*
- `>` *...to an output file...*
- `vrk.tar.xz` *is the actual output file*

| **36** : `rm vrk.tar.xz`

| **37** : `ls -l`

*You can drop the "File" parameters altogether*

| **38** : `tar -c vrk | xz > vrk.tar.xz`

| **39** : `ls -l`

___

## Part II `xz -9` `gzip` `bzip2` `tar xf`

`cd ~/School/VIP/shell/201/compress`

___

### tar (slightly stronger) compression level 9

| **40** : `ls -l`

*Note* `-9` *is the compression level*

| **41** : `xz -9 -c vrk.tar > vrk.9.tar.xz`

| **42** : `ls -l`

*Note the size difference*

### Other compression tools: gzip & bzip2

#### gzip `gzip -c file > file.gz`; `gzip -d file.gz`

| **43** : `gzip vrk.tar > vrk.tar.gz`

*Answer "y" to overwrite, though the file doesn't already exist (this is another drawback of* `gzip`*)*

| **44** : `ls -l`

*Note it replaced the original file* `vrk.tar`

| **45** : `cp ../vrk.tar .`

| **46** : `ls -l`

*There's a slightly better way...*

| **47** : `rm vrk.tar.gz`

| **48** : `ls -l`

*Note* `-c` *is for "Create, keep original"*

| **49** : `gzip -c vrk.tar > vrk.tar.gz`

*Note there was no question this time;* `-c` *is a good idea with* `gzip`

| **50** : `ls -l`

| **51** : `rm vrk.tar`

*Note* `-d` *is for "Decompress"*

| **52** : `ls -l`

| **53** : `gzip -d vrk.tar.gz`

| **54** : `ls -l`

*Note* `vrk.tar.gz` *is was replaced, just as with xz*

*We want* `vrk.tar.gz` *for reference*

| **55** : `gzip -c vrk.tar > vrk.tar.gz`

#### bzip2 `bzip2 -c file > file.bz2`; `bzip2 -d file.bz2`

*Note* `-c` *is for "Create, keep original" just as with* `gzip`

| **56** : `bzip2 -c vrk.tar > vrk.tar.bz2`

| **57** : `ls -l`

*Note* `vrk.tar` *still exists, delete before extracting*

| **58** : `rm vrk.tar`

*Note* `-d` *is for "Decompress" as with gzip*

| **59** : `bzip2 -d vrk.tar.bz2`

| **60** : `ls -l`

*Note* `vrk.tar.bz2` *is gone, we want it back for reference*

| **61** : `bzip2 -c vrk.tar > vrk.tar.bz2`

### Review sizes

| **62** : `ls -l`

*Case and point:* `xz` *is smallest, simplest to use, and takes just a little more time*

### Decompress any tarball `tar xf`

*Note* `tar` *can figure out the format, also with decompressing:*

| **63** : `rm -r vrk`

| **64** : `ls -l`

| **65** : `tar -xf vrk.tar.gz`

| **66** : `ls -l`

*Done in one step AND the original vrk.tar.gz file is still there!*

*"Again!" — Baby Dinosaur*

| **67** : `rm -r vrk`

| **68** : `ls -l`

*(Oh, and the dash* `-` *is optional with* `tar` *options)*

| **69** : `tar xf vrk.tar.bz2`

| **70** : `ls -l`

*Now with* `xz`

| **71** : `rm -r vrk && ls -l`

| **72** : `tar xf vrk.tar.xz && ls -l`


___

## Part III `tar cf` `tar tf` `tar rf`

`cd ~/School/VIP/shell/201/compress`

___

*Remember* `tar cf` *creates the tarball*

### Peek inside any tarball with `tar tf`

| **73** : `ls -l`

*Look at what's in the tarballs (notice the speed)*

| **74** : `tar tf vrk.tar`

| **75** : `tar tf vrk.tar.gz`

| **76** : `tar tf vrk.tar.bz2`

| **77** : `tar tf vrk.tar.xz`

*The list is quite long, so put it into a file for easy viewing*

| **78** : `tar tf vrk.tar.xz > vrk-tar-tf`

| **79** : `ls -l`

| **80** : `gedit vrk-tar-tf`

*tar up the* `cpdir` *directory*

| **81** : `cd ..`

| **82** : `tar cvf cpdir.tar cpdir`

| **83** : `tar tf cpdir.tar`

*Note that* `-v` *"Verbose" basically does the same as* `-t` *"contenT" while tarring*

### Add to a .tar file

*Make some prep*

| **84** : `cp cpdir.tar compress/`

| **85** : `cp -r cpdir compress/`

| **86** : `cd compress`

| **87** : `touch file1 file2 file3`

*Note the following order:* `tar cf TARBALL-FILE.tar CONTENTS CONTENTS CONTENTS ETC`

| **88** : `tar cf files.tar file1 file2 cpdir`

*Have a look inside*

| **89** : `tar tf files.tar`

*Add a file with* `-r`

| **90** : `tar rf files.tar file3`

*See if* `file3` *has been added*

| **91** : `tar tf files.tar`

### Review: tar & xz

| **92** : `rm vrk.tar.xz`

*Tar up and xz-compress in one command:*

| **93** : `tar c vrk | xz > vrk.tar.xz`

*Cleanup*

| **94** : `rm -r vrk`

| **95** : `ls -l`

*Untar and decompress in one command:*

| **96** : `tar xf vrk.tar.xz`

*Case and point:* `xz` *is probably best,* `gzip` *and* `bzip2` *exist in the Linuxverse, and* `tar xf FILE` *works on any* `.tar*` *file*

___

# The Take

- "Flags" (say `-f`, `-v`) can be combined like this: `-fv`
- The `-` hyphen is optional with flags for `tar`; `tar -fv` = `tar fv`
- These are all common compression utilities in Linux: `tar`, `xz`, `zip`, `gzip`, `bzip2`
- `tar` puts many files into one file
  - the single file is called a "tarball"
  - the size stays the same
- `tar` stands for "tape archive" and dates back to "cassette backup" technology
- `tar` works with `gzip`, `bzip2`, and `xz` (listed oldest to newest)
- `zip` is popular for Windows users, but does not work with `tar`
- `zip` makes the biggest files, `xz` makes the smallest
- `tar` can completely open a tarball compressed with `gzip`, `bzip2`, or `xz`
- compressing with `tar` requires `tar` and `|` into `gzip`, `bzip2`, or `xz`
- Here are two commands to work with compressed tarballs:
  - Compress with `xz`: `tar c DIRECTORY | xz > TARFILE.tar.xz`
  - Decompress `.tar.xz`: `tar xf TARFILE.tar.xz`
  - *Decompress is the same with `.tar.gzip` and `.tar.bzip2`*
___

#### [Lesson 8: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md)
