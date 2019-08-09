# Shell 101
## Lesson 5: Combine & Pipe Commands into Variables

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit applefoo`

| **2** : `cat applefoo`

*Note what `cat` does...*

| **3** : `cat abcsed`

| **4** : `gedit abcsed`

| **5** : `gedit abcsed.setting`

| **6** : `cat abcsed.setting`

| **7** : `gedit abcd`

| **8** : `cat abcd`

*Note what `sed` does...*

| **9** : `sed -i "s/bar/foo/" applefoo`

*gedit: Reload applefoo*

*Now, use `sed` without the `-i` ...*
  - *It won't change the file*
  - *It outputs to the terminal*

| **10** : `sed "s/foo/bar/" applefoo`

| **11** : `ls`

*Now, use `sed` with `-e` and see what happens...*

| **12** : `sed -e "s/foo/bar/g" applefoo > newapplefoo`

| **13** : `ls`

| **14** : `cat newapplefoo`

*Review what `sed` and `cat` do with the next two commands...*

- *Output `sed` search-replace results: (without `-i` or `-e` flags)*

| **15** : `sed "s/foo/bar/" applefoo`

- *Output file contents:*

| **16** : `cat applefoo`

*Next "pipe" `|` the output of `cat` into `sed`...*

| **17** : `cat applefoo | sed "s/foo/bar/"`

*Put those commands into a kind of variable value; this is called "Command Substitution": `$(command substitution)`*

| **18** : `echo $(cat applefoo | sed "s/foo/bar/")`

*Now `echo` it to a file...*

| **19** : `echo $(cat applefoo | sed "s/foo/bar/") > echocatsed_applefoo`

| **20** : `gedit echocatsed_applefoo`

| **21** : `cat echocatsed_applefoo`

*"Command Substitution" can also be done with backticks: `` `command substitution` `` (considered lazy, though)*

| **22** : `` echo `cat applefoo | sed "s/foo/bar/"` ``

*Remember some of these...*

| **23** : `echo $DESKTOP_SESSION`

| **24** : `printenv DESKTOP_SESSION`

*You can set output of any terminal command as if it is a variable using: `$(...)` or `` `...` ``*

| **25** : `echo $(printenv DESKTOP_SESSION)`

| **26** : `` echo `printenv DESKTOP_SESSION` ``

*This is useful...*

| **27** : `dpkg --print-architecture`

| **28** : `echo $(dpkg --print-architecture)`

| **29** : `echo $(dpkg --print-architecture) > print-architecture_chodpkg`

| **30** : `gedit print-architecture_chodpkg`

| **31** : `gedit comboshell`

*Create comboshell as this:*
```sh
#!/bin/sh

myOutput="$(cat $1 | sed "s/$2/$3/g")"

echo "$myOutput"

# v01
```

| **32** : `chmod ug+x comboshell`

*Watch Command Substitution work...*

| **33** : `./comboshell applefoo foo bar`

*Review the contents of abcd...*

| **34** : `cat abcd`

*Watch Command Substitution work...*

| **35** : `./comboshell abcd jjjjjjjjj "Apple likes to say abcdefghi and "`

| **36** : `./comboshell abcd j " zz"`

___

# The Take

- "Raw output" is basic text STDOUT output (AKA output in the terminal)
- `cat` will dump a file as raw output
- `sed` without `-i` will dump the results as raw output, rather than changing the file
- `sed -e` designates a new file as the destination for the output
- The output of one command can be sent as input to the next command using a "pipe": `|`
  - Syntax: `command one | command two`
- The output of a command can be treated as an argument or value if wrapped in one of two ways:
  - $ and parentheses: `$(command substitution)`
  - backticks: `` `command substitution` ``
  - Both of these are called "**Command Substitution**"
- Command Substitution can set the value of a variable in a Shell script
  - Example: `thisVariable=$(cat somefile)`
- "Quotes" work cleanly with Command Substitution
  - Example **in a script**:
```shell
variable="$(echo "something here")"
```
  - ...these "quotes" will not be confused as starting and beginning inside `$(CS brackets)`
  - Using quotes like this is the "correct" way to use Command Substitution to set variables
- And, use it directly, like this:
  - `echo $(command substitution)` (echo outputs to terminal)
  - `echo $(command substitution) > filename` (echo output into a file)

___

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-06.md)
