# Shell 301
## Lesson 11: BASH select & dialog

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `select`

| **1** : `gedit 11-menu-if`

| **2** : `./11-menu-if`

*You must use numbers to make your selection*

*(Try different things, 3 to quit)*

*Using a variable to declare the options makes the code easier to read*

| **3** : `gedit 11-menu-if-var`

| **4** : `./11-menu-if-var`

*(3 to quit)*

*Do the same thing with a `case` loop*

| **5** : `gedit 11-menu-case`

| **6** : `./11-menu-case`

*It works the same way*

*You can `echo` your answer in advance with a pipe `|`*

| **7** : `echo 2 | ./11-menu-case`

*Note that it broke using the piped input*

*Auto-answer works wtih most shell commands: `echo "y" | SHELL-COMMAND`*

### II. `dialog`

**`dialog` does not require BASH, but is a separate program that must be installed with `sudo apt install dialog`**

*5 = height; 18 = width*

| **8** : `dialog --title "Read This" --msgbox "Ink is a verb." 5 18`

*Use `\n` for a new line*

| **9** : `dialog --title "Read This" --msgbox "Ink\nis a\nverb." 12 9`

*Just the OK button is 10 wide, so 9 wide makes it ugly*

*Let's scroll wtih PgDn/PgUp*

| **10** : `dialog --title "Read This" --msgbox "Ink\nis a\nverb." 6 10`

*Show contents of a file*

| **11** : `gedit 11-dialog-text.txt`

| **12** : `dialog --textbox 11-dialog-text.txt 9 51` *(try arrow keys, see what happens)*

*Same thing, but title in the background*

| **13** : `dialog --backtitle "Julius Caesar, by William Shakespeare; Act 3, Scene 2, Marc Antony:" --textbox 11-dialog-text.txt 9 51`

*Show info, then wait 5 seconds*

| **14** : `dialog --title "Consider the Ramifications" --infobox "Ink actually is a noun and a verb.\nThink about it for five seconds." 4 38; sleep 5`

*Fill-in question*

| **15** : `dialog --inputbox "Enter a color" 7 21`

*Note your entry appeared in the middle of the box because it needs some place to go*

| **16** : `ls *.file`

*Send "2>" output to color.file*

| **17** : `dialog --inputbox "Enter a color" 7 21 2> color.file`

| **18** : `ls *.file`

| **19** : `gedit color.file`

*Yes/No question*

| **20** : `dialog --title "Quick Question" --yesno "Do you ink?" 5 17` *(answer yes)*

*Note your answer does nothing, so echo the last exit code, which is the variable `$?`*

| **21** : `echo $?` *"yes" = `0`*

*Change your answer this time*

| **22** : `dialog --title "Quick Question" --yesno "Do you ink?" 5 17` *(answer no)*

| **23** : `echo $?` *"no" = `1`*

*Note exit codes matter! We learned about them in [Lesson 6: exit & journalctl](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)*

*This belongs in a script to work properly*

| **24** : `gedit 11-dialog-1`

| **25** : `./11-dialog-1`

| **26** : `./11-dialog-1`

*Let's use a different `if` method and answer with more dialogs*

| **27** : `gedit 11-dialog-2`

| **28** : `./11-dialog-2`

| **29** : `./11-dialog-2`

*Menu with multiple options...*

*Run this in the terminal and output to size.file...*

| **30** : `dialog --menu "Choose a Size:" 11 23 4 1 X-Large 2 Large 3 Medium 4 Small 2> size.file`

| **31** : `ls *.file`

| **32** : `gedit size.file`

*Note numbers "11, 23, 4" are for "height, width, menu height", let's change the menu height...*

| **33** : `dialog --menu "Choose a Size:" 11 23 2 1 X-Large 2 Large 3 Medium 4 Small 2> size.file`

*This also works in a script...*

| **34** : `gedit 11-dialog-3`

*Note it is the same*

| **35** : `./11-dialog-3`

*gedit: Reload size.file*

*Cleanup...*

| **36** : `echo "Size List" > size.file`

*That method was simple, but building a follow-up dialog is more complex...*

| **37** : `gedit 11-dialog-4`

*This needs an exit code redirect on the end: `3>&1 1>&2 2>&3 3>&-`*

| **38** : `./11-dialog-4` *(select any size)*

*gedit: Reload size.file*

| **39** : `./11-dialog-4` *(select any size)*

*gedit: Reload size.file*

*Do the same thing with `if` tests*

| **40** : `gedit 11-dialog-5`

| **41** : `./11-dialog-5` *(select any size)*

*gedit: Reload size.file*

*Lots more to learn, easily*

| **42** : `dialog man` *(different from `man dialog`)*

___

# The Take

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
  - `--yesno` (no arguments)*
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
- `dialog` uses exit codes, which we learned in [Lesson 6: exit & journalctl](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)
- Consult the manual for more `dialog man`
___

#### [Lesson 12: BASH getopts & getopt](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)
