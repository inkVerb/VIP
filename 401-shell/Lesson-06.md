# Shell 401
## Lesson 6: Data Types & Quotes

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

### I. Introduction to "data types"

*The value of a variable can be one of many different "types of data".*

#### Common data types:
- character (char, C) *- a single, one-byte character (a-z, 0-9, and most keyboard special characters)*
- varchar *- "character varying", can be 80 characters long*
- string *- any kind of raw text*
- integer (int) *- whole numbers, positive or negative*
- float *- numbers with a decimal*
- array *- a complex variable; like a mini database, with a list of many values, each with a number/key for reference*
- boolean *- only `true` or `false` (many times `1` or `0` is the same thing)*
- NULL *- empty data, not set*
- NUL *- value similar to `false` or `0`*

#### In Shell:
1. Shell "doesn't use" data types, AKA Shell "only uses the string" data type. But, Shell still knows if a data set is empty or a true/false (boolean) value. (Other languages often require data types to be declared.)
2. Shell only uses a three data types: *(...in practicality; officially Shell 'doesn't use data types'.)*
- NULL (ie: after using `unset`)
- boolean (`true`/`false`)
- string (everything else)
- integer (can be used in arithmetic operations, floats/decimals can't)

*The fact that Shell "doesn't use" data types makes Shell a great first language!*

### II. Quotes: single vs double

#### Rules of quotes:
- Quotes are not always necessary for Shell variable values, but BASH requires quotes for values in tests (`if`, `for`, `while`, etc.)
- Variables do not ***work*** (call their values) in 'single quotes', but they ***work*** in "double quotes".
- Anything in "double quotes" will be stored as a string, even "true" and "false".
- If a value can be used as a boolean value, Shell can use it for tests (`if`, `for`, `while`, etc.)
- If a value can be used as an integer, Shell can use it for arithmetic, regardless of whether it was stored with "double" or 'single' quotes or without quotes.
- Any value with spaces must be stored using quotes, either 'single' or "double".

Example of 'single' & "double" quotes in declaring variable values:

*Edit a new file*

`gedit varquote`

*Put this code in the file and save it:*

```sh
#!/bin/sh

VAR="Hello world!"

VARsq='$VAR' # "$VAR" will become the value.

VARdq="$VAR" # The value of $VAR, "Hello world!" will bcome the value.

echo $VARsq
echo $VARdq
```

*Make it executable*

`chmod ug+x varquote`

`ls`

*Run it and watch carefully*

`./varquote`


### III. Boolean values

Example of boolean values and quotes:

*Edit a new file*

`gedit varbool`

*Put this code in the file and save it:*

```sh
#!/bin/sh

TRUEsq='true'
TRUEdq="true"
TRUEvar=true
FALSEsq='false'
FALSEdq="false"
FALSEvar=false

if $TRUEsq ; then
    echo TRUEsq $TRUEsq
else
    echo FAIL $FALSEdq
fi

if $TRUEdq ; then
    echo TRUEdq $TRUEdq
else
    echo FAIL $FALSEdq
fi

if $TRUEvar ; then
    echo TRUEvar $TRUEvar
else
    echo FAIL $FALSEdq
fi

if $FALSEsq ; then
    echo FALSEsq
else
    echo FAIL $FALSEsq
fi

if $FALSEdq ; then
    echo FALSEdq
else
    echo FAIL $FALSEdq
fi

if $FALSEvar ; then
    echo FALSEvar
else
    echo FAIL $FALSEvar
fi
```

*Make it executable*

`chmod ug+x varbool`

`ls`

*Run it and watch carefully*

`./varbool`

*Case and point: quotes make no difference in how a value is treated, even boolean.*

### IV. Arithmetic

Example of boolean values and quotes:

*Edit a new file*

`gedit varmath`

*Put this code in the file and save it:*

```sh
#!/bin/sh

_1=1
_2=2
_3=3
_4=4
_5=five
_6=six
_7=7
_8=eight
_9=9
_10=10
s1='1'
s2='2'
s3='3'
s4='4'
s5='five'
s6='six'
s7='7'
s8='eight'
s9='9'
s10='10'
d1="1"
d2="2"
d3="3"
d4="4"
d5="five"
d6="six"
d7="7"
d8="eight"
d9="9"
d10="10"

# Below, Shell will figure out that the values are integers, so it can do arithmetic with them:
echo 1 + 2 =  `expr $_1 + $_2`
echo 4 x 7 =  `expr $_4 \* $_7`
echo 9 - 3 =  `expr $_9 - $_3`
echo 10 / 5 = `expr $_10 / $_2`
echo 1 + 2 =  `expr $s1 + $s2`
echo 4 x 7 =  `expr $s4 \* $s7`
echo 9 - 3 =  `expr $s9 - $s3`
echo 10 / 5 = `expr $s10 / $s2`
echo 1 + 2 =  `expr $d1 + $d2`
echo 4 x 7 =  `expr $d4 \* $d7`
echo 9 - 3 =  `expr $d9 - $d3`
echo 10 / 5 = `expr $d10 / $d2`

# Below, Shell will figure out that the values of 5, 6, and 8 are strings, not integers:
echo eight - 3 = `expr $_8 - $_3`
echo five \* six = `expr $_5 \* $_6`
echo eight - 3 = `expr $s8 - $s3`
echo five \* six = `expr $s5 \* $s6`
echo eight - 3 = `expr $d8 - $d3`
echo five \* six = `expr $d5 \* $d6`
```

*Make it executable*

`chmod ug+x varmath`

`ls`

*Run it and watch carefully*

`./varmath`

*Case and point: quotes make no difference in how a value is treated, even in arithmetic.*

#### [Lesson 7: More with `sed` & files](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-07.md)
