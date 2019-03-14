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

*Knowing this could save your life and explain life's meaning later on...*

| **10** : `gedit allvar`

*Create allvar as this:* [allvar-01](https://github.com/inkVerb/vip/blob/master/101-shell/allvar-01)

| **11** : `ls`

| **12** : `chmod ug+x allvar`

| **13** : `ls`

| **14** : `./allvar`

| **15** : `./allvar 1 2 3 4 5 6 7 8 9`

| **16** : `./allvar I like to eat bananas in the morning, with eggs, over easy that is.`

*So,* `$@` *is everything...*

*This* `@` *means "everything" in web DNS, arrays (Shell 301), and many other things*

*These are "environment" variables that can always be called in the terminal or a script...*

| **17** : `printenv`

| **18** : `echo $USER`

| **19** : `printenv USER`

*...two ways to do the same thing*

| **20** : `echo $DESKTOP_SESSION`

| **21** : `printenv DESKTOP_SESSION`

| **22** : `echo $PWD`

| **23** : `printenv PWD`

*Here is a little trick, just for the PWD (Present Working Directory)... ;-)*

| **24** : `pwd`

| **25** : `./how2var $PWD $DESKTOP_SESSION VIP`

| **26** : `./how2var $USER USER rocks`

___

# The Take

- Arguments (like )`$1`, `$2`, and `$3`, etc) work in order after their command
- `$0` is the variable for the command that was run in the terminal
- Terminal commands may be continued to multiple lines using `\` (this helps organize stuff)
- `$@` will echo all arguments
- The terminal and Shell scripts have many other "environment variables" that can be called anytime
- *In the terminal* `echo $ENVIRONMENT_VARIABLE` = `printenv ENVIRONMENT_VARIABLE`
- `pwd` = `printenv PWD` = `echo $PWD` ...This shows the full, current location used by the terminal, AKA the "Present Working Directory"
- Variables (environment variables also) can be used in a command
- Variables used as arguments will pass their "value" as the argument

___

#### [Lesson 4: Setting Variables & Setting Files](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-04.md)
