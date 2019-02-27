# Shell 101
## Lesson 10: grep

`cd ~/School/VIP/shell/101`

___

| **1** : `echo "jjj" > abc/yoyo`

| **2** : `echo "Apple Jay" > abc/jayapple`

*Search contents inside files with* `grep`

| **3** : `grep jj *`

*Note the error about directories*

| **4** : `grep jj *.*`

*Like* `cp -r`*,* `rm -r`*,* *and* `chown -R`*,* `grep` *also needs* `-R` *with directories*

| **5** : `grep -R jj *`

*...no error*

| **6** : `grep -R Apple *`

| **7** : `grep -R Apples like *`

*Notice the errors, you must "quote" multiple words with spaces*

| **8** : `grep -R "Apples like" *`

#### [Lesson 11: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-11.md)
