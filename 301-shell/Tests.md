# Tests

### I. `true` & `false`

- `false` = `0`
- `true`  = `1`

When a test answers `true` or `1`, then shell does something via `then` or `do` 
___

### II. `while` `do` `done`

- A `while` test loops and is used to change something if needed
- A `while` test "loop" repeats the test, the script only continues when the test finally returns `false`
- `while :` will always return `true` and will repeat until `break` occurs in its loop or the user terminates the script

This is similar to the `if` test
- `while` works the same as an `if` test, but it repeats
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

### III. `if` `then` `fi`

- An `if` test runs once and does something only under certain circumstances
- Once the `if` test is finished, the script continues

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

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

- We can also use `else` to do something without any test, if the previous test returns `false`

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
- `else` can work with or without `elif`

```sh
if [ THIS IS THE TEST ]

then

# Something happens here if the test answers true

else

# Something happens here because the test failed

fi

```
___

### IV. `for` VARIABL `in` WUT

- A `for` test loops and does the same thing for each among many items

```sh
for VARIABL in *.txt

do

echo $VARIABL

done
```

### V. `case`... `esac`

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

___

### VI. `getopts`
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

## Everything else
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

### VII. `getopt`
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
### shift 2 moves 2 variables over since one variable is the setting for option -a
   shift 2
   ;;

  -b | --bravo )
   bravo=true
### shift 1 only moves 1 variable over since these options don't have settings
   shift 1
   ;;

## Finally break the loop (this will run 'break' no matter what)
  *)
   break
  ;;

 esac
done

#Clear $OPTIND from this getopt() function, just in case it is used later in this script
shift "$((OPTIND-1))"

## Normal options
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

