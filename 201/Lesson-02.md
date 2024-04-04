# Linux 201
## Lesson 2: cd, ../.., mkdir, rm -r

Ready the CLI

```console
cd ~/School/VIP/201
```

___

| **1** :$

```console
mkdir directory
```

| **2** :$

```console
ls
```

| **3** :$

```console
ln -s directory dirlink
```

| **4** :$

```console
ls
```

| **5** :$

```console
ls -l
```

| **6** :$

```console
cd directory
```

| **7** :$

```console
ls
```

| **8** :$

```console
mkdir subdirectory
```

| **9** :$

```console
ls
```

| **10** :$

```console
touch file
```

| **11** :$

```console
ls
```

| **12** :$

```console
cd ../dirlink
```

| **13** :$

```console
ls
```

| **134** :$

```console
touch subdirectory/alsofile
```

| **15** :$

```console
cd subdirectory
```

| **16** :$

```console
ls
```

| **17** :$

```console
cd ../../directory/subdirectory
```

| **18** :$

```console
ls
```

| **19** :$

```console
cd ../..
```

| **20** :$

```console
ls
```

| **21** :$

```console
mkdir dirnew
```

| **212** :$

```console
ls
```

| **23** :$

```console
cd dirnew
```

| **24** :$

```console
touch delfile
```

| **25** :$

```console
ls
```

| **26** :$

```console
cd ..
```

*Use `touch` & `ls` with a different directory...*

| **267** :$

```console
ls dirnew
```

| **28** :$

```console
touch dirnew/alsodel dirnew/alsoalso
```

| **29** :$

```console
ls -l dirnew
```

| **30** :$

```console
rm dirnew
```

*Note the error message about directories*

*Use `-r` (Recursive) to remove directories*

| **31** :$

```console
rm -r dirnew
```

| **32** :$

```console
ls
```

| **33** :$

```console
cp directory cpdirnew
```

*Note the error message about directories*

*Use `-r` with `cp` as well as `rm` for directories*

| **34** :$

```console
cp -r directory cpdirnew
```

| **35** :$

```console
ls
```

| **36** :$

```console
mv -r cpdirnew cpdir
```

*Note, `mv` rejects `-r`, just use `mv` even for directories*

| **37** :$

```console
mv cpdirnew cpdir
```

| **38** :$

```console
ls
```

| **39** :$

```console
cd cpdir
```

*Note that `.` = "current directory" and `..` = "parent directory"... even with `ls`...*

| **40** :$

```console
ls .
```

| **41** :$

```console
ls ..
```

| **42** :$

```console
cd ..
```

| **43** :$

```console
ls .
```

| **44** :$

```console
ls ..
```

*These are even listed with the "all" flag (`-a`)*

| **45** :$

```console
ls -a
```

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

#### [Lesson 3: Software, pacman, apt, dnf, lsb_release](https://github.com/inkVerb/vip/blob/master/201/Lesson-03.md)
