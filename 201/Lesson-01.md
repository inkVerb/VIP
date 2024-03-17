# Linux 201
## Lesson 1: cp, mv, ln -s, rm, touch

Ready the CLI

```console
cd ~/School/VIP/201
```

___

| **1** :$

```console
echo FILE-1 > file1
```

| **2** :$

```console
ls
```

| **3** :$

```console
cat file1
```

| **4** :$

```console
cp file1 file2
```

| **5** :$

```console
ls
```

| **6** :$

```console
cat file2
```

| **7** :$

```console
gedit file1 file2
```

| **8** :$

```console
cp file1 file3
```

| **9** :$

```console
ls
```

| **10** :$

```console
mv file3 file4
```

| **11** :$

```console
ls
```

| **12** :$

```console
ln -s file4 file5
```

| **13** :$

```console
ls
```

*Note file5 is a different color because it is a **symlink***

| **14** :$

```console
ls -l
```

*Note file5 points to `file4`, indicating where the symlink leads*

*You can also use list-long on only the symlink to see where it points*

| **15** :$

```console
ls -l file5
```

*Let's take a peek*

| **16** :$

```console
gedit file4 file5
```

| **17** :$

```console
echo FILE-5 >> file5
```

*gedit: Reload `file4` & `file5`*

*Note both `file4` and `file5` say the same thing*

| **18** :$

```console
echo SILLY-FILE5 >> file5
```

*gedit: Reload `file4` & `file5`*

| **19** :$

```console
echo INTO-FILE4 >> file4
```

*gedit: Reload `file4` & `file5`*

| **20** :$

```console
ln -s file4 file6
```

| **21** :$

```console
ls
```

| **22** :$

```console
ls -l
```

| **23** :$

```console
cat file6
```

| **24** :$

```console
gedit file6
```

*Note `file6` is the same as `file4` & `file5`*

| **25** :$

```console
rm file6
```

| **26** :$

```console
ls
```

| **27** :$

```console
ls -l
```

*Note `file4` remains*

| **28** :$

```console
rm file4
```

| **29** :$

```console
ls
```

| **30** :$

```console
ls -l
```

*Note `file5` is "broken"*

| **31** :$

```console
touch file4
```

*Note file4 is empty now...*

| **32** :$

```console
cat file4
```

*gedit: Reload file4 & file5*

| **33** :$

```console
ls -l
```

*Note file5 is no longer a broken symlink, but `file4` isn't the same as it used to be*

*gedit: Save `file6`*

| **34** :$

```console
ls
```

*Note `file6` is no longer a symlink*

| **35** :$

```console
cat file6
```

___

# The Take
- A **symlink** is a link to another file
  - It can be opened, edited, and saved as a file
  - But, all reading and writing is done in the original file
  - Deleting a symlink does not delete the original file
  - A symlinked file's destination can be seen with `ls -l`
  - An application editing or reading a symlink probably doesn't know the difference between a symlink and a real file
- `cp` copies files this way:
  - `cp source-file file-copy`
- `mv` moves files this way:
  - `mv source-file moved-file`
  - *Note: `mv` is also the way to change the name of a file*
- `ln -s` makes a "symlink" of a file this way:
  - `ln -s source-file new-symlink`
- `ls` will list file names, but not the details
- `ls -l` will show the destination (original file) of a symlink, along with other details
- `rm` removes a file this way:
  - `rm file-to-remove`
- `touch` creates an empty file, if the file doesn't already exist this way:
  - `touch file-to-touch`
- A symlink file can be changed and the original will also change
- Removing a symlink's target file will "break" the symlink
- Recreating a symlink's target file will "unbreak" the symlink

___

#### [Lesson 2: cd, ../.., mkdir, rm -r](https://github.com/inkVerb/vip/blob/master/201/Lesson-02.md)
