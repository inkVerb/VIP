# Shell 401
## Lesson 7: More with `while` & `sed`

`cd ~/School/VIP/shell/401`

___

### I. Counter `while` loop

*Edit this script*

| **1** : `gedit loopcount`

*It should look like this:*

```sh
#!/bin/sh

Max="$1"

Count=1

while [ "$Count" -le "$Max" ]; do
echo "Line No. $Count:	" >> countfile  # Note `echo "$Count	" >> countfile` contains a "tab" in the echo statement
Count=$(expr $Count + 1)
done
```

*Make sure it's executable*

| **2** : `chmod ug+x loopcount && ls`

*Run it and watch carefully*

| **3** : `./loopcount 15`

| **4** : `ls`

*Note the file created:* `countfile`

| **5** : `gedit countfile`

### II. `sed` special characters

#### `$` = "end of line"

This is the same in `vim`, so get used to it.

*Add something to the end of each line*

| **6** : `sed -i "s/$/add2end/" countfile`

*gedit: Reload countfile*

#### `\n` = new line

*Add a new line to the end of each line*

| **7** : `sed -i "s/$/\n/" countfile`

*gedit: Reload countfile*

#### `\t` = tab

*Replace each tab with two tabs*

| **8** : `sed -i "s/\t/\t\t/" countfile`

*gedit: Reload countfile*

#### `.` periods

*Change "No." to "Number"*

| **9** : `sed -i "s/No\./Number/" countfile`

*gedit: Reload countfile*

#### [Lesson 8: `$IFS` (Internal Field Separator)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-08.md)
