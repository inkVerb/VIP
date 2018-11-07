# Shell 401
## Lesson 1: Details

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Carriage Returns: DOS v Unix

`vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*No difference*

*Vim: `:q!`*

`unix2dos text-doc.txt`

`vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*Now* `^M` *at the end of the line, indicating a "carriage return"*

*Vim: `:q!`*

`dos2unix text-doc.txt`

`vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*No difference*

*Vim: `:q!`*

*Note:*
- DOS text files have "carriage returns" at the end of every line, not Unix
- Text files edited in Windows will have the DOS format, which includes carriage returns
- Carriage returns can create some problems in programming for Unix & Linux
- `dos2unix` & `unix2dos` convert text files between the DOS & Unix format

## Shell History

`history`

`cd ~/`

`ls .*history`

`vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgDown* (until last line)

*Vim: `:q!`*

`echo $HISTSIZE`

*History is preserved for the number of lines set in the `$HISTSIZE` environment variable*

*Again...*

`vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgUp* (until first line)

*Note the command on line 2*

*Vim: `:q!`*

`!2`

*Note* `!2` *calls line 2 form the history file, as for all* `!N` *useage*

`!-2`

*Note* `!-2` *calles the 2nd to last command, as for all* `!-Nth` *usage*

`!echo`

*Note* `!echo` *calls the first BASH command that began with "echo", as for all* `!TEST` *usage*

`cd ~/School/VIP/shell/401`

#### [Lesson 2: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md)
