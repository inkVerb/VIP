# Shell 101
## Lesson 3: Arguments & Variables Review

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`gedit how2var`

*Create how2var as this:* [how2var-01](https://github.com/inkVerb/vip/blob/master/101-shell/how2var-01)

`ls`

`chmod ug+x how2var`

`ls`

`./how2var one two three`

`./how2var a b abcd`

`./how2var ink "is a" verb`

*Arguments can be placed on multiple lines*

```sh
./how2var \
one \
two \
three
```

```sh
./how2var \
first \
2nd \
"third line"
```

`printenv`

`echo $USER`

`printenv USER`

`echo $DESKTOP_SESSION`

`printenv DESKTOP_SESSION`

`echo $PWD`

`printenv PWD`

*Here is a little trick, just for the PWD (Present Working Directory)... ;-)*

`pwd`

`./how2var $PWD $DESKTOP_SESSION VIP`

`./how2var $USER USER rocks`

*Knowing this could save your life and explain life's meaning later on...*

`gedit allvar`

*Create how2var as this:* [allvar-01](https://github.com/inkVerb/vip/blob/master/101-shell/allvar-01)

`ls`

`chmod ug+x allvar`

`ls`

`./allvar`

`./allvar 1 2 3 4 5 6 7 8 9`

`./allvar I like to eat bananas in the morning, with eggs, over easy that is.`

*So,* `$@` *is everything...*

*This* `@` *means "everything" in web DNS, arrays (Shell 301), and many other things*

#### [Lesson 4: Setting Variables & Setting Files](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-04.md)
