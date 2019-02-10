# Shell 401
## Lesson 5: More with Variables

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

### I. Exit Variable: `$?`

*Prepare*

`touch iamhere`

`ls` *The file exists:* `iamhere`

*Edit a new file*

`gedit varexit`

*Put this code in the file and save it:*

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

*Make it executable*

`chmod ug+x varexit`

`ls`

*Run it and watch carefully*

`./varexit`

### II. `shift` argument variable numbers

*Edit a new file*

`gedit varshift`

*Put this code in the file and save it:*

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
```

*Make it executable*

`chmod ug+x varshift`

`ls`

*Run it and watch carefully*

`./varshift one two three four five six`

*Note the* `$0` *variable does not shift,* ***only argument variables***

### III. `$@` all arguments

*Edit a new file*

`gedit varargs`

*Put this code in the file and save it:*

```sh
#!/bin/sh

echo "Before shift
$@"

shift

echo "After shift
$@"
```

*Make it executable*

`chmod ug+x varargs`

`ls`

*Run it and watch carefully*

`./varargs one two three four five six`

### IV. `$#` argument count

*Edit a new file*

`gedit vargcount`

*Put this code in the file and save it:*

```sh
#!/bin/sh

echo "Before shift
$#"

shift

echo "After shift
$#"
```

*Make it executable*

`chmod ug+x vargcount`

`ls`

*Run it and watch carefully*

`./vargcount one two three four five six`

### V. `unset` Variables

*Edit a new file*

`gedit varunset`

*Put this code in the file and save it:*

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

*Make it executable*

`chmod ug+x varunset`

*Run it and watch carefully*

`./varunset one two three four five six`

#### [Lesson 6: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-06.md)
