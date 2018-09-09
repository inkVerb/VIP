# Shell 201
## Lesson 4: ls -l, chmod

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`

___

`touch whoown iown theyown youown`

`ls`

`ls -1`

*Note the vertical list with* `-1` *(dash ONE)*

`ls -l`

*Note your username in the longer, more detailed list*

`chmod +x whoown`

`ls -l`

*Note the "x" now on whoown*

`chmod -x whoown`

`ls -l`

*Note the "x" has been removed from whoown*

`chmod 777 whoown`

`ls -l`

`chmod 444 whoown`

`ls -l`

`chmod 600 whoown`

`ls -l`

*Refer to this cheat-sheet for more about chmod:* [VIP/Cheet-Sheets: chmod](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)

#### [Lesson 5: adduser, deluser, chown](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-05.md)
