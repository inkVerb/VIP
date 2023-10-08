# Shell 301
## Lesson 10: BASH Ternary, Variable Variables & Arrays

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Arrays](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Arrays.md)
- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

## Welcome to BASH
## SH: Bourne Shell `#!/bin/sh`
## BASH: Bourne Again Shell `#!/bin/bash`

Nemo, we're not in Shellfish anymore...

Some things can only be done in BASH

FYI, the CLI we have been using is not `#!/bin/sh`, but `#!/bin/bash`

By default, Manjaro GNOME uses `#!/bin/zsh` while Manjaro Plasma and XFCE use `#!/bin/bash`

`#!/bin/zsh` in the terminal is pretty, color-coded, and offers command completion

You can actually change which shell your terminal uses with `chsh`

# `chsh`

Use "pretty" ZSH (default with Manjaro-GNOME)

```console
chsh -s /bin/zsh
```

Use standard BASH

```console
chsh -s /bin/bash
```

Learn more: [Resources & Things That Run: chsh](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#xi-chsh)

### I. Ternary Statements

Read the Cheat-Sheet: **[Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)**

**Ternary** statements work in three parts:

```bash
[[ Test ]] && if_true || if_false
```

This is based on the logical flow of `&&` and `||`

- `[ if_true ] && this_happens`
- `[ if_false ] || this_happens`
- These can run in the terminal:
  - `true && echo "success"`
  - `false || echo "fail"`

*Note the `[[ double brackets ]]` are only allowed in BASH, not Shell, which is why we can do this*

*Many coders might argue that this BASH statement is not a genuine, true "ternary" statement, but it is very close and logically it is near-identical*

We address these more in [501-PHP: Ternary Statements](https://github.com/inkVerb/vip/blob/master/501/Lesson-01.md#ternary-statements)

```bash
[[ "$test_var" = "five" ]] && echo "yes, five" || echo "not five"

[[ -f "real_file" ]] && echo "yes, file exists" || echo "file does not exist"
```

| **1** :$

```console
gedit 10-ternary-echo
```

| **2** :$

```console
./10-ternary-echo five
```

| **3** :$

```console
./10-ternary-echo four
```

```bash
[[ "$test_var" = "five" ]] && var="yes, value five" || var="not value five"

[[ -f "real_file" ]] && var="yes, file exists" || var="file does not exist"
```

| **4** :$

```console
gedit 10-ternary-var
```

| **5** :$

```console
./10-ternary-var five
```

| **6** :$

```console
./10-ternary-var four
```

### II. `${#Variable}`

```bash
${#variable} #shows number of characters in $variable
```

| **7** :$

```console
gedit 10-count
```

| **8** :$

```console
./10-count five
```

| **9** :$

```console
./10-count six
```

### III. `${!Variable}` Variables

```bash
variable=changeme
${!variable} # Same as $changeme
```

| **10** :$

```console
gedit 10-varvar
```

| **11** :$

```console
./10-varvar abcyoume
```

*Take a good look and try to see how that makes sense; it can be VERY useful!*

### IV. Arrays

An array is basically a variable with multiple values

#### Auto-indexed (numbered keys)

```bash
NumArray=(one two)
echo ${NumArray[0]} # one
echo ${NumArray[1]} # two
```

| **12** :$

```console
gedit 10-array
```

| **13** :$

```console
./10-array
```

*Note @ means all elements (BASH thinks of them as separate values)*

*Note * does the same thing as @ (BASH thinks it is one, long value)*

| **14** :$

```console
gedit 10-array-index-id
```

| **15** :$

```console
./10-array-index-id 1
```

| **16** :$

```console
./10-array-index-id 0
```

*Note the first element's index key ID is 0*

#### Associative (with string keys)

```bash
declare -A KeyArray # must have!

# All keys
KeyArray=([key1]=value1 [key2]=value2)

echo ${KeyArray[key1]} # value1
echo ${KeyArray[key2]} # value2

# Or each key
KeyArray[key3]=value3
KeyArray[key4]=value4

echo ${KeyArray[key3]} # value3
echo ${KeyArray[key4]} # value4
```

| **17** :$

```console
gedit 10-array-associative
```

*Note `declare -A ARRAYNAME` precedes*

| **18** :$

```console
./10-array-associative i
```

| **19** :$

```console
./10-array-associative ii
```

| **20** :$

```console
./10-array-associative iii
```

| **21** :$

```console
./10-array-associative iv
```

| **22** :$

```console
./10-array-associative v
```

*Note:*
  - *There are two ways to define the elements of the associative array*
  - *Array keys are case-sensitive*

| **23** :$

```console
./10-array-associative i III
```

| **24** :$

```console
./10-array-associative i II
```

| **25** :$

```console
./10-array-associative i I
```

| **26** :$

```console
./10-array-associative iv IV
```

| **27** :$

```console
./10-array-associative iii V
```

| **28** :$

```console
gedit 10-array-associative-declare
```

| **29** :$

```console
./10-array-associative-declare
```

*Tip: Uncomment the `#declare` lines (5 & 13) to `declare` and see that it works...*

| **30** :$

```console
./10-array-associative-declare
```

___
# Rules of BASH Arrays
## Rule 1: An array *can't* go inside an array (no 3-D)
## Rule 2: Declare associative arrays first `declare -A ArrayName`
## Rule 3: Choose associative or auto-indexed

***Either***

### Associative: `MyArray=([key]=frst [ky2]=sec) ... MyArray[key] MyArray[ky2]` (The key can be what you want)

```bash
declare -A MyArray
MyArray=([key]=frst [ky2]=sec)
echo ${MyArray[key]}
echo ${MyArray[ky2]}
```

***Or***

### Auto-indexed: `MyArray=(one two) ... MyArray[0] MyArray[1]`
```bash
MyArray=(one two)
echo ${MyArray[0]}
echo ${MyArray[1]}
```

***Not both!***

___

| **31** :$

```console
gedit 10-array-keys
```

| **32** :$

```console
./10-array-keys
```

*Note that associative arrays don't necessarily keep a predictable order*

### `"`Quote spaces`"`

```bash
myArray=("Spaces in string" One_word)
echo ${myArray[0]} # Spaces in string
echo ${myArray[1]} # One_word
```

| **33** :$

```console
gedit 10-array-strings
```

| **34** :$

```console
./10-array-strings
```

*Note quoted strings are allowed as elements*

### `"`Quote spaces`"` also in associative arrays

```bash
declare -A myArray
myArray=([key1]="Spaces in string" [key2]=One_word )
echo ${myArray[key1]} # Spaces in string
echo ${myArray[key2]} # One_word
```

| **35** :$

```console
gedit 10-array-associative-strings
```

| **36** :$

```console
./10-array-associative-strings
```

*Note associative arrays can have quoted strings as elements too*

### Array as list in `for` loop

```bash
for Var in ${Array[*]}

do
echo $Var

done
```

| **37** :$

```console
gedit 10-array-for
```

*Note `${myArray[*]}` means "all values"*

| **38** :$

```console
./10-array-for
```

*Let's use an associative array to further illustrate*

| **39** :$

```console
gedit 10-array-for-associative
```

*Note `${myArray[@]}` also means "all values"*

| **40** :$

```console
./10-array-for-associative
```

___

# The Take
- A "ternary statement" works in three parts:
  - Test
  - Do if true
  - Do if false
- Shell and BASH do not have true ternary statements, but BASH allows a near-identical version
- BASH ternary syntax:
  - `[[ Test ]] && if_true || if_false`
  - `[[ $var = "one" ]] && echo "yes" || echo "no"`
  - `[[ $var = "one" ]] && new_var="yes" || new_var="no"`
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

#### [Lesson 11: BASH select & dialog](https://github.com/inkVerb/vip/blob/master/301/Lesson-11.md)
