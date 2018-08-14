# Shell 101
## Lesson 11: Quote/Escape Special Characters

`cd ~/Work/VIP/shell/101`

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

#### [Lesson 12: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-12.md)
