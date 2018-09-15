# Shell 101
## Lesson 10: grep

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`echo "jjj" > abc/yoyo`

`echo "Apple Jay" > abc/jayapple`

*Search contents inside files with* `grep`

`grep jj *`

*Note the error about directories*

`grep jj *.*`

*Like* `cp -r`*,* `rm -r`*,* *and* `chown -R`*,* `grep` *also needs* `-R` *with directories*

`grep -R jj *`

*...no error*

`grep -R Apple *`

`grep -R Apples like *`

*Notice the errors, you must "quote" multiple words with spaces*

`grep -R "Apples like" *`

#### [Lesson 11: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-11.md)
