# Shell 301
## Lesson 9: Arithmetic 

`cd ~/Work/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/301-shell/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/301-shell/Tests.md)
___

### I. `${#VARIABLE}`

`gedit 09-count`

`./09-count five`

`./09-count six`

### II. Basic Math `expr`

`expr 5 + 6`

`expr 12 - 1`

`expr 7 / 2`

*Note it only answers in whole numbers*

*Modulus gives only the remainder*

`expr 7 % 2`

*Look, the asterisk must be cancelled because all by itself an asterisk "means something"*

`expr 7 \* 2`

`gedit 09-expr`

`./09-expr 2 + 72`

`./09-expr 55 - 7`

`./09-expr 88 / 11`

`./09-expr 14 * 2`

`./09-expr 7 % 2`

`gedit 09-expr-show`

`./09-expr-show 55 + 1`

`./09-expr-show 20 \* 3`

`./09-expr-show 22 % 3`

### III. Comparison Operators

#### A. `-eq -ne -gt -lt -ge -le`

`gedit 09-operators`

`./09-operators 4 4 eq`

`./09-operators 4 7 eq`

`./09-operators 4 4 ne`

`./09-operators 4 7 ne`

`./09-operators 8 9 gt`

`./09-operators 9 8 gt`

`./09-operators 8 9 lt`

`./09-operators 9 8 lt`

`./09-operators 10 23 ge`

`./09-operators 10 23 ge`

`./09-operators 10 23 le`

`./09-operators 10 23 le`

`./09-operators 3.14 15 gt`

*Oops, it only works with whole numbers*

*But, it works with negative numbers*

`./09-operators 5 -5 ne`

`./09-operators -5 -5 ne`

#### B. Substitute the `$VARIABLE`

`gedit 09-operators-subvar`

`./09-operators-subvar 12 12 lt`

`./09-operators-subvar 12 13 lt`

#### C. `== != > < >= <=` (BASH)

`gedit 09-operators-symbol`

*Note at the top:* `#!/bin/bash`

*These symbols require BASH. Nemo, we're not in Shellfish anymore...*

`./09-operators-symbol 12 12 eq`

`./09-operators-symbol 12 13 eq`


#### [Lesson 10: BASH Variable Variables & Arrays](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-10.md)
