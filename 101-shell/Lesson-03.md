# Shell 101
## Lesson 3: Arguments & Variables Review

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit how2var`

*Create how2var as this:* [how2var-01](https://github.com/inkVerb/vip/blob/master/101-shell/how2var-01)

| **2** : `ls`

| **3** : `chmod ug+x how2var`

| **4** : `ls`

| **5** : `./how2var one two three`

| **6** : `./how2var a b abcd`

| **7** : `./how2var ink "is a" verb`

*Arguments can be placed on multiple lines*

| **8** :
```sh
./how2var \
one \
two \
three
```

| **9** :
```sh
./how2var \
first \
2nd \
"third line"
```

| **10** : `printenv`

*These are "environment" variables that can always be called in the terminal or a script*

| **11** : `echo $USER`

| **12** : `printenv USER`

*...two ways to do the same thing*

| **13** : `echo $DESKTOP_SESSION`

| **14** : `printenv DESKTOP_SESSION`

| **15** : `echo $PWD`

| **16** : `printenv PWD`

*Here is a little trick, just for the PWD (Present Working Directory)... ;-)*

| **17** : `pwd`

| **18** : `./how2var $PWD $DESKTOP_SESSION VIP`

| **19** : `./how2var $USER USER rocks`

*Knowing this could save your life and explain life's meaning later on...*

| **20** : `gedit allvar`

*Create how2var as this:* [allvar-01](https://github.com/inkVerb/vip/blob/master/101-shell/allvar-01)

| **21** : `ls`

| **22** : `chmod ug+x allvar`

| **23** : `ls`

| **24** : `./allvar`

| **25** : `./allvar 1 2 3 4 5 6 7 8 9`

| **26** : `./allvar I like to eat bananas in the morning, with eggs, over easy that is.`

*So,* `$@` *is everything...*

*This* `@` *means "everything" in web DNS, arrays (Shell 301), and many other things*

#### [Lesson 4: Setting Variables & Setting Files](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-04.md)
