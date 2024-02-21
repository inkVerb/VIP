# Linux 201
## Lesson 7: tar, xz, zip, gzip, bzip2

Ready the CLI

```console
cd ~/School/VIP/201
```

**FOR** | **14 - 16** :$

```console
cd verb.ink
```

Reference

`wget -O vip.zip https://github.com/inkVerb/vip/archive/master.zip`

#### [Compression Cheat Sheet](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Compression.md)

___

*First some prep*

| **1** :$

```console
mkdir compress
```

## I. `zip` `tar` `xz`

| **2** :$

```console
ls -l
```

| **3** :$

```console
unzip vip.zip
```

| **4** :$

```console
ls -l
```

*What a strange name, "VIP-master"*

| **5** :$

```console
mv VIP-master vip
```

| **6** :$

```console
ls -l
```

*That zip file was strange, let's delete it*

| **7** :$

```console
rm vip.zip
```

| **8** :$

```console
ls -l
```

### zip: `zip -r file.zip dir`; `unzip file.zip`

| **9** :$

```console
zip -r vip.zip vip
```

| **10** :$

```console
ls -l
```

*You can see the `vip` directory*

*This time use `-d` to unzip it to the `compress` directory*

| **11** :$

```console
unzip vip.zip -d compress/
```

| **12** :$

```console
cp vip.zip compress/
```

| **13** :$

```console
cd compress
```

| **14** :$

```console
ls -l
```

*It works, but we don't need this extra `vip` directory; delete it*

| **15** :$

```console
rm -r vip
```

| **16** :$

```console
cd ..
```

### tar (Tape ARchive): `tar -cvf file.tar dir`; `tar -xvf file.tar`

*Note `-c` is for "Create"; `-v` is for "Verbose"; `-f` is for "File"*

| **17** :$

```console
tar -cvf vip.tar vip
```

| **18** :$

```console
ls -l
```

| **19** :$

```console
cp vip.tar compress/
```

| **20** :$

```console
cd compress
```

| **21** :$

```console
ls -l
```

*Note `vip.tar` is not compressed, larger than `vip.zip`*

*Note `-x` is for "eXtract"; `-v` is for "Verbose"; `-f` is for "File"*

| **22** :$

```console
tar -xvf vip.tar
```

| **23** :$

```console
ls -l
```

| **24** :$

```console
rm -r vip
```

### xz: `xz file`; `xz -d file.xz`

Ready the CLI (if needed)

```console
cd ~/School/VIP/201/compress
```

| **25** :$

```console
xz vip.tar
```

| **26** :$

```console
ls -l
```

*Note it replaced the original file `vip.tar`*

*Note `-d` is for "Decompress"*

| **27** :$

```console
xz -d vip.tar.xz
```

| **28** :$

```console
ls -l
```

*Note the .tar.xz file is gone*

*Now you would normally want to untar it*

| **29** :$

```console
tar -xf vip.tar
```

| **30** :$

```console
ls -l
```

*Create the .tar.xz file without removing the original using `-c`*

| **31** :$

```console
xz -c vip.tar > vip.tar.xz
```

| **32** :$

```console
ls -l
```

*Compare types*

*Note which files are larger and smaller: .tar .zip .tar.xz*

### Combine `tar` & `xz` into one command

| **33** :$

```console
rm vip.tar.xz vip.tar
```

| **34** :$

```console
ls -l
```

*Now we will create a .*

*Note without `-v` for "Verbose" it is nice and quiet*

| **35** :$

```console
tar -cf - vip | xz > vip.tar.xz
```

| **36** :$

```console
ls -l
```

*Breakdown:*
- `-c` *"Create" something new*
- `-f` *"File" output filename will be specified*
- `-` *placeholder where the output tarball filename normally goes, i.e. `vip.tar`*
- `vip` *the tarball content source, here one directory, being tarred up*
- `|` *"pipe" (send) that output to whatever comes next*
- `xz` *the next command, using `xz` compression*
- `>` *...to an output file...*
- `vip.tar.xz` *is the actual output file*

| **37** :$

```console
rm vip.tar.xz
```

| **38** :$

```console
ls -l
```

*You can drop the "File" parameters altogether*

| **39** :$

```console
tar -c vip | xz > vip.tar.xz
```

| **40** :$

```console
ls -l
```

___

## II. `xz -2` `gzip` `bzip2` `tar xf`

Ready the CLI (if needed)

```console
cd ~/School/VIP/201/compress
```

___

### `tar`: Compression Levels

*Some quick prep...*

| **41** :$

```console
cp ../vip.tar . && ls -l
```

*Note `-2` is the compression level...*

| **42** :$

```console
xz -2 -c vip.tar > vip.2.tar.xz
```

| **43** :$

```console
ls -l
```

*Note the size difference*

*Compression level 9 (`-9`) is the highest*

### Other Compression Tools: `gzip` & `bzip2`

#### gzip: `gzip -c file > file.gz`; `gzip -d file.gz`

| **44** :$

```console
gzip vip.tar
```

| **45** :$

```console
ls -l
```

*Note vip.tar.gz replaced the original file `vip.tar`*

| **46** :$

```console
cp ../vip.tar .
```

| **47** :$

```console
ls -l
```

*There's a slightly better way...*

| **48** :$

```console
rm vip.tar.gz
```

| **49** :$

```console
ls -l
```

*Note `-c` is for "Create, keep original"*

| **50** :$

```console
gzip -c vip.tar > vip.tar.gz
```

*Note there was no question this time; `-c` is a good idea with `gzip`*

| **51** :$

```console
ls -l
```

| **52** :$

```console
rm vip.tar
```

| **53** :$

```console
ls -l
```

*Note `-d` is for "Decompress"*

| **54** :$

```console
gzip -d vip.tar.gz
```

| **55** :$

```console
ls -l
```

*Note `vip.tar.gz` is was replaced, just as with xz*

*We want `vip.tar.gz` for reference, so cleanup...*

| **56** :$

```console
gzip -c vip.tar > vip.tar.gz
```

#### bzip2: `bzip2 -c file > file.bz2`; `bzip2 -d file.bz2`

| **57** :$

```console
ls -l
```

| **58** :$

```console
bzip2 vip.tar
```

*Note `vip.tar.bz2` replaced `vip.tar`, just as with xz and gzip*

| **59** :$

```console
ls -l
```

*Note `-d` is for "Decompress" as with gzip*

| **60** :$

```console
bzip2 -d vip.tar.bz2
```

| **61** :$

```console
ls -l
```

*Note `vip.tar.bz2` is gone, we want it back for reference...*

| **62** :$

```console
bzip2 -c vip.tar > vip.tar.bz2
```

*Note `-c` is for "Create, keep original" just as with `gzip`*

### Review the file sizes

| **63** :$

```console
ls -l
```

*Case and point: `xz` is smallest, simplest to use, and takes just a little more time*

### Deconpress and extract any tarball: `tar xf`

*Note `tar` can figure out the format, also with decompressing:*

| **64** :$

```console
rm -r vip
```

| **65** :$

```console
ls -l
```

| **66** :$

```console
tar -xf vip.tar.gz
```

| **67** :$

```console
ls -l
```

*Done in one step AND the original vip.tar.gz file is still there!*

*"Again!" — Baby Dinosaur*

| **68** :$

```console
rm -r vip && ls -l
```

*(Oh, and the dash `-` is optional with `tar` options)*

| **69** :$

```console
tar xf vip.tar.bz2
```

| **70** :$

```console
ls -l
```

*Quick cleanup...*

| **71** :$

```console
rm -r vip && ls -l
```

*Now with `xz`*

| **72** :$

```console
tar xf vip.tar.xz
```

| **73** :$

```console
ls -l
```

___

## III. `tar cf` `tar tf` `tar rf`

Ready the CLI (if needed)

```console
cd ~/School/VIP/201/compress
```

___

*Remember `tar cf` creates the tarball*

### Take a peek inside any tarball: `tar tf`

*Take a peek at what's in the tarballs (notice the speed of each)*

| **74** :$

```console
tar tf vip.tar
```

*Note that only shows the contents, no files changed*

| **75** :$

```console
ls -l
```

*Note `tar t...` works with .tar files and with its compressors (gzip, bzip2, and xz)*

| **76** :$

```console
tar tf vip.tar.gz
```

| **77** :$

```console
tar tf vip.tar.bz2
```

| **78** :$

```console
tar tf vip.tar.xz
```

*The list is quite long, so put it into a file for easy viewing*

| **79** :$

```console
tar tf vip.tar.xz > vip-tar-tf
```

| **80** :$

```console
ls -l
```

| **81** :$

```console
gedit vip-tar-tf
```

*tar up the `cpdir` directory*

| **82** :$

```console
cd ..
```

| **83** :$

```console
tar cvf cpdir.tar cpdir
```

| **84** :$

```console
tar tf cpdir.tar
```

*Note that `-v` "Verbose" basically does the same as `-t` "contenT" while tarring*

### Add to a .tar file

*Make some prep*

| **85** :$

```console
cp cpdir.tar compress/
```

| **86** :$

```console
cp -r cpdir compress/
```

| **87** :$

```console
cd compress
```

| **88** :$

```console
touch file1 file2 file3
```

*Note the following order: `tar cf TARBALL-FILE.tar CONTENTS CONTENTS CONTENTS ETC`*

| **89** :$

```console
tar cf files.tar file1 file2 cpdir
```

*Take a peek inside*

| **90** :$

```console
tar tf files.tar
```

*Add a file with `-r`*

| **91** :$

```console
tar rf files.tar file3
```

*See if `file3` has been added*

| **92** :$

```console
tar tf files.tar
```

### Review: `tar` & `xz`

| **93** :$

```console
rm vip.tar.xz && ls -l
```

*Tar up and xz-compress in one command:*

| **94** :$

```console
tar c vip | xz > vip.tar.xz
```

*`-J` flag to tar up and xz-compress in one command:*

| **95** :$

```console
tar Jc vip vipJ.tar.xz
```

- `-J` use `xz`
- `-j` use `bzip2`
- `-z` use `gzip`

*See the results...*

| **96** :$

```console
ls -l
```

*Cleanup*

| **97** :$

```console
rm -r vip && ls -l
```

*Untar and decompress in one command:*

| **98** :$

```console
tar xf vip.tar.xz
```

*See, it worked...*

| **99** :$

```console
ls -l
```

*Case and point: `xz` is probably best, `gzip` and `bzip2` exist in the Linuxverse, and `tar xf FILE` works on any `.tar*` file*

___

# The Take

- Important commands
  - `tar Jc source archive.txz` make `xz` compressed tarball in one command
    - `-J` use `xz`
    - `-j` use `bzip2`
    - `-z` use `gzip`
  - `tar t archive.tar` see what's inside
  - `tar xf archive.tar` extract
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

#### [Lesson 8: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201/Lesson-08.md)
