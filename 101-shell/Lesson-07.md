# Shell 101
## Lesson 7: cat vs echo

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit abcd sedoutput.text`

*Note* `cat` *displays contents of a file on the screen*

| **2** : `cat abcd`

*Note* `echo` *sends output as raw output to the screen*

| **3** : `echo $(cat abcd)`

*...and* `echo` *doesn't make paragraph breaks when it does*

| **4** : `sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd`

| **5** : `echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd)`

| **6** : `cat abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **7** : `echo $(cat abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **8** : `sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **9** : `echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

| **10** : `echo OneOneOne > one`

| **11** : `echo TwoTwoTwo > two`

| **12** : `cat one`

| **13** : `cat two`

| **14** : `cat one two`

| **15** : `cat one two > onetwo`

| **16** : `cat onetwo`

*Note cat combined one and two into onetwo*

| **17** : `echo ThreeThreeThree > three`

| **18** : `cat three two one >> onetwo`

| **19** : `cat onetwo`

*Note cat also appended to onetwo via >>*

| **20** : `rm one two three onetwo`

___

# The Take

- `echo` removes paragraph breaks when used against a `$(cat file)` command substitution
- `cat` preserves paragraph breaks when used by itself
- `cat` can source from multiple files separated by spaces, *before* the output file indicator: `>`
- `cat` can append to an existing file with the output file indicator: `>>`


___

#### [Lesson 8: echo, sed, cat, tee & pipe scripts](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-08.md)
