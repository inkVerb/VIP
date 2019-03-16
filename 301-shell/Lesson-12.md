# Shell 301
## Lesson 12: BASH getopts & getopt

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `getopts`

#### Note: `$OPTARG` & `$OPTIND` are native variables for `getopts`

| **1** : `gedit 12-flags-1`

*Note on line 12* `$OPTIND`


*Note on line 20* `:`


| **2** : `./12-flags-1 -h` (help)

| **3** : `./12-flags-1 -j` (not a valid flag)

| **4** : `./12-flags-1 -a Alpha -b Beta -c Charlie -d Dogma`

| **5** : `./12-flags-1 -a Alpha -b Beta -c C Charlie -d Dogma`

| **6** : `./12-flags-1 -a Alpha -b Beta -c "C Charlie" -d Dogma`

| **7** : `./12-flags-1  -b Beta -a Alpha -d "Do Dogma" -c "C Charlie" `

| **8** : `gedit 12-flags-2`

| **9** : `./12-flags-2 -h`

| **10** : `./12-flags-2 -ad Dunno`

| **11** : `./12-flags-2 -cadb Dunno`

| **12** : `./12-flags-2 -abcd Dunno Dumbo`

| **13** : `./12-flags-2 -abcd "Dunno Dumbo"`

| **14** : `./12-flags-2 -abcd 'Dunno Dumbo'`

| **15** : `./12-flags-2 -b`

| **16** : `./12-flags-2 -r`

| **17** : `./12-flags-2 -h`

| **18** : `gedit 12-flags-3`

| **19** : `./12-flags-3 -a Alpha -bcd Bogma`

| **20** : `./12-flags-3 -a Alpha -e "Emancipation" -bcd Bogma`

| **21** : `./12-flags-3 -e "Emancipation" -bcd Bogma -a Alpha`

*Note anything after the -bcd options is ignored because they accept a global argument, be aware when combining specific options and global options*

| **22** : `./12-flags-3 -a`

| **23** : `./12-flags-3 -k`

| **24** : `./12-flags-3 -h`

### II. `getopt`

*Note* `getops` *only accepts one-letter options,* `getopt` *is for* `--long` *options and requires more variables and checks*

| **25** : `gedit 12-long`

*Note* `--long` *alternative options are included*

*Note the global option was removed since* `getopt` *checks requirements by itself*

| **26** : `./12-long -a Alpha -bce`

| **27** : `./12-long --alpha Alpha --ecko --delta --beetle --charlie `

*Note the order no longer affects the output since everything is done by* `if` *statements in order, at the end of the script*

| **28** : `./12-long --alpha Alpha -bcd --ecko`

| **29** : `./12-long -a Alpha --beetle --delta -e --charlie`

*Note both short and long are accepted*

| **30** : `./12-long -k` (invalid option)

| **31** : `./12-long` (no options)

| **32** : `./12-long --help`

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
  - `f)` what to do if this flag was argued (as many as needed)
  - `f)` what to do if this flag was argued (as many as needed)
  - `esac` closes the case index
  - `done` closes the getopt loop

- See usage and examples here: [Tests: getopts](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#ix-getopts)

## `getopt` (for one-letter OR long-word flags)
- Procedure of a `getopt` flag set:
  - `optionsVariable=$(getopt ...)` defines the allowed flags (optionsVariable can be any variable)
  - `eval set --"$optionsVariable"` checks that the variables will work
  - `OPTIND=1` resets one of the `getopt` native variables
  - `flagoption=false` resets the flag to `false` (as many as needed)
  - `flagoption=false` resets the flag to `false` (as many as needed)
  - `flagoption=false` resets the flag to `false` (as many as needed)
  - `while [[ $# > 0 ]]` tests whether accepted flags have been argued
  - `do` opens a case loop
  - `case $1 in` defines whatever flag getopt will process
  - `-f | --flagoption )` what to do if this flag was argued (as many as needed)
  - `-f | --flagoption )` what to do if this flag was argued (as many as needed)
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

| **33** : `sudo apt install bastet moon-buggy ninvaders nsnake pacman4console`

(Make sure the terminal is big enough!)

| **34** : `bastet`

| **35** : `moon-buggy`

| **36** : `ninvaders`

| **37** : `nsnake`

| **38** : `pacman4console`
