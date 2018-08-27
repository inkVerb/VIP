# Shell 301
## Lesson 10: BASH Variable Variables & Arrays

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Arrays](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Arrays.md)
- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

## Welcome to BASH: Bourne Again Shell! `#!/bin/bash`

Nemo, we're not in Shellfish anymore... *(Hehe, see what I did there?)*

Some things can only be done in BASH

### Variable Variables

`gedit 10-varvar`

`./10-varvar abcyoume`

*Take a good look and try to see how that makes sense; it can be VERY useful!*

### Arrays

`gedit 10-array`

`./10-array`

*Note @ means all elements*

*Note * does the same thing as @*

`gedit 10-array-index-id`

`./10-array-index-id 1`

`./10-array-index-id 0`

*Note the first element's index ID (key) is 0*

`gedit 10-array-associative`

*Note* `declare -A ARRAYNAME` *precedes*

`./10-array-associative i`

`./10-array-associative ii`

`./10-array-associative iii`

`./10-array-associative iv`

`./10-array-associative v`

*Note there are two ways to define the elements of the associative array*

`./10-array-associative i III`

`./10-array-associative i II`

`./10-array-associative i I`

`./10-array-associative iv IV`

`./10-array-associative iii V`

`gedit 10-array-associative-declare`

`./10-array-associative-declare`

*Tip: Uncomment the* `#declare` *lines (5 & 13) to* `declare` *and see that it works...*

`./10-array-associative-declare`


___

## Rule 1: You CAN'T put an array inside an array
## Rule 2: Associative arrays need this first `declare -A ARRAYNAME`
## Rule 3: Choose associative or key-indexed
EITHER
### associative: `MyArry=([key]=frst [ky2]=sec) .. MyArry[key] MyArry[ky2]`
OR
### indexed: `MyArry=(one two) .. MyArry[0] MyArry[1]`

NOT BOTH

___

`gedit 10-array-keys`

`./10-array-keys`

*Note that associative arrays don't necessarily keep a predictable order*

`gedit 10-array-strings`

`./10-array-strings`

*Note quoted strings are allowed as elements*

`gedit 10-array-associative-strings`

`./10-array-associative-strings`

*Note associative arrays can have strings as elements too*

#### [Lesson 11: BASH Functions](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-11.md)

