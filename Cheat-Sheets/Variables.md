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
- `shift` = The `$2` value will become `$1`, etc
- `shift 3` = The `$4` value will become `$1`, etc
- `shift` will *never* change the `$0` variable

___

### II. Custom variable names

#### Three types of variables:
- Environment variables (can't change, view many of these with `printenv` in the terminal)
- Argument variables (assigned by following the executable command; `$0`, `$1`, `$2`, etc)
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

#### `unset`: Clearing a variable's value

Using `unset VariablE_NAME` will remove a variable's value, technically making it "NULL"

For example:

```sh
var="fifty"

echo $var

# The screen will display "fifty".

unset var

echo $var

# The screen will display nothing.
```

#### `readonly`: Making a read-only variable

Using `readonly VariablE_NAME` will create a variable that can neither be changed nor `unset`

For example:

```sh
readonly READONLYVAR="I can never be changed in this script."
```
___

### III. Two ways to create variables
1. Declare the variable & value

```sh
Variabl=doggy
myColor=pink
```
- Now, when using the variable `$Variabl` with `$` it will have the value "doggy"
- And, when using the variable `$myColor` with `$` it will have the value "pink"
...such as...

```sh
echo $Variabl
touch $myColor
```

2. Use a shell command, which does something so the variable gets its value

```sh
shellcommand Variabl
```

- But, `shellcommand` isn't a real comand
...here are real examples...

```sh
for Variabl in *.md; do
# Do something
done
```
... now `$Variabl` has a value

```sh
read Variabl
```
... now `$Variabl` has a value

```sh
echo "I am a sweet potato."
```

... Now `$?` = "0" because echo ran successfully and exited without error
___

### IV. Find-replace in a variable's value

- `${Variabl%foo}bar` will replace "foo" in the value output with "bar"

Say the variable's value is set to "applefoo"

```sh
Variabl=applefoo
```

Using `${Variabl%foo}bar` will change the variable's output to "applebar"

```sh
echo ${Variabl%foo}bar
```

returning

```sh
applebar
```

Replace a string with nothing with: `${Variabl%foo}`

```sh
echo ${Variabl%foo}
```

returning

```sh
apple
```

___

### V. Variable Variables

#### Method 1: via `eval` (capable in Shell)

```sh
#!/bin/sh
varONE="varTWO"
eval "$varONE='$(echo "I love apples.")'"
echo $varTWO # -> "I love apples."

```

OR, to be cleaner and more complex...

```sh
#!/bin/sh
varONE="varTWO"
MyMessage="I love apples."
eval "$varONE='$(echo "$MyMessage")'"
echo $varTWO # -> "I love apples."
```

OR, to include a [heredoc](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md#i-heredoc-cat-eof)...
```sh
#!/bin/sh
varONE="varTWO"
MyHeredoc="$(cat <<EOF
This is my message.
I am using $varONE.
This is the third line.
EOF
)"
eval "$varONE='$(echo "$MyHeredoc")'"
echo $varTWO # -> "No quotes: This is my message. I'm using $varONE. This is the third line." (all on one line)
echo Now, with quotes:
echo "$varTWO" # -> Note lines are preserved because `echo` only preserves variable lines with double quotes, as also in the `eval` statement.
```

#### Method 2: via `${!var}` (requires BASH)

```bash
#!/bin/bash
# Set these variables:
myvar="apple"
one="my"
TWO="var"
three="myvar"
four="${one}${TWO}" # This does not require BASH, only SH

# Call the variables
echo "$three"
# returns: myvar

echo "${!three}"
# returns: apple
# $three = "myvar" hence ${!three} = $myvar = "apple"
# This requires BASH

echo "$four"
# returns: myvar

echo "${!four}"
# returns: apple
# This requires BASH

```

___

### VI. `for` Variabl `in` WUT

- `for Variabl` sets `$Variabl` as a changing varable for each occurrence in "WUT"
- "WUT" can be anything, such as files, such as `*.odt` or `*.png` or `*`
- If "WUT" includes a full path, then each `do` cycle will set `$Variabl` to include the same full path

```sh
for Variabl in *.txt

do

# Change to .md files:

echo ${Variabl%txt}md

# Change to files with no extension:

echo ${Variabl%.txt}

done
```

- `*.txt` can be anything, usually returning many items
- `${Variabl%txt}md` will replace "txt" with "md" in the output
- All of this is used in a `do`... `done` loop that follows

___

### VII. `case` $Variabl `in` ...`esac`
- `case` uses a varible, but the variable must already be set
- `case` does NOT set a variable

```sh
case $Variabl in

DO SOMETHING FOR EACH SCENARIO OF WHAT $Variabl COULD BE

esac
```

___

### VIII. `getopts`
- `getopts` sets a variable in a `while` loop


```sh
while getopts ":a:b:c:" Variabl
...
```
- Now, `$Variabl` can be used in the `while getopts`... `case` loop


___

### IX. `getopt`
- `getopt` HELPS to set a variable in a nested command using `var=$(getopt ...)` or `` var=`getopt ...` ``


```sh
Variabl=$(getopt -o a:bcdeh) # OR...
Variabl=`getopt -o a:bcdeh` # Backticks do the same thing
...
```
- Now, `$Variabl` can be used in the `while`... `case` loop
