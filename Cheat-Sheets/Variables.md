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

Using `unset variable` will remove a variable's value, technically making it "NULL"

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

*Read-only variables are usually named with ALL_UPPERCASE; it's not necessary, just Shell coder common practice*

Using `readonly variable=...` will create a variable that can neither be changed nor `unset`

For example:

```sh
readonly READONLYVar="I can never be changed in this script."
```

#### `local`: Works only *inside* a function

Using `local variable=...` will create a variable that only has its value inside the function where it is used

For example:

```sh
myFunction() {

# works only inside this function:
local var1="something"

# works everywhere in the script:
var2="something"

}

# variables only work after the function is called:
myFunction

```

#### `export`: Works also *outside* a script

Using `export variable` will make a variable retain its value even after the script exits

For example:

```sh
# This variable retain its value even after the script finishes:
export var="something"
```

Or, define first, `export` later:

```sh
var="something"
export var
```
___

### III. Two ways to define variables
1. Declare the variable & value

```sh
var=doggy
myColor=pink
```
- Now, when using the variable `$var` with `$` it will have the value "doggy"
- And, when using the variable `$myColor` with `$` it will have the value "pink"
...such as...

```sh
echo $var
touch $myColor
```

2. Use a shell command, which does something so the variable gets its value

```sh
SHELLCOMMAND var
```

...real examples...

```sh
for var in *.md; do
# Do something
done
```
... now `$var` has a value

```sh
read var
```
... now `$var` has a value

```sh
echo "I am a sweet potato."
```

... Now `$?` = "0" because echo ran successfully and exited without error
___

### IV. Removing text in a variable's value
#### `${var#START}`
#### `${var%END}`
#### `${var%END}`
#### `${var//remove/}`
#### `${var//$remove/}`
#### `${var//remove/replace}`
#### `${var//$remove/$replace}`

```sh
${Variable%food}
${Variable#food}
${Variable//food/}
${Variable//$food/}
${Variable//food/bard}
${Variable//$food/$bard}
```

1. Remove text at start: `${var#foo}`

```sh
var=fooapplefoo
echo ${var#foo}
```

returning

```sh
applefoo
```

2. Remove text at end: `${var%foo}`

```sh
var=fooapplefoo
echo ${var%foo}
```

returning

```sh
fooapple
```

3. Nifty trick to replace text at the start or end

(Remove end, then append)

- `${var%foo}bar` will replace "foo" in the value output with "bar"

```sh
var=fooapplefoo
echo ${var%foo}bar
```

returns

```sh
fooapplebar
```

(Prepend, then remove start)

- `bar${var#foo}` will replace "foo" in the value output with "bar"

```sh
var=fooapplefoo
echo bar${var#foo}
```

returns

```sh
barapplefoo
```

4. Remove text from anywhere: `${var//foo/}`

```sh
var=fooapplefoo
echo ${var//apple/}
```

returning

```sh
foofoo
```

5. Remove variable from anywhere: `${var//$foo/}`

```sh
var=fooapplefoo
bar=apple
echo ${var//$bar/}
```

returning

```sh
foofoo
```

6. Replace text anywhere: `${var//foo/bar}`

```sh
var=fooapplefoo
echo ${var//apple/banana}
```

returning

```sh
foobananafoo
```

7. Replace variable anywhere: `${var//$foo/$bar}`

```sh
var=fooapplefoo
rab=apple
bar=banana
echo ${var//$rab/$bar}
```

returning

```sh
foobananafoo
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

OR, to include a [heredoc](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md#ii-heredoc-cat-eof)...
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

### VI. `for` var `in` LST

- `for var` sets `$var` as a changing varable for each occurrence in "LST"
- "LST" can be anything, such as files, such as `*.odt` or `*.png` or `*`
- If "LST" includes a full path, then each `do` cycle will set `$var` to include the same full path

```sh
for var in *.txt

do

# Change to .md files:

echo ${var%txt}md

# Change to files with no extension:

echo ${var%.txt}

done
```

- `*.txt` can be anything, usually returning many items
- `${var%txt}md` will replace "txt" with "md" in the output
- All of this is used in a `do`... `done` loop that follows

___

### VII. `case` $var `in` ...`esac`
- `case` uses a varible, but the variable must already be set
- `case` does NOT set a variable

```sh
case $var in

DO SOMETHING FOR EACH SCENARIO OF WHAT $var COULD BE

esac
```

___

### VIII. `getopts`
- `getopts` sets a variable in a `while` loop


```sh
while getopts ":a:b:c:" var
...
```
- Now, `$var` can be used in the `while getopts`... `case` loop


___

### IX. `getopt`
- `getopt` HELPS to set a variable in a nested command using `var=$(getopt ...)` or `` var=`getopt ...` ``


```sh
var=$(getopt -o a:bcdeh) # OR...
var=`getopt -o a:bcdeh` # Backticks do the same thing
...
```
- Now, `$var` can be used in the `while`... `case` loop
