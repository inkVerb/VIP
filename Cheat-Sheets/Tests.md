# Tests

*Refer to this lesson for more about shells, errors, and debugging:* [VIP/Shell 401 – Lesson 9](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-09.md)
___

### I. Test: `true` & `false`

- `false` = `0`
- `true`  = `1`

When a test answers `true` or `1`, then shell does something via `then` or `do`

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

___

### III. `for` VARIABL `in` WUT

- A `for` test loops and does the same thing for each among many items

The `if` test is similar to the `for` looping test, but...
- `if` does NOT repeat, it only runs ONE TIME
- `if` --> `for`
- `then` --> `do`
- `fi` --> `done`

```sh
for VARIABL in *.txt

do

echo $VARIABL

done
```

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

___

### VI. Count with `while` & `until`

This is a classic example of a "counting" loop:

```sh
#!/bin/sh

MAX="$1" # Set a maxiumum when run from the command line as argument $1

COUNT=1

while [ "$COUNT" -le "$MAX" ]; do
echo "Line #$COUNT"
# Uncomment the line below to echo each new count into a file
#echo "Line #$COUNT" >> countfile
COUNT=$(expr $COUNT + 1)
done

```

- This works with Shell (`#!/bin/sh`) and does not require BASH (`#!/bin/bash`)
- Put the above script into a file, make it executable with `chmod ug+x` and run it to see how it works.
- Note the example includes an `echo ... >> FILE` use, but this counting variable can be used with many commands.
- This example uses `while`, but the counter can also work with `for` and `until` loops

Here is an example of the code re-written for `until`:

```sh
#!/bin/sh

MAX="$1" # Set a maxiumum when run from the command line as argument $1
MAXPLUSONE=$(expr $MAX + 1) # Set a variable above the maximum so the loop will run the $MAX value

COUNT=1

until [ "$COUNT" = "$MAXPLUSONE" ]; do
echo "Line #$COUNT"
# Uncomment the line below to echo each new count into a file
#echo "Line #$COUNT" >> countfile
COUNT=$(expr $COUNT + 1)
done

```

___

### VII. `case`... `esac`

- `case` is a simple multiple `if` test
- `a)` is the `case` argument for using the `-a` flag
- `case` arguments close with `;;`
- `*` is the "everything not listed" `case` argument, usually to recognize an error and display "help" instructions

```sh
case $VARIABL in

# If $VARIABL=a
  a)
   DO SOMETHING "A", maybe with $VARIABL
  ;;

# If $VARIABL=b
  b)
   DO SOMETHING "B", maybe with $VARIABL
  ;;

# If $VARIABL=wallawalla
  wallawalla)
   DO SOMETHING "Walla Walla", maybe with $VARIABL
  ;;

# If $VARIABL= anything else
  *)
   DO SOMETHING ELSE, maybe with $VARIABL
  ;;

esac
```

- `case` options can be separated with a pipe `|`

```sh
case $VARIABL in

# If $VARIABL=a
  a)
   DO SOMETHING "A", maybe with $VARIABL
  ;;

# If $VARIABL=b OR $VARIABL=c
  b|c)
   DO SOMETHING "B or C", maybe with $VARIABL
  ;;

esac
```

- `case` options can ignore case using brackets

```sh
case $VARIABL in

# If $VARIABL=a
  [aA] )
   DO SOMETHING "A", maybe with $VARIABL
  ;;

# If $VARIABL=b OR $VARIABL=c
  [bB] | [cC] )
   DO SOMETHING "B or C", maybe with $VARIABL
  ;;

# If $VARIABL=yes OR $VARIABL=y
  [yY] | [yY][eE][sS] )
   DO SOMETHING "yes", maybe with $VARIABL
  ;;

# If $VARIABL=no OR $VARIABL=n
  [nN] | [nN][oO] )
   DO SOMETHING "no", maybe with $VARIABL
  ;;

esac
```

- `case` can work with an "always true" loop using `while :`
- End this "always true" loop with `break`

```sh
while :

do

case $VARIABL in

# If $VARIABL=a
  a)
   DO SOMETHING "A", maybe with $VARIABL
  ;;

# If $VARIABL=stopit
  stopit)
   DO SOMETHING about stopping, maybe with $VARIABL
   break
  ;;

esac

done
```

- "Lazy case" (variable-if) method:

```sh
# First, the case index

case $VARIABL in

# If $VARIABL=a
  a)
   caseA=true
  ;;

# If $VARIABL=b
  b)
   caseB=true
  ;;

# If $VARIABL=wallawalla
  wallawalla)
   casewallawalla=true
  ;;

# If $VARIABL= anything else
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

### VIII. Multiple Tests

#### Operators:

##### `&&` = "and"

##### `||` = "or"

##### `;` = "end of line"

#### Order of Logic: `&&` ... `||` ... `;`

**`&&` AND test**
```sh
if [ TEST_ONE ] && [ TEST_TWO ]; then
  # This will happen if both tests return "true".
fi
```

**`||` OR test**
```sh
if [ TEST_ONE ] || [ TEST_TWO ]; then
  # This will happen if either or both tests return "true".
fi
```

**`&&` AND with `||` OR test**
```sh
if [ TEST_ONE_A ] && [ TEST_ONE_B ] || [ TEST_TWO_A ] && [ TEST_TWO_B ]; then
  # This will happen either:
  # 1. if both TEST_ONE_? tests return "true" or
  # 2. if both TEST_TWO_? tests return "true".
fi
```

*This can work with more than two tests.*

**Three `&&` AND tests**
```sh
if [ TEST_ONE ] && [ TEST_TWO ] && [ TEST_THREE ]; then
  # This will happen if all three tests return "true".
fi
```

**Three `||` OR tests**
```sh
if [ TEST_ONE ] || [ TEST_TWO ] || [ TEST_THREE ]; then
  # This will happen if any one or all tests return "true".
fi
```

___

### Welcome to BASH
#### `#!/bin/bash`
#### BASH vs Shell

BASH and Shell do some `if`/`for`/`while`/`until` tests differently.

##### Quoting tested variables

Shell: `$1` – Variables in tests **MAY** use quotes, but **DO NOT** need to.
```sh
#!/bin/sh
if [ -d $1 ] || [ -f $1 ] || [ -e $1 ] || [ -n $1 ] || [ -z $1 ] || [ $1 = $2 ] || [ $1 = sometext ]
then; echo yes; fi
# NOT...
if [ ! -d $1 ] || [ ! -f $1 ] || [ ! -e $1 ] || [ ! -n $1 ] || [ ! -z $1 ] || [ $1 != $2 ] || [ $1 != sometext ]
then; echo yes; fi
```

BASH: `"$1"` – Variables in tests **MUST ALWAYS** use quotes.
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

Shell: `if [ $NUM1 -eq $NUM2 ]` – Variables **MAY** use quotes, but do **NOT NEED** to.
```sh
#!/bin/sh
if [ $NUM1 -eq $NUM2 ]
if [ $NUM1 -ne $NUM2 ]
if [ $NUM1 -gt $NUM2 ]
if [ $NUM1 -lt $NUM2 ]
if [ $NUM1 -ge $NUM2 ]
if [ $NUM1 -le $NUM2 ]
```

BASH: `if [ "$NUM1" -eq "$NUM2" ]` – Variables **MUST ALWAYS** use quotes.

BASH: `if (( "$NUM1" == "$NUM2" ))` – Symbol operators require double `((`parentheses`))`.
```bash
#!/bin/bash
if [ "$NUM1" -eq "$NUM2" ]
if [ "$NUM1" -ne "$NUM2" ]
if [ "$NUM1" -gt "$NUM2" ]
if [ "$NUM1" -lt "$NUM2" ]
if [ "$NUM1" -ge "$NUM2" ]
if [ "$NUM1" -le "$NUM2" ]

if (( "$NUM1" == "$NUM2" ))
if (( "$NUM1" != "$NUM2" ))
if (( "$NUM1" > "$NUM2" ))
if (( "$NUM1" < "$NUM2" ))
if (( "$NUM1" >= "$NUM2" ))
if (( "$NUM1" <= "$NUM2" ))
```

___

### IX. `getopts`
- `getopts` is processed via: `while` [`getopts...`] `do` `case`
- Each `case` can execute the script
- `getopts` only allows single-letter flags, like: `-a` `-b` `-c` and together `-abc`

#### Format: `getopts OPTIONS-STRING VARIABLE-NAME [ARGUMENTS]`

#### OPTIONS-STRING (not a variable name): The allowed flags
- Each letter is a new flag, no separators necessary
- `:` first means that `?` will be assigned to any flag not listed, which can be used later in a `case` argument
- `:` after any letter means that the letter's flag will take an option set as `$OPTARG` in the `while getopts` loop

#### VARIABLE-NAME (not a variable name): The flag actually used
- This variable is used in the `case` that follows

```bash
while getopts "ab" Flag; do
 case $Flag in

  a)
   DO SOMETHING BECAUSE OF FLAG -a
  ;;

  b)
   DO SOMETHING BECAUSE OF FLAG -b
  ;;

 esac
done
```

The variable `$Flag` became either "a" or "b"

#### [ARGUMENTS] (not a variable name, optional): Normal humans don't use this!
- The default value is "`$@`", which is exactly what is entered in the terminal
- Anything here will override what is entered in the terminal
- This is a way to make the script automatically run a specific `case` argument

Running `./myscript`

with:

```bash
while getopts "a:b" FlagVAR -a iLoveGrapes; do
```

...will have the same effect as

running `./myscript -a iLoveGrapes`

with:

```bash
while getopts "a:b" FlagVAR; do
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

___

### X. `getopt`
- `getopt` is processed via: `while [[ $# > 0 ]]; do` `case`
- Each `case` sets a variable to `true`, then the script should run later in an `if` test for those variables
- `getopt` allows single-letter flags, AND "long" option alternatives like: `--alpha` `--bravo` in place of `-a` `-b` and together `-ab`
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
