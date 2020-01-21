# Shell 401
## Lesson 5: More with Variables

`cd ~/School/VIP/shell/401`

___

### I. Exit Code Variable: `$?`

*Prepare*

| **1** : `touch iamhere`

| **2** : `ls iamhere`

*The file exists: `iamhere`*

| **3** : `echo $?` *`$?` is "the last exit code"*

*Exit code `0` means the last command was a success and returned STDOUT "true"*

| **4** : `ls iamNOThere`

| **5** : `echo $?`

*Exit code `2` means the last command was a failure and returned with STDERR error*

*Exit code `1` would mean the last command was a success and returned STDOUT "false"*

*Edit this script*

| **6** : `gedit varexit`

*It should look like this:*

| **varexit** :

```sh
#!/bin/sh

echo "$? first echo"

echo "I am a hot sweet potato."

echo "$? sweet potato echo"

if [ -f "iamhere" ]; then
echo "$? iamhere echo"
fi

if [ -f "iamNOThere" ]; then
echo "I shouldn't be here."
else
echo "$? iamNOThere echo, so exit code \"1\""
fi

notacommand

echo "$? notacommand is not a real command, so exit code \"127\""
```

*Run it and watch carefully*

| **7** : `./varexit`

### II. `shift` Argument Variable Numbers

*Edit this script*

| **8** : `gedit varshift`

*It should look like this:*

| **varshift** :

```sh
#!/bin/sh

echo "Before shift
\$0=$0
\$1=$1
\$2=$2
\$3=$3
\$4=$4
\$5=$5
\$6=$6"

shift

echo "After shift
\$0=$0
\$1=$1
\$2=$2
\$3=$3
\$4=$4
\$5=$5
\$6=$6"

shift 3

echo "After shift 3
\$0=$0
\$1=$1
\$2=$2
\$3=$3
\$4=$4
\$5=$5
\$6=$6"
```

*Run it and watch carefully*

| **9** : `./varshift one two three four five six`

*Note the `$0` variable does not shift,* ***only argument variables***

### III. `$@` vs `$*` (All Arguments)

*These are different:*

- `$@` = all arguments as separate variables
- `$*` = all arguments, but as one long string

*But, they almost always behave the same way...*

*Edit this script*

| **10** : `gedit varargs`

*It should look like this:*

| **varargs** :

```sh
#!/bin/sh

echo "
@ Before shift @@@@@
$@

* Before shift *****
$*
"

shift

echo "
@ After shift @@@@@
$@

* After shift *****
$*
"
```

*Run it and watch carefully*

| **11** : `./varargs one two three four five six`

*Now, we will embed this into another script and pass those arguments via `$@` & `$*` ...*

*Edit this script*

| **12** : `gedit varargsvar`

*It should look like this:*

| **varargsvar** :

```sh
#!/bin/sh

echo "
Arguments entered via \$@ ..."
./varargs $@

echo "
Arguments entered via \$(echo \$@) ..."
./varargs $(echo $@)

echo "
Arguments entered via \$* ..."
./varargs $*

echo "
Arguments entered via \$(echo \$*) ..."
./varargs $(echo $*)
```

*Run it and watch carefully*

| **13** : `./varargsvar one two three four five six`

*...No matter how we run it, `$@` & `$*` basically behave the same.*

### IV. `$#` Argument Count

*Edit this script*

| **14** : `gedit vargcount`

*It should look like this:*

| **vargcount** :

```sh
#!/bin/sh

echo "Before shift
$#"

shift

echo "After shift
$#"
```

*Run it and watch carefully*

| **15** : `./vargcount one two three four five six`

### V. `unset` Variables

*Edit this script*

| **16** : `gedit varunset`

*It should look like this:*

| **varunset** :

```sh
#!/bin/sh

myVariable="This is my variable."

myArguments="$@"

myArgCount="$#"

shift

myShiftedArgs="$@"

myShiftedCount="$#"

echo"Before unset
myArguments    = $myArguments
myArgCount     = $myArgCount
myShiftedArgs  = $myShiftedArgs
myShiftedCount = $myShiftedCount
"

unset myArguments

echo"After first unset
myArguments    = $myArguments
myArgCount     = $myArgCount
myShiftedArgs  = $myShiftedArgs
myShiftedCount = $myShiftedCount
"

unset myArgCount
unset myShiftedArgs
unset myShiftedCount

echo"After all unset
myArguments    = $myArguments
myArgCount     = $myArgCount
myShiftedArgs  = $myShiftedArgs
myShiftedCount = $myShiftedCount
"
```

| **17** : `./varunset one two three four five six`

### VI. Variables in `${bracketts}`

*Edit this script*

| **18** : `gedit varbrackett-sh`

*It should look like this:*

| **varbrackett-sh** :

```sh
#!/bin/sh

myVAR="Pineapple pie"

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $myVAR

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$myVAR"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${myVAR}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${myVAR}"
```
*Run it and watch carefully*

| **19** : `./varbrackett-sh one two three four five six seven eight nine ten eleven twelve`

*Again, but with **BASH**...*

*Edit this script*

| **20** : `gedit varbrackett-bash`

*It should look like this:*

| **varbrackett-bash** :

```bash
#!/bin/bash

myVAR="Pineapple pie"

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $myVAR

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$myVAR"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${myVAR}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${myVAR}"
```

*Run it and watch carefully*

| **21** : `./varbrackett-bash one two three four five six seven eight nine ten eleven twelve`

### VII. 'export' variables

*Edit these scripts to see the short version*

| **22** : `gedit variable-no-export variable-exported`

*They should look like this:*

| **variable-no-export** :

```sh
#!/bin/sh

myVAR="Hello world!"

~/School/VIP/shell/401/variable-exported
```
*The above script is in the next file...*

| **variable-exported** :

```sh
#!/bin/sh

echo "${myVAR}"
```

*Run the first script and watch carefully*

| **23** : `./variable-no-export`

*Edit this script*

| **24** : `gedit variable-yes-export`

*It should look like this:*

| **variable-yes-export** :

```sh
#!/bin/sh

export myVAR="Hello world!"

~/School/VIP/shell/401/variable-exported
```

*Run it and watch carefully*

| **25** : `./variable-yes-export`

*Note a variable only carries into another script if declared with: `export`*

### VII. `readonly` variables (constants)

*"Constants" are, basically, variables that can't change (oxymoron, but you get the idea)*

*Generally, only/always use ALL CAPS for naming a "constant" so other Shell coders understand you*

#### 1. You can't change a `readonly` variable's value

*Edit this script*

| **26** : `gedit variable-readonly-1`

*It should look like this:*

| **variable-readonly-1** :

```sh
#!/bin/sh

# Create a variable as read-only
readonly MYROVAR="I am read-only, a never-changing constant!"

# echo the variable
echo "Whatami: $MYROVAR"

# Try to change the variable
MYROVAR="I am changed!"
```

*Run it and watch carefully*

| **27** : `./variable-readonly-1`

#### 2. You can't `unset` a `readonly` variable

*Edit this script*

| **28** : `gedit variable-readonly-2`

*It should look like this:*

| **variable-readonly-2** :

```sh
#!/bin/sh

# Create a variable as read-only
readonly MYROVAR="I am read-only, a never-changing constant!"

# echo the variable
echo "Whatami: $MYROVAR"

# Try to unset the variable
unset MYROVAR
```

*Run it and watch carefully*

| **29** : `./variable-readonly-2`

**Usually, "should-be-constant variables" are ALL_UPPERCASE, it's just a good Shell coder's healthy habit**

*(This is why environment variables are ALL_UPPERCASE, see with `printenv`)*

*ALL_UPPERCASE variables may or may not be "`readonly`"; they just "shouldn't" be changed, according to common practice*

### VIII. Removing text in a variable's value: `${var#foo}` vs `${var%foo}`

*Edit this script*

| **30** : `gedit varfoo`

*It should look like this:*

| **varfoo** :

```sh
#!/bin/sh

var="fooapplefoo"
var1=${var#foo}
var2=${var%foo}

echo "var: $var
var1: $var1
var2: $var2"
```

| **31** : `./varfoo`

*Take a good look at that, would ya!*

___

# The Take

- `$?` is the most recent exit code
- `shift` reassigns arguments to different argument variables (`$2` becomes `$1`, etc)
- `$0` is the "command" variable, not an "argument" variable
- `$@` & `$*` both mean "all arguments" (`$1` and after, ***NOT** `$0`)
  - Both behave much the same way
  - `$@` is more "proper" because the arguments are separated
  - `$*` considers all arguments to be in a single string
  - Don't let the similarity make you lazy, avoid `$*` unless you need it specifically!
- `$#` is the number of arguments
- `unset` unsets (removes) a variable's value
  - Syntax: `unset VARIABLE_TO_UNSET`
- Variables may be wrapped in curly brackets `${variable}` when called
  - ***In BASH (not Shell)*** this is necessary for arguments (`$1`, `$2`, etc) larger than 9
    - `$10` would register as *argument one* (`$1`)
    - `${10}` would register as a *argument ten*
  - This also helps variables work in some situations they otherwise wouldn't
- `export` carries a variable into other scripts
  - Syntax: `export NEWVARIABLE="Variable's value"`
- `readonly` makes a variable both unable to change and unable to `unset`
  - Syntax: `readonly NEWVARIABLE="Variable's value"`
  - It's common practice in Shell coding to name variables that "shouldn't" change with ALL_UPPERCASE
- Removal:
  - `${var#foo}` removes test at the **beginning** of a variable's value
  - `${var%foo}` removes test at the **end** of a variable's value
- See usage and examples here: [Variables](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 6: Data Types & Quotes](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-06.md)
