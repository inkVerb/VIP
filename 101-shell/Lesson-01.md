# Shell 101
## Lesson 1: gedit, echo & sed

`cd ~/School/VIP/shell/101`

___

| **1** : `echo "Output to terminal"`

*The "input" you enter into the terminal is called: "STDIN"*

*The "output" you see in the terminal is called: "STDOUT"*

*Below, the STDIN is `echo "Hello ink!"` and the STDOUT is `Hello ink!`*

| **2** : `echo "Hello ink!"`

| **3** : `echo "abcdefghijklmnopqrstuvwxyz"`

| **4** : `ls`

*See, there are no files here*

*We can send STDOUT to a file with: `> MYFILE`*

| **5** : `echo "Output to file" > abcd`

| **6** : `ls`

*See, now there's a new file here*

| **7** : `gedit abcd`

| **8** : `echo "abcdefghijklmnopqrstuvwxyz" > abcd`

*gedit: Reload*

| **9** : `echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

| **10** : `echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

*Note the number of lines*

| **11** : `echo "foo :-)" >> abcd`

*gedit: Reload*

| **12** : `sed -i "s/foo/bar/" abcd`

*gedit: Reload*

| **13** : `sed -i "s/bar//" abcd`

*gedit: Reload*

| **14** : `echo "add foo and then some" >> abcd`

*gedit: Reload*

| **15** : `sed -i "s/foo/bar/" abcd`

*gedit: Reload*

*Note the line number of "add bar and then some"*

| **16** : `sed -i "/bar/d" abcd`

*gedit: Reload*

*Note the line with "bar" is gone*

| **17** : `echo "Replace this Apple delBar line." >> abcd`

*gedit: Reload*

| **18** : `sed -i "/Replace.*/ c\The line with Mr. Apple delBar has been replaced" abcd`

*gedit: Reload*

*Ctrl + D deletes a line in gedit*
- Use it to delete the line about "Mr. Apple delBar"
- Then Ctrl + S to save the file

___

# The Take

- Computers (the terminal also) work with *input* & *output*
- STDIN = input
- STDOUT = output
- `echo` is a command that inputs something for simple text output
- `echo` can send output to a file with `>` & `>>`
- `ls` "lists" what's in the current directory as output (STDOUT)
- `sed` can replace or delete text in a file
- `sed` uses "d" to delete a line
- Gedit usees **Ctrl + D** to delete a line

___

#### [Lesson 2: Arguments & Variables](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-02.md)
