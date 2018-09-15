# Shell 101
## Lesson 8: echo, cat & tee in scripts

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`gedit abcd comboshell sedoutput.text`

*Note* `tee` *will overwrite any contents in the output file*

`cat abcd`

`./comboshell abcd j "z-"`

*Update comboshell to this:* [comboshell-02](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-02)

`./comboshell abcd j "z-"`

*gedit: Reload sedoutput.text*

*Update comboshell to this:* [comboshell-03](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-03)

`./comboshell abcd j "z00 zoo "`

*gedit: Reload sedoutput.text*

`echo "Took out the trash." > sedoutput.text`

*gedit: Reload sedoutput.text*

*Update comboshell to this:* [comboshell-04](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-04)

`./comboshell abcd j "z-"`

*gedit: Reload sedoutput.text*

#### [Lesson 9: find](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-09.md)
