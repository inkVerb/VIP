# Shell 201
## Lesson 4: ls -1, ls -l, ls -a, chmod

`cd ~/School/VIP/shell/201`

___

| **1** : `touch whoown iown theyown youown`

| **2** : `ls`

| **3** : `ls -1`

*Note the vertical list with `-1` (dash ONE)*

| **4** : `ls -l`

*Note your username in the longer, more detailed list*

| **5** : `chmod +x whoown`

| **6** : `ls -l`

*Note the "x" now on whoown*

*This is DANGEROUS: `chmod +x whoown`*

*...for personal files, use `chmod ug+x whoown` so the public can't execute the file*

| **7** : `chmod -x whoown`

| **8** : `ls -l`

*Note the "x" has been removed from whoown*

| **9** : `chmod ug+x whoown`

*Note it is green, but the "x" doesn't exist in the third group of public permissions; this is safer*

*You can also use numbers to set these, which is more normal*

| **10** : `chmod 777 whoown`

| **11** : `ls -l`

| **12** : `chmod 444 whoown`

| **13** : `ls -l`

| **14** : `chmod 600 whoown`

| **15** : `ls -l`

*Refer to this cheat-sheet for more about chmod:* [VIP/Cheet-Sheets: chmod](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)

| **16** : `touch .hideme .hidemealso .cantseeme`

| **17** : `ls`

*Note you can't see the files just created, because files that start with a period `.` are "hidden"*

| **18** : `ls -a`

| **19** : `ls -la`

| **20** : `mkdir .hidedir .cantseedir`

| **21** : `ls`

*Directories also can be "hidden"*

| **22** : `ls -a`

___

# The Take

- `ls -1` (with the number one `-1`, not `-l`) will list files vertically
- `chmod` will change file permissions, see usage and examples here: [VIP/Cheet-Sheets: chmod](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)
- `ls -l` will output a list of files with information that includes the permissions that `chmod` changes
- `ls -a` shows "All" files and directories, even those hidden
- `.` at the beginning of a file or directory name make it "hidden"
___

#### [Lesson 5: adduser, deluser, chown](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-05.md)
