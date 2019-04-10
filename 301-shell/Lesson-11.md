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

*Note functions work with* `#!/bin/sh` *on the first line, but also work with* `#!/bin/bash`

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

*Using a variable to declare the options makes the code easier to read*

| **10** : `gedit 11-menu-if-var`

| **11** : `./11-menu-if-var`

*(3 to quit)*

*Do the same thing with a* `case` *loop*

| **12** : `gedit 11-menu-case`

| **13** : `./11-menu-case`

*It works the same way*

*You can* `echo` *your answer in advance*

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

*Menu with multiple options...*

*Run this in the terminal and output to size.file...*

| **37** : `dialog --menu "Choose a Size:" 11 23 4 1 X-Large 2 Large 3 Medium 4 Small 2> size.file`

| **38** : `ls *.file`

| **39** : `gedit size.file`

*This also works in a script...*

| **40** : `./11-dialog-3`

*gedit: Reload size.file*

*That method was simple, but having a follow-up dialog is more complex...*

| **41** : `gedit 11-dialog-4`

*gedit: Reload size.file*

*This needs this exit code redirect on the end:* `3>&1 1>&2 2>&3 3>&-`

| **42** : `./11-dialog-4` (select any size)

*gedit: Reload size.file*

| **43** : `./11-dialog-4` (select any size)

*gedit: Reload size.file*

*Do the same thing with* `if` *tests*

| **44** : `gedit 11-dialog-5`

| **45** : `./11-dialog-5` (select any size)

*gedit: Reload size.file*

*Lots more to learn, easily*

| **46** : `dialog man`

___

# The Take

## Functions
- Functions work in Boure shell (`#!/bin/sh`) and BASH (`#!/bin/bash`)
- A "function" is like a small script inside the script
- A BASH function uses parentheses as `function()` when the function is defined
- A BASH function does not use parentheses when called, only the name, such as `function`
- A BASH function uses variables and arguments
- BASH function variables can be set as:
  - `global` *(default)*
  - `local`
- BASH function variable syntax:
  - `global variable="value"` *(optional)*
  - `local variable="value"`

## `select`
- `select` only works in BASH
- `select` creates a simple text input menu for terminal dialog
- Syntax: `select inputVariable in option1 option2 options3`
- Procedure of a `select` dialog:
  - `select` sets the variable assigned to human user input and the options allowed
  - `do` opens a dialog loop
  - `case`/`if` ...either may be used
  - test contents as appropriate for `case`/`if`
  - `esac`/`fi` ...close either appropriately
  - `done` closes the dialog loop
- The options may be placed in a variable, then called later, like this:
```bash
options="option1 'option 2' Three"
select inputVariable in $options
```

## `dialog`
- `dialog` can work in Shell and BASH, but must be installed via `sudo apt install dialog`
- Syntax: `dialog OPTIONS`
- Basic syntax: `dialog --title "Title Here" --msgbox "Longer message here..." HEIGHT WIDTH`
- Common flags:
  - `--title` (one argument)
  - `--msgbox` (one argument)
  - `--yesno` *(no arguments)*
  - `--menu "Heading" HEIGHT WIDTH NUM-OF-OPTIONS 1 OPT1 2 OPT2 TAIL-COMMANDS`
- `--menu` is a complex flag, but necessary for multiple choice
  - Basic example:
    -`dialog --menu "Choose an option:" 11 23 3 1 "Option 1" 2 Two 3 Third 2> output-file`
  - In a script, the tail command can directly output to a file via `2> output-file`
    - This returns no follow-up dialog
  - For a dialog response, send output to a `case` loop:
    1. Put the entire `dialog` command inside a `$(command substitution)`
    2. Output is determined in the cases or after, `dialog ... 2> output-file` won't work!
    3. The "tail commands" must be: `3>&1 1>&2 2>&3 3>&-`
- Consult the manual for more `dialog man`
___

#### [Lesson 12: BASH getopts & getopt](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)
