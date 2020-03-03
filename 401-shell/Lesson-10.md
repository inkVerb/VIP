# Shell 401
## Lesson 10: Dynamics of Functions

Ready the CLI

`cd ~/School/VIP/shell/401`

___

### 5 Rules of Functions:
1. Functions ***MIGHT NOT*** work in Shell ***before 2018***...
  - **On 32 bit Linux machines**, functions only work in BASH, ***NOT*** Shell.
  - **On 64 bit Linux machines**, (most 2018 & later), functions work in ***BOTH*** BASH ***AND*** Shell.
2. Functions must be declared before called.
3. Functions take arguments.
4. Variables in functions can be either:
  - `global` (for the entire script)
  - `local` (for the function only)
5. Functions don't `exit`; they `return`, but `exit` & `return` codes are the same
  - If a `return` code is not set, the last executed command's `exit` status will be used instead
  - `$?` is the variable for the last `return` or `exit` code

### I. Argument & `return`

#### First, playtime with `exit` codes & `$?`

| **1** : `ls`

*It worked, so the `exit` code should be `0`*

| **2** : `echo $?`

*List a non-existent directory*

| **3** : `ls nothere`

*That doesn't exist, so it would return a fail, usually `2`*

| **4** : `echo $?`

*Try a command that doesn't exist*

| **5** : `nocom`

*Bigger fail, bigger number*

| **6** : `echo $?`

*Good old-fashioned `true`/`false` as commands, again...*

| **7** : `true`

| **8** : `echo $?`

| **9** : `false`

| **10** : `echo $?`

#### Watch `return` codes function in functions

*Edit this script to see the short version*

| **11** : `gedit functionreturns`

*It should look like this:*

| **functionreturns** :

| **12** :
```bash
#!/bin/bash

# Create a simple echo function
echofunction() {
echo "First function"
}

# Call the simple echo function
echo "Running echofunction..."
echofunction


# Show the "return" code
echo "Return code: $?"

# Create a multi-return code function
# This will "return" the first argument of the function
returnfunction() {
return $1
}

# Call the multi-return code function as "1"
echo "Running returnfunction 1..."
returnfunction 1

# Show the "return" code
echo "Return code: $?"

# Call the multi-return code function as "2"
echo "Running returnfunction 2..."
returnfunction 2

# Show the "return" code
echo "Return code: $?"

# Call the multi-return code function as "3"
echo "Running returnfunction 3..."
returnfunction 3

# Show the "return" code
echo "Return code: $?"

# Call the multi-return code function as "apples"
echo "Running returnfunction apples..."
returnfunction apples

# Show the "return" code
echo "Return code: $?"
```

*Run it and watch carefully*

| **13** : `./functionreturns`

*Note:*
1. *The `return` code takes arguments and is called via `$?`, just like `exit`*
2. *Functions take arguments, like `$1`, `$2`, etc*

### II. Variables as `local` & Functions Declared First

*Edit this script to see the short version*

| **14** : `gedit functionlocal`

*It should look like this:*

| **functionlocal** :

```bash
#!/bin/bash

# Create the function (nothing happens yet)
varfunction() {
local VarA="apricots"
VarB="berries"

echo "function VarA = $VarA"
echo "function VarB = $VarB"
}

# Set the global variables
VarA="apples"
VarB="bananas"

# echo the global variables
echo "script VarA = $VarA"
echo "script VarB = $VarB"

# Call the function
# VarA sets "local"
# VarB sets "global"
varfunction

# echo the global variables again to see what changed
echo "script VarA = $VarA"
echo "script VarB = $VarB"
```

*Run it and watch carefully*

| **15** : `./functionlocal`

*Note that the function changed the value of VarB "globally", but VarA only "locally" inside the function*

___

# The Take

- Remember the *5 Rules of Functions*
1. Functions only work in BASH, not Shell
2. Functions ***in scripts*** must be declared (defined) before they are called
  - This is not true in other "compiles" programs, only scripts because scripts are processed in order while compiled programs are run by the computer all at once
  - Understanding this, that scripts are processed "in order" helps to understand what a "script" is among programming languages
3. Functions take arguments; `$1`, `$2`, etc work within the function
4. Variables in functions can be `local` or `global`
  - `global` is the default
  - Examples:
    - `local Variable=value`
    - `global Variable=value`
5. `exit` & `return`
  - `$?` is the variable for the last `exit` or `return` code
  - Terminal commands have `exit` codes
  - BASH functions have `return` codes
  - `exit` & `return` code numbers mean the same things
  - If undeclared, `return` inherits the code of the last `exit` in the function

___

#### [Lesson 11: RegEx Character Classes & Heredocs](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md)
