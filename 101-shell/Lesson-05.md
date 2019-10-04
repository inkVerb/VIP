# Shell 101
## Lesson 5: Variables from Pipe & Command Substitution

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

*Put those commands into a kind of variable value; this is called "Command Substitution": `$(Command Substitution)`*

| **18** : `echo $(cat applefoo | sed "s/foo/bar/")`

*Now `echo` it to a file...*

| **19** : `echo $(cat applefoo | sed "s/foo/bar/") > echocatsed_applefoo`

| **20** : `gedit echocatsed_applefoo`

| **21** : `cat echocatsed_applefoo`

*"Command Substitution" can also be done with backticks: `` `Command Substitution` `` (considered lazy, though)*

| **22** : `` echo `cat applefoo | sed "s/foo/bar/"` ``

*This is useful to get your CPU type...*

| **23** : `dpkg --print-architecture`

*`echo` it into a file...*

| **24** : `echo $(dpkg --print-architecture) > print-architecture_chodpkg`

| **25** : `gedit print-architecture_chodpkg`

*You can "substitute" any command for its output using: `$(...)` or `` `...` ``*

*Let's `kill` a desktop app using Command Substitution...*

| **26** : `gnome-mines &`

*Get the app's "process ID" (PID)...*

| **27** : `pgrep gnome-mines`

*Note the PID number and replace 55555 with that number below:*

| **28** : `kill 55555`

*Do it again, note the number changes...*

| **29** : `gnome-mines &`

| **30** : `pgrep gnome-mines`

| **31** : `kill 55555`

*Now, replace the PID number with `$(`what gets the number`)` (`$(pgrep gnome-mines)`)...*

| **32** : `gnome-mines &`

| **33** : `kill $(pgrep gnome-mines)`

*...Try it a few more times if you want, always the same, no changing numbers!*

| **34** : `gedit comboshell`

*Create comboshell as this:*
```sh
#!/bin/sh

myOutput="$(cat $1 | sed "s/$2/$3/g")"

echo "$myOutput"

# v01
```

| **35** : `chmod ug+x comboshell`

*Watch Command Substitution work...*

| **36** : `./comboshell applefoo foo bar`

*Review the contents of abcd...*

| **37** : `cat abcd`

*Watch Command Substitution work...*

| **38** : `./comboshell abcd jjjjjjjjj "Apple likes to say abcdefghi and "`

| **39** : `./comboshell abcd j " zz"`

___

# The Take

## Pipi `|`
- STDIN input is, more or less what you type into the terminal
- "Raw output" is basic text STDOUT output, more or less output in the terminal
- `cat` will dump a file's contents as raw output (STDOUT)
- `sed` *without `-i`* will dump the results as raw output, rather than changing the file
- `sed -e` "exports" the output to a different file with `> outputfile`
- Many commands use a file for their STDIN input "source"
  - The file `cat` uses is the STDIN input "source"
  - The file `sed` changes is the STDIN input "source"
- STDOUT (output) of one command can be sent as STDIN (input) "source" to the next command using a "pipe": `|`
  - Syntax: `command one | command two`

## `$(`Command Substitution`)`
- The output of a command can be treated as an argument or value if wrapped one of two ways:
  - $ and parentheses: `$(Command Substitution)`
  - backticks: `` `Command Substitution` ``
  - Both of these are called "**Command Substitution**"
- Command Substitution can set the value of a variable in a Shell script
  - Example: `thisVariable=$(cat somefile)`
- "Quotes" work cleanly inside Command Substitution
  - Example **in a script**:
```shell
variable="$(echo "something here")"
```
  - ...these "quotes" will not be confused as starting and beginning inside `$(CS wrapper)`
  - Using quotes like this is the "correct" way to use Command Substitution to set variables
- And, use it directly, like this:
  - `some-command $(Command Substitution)` (the Command Substitution can be an argument)
  - `some-command $(Command Substitution) > filename` (send STDOUT output into a file)

___

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-06.md)
