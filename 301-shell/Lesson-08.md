# Shell 301
## Lesson 8: date & pwgen

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `date`

| **1** : `date`

*Different format*

| **2** : `date +%c`

*MM/DD/YY*

| **3** : `date +%D`

*YYYY-MM-DD*

| **4** : `date +%F`

*HH:mm:SS*

| **5** : `date +%T`

*YYYY*

| **6** : `date +%Y`

*Mon*

| **7** : `date +%b`

*Month*

| **8** : `date +%B`

*MM*

| **9** : `date +%m`

*DD*

| **10** : `date +%d`

*Dy*

| **11** : `date +%a`

*Day*

| **12** : `date +%A`

*HH*

| **13** : `date +%H`

*mm (minute)*

| **14** : `date +%M`

*SS (seconds)*

| **15** : `date +%S`

*Nifty combos*

| **16** : `date +%Y_%m_%d_%T`

| **17** : `date +%Y/%m/%d_%T`

| **18** : `date +%Y/%m/%d_%H:%M:%S`

| **19** : `date +%Y-%m-%d.%H-%M-%S`

*Read more options here:* [https://www.computerhope.com/unix/udate.htm]

### II. `pwgen`

| **20** : `pwgen`

*Only 1* `-1`

| **21** : `pwgen -1`

*36 characters long* `36`

| **22** : `pwgen -1 36`

*Include at least 1 special character* `-y`

| **23** : `pwgen -1 10 -y`

*No numerals* `-0`

| **24** : `pwgen -1 10 -0`

*No caps* `-A`

| **25** : `pwgen -1 10 -A`

*Combine options into one*

| **26** : `pwgen -A01y 10`

*Read more options here:* [https://linux.die.net/man/1/pwgen]

### III. `pwgen` + `date` is useful

| **27** : `echo $(date +%Y-%m-%d_%H-%M-%S)_$(pwgen -1 9)`

| **28** : `gedit 08-date-name`

| **29** : `./08-date-name yoyo`

#### [Lesson 9: Arithmetic](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-09.md)
