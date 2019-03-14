# Shell 401
## Lesson 6: Data Types & Quotes

`cd ~/School/VIP/shell/401`

___

### I. Introduction to "data types"

*The value of a variable can be one of many different "types of data".*

VAR=5
- The value "data type" is a number.

VAR=H
- The value "data type" is a single letter.

VAR="I'm a cucumber!"
- The value "data type" is a sentence (what coders call a 'string').

VAR=false
- The value "data type" is a true/false value (what coders call 'boolean').

#### Common data types:
- character (char, C) *- a single, one-byte character (a-z, A-Z, 0-9, and most keyboard special characters)*
- varchar *- "character varying", usually up to 80 characters long*
- string *- any kind of raw text, usually "any length"*
- integer (int) *- whole numbers, positive or negative*
- float *- numbers with a "floating" decimal, up to 7 decimal digits*
- double float (double) *- "double" precision floating decimal, up to 15 decimal digits*
- array *- a complex variable; a "mini database variable"; a list (array) of multiple values, each with a number/key for reference*
- boolean *- only `true` or `false` (usually `1` or `0` is the same thing as `true` or `false`)*
- NULL *- empty data, not set (ie: before declaring a variable's value or after using `unset`)*

*Shell* ***utilizes*** *data types; but Shell does not* ***use*** *(store as) data types other than "string".*

#### Data types in Shell:
1. Shell "doesn't **use**" data types, AKA Shell only stores all variable value data as the **string** data type. *(In many other languages, you must declare data types for variables.)* But, Shell can **utilize** data different ways...
2. Shell mainly **utilizes** three data types:
- boolean (`true`/`false`)
- integer (can be used in arithmetic operations, floats/decimals can't)
- string (everything else)
3. BASH can **utilize** a fourth data type:
- array (multiple values, called with a **key**)

*Since Shell "doesn't use" data types, that's one less thing to worry about. This makes Shell a great first language!*

### II. Quotes: single vs double

*Quoting with 'single' vs "double" quotes makes a difference.*

#### Rules of quotes:
- Quotes are not always necessary for Shell variable values, but BASH requires quotes for values in tests (`if`, `for`, `while`, etc.)
- Variables do not ***work*** (call their values) in 'single quotes', but they ***work*** in "double quotes".
- Anything in "double quotes" will be stored as a string, even "true" and "false".
- If a value can be used as a boolean value, Shell can use it for tests (`if`, `for`, `while`, etc.)
- If a value can be used as an integer, Shell can use it for arithmetic, regardless of whether it was stored with "double" or 'single' quotes or without quotes.
- Any value with spaces must be stored using quotes, either 'single' or "double".

Example of 'single' & "double" quotes in declaring variable values:

*Edit this script*

| **1** : `gedit varquote`

*It should look like this:*

```sh
#!/bin/sh

VAR="Hello world!"

VARsq='$VAR' # "$VAR" will become the value.

VARdq="$VAR" # The value of $VAR, "Hello world!" will bcome the value.

echo $VARsq
echo $VARdq
```

*Make it executable*

| **2** : `chmod ug+x varquote`

| **3** : `ls`

*Run it and watch carefully*

| **4** : `./varquote`


### III. Boolean values

Example of boolean values and quotes:

*Edit this script*

| **5** : `gedit varbool`

*It should look like this:*

```sh
#!/bin/sh

TRUEsq='true'
TRUEdq="true"
TRUEvar=true
FALSEsq='false'
FALSEdq="false"
FALSEvar=false

# These tests already have the answer, "true" or "false"; true/false is how Shell tests work!
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

| **6** : `chmod ug+x varbool`

| **7** : `ls`

*Run it and watch carefully*

| **8** : `./varbool`

*Case and point: quotes make no difference in how a value is treated, even boolean.*

### IV. Arithmetic

Example of integer values and quotes:

*Edit this script*

| **9** : `gedit varmath`

*It should look like this:*

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

# Below, Shell will figure out that the values of 5, 6, and 8 are strings, not integers, and thus report an error:
echo eight - 3 = `expr $_8 - $_3`
echo five \* six = `expr $_5 \* $_6`
echo eight - 3 = `expr $s8 - $s3`
echo five \* six = `expr $s5 \* $s6`
echo eight - 3 = `expr $d8 - $d3`
echo five \* six = `expr $d5 \* $d6`
```

*Make it executable*

| **10** : `chmod ug+x varmath`

| **11** : `ls`

*Run it and watch carefully*

| **12** : `./varmath`

*Case and point: quotes make no difference in how a value is treated, even in arithmetic.*

___

# The Take

-

___

#### [Lesson 7: More with `while` & `sed`](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-07.md)
