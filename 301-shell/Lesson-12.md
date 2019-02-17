# Shell 301
## Lesson 12: BASH getopts & getopt

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `getopts`

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

### II. `getopt`

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

# Done! Have a cookie: ### #

Wait, what are these?

`sudo apt install bastet moon-buggy ninvaders nsnake pacman4console`

(Make sure the terminal is big enough!)

`bastet`

`moon-buggy`

`ninvaders`

`nsnake`

`pacman4console`

