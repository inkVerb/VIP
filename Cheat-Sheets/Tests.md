# Tests

*Refer to this lesson for more about shells, errors, and debugging:* [VIP/Shell 401 – Lesson 9](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-09.md)

*Learn more about error exit codes here:* [http://tldp.org/LDP/abs/html/exitcodes.html]
___

### I. Test: `true` & `false`

When a test answers `true`, then shell does something via `then` or `do`

___

### II. `if` `then` (`else` / `elif`) `fi`

- An `if` test runs once and does something only under certain circumstances
- Once the `if` test is finished, the script continues

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

fi

```

- We can also use `else` to do something without any test, if the previous test returns `false`

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

else

# Something happens here because the test failed

fi

```

- We can also use `elif` to run a different test, if the previous test returns `false`

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

elif [ THIS IS ANOTHER TEST IF THE PREVIOUS TEST RETURNED FALSE ]

# Something happens here if this other test answers true

elif [ THIS IS ANOTHER TEST IF THE PREVIOUS TESTS ALL RETURNED FALSE ]

# Something happens here if this other other test answers true

fi

```

- `else` can also work with `elif`

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

elif [ THIS IS ANOTHER TEST IF THE PREVIOUS TEST RETURNED FALSE ]

# Something happens here if this other test answers true

elif [ THIS IS ANOTHER TEST IF THE PREVIOUS TESTS ALL RETURNED FALSE ]

# Something happens here if this other other test answers true

else

# Something happens here because all previous tests failed

fi

```

Also see: [VIP/Shell 301 – Lesson 1](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-01.md)

___

### III. `for` Variabl `in` Lst

- A `for` test loops and does the same thing for each among many items

```sh
for Variable in Some_List

do

  # ...do something, maybe with $Variable

done
```

The `if` test is similar to the `for` looping test, but...

- `if` does NOT repeat, it only runs ONE TIME
- `if` --> `for`
- `then` --> `do`
- `fi` --> `done`

```sh
for Variabl in *.txt

do

echo $Variabl

done
```

#### `continue` & `break`

Both of these can also be used in `until` and `while` loops

- `continue` will skip a loop cycle, doing nothing else

```sh
for Variabl in *.txt

do

  if [ -f "skip-me" ]; then
    continue
  fi

echo $Variabl

done
```

- `break` will end the loop

```sh
for Variabl in *.txt

do

  if [ -f "stop-at-me" ]; then
    break
  fi

echo $Variabl

done
```

Also see: [VIP/Shell 301 – Lesson 3](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-03.md)

___

### IV. `while` `do` `done`

- A `while` test will `do` an action "while" a test returns `true`
- Once the test returns `false`, the loop will break
- A `while` test loops and is used to change something if needed
- A `while` test "loop" repeats the test, the script only continues when the test finally returns `false`
- `while :` will always return `true` and will repeat until `break` occurs in its loop or the user terminates the script

The `if` test is similar to the `while` looping test, but...
- `if` does NOT repeat, it only runs ONE TIME
- `if` --> `while`
- `then` --> `do`
- `fi` --> `done`

```sh
while [ THIS IS THE TEST ]

do

# Something happens here if the test answers true

done

```

Also see: [VIP/Shell 301 – Lesson 5](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)

___

### V. `until` `do` `done`

- An `until` test will `do` an action while a test returns `false`, "until" the test returns `true`
- Once the test returns `true`, the loop will break
- An `until` test loops and is similar to a `while` loop
- `until :` will always return `true` and will thus `break` before it can run `do`

```sh
until [ THIS IS THE TEST ]

do

# Something happens here if the test answers false

done

```

Also see: [VIP/Shell 301 – Lesson 5](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)

___

### VI. Count with `while` & `until`

```sh
while [ TEST IS TRUE ]

do

  # ...doing something

done
```

```sh
until [ TEST IS FALSE ]

do

  # ...doing something

done
```

This is a classic example of a "counting" loop:

```sh
#!/bin/sh

Max="$1" # Set a maxiumum when run from the command line as argument $1

Count=1

while [ "$Count" -le "$Max" ]; do
echo "Line #$Count"
# Uncomment the line below to echo each new count into a file
#echo "Line #$Count" >> countfile
Count=$(expr $Count + 1)
done

```

- This works with Shell (`#!/bin/sh`) and does not require BASH (`#!/bin/bash`)
- Put the above script into a file, make it executable with `chmod ug+x` and run it to see how it works.
- Note the example includes an `echo ... >> FILE` use, but this counting variable can be used with many commands.
- This example uses `while`, but the counter can also work with `for` and `until` loops

Here is an example of the code re-written for `until`:

```sh
#!/bin/sh

Max="$1" # Set a maxiumum when run from the command line as argument $1
MaxPlusOne=$(expr $Max + 1) # Set a variable above the maximum so the loop will run the $Max value

Count=1

until [ "$Count" = "$MaxPlusOne" ]; do
echo "Line #$Count"
# Uncomment the line below to echo each new count into a file
#echo "Line #$Count" >> countfile
Count=$(expr $Count + 1)
done

```

Also see: [VIP/Shell 301 – Lesson 7](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-07.md)

___

### VII. `case`... `esac`

```sh
case $Variable in

  apples)
    # ...do something because $Variable = apples
  ;;

  berries)
    # ...do something because $Variable = berries
  ;;

esac
```

- `case` is a multiple-choice `if` test for a variable
- `a)` is the `case` when the variable = "`a`"
- `case` arguments close with `;;`
- `*` is the "everything not listed" `case` argument, usually to recognize an error and display "help" instructions

```sh
case $Variabl in

# If $Variabl=a
  a)
   DO SOMETHING "A", maybe with $Variabl
  ;;

# If $Variabl=b
  b)
   DO SOMETHING "B", maybe with $Variabl
  ;;

# If $Variabl=wallawalla
  wallawalla)
   DO SOMETHING "Walla Walla", maybe with $Variabl
  ;;

# If $Variabl= anything else
  *)
   DO SOMETHING ELSE, maybe with $Variabl
  ;;

esac
```

- `case` options can be separated with a pipe `|`

```sh
case $Variabl in

# If $Variabl=a
  a)
   DO SOMETHING "A", maybe with $Variabl
  ;;

# If $Variabl=b or $Variabl=c
  b|c)
   DO SOMETHING "B or C", maybe with $Variabl
  ;;

esac
```

- `case` options can ignore case using brackets

```sh
case $Variabl in

# If $Variabl=a
  [aA] )
   DO SOMETHING "A", maybe with $Variabl
  ;;

# If $Variabl=b or $Variabl=c
  [bB] | [cC] )
   DO SOMETHING "B or C", maybe with $Variabl
  ;;

# If $Variabl=yes or $Variabl=y
  [yY] | [yY][eE][sS] )
   DO SOMETHING "yes", maybe with $Variabl
  ;;

# If $Variabl=no or $Variabl=n
  [nN] | [nN][oO] )
   DO SOMETHING "no", maybe with $Variabl
  ;;

esac
```

- `case` can work with an "always true" loop using `while :`
- End this "always true" loop with `break`

```sh
while :

do

case $Variabl in

# If $Variabl=a
  a)
   DO SOMETHING "A", maybe with $Variabl
  ;;

# If $Variabl=stopit
  stopit)
   DO SOMETHING about stopping, maybe with $Variabl
   break
  ;;

esac

done
```

- "Lazy case" (variable-if) method:

```sh
# First, the case index

case $Variabl in

# If $Variabl=a
  a)
   caseA=true
  ;;

# If $Variabl=b
  b)
   caseB=true
  ;;

# If $Variabl=wallawalla
  wallawalla)
   casewallawalla=true
  ;;

# If $Variabl= anything else
  *)
   echo "Freak out! I didn't plan for this!"
   break
  ;;

esac

# Now, the series of if tests for each above case

if [ "$caseA" = "true" ]; then
  DO SOMETHING "A"
fi

if [ "$caseB" = "true" ]; then
  DO SOMETHING "B"
fi

if [ "$casewallawalla" = "true" ]; then
  DO SOMETHING "wallawalla"
fi

```

Also see: [VIP/Shell 301 – Lesson 5](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)

___

### VIII. Multiple Tests

#### Operators:

##### `&&` = "and"

##### `||` = "or"

##### `;` = "end of line"

#### Order of Logic: `&&` ... `||` ... `;`

```sh
if [ Test_is_true ] && [ Test_this ]... ;fi

if [ Test_is_false ] || [ Test_this THIS ]... ;fi
```

**...but it does not need to be in a test...**

```sh
Command Success && Run_this_Command_also...

Command Failure || Run_this_Command_also...
```

**`&&` And test**
```sh
if [ Test_one ] && [ Test_two ]; then
  # This will happen if both tests return "true".
fi
```

**`||` Or test**
```sh
if [ Test_one ] || [ Test_two ]; then
  # This will happen if either or both tests return "true".
fi
```

**`&&` And with `||` Or test**
```sh
if [ Test_one_A ] && [ Test_one_B ] || [ Test_two_A ] && [ Test_two_B ]; then
  # This will happen either:
  # 1. if both Test_one_? tests return "true" or
  # 2. if both Test_two_? tests return "true".
fi
```

*This can work with more than two tests.*

**Three `&&` And tests**
```sh
if [ Test_one ] && [ Test_two ] && [ Test_three ]; then
  # This will happen if all three tests return "true".
fi
```

**Three `||` Or tests**
```sh
if [ Test_one ] || [ Test_two ] || [ Test_three ]; then
  # This will happen if any one or all tests return "true".
fi
```

Also see: [VIP/Shell 301 – Lesson 7](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-07.md)

___

### Welcome to BASH
#### `#!/bin/bash`
#### BASH vs Shell

BASH and Shell do some `if`/`for`/`while`/`until` tests differently

##### Quoting tested variables

Shell: `$1` – Variables in tests **may** use quotes, but **do not** need to
```sh
#!/bin/sh
if [ -d $1 ] || [ -f $1 ] || [ -e $1 ] || [ -n $1 ] || [ -z $1 ] || [ $1 = $2 ] || [ $1 = sometext ]
then; echo yes; fi
# NOT...
if [ ! -d $1 ] || [ ! -f $1 ] || [ ! -e $1 ] || [ ! -n $1 ] || [ ! -z $1 ] || [ $1 != $2 ] || [ $1 != sometext ]
then; echo yes; fi
```

BASH: `"$1"` – Variables in tests **must always** use quotes.
```bash
#!/bin/bash
if [ -d "$1" ] || [ -f "$1" ] || [ -e "$1" ] || [ -n "$1" ] || [ -z "$1" ] || [ "$1" = "$2" ] || [ "$1" = "sometext" ]
then; echo yes; fi
# NOT...
if [ ! -d "$1" ] || [ ! -f "$1" ] || [ ! -e "$1" ] || [ ! -n "$1" ] || [ ! -z "$1" ] || [ "$1" != "$2" ] || [ "$1" != "sometext" ]
then; echo yes; fi
```

##### Comparison

```bash
# Shell | BASH
  -eq     ==    # is equal to
  -ne     !=    # is not equal to
  -gt     >     # is greater than
  -lt     <     # is less than
  -ge     >=    # is greater than or equal to
  -le     <=    # is less than or equal to
```

Shell: `if [ $Num1 -eq $Num2 ]` – Variables **may** use quotes, but do **not need** to

```sh
#!/bin/sh
if [ $Num1 -eq $Num2 ]
if [ $Num1 -ne $Num2 ]
if [ $Num1 -gt $Num2 ]
if [ $Num1 -lt $Num2 ]
if [ $Num1 -ge $Num2 ]
if [ $Num1 -le $Num2 ]
```

BASH: `if [ "$Num1" -eq "$Num2" ]` – Variables **must always** use quotes

BASH: `if (( "$Num1" == "$Num2" ))` – Symbol operators require double `((`parentheses`))`

```bash
#!/bin/bash
if [ "$Num1" -eq "$Num2" ]
if [ "$Num1" -ne "$Num2" ]
if [ "$Num1" -gt "$Num2" ]
if [ "$Num1" -lt "$Num2" ]
if [ "$Num1" -ge "$Num2" ]
if [ "$Num1" -le "$Num2" ]

if (( "$Num1" == "$Num2" ))
if (( "$Num1" != "$Num2" ))
if (( "$Num1" > "$Num2" ))
if (( "$Num1" < "$Num2" ))
if (( "$Num1" >= "$Num2" ))
if (( "$Num1" <= "$Num2" ))
```

Also see: [VIP/Shell 301 – Lesson 9](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-09.md)

___

### IX. `getopts`
- `getopts` is processed via: `while` [`getopts...`] `do` `case`
- Each `case` can execute the script
- `getopts` only allows single-letter flags, like: `-a` `-b` `-c` and together `-abc`

#### Format: `getopts Options_String Variable_Name [Arguments]`

#### Options_String (not a variable name): The allowed flags
- Each letter is a new flag, no separators necessary
- `:` first means that missing bad arguments won't error messages
- `a:` means the `-a` flag requires & allows an argument set as `$OPTARG` in the `while getopts` loop

#### Variable_Name (not a variable name): The flag actually used
- This variable is used in the `case` that follows

```bash
while getopts "ab" Flag; do
 case $Flag in

  a)
   Do_Something_Else_Because_of_flag -a
  ;;

  b)
   Do_Something_Else_Because_of_flag -b
  ;;

 esac
done
```

The variable `$Flag` became either "a" or "b"

#### [Arguments] (not a variable name, optional): Normal humans don't use this!
- The default value is "`$@`", which is exactly what is entered in the terminal
- Anything here will override what is entered in the terminal
- This is a way to make the script automatically run a specific `case` argument

Running `./myscript`

with:

```bash
while getopts "a:b" FlagVar -a iLoveGrapes; do
```

...will have the same effect as

running `./myscript -a iLoveGrapes`

with:

```bash
while getopts "a:b" FlagVar; do
```

#### `$OPTARG`
- `$OPTARG` is the argument applied to a flag with `:`
```bash
./myscript -f MyBig-Option
```
In this, `-f` is the flag and "MyBig-Option" is `$OPTARG`

#### `$OPTIND`
- `$OPTIND` will be the index number of the "next argument" to be processed. It can be confusing, but remember...
- If there are no arguments, `$OPTIND` will be empty
- After `getopts` finishes, `$OPTIND` will be set to "?", which may or may not be a problem later on

#### `$OPTERR`
- The value is either `1` or `0` (`true` or `false`)
- The default is `1` (`true`)
- If `1` (`true`), BASH will display errors from `getopts`

```bash
while getopts ":a:b" Flag; do
 case $Flag in

  a)
   echo "Work with $OPTARG using flag -$Flag"
  ;;

  b)
   echo "Work with $OPTARG using flag -$Flag"
  ;;

# Everything else
  *)
   echo "Dude, get right."
   exit 1
  ;;

 esac
done

#Clear $OPTIND from this getopts() function, just in case it is used later in this script
shift "$((OPTIND-1))"
```

This can take arguments:
- `./myscript -a A-option -b`
- `./myscript -a A-option`
- `./myscript -b`
...Anything else will echo "Dude, get right."

Also see: [VIP/Shell 301 – Lesson 12](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)

___

### X. `getopt`

- `getopt` is processed via: `while [[ $# > 0 ]]; do` `case`
- Each `case` sets a variable to `true`, then the script should run later in an `if` test for those variables
- `getopt` allows single-letter flags, And "long" option alternatives like: `--alpha` `--bravo` in place of `-a` `-b` and together `-ab`
- `getopt` is not as user-friendly for programmers and requires many things done manually
- The main lesson in using `getopt` is: Don't, to use `getopts` instead!

#### `shift`
- `shift` tells BASH to process different arguments entered in the terminal
- `shift 1` moves to process the next argument
- `shift 2` moves two arguments over
- If you don't use `shift` with `getopt`, the `case` loop will continue processing the same argument again and again

```bash
myOptions=`getopt -o a:b -l alpha:,beetle,charlie,delta,ecko,help -n "$(basename "$0")" -- "$@"`
#Alternative way to do the same thing:
myOptions=$(getopt --options a:b --longoptions :alpha:,bravo --name "$(basename "$0")" -- "$@")

# Make sure it's working
eval set --"$myOptions"

# Fix OPTIND
OPTIND=1

# Set the variables to false
alpha=false
bravo=false

while [[ $# > 0 ]]; do
 case $1 in

  -a | --alpha )
   alpha=true
   alphaOPTION="$2"
# shift 2 moves 2 variables over since one variable is the setting for option -a
   shift 2
   ;;

  -b | --bravo )
   bravo=true
# shift 1 only moves 1 variable over since these options don't have settings
   shift 1
   ;;

# Finally break the loop (this will run 'break' no matter what)
  *)
   break
  ;;

 esac
done

#Clear $OPTIND from this getopt() function, just in case it is used later in this script
shift "$((OPTIND-1))"

# Normal options
if [ $alpha = true ]; then
   echo "Work option A with $alphaOPTION"
fi

if [ $beetle = true ]; then
   echo "Work option B"
fi

```

This can take arguments:
- `./myscript -a A-option -b`
- `./myscript --alpha A-option -b`
- `./myscript --alpha A-option --bravo`
- `./myscript -a A-option --bravo`
- `./myscript -a A-option`
- `./myscript --alpha A-option`
- `./myscript -b`
- `./myscript --bravo`

Also see: [VIP/Shell 301 – Lesson 12](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)

___

### XI. Ternary Statements `?:`

This is *not* used in BASH or Shell, but it is used in many other languages, including C, PHP, and JavaScript:

**Ternary Statement:**

```js
Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';

# example:

Variable = ( $Some_Variable == 5 ) ? 'it is five' : 'not five';

```

**Shell one-line equivalent:**

```sh
Variable=$([ THIS IS THE TEST ] && echo 'value_if_true' || echo 'value_if_false')

# example:

Variable=$([ "$Some_Variable" == "5" ] && echo 'it is five' || echo 'not five')

```

**Shell `if` test equivalent:**

```sh

if [ THIS IS THE TEST ]; then
  Variable='value_if_true'
else
  Variable='value_if_false'
fi

# example:

if [ "$Some_Variable" == "5" ]; then
  Variable='it is five'
else
  Variable='not five'
fi

```
