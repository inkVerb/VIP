# Shell 401
## Lesson 6: Data Types

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Constrcution

**Caution: Not all statements have been fact-checked**

### I. Introduction to "data types"

### Under Constrcution!!

**Caution: Not all statements have been fact-checked**

*The value of a variable can be one of many different "types of data".*

#### Data types:
- character (char, C) *- a single, one-byte character a-z, 0-9, and keyboard special characters*
- string *- any kind of raw text*
- integer (int) *- whole numbers, positive or negative*
- float *- numbers with a decimal*
- array *- a complex variable; like a mini database with a list of many values, each with a number/key for reference*
- boolean *- only `true` or `false` (many times `1` or `0` is the same thing)*
- NULL *- empty data, not set*

#### In Shell:
1. Shell automatically recognizes and sets data types, you can't. (Other languages may require that you declare the data type.)
2. Shell only uses a few data types:
- boolean (`true`/`false`)
- integer (can be used in arithmetic operations, floats/decimals can't)
- string (everything else)
- NULL (ie: after using `unset`)

*The fact that Shell only uses these three data types and automatically assigns them makes Shell a great first language!*

#### Quotes
- Values in 'single quotes', Shell will try to assign as boolean.
- If a value in 'single quotes' can't be a boolean, Shell will store the value as a string.
- Anything in "double quotes" will be stored as a string, even "true" and "false".
- If a value can be used as an integer, Shell can use it for arithmetic, regardless of whether it was stored with "double" or 'single' quotes.
- Any value with spaces must be stored using quotes, either 'single' or "double".
- 'Single' and "double" quotes can change some things, 'single' is generally stops special characters from functioning, but we don't address all that here.

### I. Boolean vs string

VAR="true"  ...sets a string
VAR="false" ...sets a string
VAR=true    ...sets a boolean value
VAR=false   ...sets a boolean value
echo $VAR

echo $VAR


TRUE FALSE IF TEST


### II. Using a boolean variable
VAR=true
$VAR && echo "Is true."
VAR=false
$VAR || echo "Is false."
VAR="true"
echo "Is $VAR."
VAR="false"
echo "Is $VAR"

-z & unset "the proper way" (VAR=$1; $VAR # Is $VAR set? # Use some arithmetic to see.) [top three answers here](https://serverfault.com/questions/7503/how-to-determine-if-a-bash-variable-is-empty)


#### [Lesson 7: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-07.md)
