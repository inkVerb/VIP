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
```
___

### II. Two ways to create variables
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
for VARIABL in *.md
... now $VARIABL has a value
```

```sh
read VARIABL
... now $VARIABL has a value

```

___

### III. Find-replace in a variable's value

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

### IV. `for` VARIABL `in` WUT

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

### V. `case` $VARIABL `in` ...`esac`
- `case` uses a varible, but the variable must already be set
- `case` does NOT set a variable

```sh
case $VARIABL in

DO SOMETHING FOR EACH SCENARIO OF WHAT $VARIABL COULD BE

esac
```

___

### VI. `getopts`
- `getopts` sets a variable in a `while` loop


```sh
while getopts ":a:b:c:" VARIABL
...
```
- Now, `$VARIABL` can be used in the `while getopts`... `case` loop


___

### VII. `getopt`
- `getopt` HELPS to set a variable in a nested command using `VAR=$(getopt ...)` or `` VAR=`getopt ...` ``


```sh
VARIABL=$(getopt -o a:bcdeh) # OR...
VARIABL=`getopt -o a:bcdeh` # Backticks do the same thing
...
```
- Now, `$VARIABL` can be used in the `while`... `case` loop

