# Shell 201
## Lesson 4: ls -1 -l -a -r, chmod

Ready the CLI

`cd ~/School/VIP/201`

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

#### Permissions

| **1** :$ `touch whoown iown theyown youown`

| **2** :$ `ls`

| **3** :$ `ls -1`

*Note the vertical list with `-1` (dash ONE)*

| **4** :$ `ls -l`

*Note your username in the longer, more detailed list*

| **5** :$ `chmod +x whoown`

| **6** :$ `ls -l`

*Note the "x" now on whoown: `-rwxrwxr-x` ('x' appears 3 times, the last one can be dangerous because it is public)*

*This is the danger: `chmod +x whoown`*

*For personal files, use `chmod ug+x whoown` so the last "x" won't be there, so the public can't execute the file*

| **7** :$ `chmod -x whoown`

| **8** :$ `ls -l`

*Note the "x" has been removed from whoown*

| **9** :$ `chmod ug+x whoown`

| **10** :$ `ls -l`

*Note it is green, but "x" only appears 2 times: `-rwxrwxr--`, so only the owner can execute the file*

*These are "permissions" (`-rw-rw-r--`, `-rwxrwxr--`, `-rwxrwxr-x`, etc )*

*You can also use numbers to set permissions, which is more normal for programmers*

| **11** :$ `chmod 777 whoown`

| **12** :$ `ls -l` *Note the new permissions (`-rwxrwxrwx`)*

| **13** :$ `chmod 444 whoown`

| **14** :$ `ls -l` *Note the new permissions (`-r--r--r--`)*

*Note `chmod ug+x` is "relative" while using `chmod` with numbers is absolute...*

| **15** :$ `chmod ug+x whoown`

| **16** :$ `ls -l` *Note the permissions are now `-r-xr-xr--`, different from last time we used `chmod ug+x`*

| **17** :$ `chmod 664 whoown`

| **18** :$ `ls -l` *Note the new permissions (`-rw-rw-r--`) are the original permissions*

| **19** :$ `chmod 774 whoown`

| **20** :$ `ls -l` *Note, that was what we had before: `-rwxrwxr--`*

| **21** :$ `chmod 600 whoown`

| **22** :$ `ls -l` *Note the new permissions (`-rw-------`)*

*Refer to this cheat-sheet for more about chmod:* [VIP/Cheat-Sheets: Permissions](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)

#### Hidden files

| **23** :$ `touch .hideme .hidemealso .cantseeme`

| **24** :$ `ls`

*Note you can't see the files just created, because files that start with a period `.` are "hidden"*

| **25** :$ `ls -a`

| **26** :$ `ls -l`

| **27** :$ `ls -la`

| **28** :$ `mkdir .hidedir .cantseedir`

| **29** :$ `ls`

*Directories also can be "hidden"*

| **30** :$ `ls -a`

*In Nautilus (the file explorer) press <kbd>Ctrl</kbd> + H to toggle view of hidden files and directories*

#### Reverse order

| **31** :$ `ls`

| **32** :$ `ls -r`

| **33** :$ `ls -1`

| **34** :$ `ls -1r`

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
