# Shell 301
## Lesson 12: BASH getopts & getopt

Ready the CLI

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `getopts`

#### Note: `$OPTARG` & `$OPTIND` are native variables for `getopts`

#### A. Each flag gets one argument (but not help)

| **1** : `gedit 12-flags-1`

*Note the line with `while getopts`*

- `:` first means that missing bad arguments won't error messages
- `a:` means the `-a` flag requires & allows an argument set as `$OPTARG` in the `while getopts` loop

| **2** : `./12-flags-1 -h` (help)

| **3** : `./12-flags-1 -j` (not a valid flag)

| **4** : `./12-flags-1 -a Alpha -b Beta -c Charlie -d Dogma`

| **5** : `./12-flags-1 -a Alpha -b Beta -c C Charlie -d Dogma`

*...Two arguments broke it after `-c C`*

| **6** : `./12-flags-1 -a Alpha -b Beta -c "C Charlie" -d Dogma`

| **7** : `./12-flags-1 -b Beta -a Alpha -d Dogma -c Charlie `

*...Keeps your order*

| **8** : `./12-flags-1 -b`

*...`-b` requires an argument because it is `b:` in the `while getopts` line*

#### B. No arguments allowed

| **9** : `gedit 12-flags-2`

| **10** : `./12-flags-2 -b`

*...`-b` does NOT require an argument because `b` is not followed by `:` in the `while getopts` line*

| **11** : `./12-flags-2 -d Dunno`

*...The `$OPTARG` variable doesn't recognize the argument because there was no `:` for flag `-d` in the `while getopts` line*

#### C. Global argument

This nifty code allows for a global argument (use with, not part of, `getopts`):

```bash
# Create $globalArg
eval "globalArg=\${${OPTIND}}"
# If no argument input
if [ -z "${globalArg}" ]; then
 echo "You didn't set any options!"
 echo " How to use:
 $0 -a|b|c|d <option>
 $0 -h ...will show this message."
 exit 1
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
   exit 1
  ;;

## Help
  h)
   echo "You asked for help!"
   echo " How to use:
 $0 -a|b|c|d <option>
 $0 -h ...will show this message."
   exit 0
  ;;
 esac
done
```

| **12** : `./12-flags-3 -ad Dunno`

*...Flags `-a` and `-d` take the same argument*

| **13** : `./12-flags-3 -abcd Dunno Dubbo`

*...Note no "Dubbo", only one argument allowed this way*

| **14** : `./12-flags-3 -a Dunno -bcd Dubbo`

*...No flags allowed after the only argument*

#### D. Global argument

| **15** : `gedit 12-flags-4`

| **16** : `./12-flags-4 -a Alpha -bcd Bogma`

*...Note "Bogma" came from our `$globalArg` cluster, not from `getopts`*

| **17** : `./12-flags-4 -a Alpha -e Emancipation -bcd Bogma`

| **18** : `./12-flags-4 -e "Emancipation" -bcd Bogma -a Alpha`

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

| **19** : `gedit 12-flags-5`

| **20** : `./12-flags-5 -h`

### II. `getopt`

*Note `getops` only accepts one-letter options, `getopt` is for `--long` options and requires more variables and checks*

| **21** : `gedit 12-long`

*Note `--long` alternative options are included*

*Note the global option was removed since `getopt` checks requirements by itself*

| **22** : `./12-long -a Alpha -bce`

| **23** : `./12-long --alpha Alpha --ecko --delta --beetle --charlie `

*Note the order no longer affects the output since everything is done by `if` statements in order, at the end of the script*

| **24** : `./12-long --alpha Alpha -bcd --ecko`

| **25** : `./12-long -a Alpha --beetle --delta -e --charlie`

*Note both short and long are accepted*

| **26** : `./12-long -k` (invalid option)

| **27** : `./12-long` (no options)

| **28** : `./12-long --help`

___

# The Take

## `getopts` & `getopt` (similar, yet worlds apart)
- Both receive, check, and process flags and related arguments for a BASH script
- Both require `while` and `case` loops
- `getopts` only allows one-letter flags and is relatively simple
- `getopt` allows one-letter flags or long-word flags and is much more complicated

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

| **D1** : `sudo apt install bastet moon-buggy ninvaders nsnake pacman4console`

(Make sure the terminal is big enough!)

| **D2** : `bastet`

| **D3** : `moon-buggy`

| **D4** : `ninvaders`

| **D5** : `nsnake`

| **D6** : `pacman4console`

___

## Next: [Shell 401: Onward](https://github.com/inkVerb/VIP/blob/master/401-shell/README.md)
