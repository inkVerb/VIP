# Shell 401
## Lesson 7: More with `sed` & files

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Constrcution (below)

### I. Counter `while` loop

*Edit a new file*

`gedit loopcount`

*Put this code in the new file and save it:*

```sh
#!/bin/sh

Max="$1"

Count=1

while [ "$Count" -le "$Max" ]; do
echo "Line No. $Count:	" >> countfile  # Note `echo "$Count	" >> countfile` contains a "tab" in the echo statement
Count=$(expr $Count + 1)
done
```

*Make it executable*

`chmod ug+x loopcount`

`ls`

*Run it and watch carefully*

`./loopcount 15`

`ls`

*Note the file created:* `countfile`

`gedit countfile`

### II. `sed` special characters

#### `$` = "end of line"

This is the same in `vim`, so get used to it.

*Add something to the end of each line*

`sed -i "s/$/add2end/" countfile`

*gedit: Reload countfile*

#### `\n` = new line

*Add a new line to the end of each line*

`sed -i "s/$/\n/" countfile`

*gedit: Reload countfile*

#### `\t` = tab

*Replace each tab with two tabs*

`sed -i "s/\t/\t\t/" countfile`

*gedit: Reload countfile*

#### `.` periods

*Change "No." to "Number"*

`sed -i "s/No\./Number/" countfile`

*gedit: Reload countfile*

## Under Constrcution (here)

### III. Characters
Character class [abc] [!abc] [a-h] [2-8]
Named character classes [:alpha:] etc



#### [Lesson 8: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-08.md)
