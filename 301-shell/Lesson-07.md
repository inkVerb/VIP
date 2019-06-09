# Shell 301
## Lesson 7: Functions, source & Combining Tests

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. Read a max number and count

| **1** : `gedit 07-while-count-read`

| **2** : `./07-while-count-read` *Enter nothing, then enter letters, then enter nothing*

| **3** : `./07-while-count-read` *Enter a high number, such as 9001*

### II. Read files & types, then check

| **4** : `gedit 07-create`

| **5** : `./07-create`

| **6** : `ls`

| **7** : `gedit 07-check`

*Note `&&` means "AND" `||` means "OR"*

| **8** : `./07-check`

*Run `07-check` many times, consider these:*

Files: `1.z` `2.z` `3.z` `4.z` `5.z` `6.z` `7.z` `8.z` `9.z` `0.z`

Dirs: `1-Z` `2-Z` `3-Z` `4-Z` `5-Z` `6-Z` `7-Z` `8-Z` `9-Z` `0-Z`

Links: `1.l` `2.l` `3.l` `4.l` `5.l` `6.l` `7.l` `8.l` `9.l` `0.l`

*These will be added*

### III. source `.`

| **9** : `gedit 07-source 07-sourced`

| **10** : `ls -l 07-source*`

*Note the file "07-source" is executable, but "07-sourced" is not*

*And "07-sourced" has no `#!/bin/bash` declaration*

| **11** : `./07-source`

*Uncomment lines 24 & 27 and run it again*

| **12** : `./07-source`

*It can be good practice to include the shebang-BASH (`#!/bin/bash`) in any "included" files so they are easier to see in text editors*

### IV. `function()`

1. A function is like a script inside a script.
2. It even takes `$1`, `$2`, etc arguments that run inside the script.

| **13** : `gedit 7-function`

*Note functions work with `#!/bin/sh` on the first line, but also work with `#!/bin/bash`*

| **14** : `./7-function`

| **15** : `gedit 7-function-breakdown`

*Note a few things before we continue...*
___
> 1. Create the function:
>
> `functionName() {`
>
> 2. Put your code between the curlies *starting on a new line*.
>
> 3. Arguments like `$1` and `$2` and all their friends work just the same within the function.
>
> 4. Create a variable that only exists inside the function with this:
>
> `local` `myVariable=Saucy`
>
> 6. Make sure you do something...
>
> `echo "VIP Linux tutorials are $myVariable!"`
>
> 7. `}` And close the function
>
> 8. Then, call the function with its name...
>
> `functionName`
___

*Let's get back to work...*

| **16** : `./7-function-breakdown`

*Let's get a little more involved with variables...*

| **17** : `gedit 7-function-variables`

*Note the three global variables and the two local-function variables*

| **18** : `./7-function-variables ONe TWo THRee`

| **19** : `./7-function-variables pine apple pen`

___

# The Take

## Combining tests
- `while` can be used to count up to a given number, producing output at each count
- `while` can be used to repeatedly request the human user input a response until the response is accepted
- `&&` and `||` combine tests
  - `&&` means "and": the test after is run if the previous test answers `true`
  - `||` means "or": the test after is run if the previous test answers `false`

## Sourcing
- Files can be invluded via `source` or a period `.`
- Variables can be declared in "sourced" (included) files

## Functions
- A "function" is like a small script inside the script
- A function uses parentheses as `function()` when the function is defined
- A function does not use parentheses when called, only the name, such as `function`
- A function uses variables and arguments
- Function variables can be set as:
  - `global` (default)*
  - `local`
- Function variable syntax:
  - `global variable="value"` (optional)*
  - `local variable="value"`
___

#### [Lesson 8: date & pwgen](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-08.md)
