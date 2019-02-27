# Shell 201
## Lesson 4: ls -l, chmod

`cd ~/School/VIP/shell/201`

___

| **1** : `touch whoown iown theyown youown`

| **2** : `ls`

| **3** : `ls -1`

*Note the vertical list with* `-1` *(dash ONE)*

| **4** : `ls -l`

*Note your username in the longer, more detailed list*

| **5** : `chmod +x whoown`

| **6** : `ls -l`

*Note the "x" now on whoown*

*This is DANGEROUS:* `chmod +x whoown`

*...for personal files, use* `chmod ug+x whoown` *instead so the public can't execute the file*

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

#### [Lesson 5: adduser, deluser, chown](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-05.md)
