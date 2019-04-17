# Shell 301
## Lesson 5: case

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `case`

| **1** : `gedit 05-case-numlett`

| **2** : `./05-case-numlett 1`

| **3** : `./05-case-numlett 2`

| **4** : `./05-case-numlett 3`

| **5** : `./05-case-numlett a`

| **6** : `./05-case-numlett b`

| **7** : `./05-case-numlett c`

| **8** : `gedit 05-case-options`

| **9** : `./05-case-options`

*Input any of the following: a, b, f, g, v, z, and others, finally "quit"*

| **10** : `gedit 05-case-chat`

| **11** : `./05-case-chat one two three`

*Input any of the following: verb, ink, hi, yoyo, byebye, done, one, two, three, and others, finally "quit"*

| **12** : `./05-case-chat apple pineapple pen`

*Input any of the same, also the following: apple, pineapple, pen, finally "quit"*

### II. `case` with `y/n`

| **13** : `gedit 05-case-yn`

| **14** : `./05-case-yn`

*Run it multiple times with: y, n, Y, N, Yes, No, yes, no, YES, NO, yES, nO, yeS, yEs, and other answers*

### III. `case` `y/n` & `exit 1`

| **15** : `gedit 05-case-yn-loop`

*Note `exit 1` will produce* STDOUT *to `1>` but `exit 0` has no output just as `2>` is from an unwritten `exit 2` event*

| **16** : `./05-case-yn-loop`

*Input "wrong" answers to see it loop*

___

# The Take

## `case` (multiple scripts for each of multiple conditions)
- `case` runs any of many mini-scripts based on the value of a variable
- `case` is useful to
  1. Fit different scenarios in a `while`/`until` loop
  2. Respond appropriately to a `read` dialog with the human user
  3. Adapt to custom flag arguments (or more in-depth with BASH using `getopts`, later lessons)
  4. Do the job of a long `if`-`elif` test series without being as complex
  5. Work based on a variable's value set earlier in the script
- *Note One common way to organize a `case` scenario is for each "case" to simply set a variable as `true`, then process that variable based on an `if` test later in the script. This makes scripts longer, but the `case` index is easier to read. This is seen in the cheat-sheet [Tests: case](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#vii-case-esac) under the "Lazy case" method example*
- Procedure of a `case` index:
  - `case` defines the variable to be matched
  - `in` opens the case index of possible value matches
  - `value)` what to do if the case variable has this value (as many as needed)
  - `value)` what to do if the case variable has this value (as many as needed)
  - `value)` what to do if the case variable has this value (as many as needed)
  - `*)` what to do if the case variable doesn't match any above case
  - `esac` closes the case index
- Syntax of the `while` line:
  - `case` `$VARIABLE_BEING_MATCHED`
- See usage and examples here: [Tests: case](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#vii-case-esac)

___

#### [Lesson 6: exit & journalctl](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-06.md)
