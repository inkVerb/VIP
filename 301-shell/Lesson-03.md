# Shell 301
## Lesson 3: for VAR in WUT do done

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `for VAR in WUT; do`

one*

| **1** : `ls one*`

| **2** : `gedit 03-do-echo-1`

| **3** : `./03-do-echo-1`

one-1*

| **4** : `ls one-1*`

| **5** : `gedit 03-do-echo-2`

| **6** : `./03-do-echo-2`

*.one

| **7** : `ls *.one`

| **8** : `gedit 03-do-echo-3`

*Note `do` is on the same line as `for` via `;`*

| **9** : `./03-do-echo-3`

*t.one

| **10** : `ls *t.one`

| **11** : `gedit 03-do-echo-4`

| **12** : `./03-do-echo-4`

3.*

| **13** : `ls 3.*`

| **14** : `gedit 03-do-echo-5`

| **15** : `./03-do-echo-5`

\*3*

| **16** : `ls *3*`

| **17** : `gedit 03-do-echo-6`

| **18** : `./03-do-echo-6`

\*one* "is a file."

| **19** : `ls *one*`

| **20** : `gedit 03-do-echo-7`

| **21** : `./03-do-echo-7`

### II. `break` & `continue`

#### *Usually, `break` & `continue` are wrapped in an `if` test*

#### `break` will "break out" a loop

*Note the two `echo` commands and where the `break` applies...*

| **20** : `gedit 03-do-echo-8`

| **21** : `./03-do-echo-8`

#### `continue` will skip whatever is left in a loop cycle and "continue" on to the next cycle

*Note the two `echo` commands and where the `continue` applies...*

| **20** : `gedit 03-do-echo-9`

| **21** : `./03-do-echo-9`

___

# The Take

## `for` (a loop for each of many)
- `for` is a "loop", not a "test" like `if`
- `for` runs (loops) a mini-script "for" each instance of a thing
- `for` is useful to do the same or a similar thing to each of many files
- Procedure of a `for` loop:
  - `for` opens and defines the conditions
  - `do` opens the mini-script to be looped
  - `done` closes the mini-script
- `break` will end the loop (usually in an `if` test)
- `continue` will skip to the next loop cycle, doing nothing else (usually in an `if` test)
- Syntax of the `for` line:
  - `for` `VARIABLE` `in` `CONDITIONS`
- See usage and examples here: [Tests: for](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iii-for-variabl-in-wut)
___

#### [Lesson 4: ](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-04.md)
