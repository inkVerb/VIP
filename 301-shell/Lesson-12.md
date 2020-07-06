# Shell 301
## Lesson 12: BASH getopts & getopt

Ready the CLI

`cd ~/School/VIP/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `getopts`

```bash
while getopts "f:l:a:g:s" Var
do
  case $Var in
    f)
      ...
    ;;
  esac
done
```

#### Note: `$OPTARG` & `$OPTIND` are native variables for `getopts`

#### A. Each flag gets one argument (but not help)

| **1** :$ `gedit 12-flags-1`

*Note the line with `while getopts`*

- `:` first means that non-listed flags can won't cause error messages
  - This allows for `*` and `?` to be used in `case` arguments
- `a:` means the `-a` flag requires an argument
  - The argument will be set as `$OPTARG` in the `while getopts` loop
  - This is a "flag argument" AKA "option argument", as opposed to a `$1` style argument
- `a` not followed by `:` would mean that the `-a` flag ignores arguments

| **2** :$ `./12-flags-1 -h` (help)

| **3** :$ `./12-flags-1 -j` (fail: not a valid flag)

| **4** :$ `./12-flags-1 -a` (fail: flags require arguments)

| **5** :$ `./12-flags-1 -a Alpha`

*Note not all flags are required*

| **6** :$ `./12-flags-1 -a Alpha -b Beta -c Charlie -d Dogma`

*Note all flags may be used*

| **7** :$ `./12-flags-1 -a Alpha -b Beta -c C Charlie -d Dogma`

*Note two arguments broke it after `-c C`*

| **8** :$ `./12-flags-1 -a Alpha -b Beta -c "C Charlie" -d Dogma`

| **9** :$ `./12-flags-1 -b Beta -a Alpha -d Dogma -c Charlie `

*Note it keeps your order*

| **10** :$ `./12-flags-1 -b`

*...`-b` requires an argument because it is `b:` in the `while getopts` line*

#### B. No arguments allowed

| **11** :$ `gedit 12-flags-2`

| **12** :$ `./12-flags-2 -b`

*...`-b` does NOT require an argument because `b` is not followed by `:` in the `while getopts` line*

| **13** :$ `./12-flags-2 -d Dunno`

*...The `$OPTARG` variable doesn't recognize the argument because there was no `:` for flag `-d` in the `while getopts` line*

#### C. Global argument only

This nifty code allows for a global argument (use with, not part of, `getopts`):

*Note `eval` "concatenates" many things to produce a single command*

- *We won't explore `eval` any deeper in this course*

*About our `exit` codes:*

- *We use `exit 1` for "proper false" (STDOUT) when the user asks for help*
  - *This can be tested later, such as with `$?` to see if it was a valid command*
- *We use `exit 2` for "error" (STDERR) when user inputs wrong flags*
  - *This can be tested later, such as with `$?` or with `set -e` to exit with any error*
- *The script will automatically use `exit 0` once our `getopts` loop ends with proper flags*

```bash
# Create $globalArg
eval "globalArg=\${${OPTIND}}"
# If no argument input
if [ -z "${globalArg}" ]; then
 echo "You didn't set any options!"
 echo " How to use:
 $0 -a|b|c|d <option>
 $0 -h ...will show this message."
 exit 2
fi

OPTIND=1 # Reset $OPTIND

## case loop here ##

shift "$((OPTIND-1))" # Get $OPTIND out of the way just in case
```

And, put this before the main flag `case` loop to handle help and display false flags:

```bash
while getopts ":abcdh" Flg; do
 case $Flg in
## Do nothing for valid flags
  abcd)
   :
  ;;

## Error for invalid flags
  \?)
   echo "You used an invalid flag: -${OPTARG}" >&2
   echo " How to use:
 $0 -a|b|c|d <option>
 $0 -h ...will show this message."
   exit 2
  ;;

## Help
  h)
   echo "You asked for help!"
   echo " How to use:
 $0 -a|b|c|d <option>
 $0 -h ...will show this message."
   exit 1
  ;;
 esac
done
```

| **14** :$ `gedit 12-flags-3`

| **15** :$ `./12-flags-3 -ad Dunno`

*...Flags `-a` and `-d` take the same argument*

| **16** :$ `./12-flags-3 -abcd Dunno Dubbo`

*...Note no "Dubbo", only one argument allowed this way*

| **17** :$ `./12-flags-3 -a Dunno -bcd Dubbo`

*...No flags allowed after the only argument*

#### D. Both global and flag arguments

| **18** :$ `gedit 12-flags-4`

| **19** :$ `./12-flags-4 -a Alpha -bcd Bogma`

*...Note "Bogma" came from our `$globalArg` cluster, not from `getopts`*

| **20** :$ `./12-flags-4 -a Alpha -e Emancipation -bcd Bogma`

| **21** :$ `./12-flags-4 -e "Emancipation" -bcd Bogma -a Alpha`

*Note anything after the -bcd options is ignored because they accept a global argument, be aware when combining specific options and global options*

#### E. Use a function for help

Create a function to call the help message, rather than repeating it in both the `case` for `-h` and wildcard

```bash
# Create a help message function
function how_to_use()
{
 echo " How to use:
 $0 -a <option> -b <option>
 $0 -h ...will show this message."
}

# Use the function
how_to_use
```

| **22** :$ `gedit 12-flags-5`

| **23** :$ `./12-flags-5 -h`

### II. `getopt`

```bash
getopt -o f:l:a:g:s -l flag:,lag:,ages:,sag -n "$(basename "$0")" -- "$@"
...and much much more...
```

#### Note:
##### `getops` only accepts one-letter options
##### `getopt` is for `--long` options and requires more variables and checks

*First, see what `basename` does...*

| **24** :$ `basename /path/to/here`

| **25** :$ `basename /path/to/here.file`

| **26** :$ `basename /path/to/here.file .file`

| **27** :$ `basename -a /path/one /path/two`

*Many tools like `basename` help `getopt` to work...*

| **28** :$ `gedit 12-long`

*Note `--long` alternative options are included*

*Note the global option was removed since `getopt` checks requirements by itself*

| **29** :$ `./12-long -a Alpha -bce`

| **30** :$ `./12-long --alpha Alpha --ecko --delta --beetle --charlie `

*Note the order no longer affects the output since everything is done by `if` statements in order, at the end of the script*

| **31** :$ `./12-long --alpha Alpha -bcd --ecko`

| **32** :$ `./12-long -a Alpha --beetle --delta -e --charlie`

*Note both short and long are accepted*

| **33** :$ `./12-long -k` (invalid option)

| **34** :$ `./12-long` (no options)

| **35** :$ `./12-long --help`

___

# The Take

## `getopts` & `getopt` (similar, yet worlds apart)
- Both receive, check, and process flags and related arguments for a BASH script
- Both require `while` and `case` loops
- `getopts` only allows one-letter flags and is relatively simple
- `getopt` allows one-letter flags or long-word flags and is much more complicated
- `eval` "concatenates" many parts to produce and execute a single command
  - `eval` may be used in more complex `getopts` & `getopt` scripts
  - We do not explore `eval` deeper in this course

## `getopts` (for one-letter flags)
- Procedure of a `getopts` flag set:
  - `while getopts` defines the allowed flags
  - `do` opens a case loop
  - `case` defines the flag variable to be matched
  - `in` opens the case index of possible flag matches
  - `f)` what to do if this flag was argued (as many as needed)
  - `esac` closes the case index
  - `done` closes the getopt loop
- See usage and examples here: [Tests: getopts](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#ix-getopts)

## *Explaining `getopt` in detail is beyond the scope of this survey lesson*

## `getopt` (for one-letter OR long-word flags)
- Procedure of a `getopt` flag set:
  - `optionsVariable=$(getopt ...)` defines the allowed flags (optionsVariable can be any variable)
  - `eval set --"$optionsVariable"` checks that the variables will work
  - `OPTIND=1` resets one of the `getopt` native variables
  - `flagoption=false` resets the flag to `false` (as many as needed)
  - `while [[ $# > 0 ]]` tests whether accepted flags have been argued
  - `do` opens a case loop
  - `case $1 in` defines whatever flag getopt will process
  - `-f | --flagoption )` what to do if this flag was argued (as many as needed)
  - `*)` sets the final case for what's next: break
  - `break` ends the loop
  - `esac` closes the case index
  - `done` closes the getopt loop
  - `shift "$((OPTIND-1))"` resets the same `getopt` native variables as before (good housekeeping)
- See usage and examples here: [Tests: getopt](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#x-getopt)

___

# Done! Have a cookie: ### #

Wait, what are these?

| **D1** :$ `sudo apt install bastet moon-buggy ninvaders nsnake pacman4console`

(Make sure the terminal is big enough!)

| **D2** :$ `bastet`

| **D3** :$ `moon-buggy`

| **D4** :$ `ninvaders`

| **D5** :$ `nsnake`

| **D6** :$ `pacman4console`

___

## Next: [Shell 401: Onward](https://github.com/inkVerb/VIP/blob/master/401-shell/README.md)
