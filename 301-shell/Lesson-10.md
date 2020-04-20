# Shell 301
## Lesson 10: BASH Variable Variables & Arrays

Ready the CLI

`cd ~/School/VIP/301`

- [Arrays](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Arrays.md)
- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

## Welcome to BASH
## SH: Bourne Shell `#!/bin/sh`
## BASH: Bourne Again Shell `#!/bin/bash`

Nemo, we're not in Shellfish anymore... *(Hehe, see what I did there?)*

Some things can only be done in BASH

### Variable Variables

| **1** : `gedit 10-varvar`

| **2** : `./10-varvar abcyoume`

*Take a good look and try to see how that makes sense; it can be VERY useful!*

### Arrays

| **3** : `gedit 10-array`

| **4** : `./10-array`

*Note @ means all elements (BASH thinks of them as separate values)*

*Note * does the same thing as @ (BASH thinks it is one, long value)*

| **5** : `gedit 10-array-index-id`

| **6** : `./10-array-index-id 1`

| **7** : `./10-array-index-id 0`

*Note the first element's index key ID is 0*

| **8** : `gedit 10-array-associative`

*Note `declare -A ARRAYNAME` precedes*

| **9** : `./10-array-associative i`

| **10** : `./10-array-associative ii`

| **11** : `./10-array-associative iii`

| **12** : `./10-array-associative iv`

| **13** : `./10-array-associative v`

*Note*
  - *There are two ways to define the elements of the associative array*
  - *Array keys are case-sensitive*

| **14** : `./10-array-associative i III`

| **15** : `./10-array-associative i II`

| **16** : `./10-array-associative i I`

| **17** : `./10-array-associative iv IV`

| **18** : `./10-array-associative iii V`

| **19** : `gedit 10-array-associative-declare`

| **20** : `./10-array-associative-declare`

*Tip: Uncomment the `#declare` lines (5 & 13) to `declare` and see that it works...*

| **21** : `./10-array-associative-declare`

___
# Rules of BASH Arrays
## Rule 1: An array *can't* go inside an array (no 3-D)
## Rule 2: Declare associative arrays first `declare -A ArrayName`
## Rule 3: Choose associative or auto-indexed
EITHER
### associative: `MyArray=([key]=frst [ky2]=sec) ... MyArray[key] MyArray[ky2]` (The key can be what you want)

```sh
MyArray=([key]=frst [ky2]=sec)
echo ${MyArray[key]}
echo ${MyArray[ky2]}

````
OR
### auto-indexed: `MyArray=(one two) ... MyArray[0] MyArray[1]`
```sh
MyArray=(one two)
echo ${MyArray[0]}
echo ${MyArray[1]}
```

NOT BOTH

___

| **22** : `gedit 10-array-keys`

| **23** : `./10-array-keys`

*Note that associative arrays don't necessarily keep a predictable order*

| **24** : `gedit 10-array-strings`

| **25** : `./10-array-strings`

*Note quoted strings are allowed as elements*

| **26** : `gedit 10-array-associative-strings`

| **27** : `./10-array-associative-strings`

*Note associative arrays can have strings as elements too*

### Array as list in `for` loop

| **28** : `gedit 10-array-for`

*Note `${myArray[*]}` means "all values"*

| **29** : `./10-array-for`

*Let's use an associative array to further illustrate*

| **30** : `gedit 10-array-for-associative`

*Note `${myArray[@]}` also means "all values"*

| **31** : `./10-array-for-associative`

___

# The Take

- An "array" is a variable with multiple values
- Arrays only work in "BASH" (`#!/bin/bash`), not the "Bourne shell" (`#!/bin/sh`)
- Each value is called with an index "key", which is a sequential number unless declared otherwise
- The default array key numbers begin with `0` for the first value
- An "associative" array has customized keys, which are not numbers
- An associative array must be declared *before* it's values and keys are declared
  - The array can be declared while empty using `declare -A Array_Name` or
  - The array can be declared with values, later replacing the values with associated keys
- Syntax:
  - `arrayName=(value0 value1 value2)` declares the array and its values
  - `${arrayName[1]}` calls the second value, "value1"
  - `arrayName[3]=value3` sets the fourth value as "value3"
  - `declare -A arrayName` declares an empty array (usually before associative declarations)
  - `arrayName[KeyA]=valueForA` sets the key and its value, if the array has already been declared
  - `${arrayName[@]}` returns all array values
  - `${arrayName[*]}` returns all array values
- Arrays can be used as lists in `for` loops
___

#### [Lesson 11: BASH select & dialog](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-11.md)
