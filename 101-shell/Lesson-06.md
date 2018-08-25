# Shell 101
## Lesson 6: tee
## tee = T

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`gedit applefoo`

`sed "s/foo/bar/" applefoo`

`echo $(sed "s/foo/bar/" applefoo) > sedoutput.text`

`gedit sedoutput.text`

`echo "Add a line" >> sedoutput.text`

*gedit: Reload sedoutput.text*

`echo $(sed "s/foo/bar/" applefoo) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

#### [Lesson 7: cat vs echo](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-07.md)
