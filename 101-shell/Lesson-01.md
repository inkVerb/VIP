# Shell 101
## Lesson 1: gedit, echo & sed

`cd ~/Work/VIP/shell/101`

`gedit &`

`nautilus . &`
___

`echo "No destination? Output to terminal, just like this."`

*The "output" you see in the terminal is called:* "STDOUT"

*The "input" you enter into the terminal is called:* "STDIN"

*Below, the* STDIN *is* `echo "Hello ink!"` *and the* STDOUT *is* `Hello ink!`

`echo "Hello ink!"`

`echo "abcdefghijklmnopqrstuvwxyz"`

`ls`

*See, there are no files here*

*We can send* STDOUT *to a file with:* `> MYFILE`

`echo "Designate a file? Output goes to the file, just like this." > abcd`

`ls`

*See, now there's a new file here*

`gedit abcd`

`echo "abcdefghijklmnopqrstuvwxyz" > abcd`

*gedit: Reload*

`echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

`echo "abcdefghijklmnopqrstuvwxyz" >> abcd`

*gedit: Reload*

`echo "foo :-)" >> abcd`

*gedit: Reload*

`sed -i "s/foo/bar/" abcd`

*gedit: Reload*

`sed -i "s/bar//" abcd`

*gedit: Reload*

`echo "add foo and then some" >> abcd`

*gedit: Reload*

`sed -i "s/foo/bar/" abcd`

*gedit: Reload*

`sed -i "/bar/d" abcd`

*gedit: Reload*

#### [Lesson 2: Arguments & Variables](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-02.md)
