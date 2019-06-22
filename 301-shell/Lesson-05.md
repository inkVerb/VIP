# Shell 301
## Lesson 5: while, until & case

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `while`

| **1** : `gedit 05-while-read`

*Note -z means "Zero" or "Zilch" for a variable that is empty*

| **2** : `./05-while-read`

*Only press Enter to see what happens again and again, comply or use Ctrl + C to close*

| **3** : `gedit 05-while-count`

*Note ! means "not"*

| **4** : `./05-while-count`

*Let's put it together into something useful*

| **5** : `gedit 05-while-count-read`

*Note ! means "not"*

| **6** : `./05-while-count-read`

### II. `until`

*Do some prep first...*

| **7** : `mkdir 05-COUNT && cp 05-until-count 05-COUNT/ && cd 05-COUNT`

| **8** : `gedit 05-until-count`

| **9** : `ls *.shell`

| **10** : `./05-until-count 5 shell`

| **11** : `ls *.shell`

| **12** : `ls *.sixtn`

| **13** : `./05-until-count 16 sixtn`

| **14** : `ls *.sixtn`

| **15** : `cd ..`

| **16** : `gedit 05-until-read`

| **17** : `./05-until-read werdup`

*Input wrong "passwords" to see what it does, input "werdup" or use Ctrl + C to close*

| **18** : `./05-until-read thepassword`

*Input wrong "passwords" to see what it does, input "thepassword" or use Ctrl + C to close*

### III. `case`

| **19** : `gedit 05-case-numlett`

| **20** : `./05-case-numlett 1`

| **21** : `./05-case-numlett 2`

| **22** : `./05-case-numlett 3`

| **23** : `./05-case-numlett a`

| **24** : `./05-case-numlett b`

| **25** : `./05-case-numlett c`

| **26** : `gedit 05-case-options`

| **27** : `./05-case-options`

*Input any of the following: a, b, f, g, v, z, and others, finally "quit"*

| **28** : `gedit 05-case-chat`

| **29** : `./05-case-chat one two three`

*Input any of the following: verb, ink, hi, yoyo, byebye, done, one, two, three, and others, finally "quit"*

| **30** : `./05-case-chat apple pineapple pen`

*Input any of the same, also the following: apple, pineapple, pen, finally "quit"*

### IV. `case` with `y/n`

| **31** : `gedit 05-case-yn`

| **32** : `./05-case-yn`

*Run it multiple times with: y, n, Y, N, Yes, No, yes, no, YES, NO, yES, nO, yeS, yEs, and other answers*

### V. `case` `y/n` & `exit 1`

| **33** : `gedit 05-case-yn-loop`

*Note `exit 1` will produce* STDOUT *to `1>` but `exit 0` has no output just as `2>` is from an unwritten `exit 2` event*

| **34** : `./05-case-yn-loop`

*Input "wrong" answers to see it loop*

___

# The Take

- `while` & `until` loops work the same way, but with opposite tests

## `while` (do something while `true` until `false`)
- `while` loops a mini-script that runs as long as a test returns `true`, until a test returns `false`
- `while` is useful to
  1. Count numbers sequentially
  2. Run a script that needs to run multiple times in order to succeed
  3. Keep trying until the "correct" response is input
- Procedure of a `while` loop:
  - `while` opens and defines the test
  - `do` opens the mini-script to be looped
  - `done` closes the mini-script
- Syntax of the `while` line:
  - `while` `CONDITIONS TO BE TESTED`
- See usage and examples here: [Tests: while](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iv-while-do-done)

## `until` (do something while `false` until `true`)
- `until` loops a mini-script that runsas long as a test returns `false`, until a test returns `true`
- `until` is useful to
  1. Count numbers sequentially
  2. Run a script that needs to run multiple times in order to succeed
  3. Keep trying until the "correct" response is input
- Procedure of a `until` loop:
  - `until` opens and defines the test
  - `do` opens the mini-script to be looped
  - `done` closes the mini-script
- Syntax of the `until` line:
  - `until` `CONDITIONS TO BE TESTED`
- See usage and examples here: [Tests: until](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#v-until-do-done)

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
