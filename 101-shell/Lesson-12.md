# Shell 101
## Lesson 12: grep with Special Characters

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

*Special characters with* `grep` *need* `-F`

`grep -R "$" *`

*Note it found everything*

`grep -F "$" *`

*Note the directory error, combine flags into one*

`grep -RF "$" *`

`grep -RF "@" *`

`grep -RF "!" *`

*So far everything works*

`grep -RF "!!" *`

*But, that didn't work, why?*

`ls -l`

`!!`

`echo "Hello Apple pie."`

`!!`

*In scripts,* `!!` *means "whatever the last command was, watch..."*

`grep -RF "!!" *`

*Sometimes, special characters can only be "canceled" with 'single quotes'*

`grep -RF '!!' *`

*...'single quotes' can behave differently in* `grep` *and most other commands*

# Done! Have a cookie: ### #

Oh, what's this?

`cowsay Moo! or something`

Don't have it yet?

`sudo apt install cowsay`

