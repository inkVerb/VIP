# Shell 101
## Lesson 5: Combine & Pipe Commands into Variables

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit applefoo`

| **2** : `cat applefoo`

| **3** : `sed -i "s/bar/foo/" applefoo`

*gedit: Reload applefoo*

| **4** : `cat applefoo`

| **5** : `sed "s/foo/bar/" applefoo`

| **6** : `ls`

| **7** : `sed -e "s/foo/bar/g" applefoo > newapplefoo`

| **8** : `ls`

| **9** : `cat newapplefoo`

| **10** : `rm newapplefoo`

| **11** : `ls`

| **12** : `cat applefoo`

| **13** : `sed "s/foo/bar/" applefoo`

*Now we see what* `cat` *and* `sed` *do, "pipe" the output of* `cat` *into* `sed`

| **14** : `cat applefoo | sed "s/foo/bar/"`

| **15** : `echo $(cat applefoo | sed "s/foo/bar/")`

| **16** : `` echo `cat applefoo | sed "s/foo/bar/"` ``

| **17** : `echo $DESKTOP_SESSION`

| **18** : `printenv DESKTOP_SESSION`

| **19** : `dpkg --print-architecture`

*You can set output of any terminal command as if it is a variable using:* `$(...)` or `` `...` ``

| **20** : `echo $(printenv DESKTOP_SESSION)`

| **21** : `` echo `printenv DESKTOP_SESSION` ``

| **22** : `echo $(dpkg --print-architecture)`

| **23** : `` echo `dpkg --print-architecture` ``

| **24** : `gedit comboshell`

*Create comboshell as this:* [comboshell-01](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-01)

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
- The output of a command can be treated as an argument if wrapped in one of two ways:
  - $ and parentheses: `$(command)`
  - backticks: ``` `command` ```
  - Both of these are called "**command substitution**"
- Command substitution can set the value of a variable in a Shell script
- The word "command" in this: `echo $(command)` is not an actual command, but represents any command you may use

___

#### [Lesson 6: tee](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-06.md)
