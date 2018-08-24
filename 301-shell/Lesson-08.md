# Shell 301
## Lesson 8: date & pwgen

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)
___

### I. `date`

`date`

*Different format*

`date +%c`

*MM/DD/YY*

`date +%D`

*YYYY-MM-DD*

`date +%F`

*HH:mm:SS*

`date +%T`

*YYYY*

`date +%Y`

*Mon*

`date +%b`

*Month*

`date +%B`

*MM*

`date +%m`

*DD*

`date +%d`

*Dy*

`date +%a`

*Day*

`date +%A`

*HH*

`date +%H`

*mm (minute)*

`date +%M`

*SS (seconds)*

`date +%S`

*Nifty combos*

`date +%Y_%m_%d_%T`

`date +%Y/%m/%d_%T`

`date +%Y/%m/%d_%H:%M:%S`

`date +%Y-%m-%d.%H-%M-%S`

*Read more options here:* [https://www.computerhope.com/unix/udate.htm]

### II. `pwgen`

`pwgen`

*Only 1* `-1`

`pwgen -1`

*36 characters long* `36`

`pwgen -1 36`

*Include at least 1 special character* `-y`

`pwgen -1 10 -y`

*No numerals* `-0`

`pwgen -1 10 -0`

*No caps* `-A`

`pwgen -1 10 -A`

*Combine options into one*

`pwgen -A01y 10`

*Read more options here:* [https://linux.die.net/man/1/pwgen]

### III. `pwgen` + `date` is useful

`echo $(date +%Y-%m-%d_%H-%M-%S)_$(pwgen -1 9)`

`gedit 08-date-name`

`./08-date-name yoyo`

#### [Lesson 9: Arithmetic](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-09.md)
