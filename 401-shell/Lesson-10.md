# Shell 401
## Lesson 10: Using functions

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

### Rules of functions:
1. Functions only work in BASH, not Shell.
2. Functions must be declared before called.
3. Functions take arguments.
4. Variables in functions can be either:
- `global` (for the entire script)
- `local` (for the function only)
5. Functions don't `exit`; they `return`, but `exit` & `return` codes are the same
6. If a `return` code is not set, the last executed command's `exit` status will be used instead

*Consider this script:*

`gedit functionreturns`

*It looks like this:*

```bash
#!/bin/sh

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

```

*Run the script and watch closely*

`./functionreturns`

*Note:*
1. *The `return` code takes arguments and is called via `$?`, just like `exit`*
2. *Functions take arguments, like `$1`, `$2`, etc*


## Under Construction

In functions, parameters are looped: `funct one two three` will loop if only $1 is used in the function.

Function variabless: local

#### [Lesson 11: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md)
