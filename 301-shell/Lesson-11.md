# Shell 301
## Lesson 11: BASH Functions, select & dialog

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `newFunction()`

A function is like a script inside a script.

It even takes $1 $2 etc arguments, then runs inside the script.

| **1** : `gedit 11-function`

*Note functions require* `#!/bin/bash` *on the first line, not* `#!/bin/sh`

| **2** : `./11-function`

| **3** : `gedit 11-function-breakdown`

*Note a few things before we continue...*
___
> Create the function:
>
> `functionName() {`
>
> Put your code between the curlies *starting on a new line*.
>
> `$1` and `$2` and all their friends work just the same within the function.
>
> Create a variable that only exists inside the function with this:
>
> `local` `myVariable=Saucy`
>
> Make sure you do something...
>
> `echo "VIP Linux tutorials are $myVariable!"`
>
> `}` And close the function
>
> Then, call the function with its name...
>
> `functionName`
___

*Let's get back to work...*

| **4** : `./11-function-breakdown`

*Let's get a little more involved with variables...*

| **5** : `gedit 11-function-variables`

*Note the three global variables and the two local-function variables*

| **6** : `./11-function-variables ONe TWo THRee`

| **7** : `./11-function-variables pine apple pen`

### II. `select`

| **8** : `gedit 11-menu-if`

| **9** : `./11-menu-if`

*You must use numbers to make your selection*

*(3 to quit)*

*Do the same thing with a* `case` *loop*

| **10** : `gedit 11-menu-case`

| **11** : `./11-menu-case`

*It works the same way*

*You can* `echo` *your answer in advance*

| **12** : `echo 2 | ./11-menu-case`

| **13** : `echo 1 | ./11-menu-case`

| **14** : `echo 3 | ./11-menu-case`

*Auto-answer works wtih most shell commands:* `echo "y" | SHELL-COMMAND`

### III. `dialog`

*5 = height; 18 = width*

| **15** : `dialog --title "Read This" --msgbox "Ink is a verb." 5 18`

*Use* `\n` *for a new line*

| **16** : `dialog --title "Read This" --msgbox "Ink\nis a\nverb." 12 9`

*Just the OK button is 10 wide, so 9 wide makes it ugly*

*Let's scroll wtih PgDn/PgUp*

| **17** : `dialog --title "Read This" --msgbox "Ink\nis a\nverb." 6 10`

*Show contents of a file*

| **18** : `gedit 11-dialog-text.txt`

| **19** : `dialog --textbox 11-dialog-text.txt 9 51` (try arrow keys, see what happens)

*Same thing, but title in the background*

| **20** : `dialog --backtitle "Julius Caesar, by William Shakespeare; Act 3, Scene 2, Marc Antony:" --textbox 11-dialog-text.txt 9 51`

*Show info, then wait 5 seconds*

| **21** : `dialog --title "Consider the Ramifications" --infobox "Ink actually is a noun and a verb.\nThink about it for five seconds." 4 38; sleep 5`

*Fill-in question*

| **22** : `dialog --inputbox "Enter a color" 7 21`

*Note your entry appeared in the middle of the box because it needs some place to go*

| **23** : `ls *.file`

*Send "2>" output to color.file*

| **24** : `dialog --inputbox "Enter a color" 7 21 2> color.file`

| **25** : `ls *.file`

| **26** : `gedit color.file`

*Yes/No question*

| **27** : `dialog --title "Quick Question" --yesno "Do you ink?" 5 17` (answer yes)

*Note your answer does nothing, so echo the last exit code, which is the variable* `$?`

| **28** : `echo $?`

*Change your answer this time*

| **29** : `dialog --title "Quick Question" --yesno "Do you ink?" 5 17` (answer no)

| **30** : `echo $?`

*This belongs in a script to work properly*

| **31** : `gedit 11-dialog-1`

| **32** : `./11-dialog-1`

| **33** : `./11-dialog-1`

*Let's use a different* `if` *method and answer with more dialogs*

| **34** : `gedit 11-dialog-2`

| **35** : `./11-dialog-2`

| **36** : `./11-dialog-2`

*Menu with multiple options*

| **37** : `gedit 11-dialog-3`

| **38** : `ls *.file`

*Run this in the terminal and output to size.file*

| **39** : `dialog --menu "Choose a Size:" 11 23 4 1 X-Large 2 Large 3 Medium 4 Small 2> size.file`

| **40** : `ls *.file`

| **41** : `gedit size.file`

| **42** : `rm size.file`

*This can work in a shell script, but it needs this exit code redirect on the end:* `3>&1 1>&2 2>&3 3>&-`

| **43** : `./11-dialog-3` (select any size)

*gedit: Reload size.file*

| **44** : `./11-dialog-3` (select any size)

*gedit: Reload size.file*

*Do the same thing with* `if` *tests*

| **45** : `gedit 11-dialog-4`

| **46** : `./11-dialog-4` (select any size)

*gedit: Reload size.file*

*Lots more to learn, easily*

| **47** : `dialog man`

#### [Lesson 12: BASH getopts & getopt](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)
