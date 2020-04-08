# Shell 301
## Lesson 3: for VAR in LST do done

Ready the CLI

`cd ~/School/VIP/shell/301/one`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

*Quick prep first: Make symlinks of this lesson's scripts in the directory we will use*

*Note, we aren't in our usual place; we are here: `~/School/VIP/shell/301/one`*

| **1** : `ln -sfn ~/School/VIP/shell/301/03-* .` *Make sure you include that period at the end!*

### I. `for Var in Lst; do`

```sh
for Var in Some_List
do
  ...do something, maybe with $Var
done
```

...This runs many times, every time `$Var` is something different

one*

| **2** : `gedit 03-do-echo-1`

| **3** : `ls one*`

| **4** : `./03-do-echo-1`

one-1*

| **5** : `gedit 03-do-echo-2`

| **6** : `ls one-1*`

| **7** : `./03-do-echo-2`

*.one

| **8** : `gedit 03-do-echo-3`

| **9** : `ls *.one`

*Note `do` is on the same line as `for` via `;`*

| **10** : `./03-do-echo-3`

*t.one

| **11** : `gedit 03-do-echo-4`

| **12** : `ls *t.one`

| **13** : `./03-do-echo-4`

3.*

| **14** : `gedit 03-do-echo-5`

| **15** : `ls 3.*`

| **16** : `./03-do-echo-5`

\*3*

| **17** : `gedit 03-do-echo-6`

| **18** : `ls *3*`

| **19** : `./03-do-echo-6`

\*one* "is a file."

| **20** : `gedit 03-do-echo-7`

| **21** : `ls *one*`

| **22** : `./03-do-echo-7`

### II. `break` & `continue`

#### *Usually, `break` & `continue` are wrapped in an `if` test*

#### `break` will "break out" a loop

*Note the error message: bash knows `break` is used by `for`...*

| **23** : `break`

*Note the two `echo` commands and where the `break` applies...*

| **24** : `gedit 03-do-echo-8`

| **25** : `ls one-*`

| **26** : `./03-do-echo-8`

#### `continue` will skip whatever is left in a loop cycle and "continue" on to the next cycle

*Note the error message: bash knows `continue` is used by `for`...*

| **27** : `continue`

*Note the two `echo` commands and where the `continue` applies...*

| **28** : `gedit 03-do-echo-9`

| **29** : `ls one-*`

| **30** : `./03-do-echo-9`

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
- Syntax of the `for` line:
  - `for` `Variable` `in` `List`
  - (each item will sequentially be assigned as the value of `$Variable`)
- See usage and examples here: [Tests: for](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iii-for-variabl-in-lst)

##  `break` & `continue`
- `break` will end the loop (usually in an `if` test)
- `continue` will skip to the next loop cycle, doing nothing else (usually in an `if` test)
- Both of these can also be used in `until` and `while` loops (covered later)
- See usage and examples here: [Tests: for – continue & break](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#continue--break)

___

#### [Lesson 4: for Applied](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-04.md)
