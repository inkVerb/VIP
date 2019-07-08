# Shell 401
## Lesson 6: Data Types & Quotes

`cd ~/School/VIP/shell/401`

___

### I. Introduction to "Data Types"

*The value of a variable can be one of many different "types of data".*

VAR=5
- The value "data type" is a number.

VAR=H
- The value "data type" is a single letter.

VAR="I'm a cucumber!"
- The value "data type" is a sentence (what coders call a 'string').

VAR=false
- The value "data type" is a true/false value (what coders call 'boolean').

#### Common Data Types:
- character (char, C) *- a single, one-byte character (a-z, A-Z, 0-9, and most keyboard special characters)*
- varchar *- "character varying", usually up to 80 characters long*
- string *- any kind of raw text, usually "any length"*
- integer (int) *- whole numbers, positive or negative*
- float *- numbers with a "floating" decimal, up to 7 decimal digits*
- double float (double) *- "double" precision floating decimal, up to 15 decimal digits*
- array *- a complex variable; a "mini database variable"; a list (array) of multiple values, each with a number/key for reference*
- boolean *- only `true` or `false`*
  - In ***other languages*** boolean `1` and `0` are interchangeable with `true` and `false`, respectively, ***not Shell***
  - Shell only recognizes `true` or `false` as boolean, not `1` or `0` because, in Shell, `1` and `0` are `exit` codes, along with `2`, `3`, `128`, and more...
  - Do not confuse boolean `1` and `0` (non-Shell languages) with STDIN (`0`), STDOUT (`1`), and STDERR (`2`), nor with other `exit` codes. ***Boolean only allows TWO values!***
  - Review `exit` codes (which are different) in [VIP/Shell 301 – Lesson 6](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)
- NULL *- empty data, not set (ie: before declaring a variable's value or after using `unset`)*

*Shell* ***utilizes*** *data types; but Shell does not* ***use*** *(store as) data types other than "string".*

#### Data Types in Shell:
1. Shell "doesn't **use**" data types, AKA Shell only stores all variable value data as the **string** data type. *(In many other languages, you must declare data types for variables.)* But, Shell can **utilize** data different ways...
2. Shell mainly **utilizes** three data types:
- boolean (`true`/`false`)
- integer (can be used in arithmetic operations, floats/decimals can't)
- string (everything else)
3. BASH can **utilize** a fourth data type:
- array (multiple values, called with a **key**)

*Since Shell "doesn't use" data types, that's one less thing to worry about. This makes Shell a great first language!*

### II. Quotes: Single vs Double

*Quoting with 'single' vs "double" quotes makes a difference.*

#### Rules of Quotes:
- Quotes are not always necessary for Shell variable values, but BASH requires quotes for values in tests (`if`, `for`, `while`, etc)
- Variables do not ***work*** (call their values) in 'single quotes', but they ***work*** in "double quotes".
- Anything in "double quotes" will be stored as a string, even "true" and "false".
- If a value can be used as a boolean value, Shell can use it for tests (`if`, `for`, `while`, etc)
- If a value can be used as an integer, Shell can use it for arithmetic, regardless of whether it was stored with "double" or 'single' quotes or without quotes.
- Any value with spaces must be stored using quotes, either 'single' or "double".

Example of 'single' & "double" quotes in declaring variable values:

*Edit this script to see the short version*

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

*Run it and watch carefully*

| **2** : `./varquote`


### III. Boolean Values

Example of boolean values and quotes:

*Edit this script to see the short version*

| **3** : `gedit varbool`

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

*Run it and watch carefully*

| **4** : `./varbool`

*Case and point: quotes make no difference in how a value is treated, even boolean.*

### IV. Arithmetic

*Examples of integer values and quotes...*

*Edit this script to see the short version*

| **5** : `gedit varmath`

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
echo "First... all numbers as integers..."
echo "No quote variables..."
echo "1 + 2 =  $(expr $_1 + $_2)"
echo "4 x 7 =  $(expr $_4 \* $_7)"
echo "9 - 3 =  $(expr $_9 - $_3)"
echo "10 / 2 = $(expr $_10 / $_2)"
echo "Single quote variables..."
echo "1 + 2 =  $(expr $s1 + $s2)"
echo "4 x 7 =  $(expr $s4 \* $s7)"
echo "9 - 3 =  $(expr $s9 - $s3)"
echo "10 / 2 = $(expr $s10 / $s2)"
echo "Double quote variables..."
echo "1 + 2 =  $(expr $d1 + $d2)"
echo "4 x 7 =  $(expr $d4 \* $d7)"
echo "9 - 3 =  $(expr $d9 - $d3)"
echo "10 / 2 = $(expr $d10 / $d2)"

# Below, Shell will figure out that the values of 5, 6, and 8 are strings, not integers, and thus report an error:
echo "
And now... \"five\", \"six\", and \"eight\" as strings, not integers..."
echo "No quote variables..."
echo "eight - 3 = $(expr $_8 - $_3)"
echo "five \* six = $(expr $_5 \* $_6)"
echo "Single quote variables..."
echo "eight - 3 = $(expr $s8 - $s3)"
echo "five \* six = $(expr $s5 \* $s6)"
echo "Double quote variables..."
echo "eight - 3 = $(expr $d8 - $d3)"
echo "five \* six = $(expr $d5 \* $d6)"
```

*Run it and watch carefully*

| **6** : `./varmath`

*Case and point: quotes make no difference in how a value is treated, even in arithmetic.*

___

# The Take

- Variables must be stored as any of many different "data types"
- Some basic data types include:
  - string
  - integer
  - float
  - array
  - boolean
    - A "boolean" is only `true` or `false` (`1` and `0` respective ***in other languages, not Shell***)
    - Review `exit` codes (which are different) in [VIP/Shell 301 – Lesson 6](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)
- Shell stores all variables as a "string" type
- BASH, of course, also allows the "array" type for arrays (duh)
- Shell and BASH adapt to whatever specific data type a variable may be used for
  - *This means worrying less about data types in Shell & BASH*
  - *This is one of the strongest arguments for learning Shell/BASH before any other language*
- 'Single' and "double" quotes allow a string to contain spaces
- 'Single' quotes often take characters more literally, making them not "work", such as
  - `*`
  - `$`
  - `!`
  - and others, but it depends on the situation
- The difference between 'single' and "double" quotes applies to many programming languages
- 'Single' or "double" quotes will not change how a variable is stored in Shell & BASH, ***except whether to include spaces in a string***, but this may not apply to other languages

___

#### [Lesson 7: More with while & sed](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-07.md)
