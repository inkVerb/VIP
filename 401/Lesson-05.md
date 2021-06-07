# Shell 401
## Lesson 5: More with Variables

Ready the CLI

`cd ~/School/VIP/401`

___

### I. Exit Code Variable: `$?`

*Prepare*

| **1** :$

```console
touch iamhere
```

| **2** :$

```console
ls iamhere
```

*The file exists: `iamhere`*

| **3** :$ *`$?` is "the last exit code"*

```console
echo $?
```

*Exit code `0` means the last command was a success and returned STDOUT "true"*

| **4** :$

```console
ls iamNOThere
```

| **5** :$

```console
echo $?
```

*Exit code `2` means the last command was a failure and returned with STDERR error*

*Exit code `1` would mean the last command was a success and returned STDOUT "false"*

*Edit this script*

| **6** :$

```console
gedit varexit
```

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

| **7** :$

```console
./varexit
```

### II. `shift` Argument Variable Numbers

*Edit this script*

| **8** :$

```console
gedit varshift
```

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

| **9** :$

```console
./varshift one two three four five six
```

*Note the `$0` variable does not shift,* ***only argument variables***

### III. `$@` vs `$*` (All Arguments)

*These are different:*

- `$@` = all arguments as separate variables
- `$*` = all arguments, but as one long string

*But, they almost always behave the same way...*

*Edit this script*

| **10** :$

```console
gedit varargs
```

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

| **11** :$

```console
./varargs one two three four five six
```

*Now, we will embed this into another script and pass those arguments via `$@` & `$*` ...*

*Edit this script*

| **12** :$

```console
gedit varargsvar
```

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

| **13** :$

```console
./varargsvar one two three four five six
```

*...No matter how we run it, `$@` & `$*` behave the same*

### IV. `$#` Argument Count

*Edit this script*

| **14** :$

```console
gedit vargcount
```

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

| **15** :$

```console
./vargcount one two three four five six
```

### V. `unset` Variables

*Edit this script*

| **16** :$

```console
gedit varunset
```

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

| **17** :$

```console
./varunset one two three four five six
```

### VI. Variables in `${bracketts}`

#### Shell (`#!/bin/sh`)

*Edit this script*

| **18** :$

```console
gedit varbrackett-sh
```

*It should look like this:*

| **varbrackett-sh** :

```sh
#!/bin/sh

myVar="Pineapple pie"

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $myVar

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$myVar"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${myVar}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${myVar}"
```
*Run it and watch carefully*

| **19** :$

```console
./varbrackett-sh one two three four five six seven eight nine ten eleven twelve
```

*Again, but with **BASH**...*

#### BASH (`#!/bin/bash`)

*Edit this script*

| **20** :$

```console
gedit varbrackett-bash
```

*It should look like this:*

| **varbrackett-bash** :

```bash
#!/bin/bash

myVar="Pineapple pie"

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $myVar

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$myVar"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${myVar}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${myVar}"
```

*Run it and watch carefully*

| **21** :$

```console
./varbrackett-bash one two three four five six seven eight nine ten eleven twelve
```

### VII. `export` Variables

*Edit these scripts to see the short version*

| **22** :$

```console
gedit variable-no-export variable-exported
```

*They should look like this:*

| **variable-no-export** :

```sh
#!/bin/sh

myVar="Hello world!"

~/School/VIP/401/variable-exported
```
*The above script is in the next file...*

| **variable-exported** :

```sh
#!/bin/sh

echo "${myVar}"
```

*Run the first script and watch carefully*

| **23** :$

```console
./variable-no-export
```

*Edit this script*

| **24** :$

```console
gedit variable-yes-export
```

*It should look like this:*

| **variable-yes-export** :

```sh
#!/bin/sh

export myVar="Hello world!"

~/School/VIP/401/variable-exported
```

*Run it and watch carefully*

| **25** :$

```console
./variable-yes-export
```

*Note a variable only carries into another script if declared with: `export`*

### VII. Removing Text in a Variable's Value: `${var#foo}` vs `${var%foo}`

*Edit this script*

| **26** :$

```console
gedit varfoo
```

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

| **27** :$

```console
./varfoo
```

*Take a good look at that*

### VIII. `readonly` Variables (Constants)

*"Constants" are, basically, variables that can't change (oxymoron, but you get the idea)*

*Generally, only/always use ALL CAPS for naming a "constant" so other Shell coders understand you*

#### 1. You can't change a `readonly` variable's value

*Edit this script*

| **28** :$

```console
gedit variable-readonly-1
```

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

| **29** :$

```console
./variable-readonly-1
```

#### 2. You can't `unset` a `readonly` variable

*Edit this script*

| **30** :$

```console
gedit variable-readonly-2
```

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

| **31** :$

```console
./variable-readonly-2
```

**Usually, "should-be-constant variables" are ALL_UPPERCASE, it's just a good Shell coder's healthy habit**

*(This is why environment variables are ALL_UPPERCASE, see with `printenv`)*

*ALL_UPPERCASE variables may or may not be "`readonly`"; they just "shouldn't" be changed, according to common practice*

### IX. Terminal & Environment Variables (`set`, `printenv` & `export`)

Ready the CLI (if needed)

`cd ~/School/VIP/401`

#### `set` *without arguments* lists all current variables and functions, everywhere

| **32** :$

```console
set
```

*It listed everything, let's do one page at a time...*

| **33** :$

```console
set | more
```

*We will do more with `set` in [Lesson 9](https://github.com/inkVerb/vip/blob/master/401/Lesson-09.md)*

#### Command line variables

*You can work with variables directly...*

| **34** :$

```console
myvar="Yoohoo!"
```

| **35** :$

```console
echo $myvar
```

| **36** :$

```console
unset myvar
```

| **37** :$

```console
echo $myvar
```

*...Now it's gone!*

#### `printenv` lists all variables in the *environment*; you may remember from [101-Lesson 3](https://github.com/inkVerb/vip/blob/master/101/Lesson-03.md)

| **38** :$

```console
printenv
```

| **39** :$

```console
printenv USER
```

| **40** :$

```console
echo $USER
```

*We can add a variable to the environment...*

| **41** :$

```console
myvar="Yipyip"
```

| **42** :$

```console
echo $myvar
```

| **43** :$

```console
printenv myvar
```

*I didn't display via `printenv` because it's not in the environment, let's put it there...*

| **44** :$

```console
export myvar
```

| **45** :$

```console
printenv myvar
```

*Try looking for it...*

| **46** :$

```console
printenv
```

*We can change it...*

| **47** :$

```console
myvar="Yakyak"
```

| **48** :$

```console
echo $myvar
```

| **49** :$

```console
printenv myvar
```

*And remove it...*

| **50** :$

```console
unset myvar
```

| **51** :$

```console
echo $myvar
```

| **52** :$

```console
printenv myvar
```

*Make it `readonly`...*

| **53** :$

```console
myvar="Coocoo"
```

| **54** :$

```console
echo $myvar
```

| **55** :$

```console
readonly myvar
```

| **56** :$

```console
myvar="Coocoo"
```

| **57** :$

```console
unset myvar
```

*...We can't change a `readonly` variable*

**One problem: `readonly` variables should be $ALL_CAPPS for good coding etiquette**

*Let's do it right, you can also make a variable `readonly` when you first set it...*

| **58** :$

```console
readonly MY_NEW_VAR="Cadoo"
```

| **59** :$

```console
echo $MY_NEW_VAR
```

| **60** :$

```console
MY_NEW_VAR="Nutty"
```

*...good, it's `readonly`*

| **61** :$

```console
export MY_NEW_VAR
```

| **62** :$

```console
printenv MY_NEW_VAR
```

*That's how it's done*

*All in one command...*

| **63** :$

```console
export readonly ALSO_VAR="VIP Linux"
```

| **64** :$

```console
printenv ALSO_VAR
```

*Note `export readonly` is the order; `readonly export` **will not** work*
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
  - Syntax: `unset Variable_to_unset`
- Variables may be wrapped in curly brackets `${variable}` when called
  - ***In BASH (not Shell)*** this is necessary for arguments (`$1`, `$2`, etc) larger than 9
    - `$10` would register as *argument one* (`$1`)
    - `${10}` would register as a *argument ten*
  - This also helps variables work in some situations they otherwise wouldn't
- Removal within variable values:
  - `${var#foo}` removes test at the **beginning** of a variable's value
  - `${var%foo}` removes test at the **end** of a variable's value
- `export` adds a variable to the *environment*, allowing it to be into other scripts
  - Syntax: `export NewVariable="Variable's value"`
  - Syntax for already assigned: `export NewVariable`
- `readonly` makes a variable both unable to change and unable to `unset`
  - Syntax: `readonly NewVariable="Variable's value"`
  - Syntax for already assigned: `readonly NewVariable`
  - It's common practice in Shell coding to name variables that "shouldn't" change with ALL_UPPERCASE
- Terminal & environment variables
  - Variables can be assigned, called, and `unset` directly in the terminal from the CLI
  - `set` *without arguments* lists all current variables and functions, everywhere
  - `printenv` lists variables in the *environment*; all without arguments, or individually:
    - Individual syntax: `printenv Variable_to_Show`
  - `export` and `readonly` can be used together when assigning a variable; *order matters!*
    - `export readonly NewVariable="Variable's value"`

- See usage and examples here: [Variables](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 6: Data Types & Quotes](https://github.com/inkVerb/vip/blob/master/401/Lesson-06.md)
