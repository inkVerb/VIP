# Shell 301
## Lesson 12: BASH select, getopts, getopt & SH dialog

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)
___

### I. `select`

`gedit 12-menu`

`./12-menu`

*You must use numbers to make your selection*

*(3 to quit)*

*You can* `echo` *your answer in advance*

`echo 2 | ./12-menu`

`echo 1 | ./12-menu`

`echo 3 | ./12-menu`

*Auto-answer works wtih most shell commands:* `echo "y" | SHELL-COMMAND`

### II. `getopts`

#### Note: `$OPTARG` & `$OPTIND` are native variables for `getopts`

`gedit 12-flags-1`

*Note on line 12* `$OPTIND`


*Note on line 20* `:`


`./12-flags-1 -h` (help)

`./12-flags-1 -j` (not a valid flag)

`./12-flags-1 -a Alpha -b Beta -c Charlie -d Dogma`

`./12-flags-1 -a Alpha -b Beta -c C Charlie -d Dogma`

`./12-flags-1 -a Alpha -b Beta -c "C Charlie" -d Dogma`

`./12-flags-1  -b Beta -a Alpha -d "Do Dogma" -c "C Charlie" `

`gedit 12-flags-2`

`./12-flags-2 -h`

`./12-flags-2 -ad Dunno`

`./12-flags-2 -cadb Dunno`

`./12-flags-2 -abcd Dunno Dumbo`

`./12-flags-2 -abcd "Dunno Dumbo"`

`./12-flags-2 -abcd 'Dunno Dumbo'`

`./12-flags-2 -b`

`./12-flags-2 -r`

`./12-flags-2 -h`

`gedit 12-flags-3`

`./12-flags-3 -a Alpha -bcd Bogma`

`./12-flags-3 -a Alpha -e "Emancipation" -bcd Bogma`

`./12-flags-3 -e "Emancipation" -bcd Bogma -a Alpha`

*Note anything after the -bcd options is ignored because they accept a global argument, be aware when combining specific options and global options*

`./12-flags-3 -a`

`./12-flags-3 -k`

`./12-flags-3 -h`

### III. `getopt`

*Note* `getops` *only accepts one-letter options,* `getopt` *is for* `--long` *options and requires more variables and checks*

`gedit 12-long`

*Note* `--long` *alternative options are included*

*Note the global option was removed since* `getopt` *checks requirements by itself*

`./12-long -a Alpha -bce`

`./12-long --alpha Alpha --ecko --delta --beetle --charlie `

*Note the order no longer affects the output since everything is done by* `if` *statements in order, at the end of the script*

`./12-long --alpha Alpha -bcd --ecko`

`./12-long -a Alpha --beetle --delta -e --charlie`

*Note both short and long are accepted*

`./12-long -k` (invalid option)

`./12-long` (no options)

`./12-long --help`

### IV. `dialog`

*5 = height; 18 = width*

`dialog --title "Read This" --msgbox "Ink is a verb." 5 18`

*Use* `\n` *for a new line*

`dialog --title "Read This" --msgbox "Ink\nis a\nverb." 12 9`

*Just the OK button is 10 wide, so 9 wide makes it ugly*

*Let's scroll wtih PgDn/PgUp*

`dialog --title "Read This" --msgbox "Ink\nis a\nverb." 6 10`

*Show contents of a file*

`dialog --textbox 12-dialog-text.txt 9 51` (try arrow keys, see what happens)

*Same thing, but title in the background*

`dialog --backtitle "Julius Caesar, by William Shakespeare; Act 3, Scene 2, Marc Antony:" --textbox 12-dialog-text.txt 9 51`

*Show info, then wait 5 seconds*

`dialog --title "Consider the Ramifications" --infobox "Ink actually is a noun and a verb.\nThink about it for five seconds." 4 38; sleep 5`

*Fill-in question* 

`dialog --inputbox "Enter a color" 7 21`

*Note your entry appeared in the middle of the box because it needs some place to go*

*Send "2>" output to color.file*

`dialog --inputbox "Enter a color" 7 21 2> color.file`

`ls *.file`

`gedit color.file`

*Yes/No question*

`dialog --title "Quick Question" --yesno "Do you ink?" 5 17` (answer yes)

*Note your answer does nothing, so echo the last exit code, which is the variable* `$?`

`echo $?`

*Change your answer this time*

`dialog --title "Quick Question" --yesno "Do you ink?" 5 17` (answer no)

`echo $?`

*This belongs in a script to work properly*

`gedit 12-dialog-1`

`./12-dialog-1`

`./12-dialog-1`

*Let's use a different* `if` *method and answer with more dialogs*

`gedit 12-dialog-2`

`./12-dialog-2`

`./12-dialog-2`

*Menu with multiple options*

`gedit 12-dialog-3`

*Run this in the terminal and output to size.file*

`dialog --menu "Choose a Size:" 11 23 4 1 X-Large 2 Large 3 Medium 4 Small 2> size.file`

`ls *.file`

`gedit size.file`

*This can work in a shell script, but it needs this exit code redirect on the end:* `3>&1 1>&2 2>&3 3>&-`

`./12-dialog-3`

`./12-dialog-3`

*Lots more to learn, easily*

`dialog man`

# Done! Have a cookie: ### #

Wait, what's pacman4console?

`sudo apt install pacman4console`

F11 (terminal to fullscreen)

`pacman4console`

