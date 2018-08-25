# Shell 101
## Lesson 9: find

`cd ~/School/VIP/shell/101`

`gedit &`

`nautilus . &`

___

`mkdir abc abc-dir`

`ls`

`find "abc*"`

*Note the error message*

`find . "abc"`

*Note it found everything*

`find . -name "abc"`

`find . -name "abc*"`

`find . -type d -name "abc*"`

`find . -type f -name "abc*"`

`touch abcsed.Setting`

`touch ink.png ink.PNG ink.jpg ink.JPG`

`mkdir png PNG jpg JPG`

`find . -name "png"`

`find . -name "*.png"`

`find . -name "*png"`

`find . -iname "*png"`

`find . -iname "*jpg"`

`find . -type f -iname "*png"`
 
`find . -type d -iname "*png"`

#### [Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-10.md)
