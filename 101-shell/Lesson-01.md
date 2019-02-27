# Shell 101
## Lesson 1: gedit, echo & sed

___

## Prepare

*F12 (guake/tilda) OR Ctrl + Alt + T (new terminal)*

| **1** : `mkdir -p ~/School/VIP/shell/101`

| **2** : `cd ~/School/VIP/shell/101`

___

| **3** : `echo "No destination? Output to terminal, just like this."`

*The "output" you see in the terminal is called:* "STDOUT"

*The "input" you enter into the terminal is called:* "STDIN"

*Below, the* STDIN *is* `echo "Hello ink!"` *and the* STDOUT *is* `Hello ink!`

| **4** : `echo "Hello ink!"`

| **5** : `echo "abcdefghijklmnopqrstuvwxyz"`

| **6** : `ls`

*See, there are no files here*

*We can send* STDOUT *to a file with:* `> MYFILE`

| **7** : `echo "Designate a file? Output goes to the file, just like this." > abcd`

| **8** : `ls`

*See, now there's a new file here*

| **9** : `gedit abcd`

| **10** : `echo "abcdefghijklmnopqrstuvwxyz" > abcd`

*gedit: Reload*

| **11** : `echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

| **12** : `echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

*Note the number of lines*

| **13** : `echo "foo :-)" >> abcd`

*gedit: Reload*

| **14** : `sed -i "s/foo/bar/" abcd`

*gedit: Reload*

| **15** : `sed -i "s/bar//" abcd`

*gedit: Reload*

| **16** : `echo "add foo and then some" >> abcd`

*gedit: Reload*

| **17** : `sed -i "s/foo/bar/" abcd`

*gedit: Reload*

*Note the line number of* "add bar and then some"

| **18** : `sed -i "/bar/d" abcd`

*gedit: Reload*

*Note the line with "bar" is gone*

| **19** : `echo "Replace this Apple delBar line." >> abcd`

*gedit: Reload*

| **20** : `sed -i "/Replace.*/ c\The line with Mr. Apple delBar has been replaced" abcd`

*gedit: Reload*

*Ctrl + D deletes a line in gedit, use it to delete the line about "Mr. Apple delBar"*

#### [Lesson 2: Arguments & Variables](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-02.md)
