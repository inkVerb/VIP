# Shell 401
## Lesson 7: More with while & sed

`cd ~/School/VIP/shell/401`

___

### I. Counter `while` Loop

*Edit this script*

| **1** : `gedit loopcount`

*It should look like this:*

```sh
#!/bin/sh

Max="$1"

Count=1

while [ "$Count" -le "$Max" ]; do
echo "Line No. $Count:	" >> countfile  # Note this contains a "tab"
Count=$(expr $Count + 1)
done
```

*Run it and watch carefully*

| **2** : `./loopcount 15`

| **3** : `ls`

*Note the file created:* `countfile`

| **4** : `gedit countfile`

### II. `sed` Special Characters

#### `.` period = concatenate

*Change "No." to "Number"...*

*`.` is canceled with* `\` *in this* `sed` *command...*

| **5** : `sed -i "s/No\./Number/" countfile`

*gedit: Reload countfile*

*Change "Number" to "Num"...*

| **6** : `sed -i "s/Nu*/Num/" countfile`

*gedit: Reload countfile*

*Note it now reads "Nummber" because* `*` *needs concatenating*

*Let's use* `.*.` *to replace anything between "Nu" and the space after...*

| **7** : `sed -i "s/Nu.*. /Num /" countfile`

*gedit: Reload countfile*

*Now it reads "Num" correctly*

*The period* `.` *means "more being added", in some circumstances, like* `sed` *and many programming languages*

#### `$` = "end of line"

This is the same in `vim`, so get used to it.

*Add something to the end of each line*

| **8** : `sed -i "s/$/_add2end/" countfile`

*gedit: Reload countfile*

#### `^` = "start of line"

*Add something to the start of each line*

| **9** : `sed -i "s/^/add2start_/" countfile`

*gedit: Reload countfile*

#### `\n` = new line

*Add a new line to the end of each line*

| **10** : `sed -i "s/$/\n/" countfile`

*gedit: Reload countfile*

#### `\t` = tab

*Replace each tab with two tabs*

| **11** : `sed -i "s/\t/ TAB /" countfile`

*Let's change this text "TAB" into a pipe* `|`

| **12** : `sed -i "s/TAB/|/" countfile`

*gedit: Reload countfile*

*Let's put a tab after the "start_" string...*

| **13** : `sed -i "s/start_/start_\t/" countfile`

*gedit: Reload countfile*

___

# The Take

- `while` can create an auto-counting loop when combined with `expr` for arithmetic
- Some special characters have meaning in text tools like `sed`:
  - `.` "concatenate" ***(needs canceling)***
  - `$` end of line ***(needs canceling)***
  - `^` start of line ***(needs canceling)***
  - `\n` new line **(already canceled)**
  - `\t` tab **(already canceled)**

___

#### [Lesson 8: $IFS (Internal Field Separator)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-08.md)
