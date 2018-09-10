# Shell 101
## Lesson 11: Quote/Escape Special Characters

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`echo "$$//" > money.file`

`gedit money.file`

`echo "\$\$//" > money.file`

*gedit: Reload money.file*

`sed -i "s///!/g" money.file`

*Notice the error*

`sed -i "s/\//\!/g" money.file`

*gedit: Reload money.file*

`sed -i "s/$/@/g" money.file`

*gedit: Reload money.file*

`sed -i "s/\$/@/g" money.file`

*gedit: Reload money.file*

`sed -i 's/\$/@/g' money.file`

*gedit: Reload money.file*

*Note* `\t` = tab, `\n` = new line

`echo "no tab one line" > tab.file`

`gedit tab.file`

`sed -i "s/no/\t no/" tab.file`

*gedit: Reload tab.file*

*Note the tab*

`sed -i "s/\t no/no/" tab.file`

*gedit: Reload tab.file*

*Note the tab is gone*

`sed -i "s/one/one\n/" tab.file`

*gedit: Reload tab.file*

`sed -i "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

*Note the line was not removed, use* `-z` *so* `sed` *is not confused*

`sed -i -z "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

#### [Lesson 12: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-12.md)
