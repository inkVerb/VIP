# Shell 201
## Lesson 4: ls -1 -l -a -r, chmod

Ready the CLI

```console
cd ~/School/VIP/201
```

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

#### Permissions

| **1** :$

```console
touch whoown iown theyown youown
```

| **2** :$

```console
ls
```

| **3** :$

```console
ls -1
```

*Note the vertical list with `-1` (dash ONE)*

| **4** :$

```console
ls -l
```

*Note your username in the longer, more detailed list*

| **5** :$

```console
chmod +x whoown
```

| **6** :$

```console
ls -l
```

*Note the "x" now on whoown: `-rwxrwxr-x` ('x' appears 3 times, the last one can be dangerous because it is public)*

*This is the danger: `chmod +x whoown`*

*For personal files, use `chmod ug+x whoown` so the last "x" won't be there, so the public can't execute the file*

| **7** :$

```console
chmod -x whoown
```

| **8** :$

```console
ls -l
```

*Note the "x" has been removed from whoown*

| **9** :$

```console
chmod ug+x whoown
```

| **10** :$

```console
ls -l
```

*Note it is green, but "x" only appears 2 times: `-rwxrwxr--`, so only the owner can execute the file*

*These are "permissions" (`-rw-rw-r--`, `-rwxrwxr--`, `-rwxrwxr-x`, etc )*

*You can also use numbers to set permissions, which is more normal for programmers*

| **11** :$

```console
chmod 777 whoown
```

| **12** :$ *Note the new permissions (`-rwxrwxrwx`)*

```console
ls -l
```

| **13** :$

```console
chmod 444 whoown
```

| **14** :$ *Note the new permissions (`-r--r--r--`)*

```console
ls -l
```

*Note `chmod ug+x` is "relative" while using `chmod` with numbers is absolute...*

| **15** :$

```console
chmod ug+x whoown
```

| **16** :$ *Note the permissions are now `-r-xr-xr--`, different from last time we used `chmod ug+x`*

```console
ls -l
```

| **17** :$

```console
chmod 664 whoown
```

| **18** :$ *Note the new permissions (`-rw-rw-r--`) are the original permissions*

```console
ls -l
```

| **19** :$

```console
chmod 774 whoown
```

| **20** :$ *Note, that was what we had before: `-rwxrwxr--`*

```console
ls -l
```

| **21** :$

```console
chmod 600 whoown
```

| **22** :$ *Note the new permissions (`-rw-------`)*

```console
ls -l
```

*Refer to this cheat-sheet for more about chmod:* [VIP/Cheat-Sheets: Permissions](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)

#### Hidden files

| **23** :$

```console
touch .hideme .hidemealso .cantseeme
```

| **24** :$

```console
ls
```

*Note you can't see the files just created, because files that start with a period `.` are "hidden"*

| **25** :$

```console
ls -a
```

| **26** :$

```console
ls -l
```

| **27** :$

```console
ls -la
```

| **28** :$

```console
mkdir .hidedir .cantseedir
```

| **29** :$

```console
ls
```

*Directories also can be "hidden"*

| **30** :$

```console
ls -a
```

*In Nautilus (the file explorer) press <kbd>Ctrl</kbd> + H to toggle view of hidden files and directories*

#### Reverse order

| **31** :$

```console
ls
```

| **32** :$

```console
ls -r
```

| **33** :$

```console
ls -1
```

| **34** :$

```console
ls -1r
```

___

# The Take

- `ls -1` (with the number one `-1`, not `-l`) will list files vertically
- `chmod` will change file permissions, see usage and examples here: [VIP/Cheat-Sheets: Permissions](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)
- `ls -l` will output a list of files with "long" information that includes the permissions that `chmod` changes
- `ls -a` shows "all" files and directories, even those hidden
- `ls -r` shows files in "reverse" order
- `ls -la` and `ls -al` combine the flags `-a` and `-l`, also `-arl`, `-r1la`, etc
- `.` at the beginning of a file or directory name makes it "hidden"
- <kbd>Ctrl</kbd> + H toggles hidden file and directory view in Nautilus
___

#### [Lesson 5: su, adduser, deluser, chown](https://github.com/inkVerb/vip/blob/master/201/Lesson-05.md)
