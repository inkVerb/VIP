# Shell 401
## Lesson 5: More with Variables

`cd ~/School/VIP/shell/401`

___

### I. Exit Code Variable: `$?`

*Prepare*

| **1** : `touch iamhere`

| **2** : `ls` *The file exists:* `iamhere`

*Edit this script*

| **3** : `gedit varexit`

*It should look like this:*

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

| **4** : `./varexit`

### II. `shift` Argument Variable Numbers

*Edit this script*

| **5** : `gedit varshift`

*It should look like this:*

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

| **6** : `./varshift one two three four five six`

*Note the* `$0` *variable does not shift,* ***only argument variables***

### III. `$@` vs `$*` (All Arguments)

*These are different:*

- `$@` = all arguments as separate variables
- `$*` = all arguments, but as one long string

*But, they almost always behave the same way...*

*Edit this script*

| **7** : `gedit varargs`

*It should look like this:*

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

| **8** : `./varargs one two three four five six`

*Now, we will embed this into another script and pass those arguments via* `$@` *&* `$*` *...*

*Edit this script*

| **9** : `gedit varargsvar`

*It should look like this:*

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

| **10** : `./varargsvar one two three four five six`

*...No matter how we run it,* `$@` *&* `$*` *basically behave the same.*

### IV. `$#` Argument Count

*Edit this script*

| **11** : `gedit vargcount`

*It should look like this:*

```sh
#!/bin/sh

echo "Before shift
$#"

shift

echo "After shift
$#"
```

*Run it and watch carefully*

| **12** : `./vargcount one two three four five six`

### V. `unset` Variables

*Edit this script*

| **13** : `gedit varunset`

*It should look like this:*

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

| **14** : `./varunset one two three four five six`

### VI. Variables in `${bracketts}`

*Edit this script*

| **15** : `gedit varbrackett-sh`

*It should look like this:*

```sh
#!/bin/sh

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $13

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$13"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${13}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${13}"
```
*Run it and watch carefully*

| **16** : `./varbrackett-sh one two three four five six seven eight nine ten eleven twelve thirteen`

*Again, but with **BASH**...*

*Edit this script*

| **17** : `gedit varbrackett-bash`

*It should look like this:*

```bash
#!/bin/bash

echo "without quotes:"
echo $9
echo $10
echo $11
echo $12
echo $13

echo "with quotes:"
echo "$9"
echo "$10"
echo "$11"
echo "$12"
echo "$13"

echo "{brackets} without quotes:"
echo ${9}
echo ${10}
echo ${11}
echo ${12}
echo ${13}

echo "{brackets} with quotes:"
echo "${9}"
echo "${10}"
echo "${11}"
echo "${12}"
echo "${13}"
```

*Run it and watch carefully*

| **18** : `./varbrackett-bash one two three four five six seven eight nine ten eleven twelve thirteen`

___

# The Take

- `$?` is the most recent exit code
- `shift` reassigns arguments to different argument variables (`$2` becomes `$1`, etc)
- `$0` is the "command" variable, not an "argument" variable
- `$@` & `$*` both mean "all arguments" (`$1` and after, ***NOT*** `$0`)
  - Both behave much the same way
  - `$@` is more "proper" because the arguments are separated
  - `$*` considers all arguments to be in a single string
  - Don't let the similarity make you lazy, avoid `$*` unless you need it specifically!
- `$#` is the number of arguments
- `unset` unsets (removes) a variable's value
  - Syntax: `unset VARIABLE_TO_UNSET`
- Variables may be wrapped in curly brackets `${variable}` when called
  - ***In BASH (not Shell)***, this is necessary for arguments (`$1`, `$2`, etc) larger than 9
    - `$10` would register as `$1`; `${10}` would register as a ten
  - This also helps variables work in some situations they otherwise wouldn't

___

#### [Lesson 6: Data Types & Quotes](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-06.md)
