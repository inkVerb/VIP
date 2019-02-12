# Variables

### I. Argument variables
`myshellscript.sh arg-1 argument-two three arg4 arg-5`

...has these values...

```sh
$0 = myshellscript.sh
$1 = arg-1
$2 = argument-two
$3 = three
$4 = arg4
$5 = arg-5

$@ = myshellscript.sh arg-1 argument-two three arg4 arg-5
$# = 5 # because there are 5 arguments
$? = # whatever the last exit code was, such as from a program
```

The `shift` command will move these arguments to different numbers:
- `shift` = The `$2` value will become `$1`, etc.
- `shift 3` = The `$4` value will become `$1`, etc.
- `shift` will *never* change the `$0` variable

___

### II. Custom variable names

#### Three types of variables:
- Environment variables (can't change, view many of these with `printenv` in the terminal)
- Argument variables (assigned by following the executable command; `$0`, `$1`, `$2`, etc.)
- Custom variables (you invent and assign these in a script)

#### Custom variable rules:
Custom variables...
1. must NOT begin with a number
2. may contain numbers after the first character
3. may contain: uppercase, lowercase, digits, and underscore (`A-Z`, `a-z`, `0-9`, `_`)
4. are case sensitive

#### Examples of valid custom variables:

- `_MyFile`
- `MY_FILE`
- `myfile`
- `mYfIlE`
- `my_file_23`
- `_15`
- `_1`
- `file4`
- `my4_files_`

#### Examples of invalid custom variables:

- `9myfile` (can't begin with digit)
- `28` (can't begin with digit)
- `TWO&THREE` (can't use `&`, only allowed special character is `_`)
- `four-five` (can't use `-`, only allowed special character is `_`)

#### Clearing a variable's value via `unset`

Using `unset VARIABLE_NAME` will remove a variable's value, technically making it "NULL".

For example:

```sh
VAR="fifty"

echo $VAR

# The screen will display "fifty".

unset VAR

echo $VAR

# The screen will display nothing.
```
___

### III. Two ways to create variables
1. Declare the variable & value

```sh
VARIABL=doggy
myColor=pink
```
- Now, when using the variable `$VARIABL` with `$` it will have the value "doggy"
- And, when using the variable `$myColor` with `$` it will have the value "pink"
...such as...

```sh
echo $VARIALE
touch $myColor
```

2. Use a shell command, which does something so the variable gets its value

```sh
shellcommand VARIABL
```

- But, `shellcommand` isn't a real comand
...here are real examples...

```sh
for VARIABL in *.md; do
# Do something
done
```
... now `$VARIABL` has a value

```sh
read VARIABL
```
... now `$VARIABL` has a value

```sh
echo "I am a sweet potato."
```

... Now `$?` = "0" because echo ran successfully and exited without error.
___

### IV. Find-replace in a variable's value

- `${VARIABL%foo}bar` will replace "foo" in the value output with "bar"

Say the variable's value is set to "applefoo"

```sh
VARIABL=applefoo
```

Using `${VARIABL%foo}bar` will change the variable's output to "applebar"

```sh
echo ${VARIABL%foo}bar
```

returning

```sh
applebar
```

Replace a string with nothing with: `${VARIABL%foo}`

```sh
echo ${VARIABL%foo}
```

returning

```sh
apple
```

___

### V. Variable Variables via `${!VAR}` (requires BASH)

```bash
#!/bin/bash
# Set these variables:
myVAR="apple"
one="my"
TWO="VAR"
three="myVAR"
four="${one}${TWO}" # This does not require BASH, only SH

# Call the variables
echo "$three"
# returns: myVAR

echo "${!three}"
# returns: apple
# $three = "myVAR" hence ${!three} = $myVAR = "apple"
# This requires BASH

echo "$four"
# returns: myVAR

echo "${!four}"
# returns: apple
# This requires BASH

```

___

### VI. `for` VARIABL `in` WUT

- `for VARIABL` sets `$VARIABL` as a changing varable for each occurrence in `WUT`
- `WUT` can be anything, such as files, such as `*.odt` or `*.png` or `*`
- If `WUT` includes a full path, then each `do` cycle will set `$VARIABL` to include the same full path

```sh
for VARIABL in *.txt

do

# Change to .md files:

echo ${VARIABL%txt}md

# Change to files with no extension:

echo ${VARIABL%.txt}

done
```

- `*.txt` can be anything, usually returning many items
- `${VARIABL%txt}md` will replace "txt" with "md" in the output
- All of this is used in a `do`... `done` loop that follows

___

### VII. `case` $VARIABL `in` ...`esac`
- `case` uses a varible, but the variable must already be set
- `case` does NOT set a variable

```sh
case $VARIABL in

DO SOMETHING FOR EACH SCENARIO OF WHAT $VARIABL COULD BE

esac
```

___

### VIII. `getopts`
- `getopts` sets a variable in a `while` loop


```sh
while getopts ":a:b:c:" VARIABL
...
```
- Now, `$VARIABL` can be used in the `while getopts`... `case` loop


___

### IX. `getopt`
- `getopt` HELPS to set a variable in a nested command using `VAR=$(getopt ...)` or `` VAR=`getopt ...` ``


```sh
VARIABL=$(getopt -o a:bcdeh) # OR...
VARIABL=`getopt -o a:bcdeh` # Backticks do the same thing
...
```
- Now, `$VARIABL` can be used in the `while`... `case` loop
