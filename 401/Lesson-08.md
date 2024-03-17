# Linux 401
## Lesson 8: $IFS (Internal Field Separator)

Ready the CLI

```console
cd ~/School/VIP/401
```

___

The `$IFS` variable is a character that separates "fields". You could say it separates words, in many cases. It's related to looping, but not directly.

Usually, the default `$IFS` is a space or tab or new line. This is partially why spaces separate arguments. So...

For example, if you run `ls`, you get this:

```bash
file1 file2 file3 file4 file5
```

...but Linux sees it as this...

```bash
file1${$IFS}file2${$IFS}file3${$IFS}file4${$IFS}file5
```

"Fields" are important because a `for` loop will loop once per field.

...The question is: ***What constitutes a field?***

If we define the `$IFS` variable as "a new line", that's like saying, "Each '*'word' (field)* is separated by a *'new line'*."

Let's run a `for` loop that separates each field as a "new line"...
___

### I. `$IFS` = new line
*Edit this script to see the short version*

| **1** :$

```console
gedit looplines
```

*It should look like this:*

| **looplines** :

```bash
#!/bin/sh

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line

for EachLine in $(cat countfile); do

echo "IFS_ $EachLine"

done
```

*Run it and watch carefully*

| **2** :$

```console
./looplines
```

### II. Complex Loop Applied
Integrate `pwgen` with `sed` in a `for` loop...

*Edit this script to see the short version*

| **3** :$

```console
gedit looprandom
```

*It should look like this:*

| **looprandom** :

```bash
#!/bin/bash

IFS=$'\n' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryLine in $(cat countfile); do

Random_string="$(pwgen -s -1 8)" # Each $Random_string will be different in each loop

echo "$EveryLine" | sed "s/add2end/IFS_$Random_string/"
echo "$EveryLine" | sed "s/add2end/IFS_$Random_string/" >> randomlooped

done

unset IFS # We don't want our strange settings messing with other things.
```

*Run it*

| **4** :$

```console
./looprandom
```

| **5** :$

```console
ls
```

*Note the file created: `randomlooped`*

| **6** :$

```console
gedit randomlooped
```

### III. `$IFS` = tab

*Remember those tabs in the file? Find the double tabs and expand them...*

*Remember: `\t` = tab*

`sed -i "s/\t\t/\tword1\tword2\tword3\t/" randomlooped`

*gedit: Reload randomlooped*

Set `$IFS` to a "tab"

*Edit this script to see the short version*

| **7** :$

```console
gedit looptab
```

*It should look like this:*

| **looptab** :

```bash
#!/bin/bash

IFS=$'\t' # Use the $IFS variable to define a "loopable" field as "each" new line"

for EveryTab in $(cat randomlooped); do

echo "IFS_tab_ $EveryTab"

done

unset IFS # We don't want our strange settings messing with other things.
```

*Run it and watch carefully*

| **8** :$

```console
./looptab
```

*Take a look at countfile again*

| **9** :$

```console
gedit countfile
```

*Note that the IFS separated items at the tab after "add2start_" on each line*

### IV. `$IFS` = colon `:`

*Edit this script to see the short version*

| **10** :$

```console
gedit loopcolon
```

*It should look like this:*

| **loopcolon** :

```bash
#!/bin/sh

IFS=$':' # Use the $IFS variable to define a "loopable" field as "each" colon

for EachColon in $(cat countfile); do

echo "IFS_Colon_ $EachColon"

done
```

*Run it and watch carefully*

| **11** :$

```console
./loopcolon
```

### V. `$IFS` = pipe `|`
*Edit this script to see the short version*

| **12** :$

```console
gedit looppipe
```

*It should look like this:*

| **looppipe** :

```bash
#!/bin/sh

IFS=$'|' # Use the $IFS variable to define a "loopable" field as "each" pipe

for EachPipe in $(cat countfile); do

echo "IFS_Pipe_ $EachPipe"

done
```

*Run it and watch carefully*

| **13** :$

```console
./looppipe
```

### VI. `$IFS` in the `$PATH`

*Remember learning about our `$PATH` in [Lesson 3]((https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md))?*

| **14** :$

```console
echo $PATH
```

**This nifty little script sorts the directories in the $PATH with a `do` loop, listing each one on a new line:**

*Edit the script*

| **15** :$

```console
gedit listpath
```

*It should look like this:*

| **listpath** :

```sh
#!/bin/sh

# Set the field separator for the `for` loop to the `:` that separates dirs in the "$PATH"
IFS=:
# If we don't put "$PATH" in "double-quotes", each dir will appear on one line
# Try removing the "double-quotes" from "$PATH" on the line below to see what happens
# Also try changing the "double-quotes" to 'single-quotes' to see what happens
for pDir in $(echo "$PATH"); do
  echo $pDir
done
```

| **16** :$

```console
./listpath
```

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

#### [Lesson 9: Interpreters, errors, logic, and empty testing](https://github.com/inkVerb/vip/blob/master/401/Lesson-09.md)
