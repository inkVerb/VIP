# Shell 101
## Lesson 7: cat vs echo

`cd ~/Work/VIP/shell/101`

`gedit &`

`nautilus . &`
___

`gedit abcd sedoutput.text`

`cat abcd`

`echo $(cat abcd)`

`sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd`

`echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd)`

`cat abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

`echo $(cat abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

`sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd | tee sedoutput.text`

*gedit: Reload sedoutput.text*

`echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

`echo OneOneOne > one`

`echo TwoTwoTwo > two`

`cat one`

`cat two`

`cat one two`

`cat one two > onetwo`

`cat onetwo`

*Note cat combined one and two into onetwo*

`echo ThreeThreeThree > three`

`cat three two one >> onetwo`

`cat onetwo`

*Note cat also appended to onetwo via >>*

`rm one two three onetwo`

#### [Lesson 8: echo, cat & tee in scripts](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-08.md)
