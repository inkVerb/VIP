# Linux 301
## Lesson 7: Multiple Tests, Count-Loops, source & Functions

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### Combining tests

```sh
if [ Test is true ] && [ Test this ]... ;fi

if [ Test is false ] || [ Test this ]... ;fi
```

**...BUT it does NOT need to be in a test...**

```sh
command success && run this command also...

command failure || run this command also...
```

### I. Combined commands

*Whatch the flow...*

| **1** :$

```console
ls && echo yes
```

| **2** :$

```console
ls bozo && echo yes
```

| **3** :$

```console
ls || echo no
```

| **4** :$

```console
ls bozo || echo no
```

### II. Combined `&&` (AND) `||` (OR) tests

```sh
if [ "$1" = "one" ] || [ "$1" = "two" ]; then

if [ "$2" = "two" ] && [ "$1" = "one" ]; then
```

| **5** :$

```console
gedit 07-or-if
```

| **6** :$

```console
./07-or-if one
```

| **7** :$

```console
./07-or-if two
```

| **8** :$

```console
./07-or-if three
```

| **9** :$

```console
./07-or-if one two
```

| **10** :$

```console
./07-or-if two one
```

*Note, you can make more complex tests with `(`parentheses`)` for order of operations*

```sh
if [ "$1" = "one" ] || ([ "$1" = "one" ] && [ "$2" = "two" ]); then

if [ "$1" = "one" ] || (([ "$1" = "skip" ] && [ "$2" = "two" ]) && [ -z "$3" ]) ; then
```

*We don't demonstrate those here, but the logic is plain and works with complex statements*

### III. Read number and count

| **11** :$

```console
gedit 07-while-count-read
```

| **12** :$ *Enter nothing, then letters, then negative numbers, then nothing*

```console
./07-while-count-read
```

| **13** :$ *Enter a high number, such as 9001*

```console
./07-while-count-read
```

### IV. source `.`

```bash
. file/to/include
```

| **14** :$

```console
gedit 07-source 07-sourced 07-sourced-also
```

| **15** :$

```console
ls -l 07-source*
```

*Note the file "07-source" is executable, but "07-sourced" is not*

*And "07-sourced" has no `#!/bin/bash` declaration*

| **16** :$

```console
./07-source
```

*Uncomment lines 24 & 27 and run it again*

| **17** :$

```console
./07-source
```

*It can be good practice to include the shebang-BASH (`#!/bin/bash`) in any "included" files so they are easier to see in text editors*

### V. `function()`

#### 4 Rules of a function:
1. Script inside a script
2. Arguments work (`$1`, `$2`, etc)
3. `local Var="Value"` (function-only variables)
4. Define first, call later

```bash
# Define (create):
newFunctionName() {
# Script here, eg:
local Variable="apple pie"
echo "$1 and $Variable"
}

# Call (use):
newFunctionName Lemmons
```

| **18** :$

```console
gedit 07-function
```

*Note functions work with `#!/bin/sh` on the first line, but also work with `#!/bin/bash`*

| **19** :$

```console
./07-function
```

| **20** :$

```console
gedit 07-function-breakdown
```

*Note a few things before we continue...*
___
> 1. Create a function...
>
> `functionName() {`
>
> 2. Put your code between the `{`curlies`}` *usually starting on a new line*
>
> 3. Arguments like `$1` and `$2` and all their friends work just the same within the function
>
> 4. You may create a variable that only exists inside the function with this:
>
> `local` `myVariable=Saucy`
>
> 6. Do something...
>
> `echo "VIP Linux tutorials are $myVariable!"`
>
> 7. `}` Close the function
>
> 8. Then, call the function with its name...
>
> `functionName`
___

*Let's get back to work...*

| **21** :$

```console
./07-function-breakdown
```

#### Once set, a variable works inside and outside of a function, unless it is `local` inside a function

*Let's get a little more involved with variables...*

| **22** :$

```console
gedit 07-function-variables
```

*Note the global variables and the local-function variables and what is set/used inside/outside the function*

| **23** :$

```console
./07-function-variables ONe TWo
```

| **24** :$

```console
./07-function-variables pine apple
```

___

# The Take

## Combining tests
- `while` can be used to count up to a given number, producing output at each count
- `while` can be used to repeatedly request the human user input a response until the response is accepted
- `&&` and `||` combine tests
  - `&&` means "and": the test after is run if the previous test answers `true`
  - `||` means "or": the test after is run if the previous test answers `false`
  - `(`parentheses`)` can denote order of operations in complex tests
    - Many layers of `(`parentheses`)` are allowed

## Sourcing
- Files can be invluded via `source` or a period `.`
- Variables can be declared in "sourced" (included) files

## Functions
- A "function" is like a small script inside the script
- A function uses parentheses as `function()` when the function is defined
- A function does not use parentheses when called, only the name, such as `function`
- A function uses variables and arguments
- Function variables can be set as:
  - global: `Variable="value"` *(default, normal)*
  - local: `local Variable=value`
  - **Once set, a variable works inside and outside of a function, unless it is `local` inside a function**
- Function variable syntax:
  - `global Variable="value"` *(optional)*
  - `local Variable="value"`
___

#### [Lesson 8: date & pwgen](https://github.com/inkVerb/vip/blob/master/301/Lesson-08.md)
