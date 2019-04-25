# Shell 401
## Lesson 10: Dynamics of Functions

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


### I. Argument & `return`

*Edit this script*

| **1** : `gedit functionreturns`

*It should look like this:*

| **2** :
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

| **3** : `./functionreturns`

*Note:*
1. *The `return` code takes arguments and is called via `$?`, just like `exit`*
2. *Functions take arguments, like `$1`, `$2`, etc*

### II. Variables as `local` & Functions Declared First

*Edit this script*

| **4** : `gedit functionlocal`

*It should look like this:*

```bash
#!/bin/bash

# Create the function (nothing happens yet)
varfunction() {
local VARa="apricots"
VARb="berries"

echo "function VARa = $VARa"
echo "function VARb = $VARb"
}

# Set the global variables
VARa="apples"
VARb="bananas"

# echo the global variables
echo "script VARa = $VARa"
echo "script VARb = $VARb"

# Call the function
# VARa sets "local"
# VARb sets "global"
varfunction

# echo the global variables again to see what changed
echo "script VARa = $VARa"
echo "script VARb = $VARb"
```

*Run it and watch carefully*

| **5** : `./functionlocal`

*Note that the function changed the value of VARb "globally", but VARa only "locally" inside the function*

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
    - `local VARIABLE=value`
    - `global VARIABLE=value`
5. `exit` & `return`
  - Terminal commands have `exit` codes
  - BASH functions have `return` codes
  - `exit` & `return` code numbers mean the same things
  - If undeclared, `return` inherits the code of the last `exit` in the function

___

#### [Lesson 11: Characters Classes & Heredocs](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md)
