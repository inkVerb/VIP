# Shell 201
## Lesson 7: tar, xz, zip, gzip, bzip2

Ready the CLI

`cd ~/School/VIP/201`

`wget -O vip.zip https://github.com/inkVerb/vip/archive/master.zip`

#### [Compression Cheat Sheet](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Compression.md)

___

*First some prep*

| **1** :$ `mkdir compress`

## I. `zip` `tar` `xz`

| **2** :$ `ls -l`

| **3** :$ `unzip vip.zip`

| **4** :$ `ls -l`

*What a strange name, "VIP-master"*

| **5** :$ `mv VIP-master vip`

| **6** :$ `ls -l`

*That zip file was strange, let's delete it*

| **7** :$ `rm vip.zip`

| **8** :$ `ls -l`

### zip: `zip -r file.zip dir`; `unzip file.zip`

| **9** :$ `zip -r vip.zip vip`

| **10** :$ `ls -l`

*You can see the `vip` directory*

*This time use `-d` to unzip it to the `compress` directory*

| **11** :$ `unzip vip.zip -d compress/`

| **12** :$ `cp vip.zip compress/`

| **13** :$ `cd compress`

| **14** :$ `ls -l`

*It works, but we don't need this extra `vip` directory; delete it*

| **15** :$ `rm -r vip`

| **16** :$ `cd ..`

### tar (Tape ARchive): `tar -cvf file.tar dir`; `tar -xvf file.tar`

*Note `-c` is for "Create"; `-v` is for "Verbose"; `-f` is for "File"*

| **17** :$ `tar -cvf vip.tar vip`

| **18** :$ `ls -l`

| **19** :$ `cp vip.tar compress/`

| **20** :$ `cd compress`

| **21** :$ `ls -l`

*Note `vip.tar` is not compressed, larger than `vip.zip`*

*Note `-x` is for "eXtract"; `-v` is for "Verbose"; `-f` is for "File"*

| **22** :$ `tar -xvf vip.tar`

| **23** :$ `ls -l`

| **24** :$ `rm -r vip`

### xz: `xz file`; `xz -d file.xz`

| **25** :$ `xz vip.tar`

| **26** :$ `ls -l`

*Note it replaced the original file `vip.tar`*

*Note `-d` is for "Decompress"*

| **27** :$ `xz -d vip.tar.xz`

| **28** :$ `ls -l`

*Note the .tar.xz file is gone*

*Now you would normally want to untar it*

| **29** :$ `tar -xf vip.tar`

| **30** :$ `ls -l`

*Create the .tar.xz file without removing the original using `-c`*

| **31** :$ `xz -c vip.tar > vip.tar.xz`

| **32** :$ `ls -l`

*Compare types*

*Note which files are larger and smaller: .tar .zip .tar.xz*

### Combine `tar` & `xz` into one command

| **33** :$ `rm vip.tar.xz vip.tar`

| **34** :$ `ls -l`

*Now we will create a .*

*Note without `-v` for "Verbose" it is nice and quiet*

| **35** :$ `tar -cf - vip | xz > vip.tar.xz`

| **36** :$ `ls -l`

*Breakdown:*
- `-c` *"Create" something new*
- `-f` *"File" output filename will be specified*
- `-` *placeholder where the output tarball filename normally goes, i.e. `vip.tar`*
- `vip` *the tarball content source, here one directory, being tarred up*
- `|` *"pipe" (send) that output to whatever comes next*
- `xz` *the next command, using `xz` compression*
- `>` *...to an output file...*
- `vip.tar.xz` *is the actual output file*

| **37** :$ `rm vip.tar.xz`

| **38** :$ `ls -l`

*You can drop the "File" parameters altogether*

| **39** :$ `tar -c vip | xz > vip.tar.xz`

| **40** :$ `ls -l`

___

## II. `xz -2` `gzip` `bzip2` `tar xf`

Ready the CLI (if needed)

`cd ~/School/VIP/201/compress`

___

### `tar`: Compression Levels

*Some quick prep...*

| **41** :$ `cp ../vip.tar . && ls -l`

*Note `-2` is the compression level...*

| **42** :$ `xz -2 -c vip.tar > vip.2.tar.xz`

| **43** :$ `ls -l`

*Note the size difference*

*Compression level 9 (`-9`) is the highest*

### Other Compression Tools: `gzip` & `bzip2`

#### gzip: `gzip -c file > file.gz`; `gzip -d file.gz`

| **44** :$ `gzip vip.tar`

| **45** :$ `ls -l`

*Note vip.tar.gz replaced the original file `vip.tar`*

| **46** :$ `cp ../vip.tar .`

| **47** :$ `ls -l`

*There's a slightly better way...*

| **48** :$ `rm vip.tar.gz`

| **49** :$ `ls -l`

*Note `-c` is for "Create, keep original"*

| **50** :$ `gzip -c vip.tar > vip.tar.gz`

*Note there was no question this time; `-c` is a good idea with `gzip`*

| **51** :$ `ls -l`

| **52** :$ `rm vip.tar`

| **53** :$ `ls -l`

*Note `-d` is for "Decompress"*

| **54** :$ `gzip -d vip.tar.gz`

| **55** :$ `ls -l`

*Note `vip.tar.gz` is was replaced, just as with xz*

*We want `vip.tar.gz` for reference, so cleanup...*

| **56** :$ `gzip -c vip.tar > vip.tar.gz`

#### bzip2: `bzip2 -c file > file.bz2`; `bzip2 -d file.bz2`

| **57** :$ `ls -l`

| **58** :$ `bzip2 vip.tar`

*Note `vip.tar.bz2` replaced `vip.tar`, just as with xz and gzip*

| **59** :$ `ls -l`

*Note `-d` is for "Decompress" as with gzip*

| **60** :$ `bzip2 -d vip.tar.bz2`

| **61** :$ `ls -l`

*Note `vip.tar.bz2` is gone, we want it back for reference...*

| **62** :$ `bzip2 -c vip.tar > vip.tar.bz2`

*Note `-c` is for "Create, keep original" just as with `gzip`*

### Review the file sizes

| **63** :$ `ls -l`

*Case and point: `xz` is smallest, simplest to use, and takes just a little more time*

### Deconpress and extract any tarball: `tar xf`

*Note `tar` can figure out the format, also with decompressing:*

| **64** :$ `rm -r vip`

| **65** :$ `ls -l`

| **66** :$ `tar -xf vip.tar.gz`

| **67** :$ `ls -l`

*Done in one step AND the original vip.tar.gz file is still there!*

*"Again!" — Baby Dinosaur*

| **68** :$ `rm -r vip && ls -l`

*(Oh, and the dash `-` is optional with `tar` options)*

| **69** :$ `tar xf vip.tar.bz2`

| **70** :$ `ls -l`

*Quick cleanup...*

| **71** :$ `rm -r vip && ls -l`

*Now with `xz`*

| **72** :$ `tar xf vip.tar.xz`

| **73** :$ `ls -l`

___

## III. `tar cf` `tar tf` `tar rf`

Ready the CLI (if needed)

`cd ~/School/VIP/201/compress`

`ls -l`

___

*Remember `tar cf` creates the tarball*

### Take a peek inside any tarball: `tar tf`

*Take a peek at what's in the tarballs (notice the speed of each)*

| **74** :$ `tar tf vip.tar`

*Note that only shows the contents, no files changed*

| **75** :$ `ls -l`

*Note `tar t...` works with .tar files and with its compressors (gzip, bzip2, and xz)*

| **76** :$ `tar tf vip.tar.gz`

| **77** :$ `tar tf vip.tar.bz2`

| **78** :$ `tar tf vip.tar.xz`

*The list is quite long, so put it into a file for easy viewing*

| **79** :$ `tar tf vip.tar.xz > vip-tar-tf`

| **80** :$ `ls -l`

| **81** :$ `gedit vip-tar-tf`

*tar up the `cpdir` directory*

| **82** :$ `cd ..`

| **83** :$ `tar cvf cpdir.tar cpdir`

| **84** :$ `tar tf cpdir.tar`

*Note that `-v` "Verbose" basically does the same as `-t` "contenT" while tarring*

### Add to a .tar file

*Make some prep*

| **85** :$ `cp cpdir.tar compress/`

| **86** :$ `cp -r cpdir compress/`

| **87** :$ `cd compress`

| **88** :$ `touch file1 file2 file3`

*Note the following order: `tar cf TARBALL-FILE.tar CONTENTS CONTENTS CONTENTS ETC`*

| **89** :$ `tar cf files.tar file1 file2 cpdir`

*Take a peek inside*

| **90** :$ `tar tf files.tar`

*Add a file with `-r`*

| **91** :$ `tar rf files.tar file3`

*See if `file3` has been added*

| **92** :$ `tar tf files.tar`

### Review: `tar` & `xz`

| **93** :$ `rm vip.tar.xz && ls -l`

*Tar up and xz-compress in one command:*

| **94** :$ `tar c vip | xz > vip.tar.xz`

*Cleanup*

| **95** :$ `rm -r vip && ls -l`

*Untar and decompress in one command:*

| **96** :$ `tar xf vip.tar.xz`

*See, it worked...*

| **97** :$ `ls -l`

*Case and point: `xz` is probably best, `gzip` and `bzip2` exist in the Linuxverse, and `tar xf FILE` works on any `.tar*` file*

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
  - *Decompress is the same with `.tar.xz`, `.tar.gzip`, and `.tar.bzip2`*

___

#### [Lesson 8: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md)
