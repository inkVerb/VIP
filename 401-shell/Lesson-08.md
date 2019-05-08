# Shell 401
## Lesson 8: $IFS (Internal Field Separator)

`cd ~/School/VIP/shell/401`

___

The `$IFS` variable is a character that separates "fields". You could say it separates words (fields). It's related to looping, but not directly.

Usually, the default `$IFS` is a space or tab or new line. This is partially why spaces separate arguments. So...

***This needs BASH to work correctly!***

```bash
command arg1 arg2 arg3
```

...is seen by the terminal as...

```bash
command${IFS}arg1${IFS}arg2${IFS}arg3
```

"Fields" are important because a `for` loop will loop once per field.

...The question is: ***What constitutes a field?***

If we define the `$IFS` variable as "a new line", that's like saying, "Each '*'word' (field)* is separated by a *'new line'*."

Let's run a `for` loop that separates each field as a "new line"...
___

### I. `$IFS` = new line

*Edit this script to see the short version*

| **1** : `gedit looplines`

*It should look like this:*

```bash
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line

for EachLine in $(cat countfile); do

echo "IFS_ $EachLine"

done
```

*Run it and watch carefully*

| **2** : `./looplines`

### II. Complex Loop Applied

Integrate `pwgen` with `sed` in a `for` loop...

*Edit this script to see the short version*

| **3** : `gedit looprandom`

*It should look like this:*

```bash
#!/bin/bash

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryLine in $(cat countfile); do

RANDOM_string="$(pwgen -s -1 8)" # Each $RANDOM_string will be different in each loop

echo "$EveryLine" | sed "s/add2end/IFS_$RANDOM_string/" >> randomlooped

done

unset IFS # We don't want our strange settings messing with other things.
```

*Run it*

| **4** : `./looprandom`

| **5** : `ls`

*Note the file created: `randomlooped`*

| **6** : `gedit randomlooped`

### III. `$IFS` = tab

*Remember those tabs in the file? Find the double tabs and expand them...*

*Remember: `\t` = tab*

`sed -i "s/\t\t/\tword1\tword2\tword3\t/" randomlooped`

*gedit: Reload randomlooped*

Set `$IFS` to a "tab"

*Edit this script to see the short version*

| **7** : `gedit looptab`

*It should look like this:*

```bash
#!/bin/bash

IFS=$'\t' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryTAB in $(cat randomlooped); do

echo "IFS_tab_ $EveryTAB"

done

unset IFS # We don't want our strange settings messing with other things.
```

*Run it and watch carefully*

| **8** : `./looptab`

*Take a look at countfile again*

| **9** : `gedit countfile`

*Note that the IFS separated items at the tab after "add2start_" on each line*

### IV. `$IFS` = colon `:`

*Edit this script to see the short version*

| **10** : `gedit loopcolon`

*It should look like this:*

```bash
#!/bin/sh

IFS=$':' # Use the $IFS variable to define a "loopable" field as "each" colon

for EachColon in $(cat countfile); do

echo "IFS_Colon_ $EachColon"

done
```

*Run it and watch carefully*

| **11** : `./loopcolon`

### V. `$IFS` = pipe `|`

*Edit this script to see the short version*

| **12** : `gedit looppipe`

*It should look like this:*

```bash
#!/bin/sh

IFS=$'|' # Use the $IFS variable to define a "loopable" field as "each" pipe

for EachPipe in $(cat countfile); do

echo "IFS_Pipe_ $EachPipe"

done
```

*Run it and watch carefully*

| **13** : `./looppipe`

___

# The Take

- The `$IFS` variable is the "Internal Field Separator"
  - This separates one field from another, such as in:
    - `do` items in a `for`/`while`/`until` loop
    - arguments from a command line or BASH functions
- `$IFS` can be set to almost anything, including:
  - `\n` newline
  - `\t` tab
  - `:` colon
  - `|` pipe
  - Whatever you set it to
- Seting Syntax:
  - `IFS=$'NEW_IFS'`
- This is useful in case you need to run a loop per item, but only items separated by line or tab or colon, etc
- Know what the IFS is and that it can be changed will make some parts of programming make much more sense

___

#### [Lesson 9: Interpreters, errors, logic, and empty testing](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-09.md)
