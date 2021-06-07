# Shell 201
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
cd ../dirlink
```

| **12** :$

```console
ls
```

| **13** :$

```console
touch subdirectory/alsofile
```

| **14** :$

```console
cd subdirectory
```

| **15** :$

```console
ls
```

| **16** :$

```console
cd ../../directory/subdirectory
```

| **17** :$

```console
ls
```

| **18** :$

```console
cd ../..
```

| **19** :$

```console
ls
```

| **20** :$

```console
mkdir dirnew
```

| **21** :$

```console
ls
```

| **22** :$

```console
cd dirnew
```

| **23** :$

```console
touch delfile
```

| **24** :$

```console
ls
```

| **25** :$

```console
cd ..
```

*Use `touch` & `ls` with a different directory...*

| **26** :$

```console
ls dirnew
```

| **27** :$

```console
touch dirnew/alsodel dirnew/alsoalso
```

| **28** :$

```console
ls -l dirnew
```

| **29** :$

```console
rm dirnew
```

*Note the error message about directories*

*Use `-r` (Recursive) to remove directories*

| **30** :$

```console
rm -r dirnew
```

| **31** :$

```console
ls
```

| **32** :$

```console
cp directory cpdirnew
```

*Note the error message about directories*

*Use `-r` with `cp` as well as `rm` for directories*

| **33** :$

```console
cp -r directory cpdirnew
```

| **34** :$

```console
ls
```

| **35** :$

```console
mv -r cpdirnew cpdir
```

*Note, `mv` rejects `-r`, just use `mv` even for directories*

| **36** :$

```console
mv cpdirnew cpdir
```

| **37** :$

```console
ls
```

| **38** :$

```console
cd cpdir
```

*Note that `.` = "current directory" and `..` = "parent directory"... even with `ls`...*

| **39** :$

```console
ls .
```

| **40** :$

```console
ls ..
```

| **41** :$

```console
cd ..
```

| **42** :$

```console
ls .
```

| **43** :$

```console
ls ..
```

*These are even listed with the "all" flag (`-a`)*

| **44** :$

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

#### [Lesson 3: Software – apt, lsb_release](https://github.com/inkVerb/vip/blob/master/201/Lesson-03.md)
