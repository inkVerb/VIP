# Shell 101
## Lesson 8: echo, sed, cat, tee & pipe scripts

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit abcd comboshell sedoutput.text`

*Note* `tee` *will overwrite any contents in the output file*

| **2** : `cat abcd`

| **3** : `./comboshell abcd j "z-"`

*Update comboshell to this:* [comboshell-02](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-02)

| **4** : `./comboshell abcd j "z-"`

*gedit: Reload sedoutput.text*

*Update comboshell to this:* [comboshell-03](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-03)

| **5** : `./comboshell abcd j "z00 zoo "`

*gedit: Reload sedoutput.text*

| **6** : `echo "Took out the trash." > sedoutput.text`

*gedit: Reload sedoutput.text*

*Update comboshell to this:* [comboshell-04](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-04)

| **7** : `./comboshell abcd j "z-"`

*gedit: Reload sedoutput.text*

*Update comboshell to this:* [comboshell-05](https://github.com/inkVerb/vip/blob/master/101-shell/comboshell-05)

| **8** : `./comboshell abcd j "vip-"`

*gedit: Reload sedoutput.text*

___

# The Take

- Argument variables (`$1`, `$2`, etc) can be used inside `$( command substitution )`
- `echo` can send variables to output
- `echo` can pipe variables to a tee output with `echo $variable | tee output/file/here`
- a pipe chain can link more than two commands: `comm 1 | comm 2 | comm 3 | output-to > file`
- `tee` will overwrite the contents of its output file

___

#### [Lesson 9: find](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-09.md)
