# Shell 101
## Lesson 5: Combine & Pipe Commands into Variables

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit applefoo`

| **2** : `cat applefoo`

| **3** : `sed -i "s/bar/foo/" applefoo`

*gedit: Reload applefoo*

*Now, use* `sed` *without the* `-i` *...*
  - *It won't change the file*
  - *It outputs to the terminal*

| **4** : `sed "s/foo/bar/" applefoo`

| **5** : `ls`

*Now, use* `sed` *with* `-e` *and see what happens...*

| **6** : `sed -e "s/foo/bar/g" applefoo > newapplefoo`

| **7** : `ls`

| **8** : `cat newapplefoo`

*Note what* `cat` *does...*

| **9** : `cat abcsed`

| **10** : `cat abcsed.setting`

| **11** : `cat abcd`

*Review with the next two commands...*

*Output file contents:*

| **12** : `cat applefoo`

*Output* `sed` *search-replace results:* (without `-i` or `-e` flags)

| **13** : `sed "s/foo/bar/" applefoo`

*Now we see what* `cat` *and* `sed` *do*

*Next "pipe"* `|` *the output of* `cat` *into* `sed`*...*

| **14** : `cat applefoo | sed "s/foo/bar/"`

*Put those commands into a kind of variable value; this is called "Command Substitution":* `$(command substitution)`

| **15** : `echo $(cat applefoo | sed "s/foo/bar/")`

*"Command Substitution" can also be done with backticks:* `` `command substitution` `` (considered lazy, though)

| **16** : `` echo `cat applefoo | sed "s/foo/bar/"` ``

*Remember some of these...*

| **17** : `echo $DESKTOP_SESSION`

| **18** : `printenv DESKTOP_SESSION`

*This is useful...*

| **19** : `dpkg --print-architecture`

*You can set output of any terminal command as if it is a variable using:* `$(...)` or `` `...` ``

| **20** : `echo $(printenv DESKTOP_SESSION)`

| **21** : `` echo `printenv DESKTOP_SESSION` ``

| **22** : `echo $(dpkg --print-architecture)`

| **23** : `` echo `dpkg --print-architecture` ``

| **24** : `gedit comboshell`

*Create comboshell as this:*
```sh
#!/bin/sh

myOutput=$(cat $1 | sed "s/$2/$3/g")

echo "$myOutput"

# v01
```

| **25** : `chmod ug+x comboshell`

| **26** : `./comboshell applefoo foo bar`

| **27** : `./comboshell abcd jjjjjjjjj "Apple likes to say abcdefghi and "`

| **28** : `./comboshell abcd j " zz"`

___

# The Take

- "Raw output" is basic text STDOUT output (AKA output in the terminal)
- `cat` will dump a file as raw output
- `sed` without `-i` will dump the results as raw output, rather than changing the file
- `sed -e` designates a new file as the destination for the output
- `rm` deletes a file
- The output of one command can be sent as input to the next command using a "pipe": `|`
  - Syntax: `command one | command two`
- The output of a command can be treated as an argument or value if wrapped in one of two ways:
  - $ and parentheses: `$(command substitution)`
  - backticks: `` `command substitution` ``
  - Both of these are called "**Command Substitution**"
- Command Substitution can set the value of a variable in a Shell script
  - Example: `thisVariable=$(cat somefile)`
- And, use it directly, like this:
  - `echo $(command substitution)` (echo outputs to terminal)
  - `echo $(command substitution) > filename` (echo output into a file)

___

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-06.md)
