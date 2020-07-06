# Shell 101
## Lesson 7: cat vs echo

Ready the CLI

`cd ~/School/VIP/101`

___

| **1** :$ `gedit abcd sedoutput.text`

*Remember `cat` outputs contents of a file as raw output (STDOUT)...*

| **2** :$ `cat abcd`

*Remember `echo` sends whatever raw input (STDIN) as raw output (STDOUT)...*

| **3** :$ `echo $(cat abcd)`

*...and `echo` doesn't preserves "new lines" (paragraph breaks) when it does*

| **4** :$ `sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd`

| **5** :$ `echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd)`

| **6** :$ `cat abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **7** :$ `echo $(cat abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **8** :$ `sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **9** :$ `echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **10** :$ `echo OneOneOne > one`

| **11** :$ `echo TwoTwoTwo > two`

| **12** :$ `cat one`

| **13** :$ `cat two`

| **14** :$ `cat one two`

| **15** :$ `cat one two > onetwo`

| **16** :$ `cat onetwo`

*Note `cat` combined one and two into onetwo*

*Note note also that `cat` preserved the lines*

| **17** :$ `echo $(cat one two)`

*Note `echo $(COMMAND_SUBSTITUTION)` removed the new lines like it always does*

| **18** :$ `echo ThreeThreeThree > three`

| **19** :$ `cat three two one >> onetwo`

| **20** :$ `cat onetwo`

*Note `cat` also appended onetwo via `>>`*

| **21** :$ `echo $(cat onetwo)`

*Note `echo $(COMMAND_SUBSTITUTION)` removed the new lines like it always does*

___

# The Take

- `echo` removes "new lines" (paragraph breaks) when used to output a `$(cat file)` command substitution
- `cat` preserves "new lines" (paragraph breaks) when used by itself
- `cat` can source from multiple files separated by spaces, *before* the output file indicator: `>`
- `cat` can append to an existing file with the output file indicator: `>>`

___

#### [Lesson 8: echo, sed, cat, tee & pipe scripts](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-08.md)
