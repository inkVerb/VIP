# Shell 301
## Lesson 5: while, until & case

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `while`

### "If the `[Test]` is `true`, `while` will `do` through `done`, then take the `[Test]` again."

**`true` = `do`**: *A `while` loop will automatically `break` once the test fails*

**`while` loop**

```sh
while [ Test_is_true ]; do
  ...doing something
done
```

| **1** :$

```console
gedit 05-while-read
```

*Note `-z` means "Zero" or "Zilch" for a variable that is empty*

| **2** :$

```console
./05-while-read
```

*Only press Enter to see what happens again and again, comply or use <kbd>Ctrl</kbd> + <kbd>C</kbd> to close*

**`while` counter loop**

```sh
count=0
while [ Test_is_true ]; do
  ...doing something
  count=$(expr ${count} + 1)
done
```

| **3** :$

```console
gedit 05-while-count
```

*Note `!` means "not"*

| **4** :$

```console
./05-while-count
```

*Let's put it together into something useful*

| **5** :$

```console
gedit 05-while-count-read
```

*Note `!` means "not"*

| **6** :$

```console
./05-while-count-read
```

### II. `until`

### "If the `[Test]` is `false`, `until` will `do` through `done`, then take the `[Test]` again."

**`false` = `do`**: *An `until` loop will will repeat as long as the test fails*

**`until` loop**

```sh
until [ Test_is_false ]; do
  ...doing something
done
```

*Do some prep first...*

| **7** :$

```console
mkdir 05-COUNT && cp 05-until-count 05-COUNT/ && cd 05-COUNT
```

**`until` counter loop**

```sh
count=0
until [ Test_is_false ]; do
  ...doing something
  count=$(expr ${count} + 1)
done
```

| **8** :$

```console
gedit 05-until-count
```

| **9** :$

```console
ls *.shell
```

| **10** :$

```console
./05-until-count 5 shell
```

| **11** :$

```console
ls *.shell
```

| **12** :$

```console
ls *.sixtn
```

| **13** :$

```console
./05-until-count 16 sixtn
```

| **14** :$

```console
ls *.sixtn
```

| **15** :$

```console
cd ..
```

| **16** :$

```console
gedit 05-until-read
```

| **17** :$

```console
./05-until-read werdup
```

*Input wrong "passwords" to see what it does, input "werdup" or use <kbd>Ctrl</kbd> + <kbd>C</kbd> to close*

| **18** :$

```console
./05-until-read thepassword
```

*Input wrong "passwords" to see what it does, input "thepassword" or use <kbd>Ctrl</kbd> + <kbd>C</kbd> to close*

### III. `case`

### "Multiple choice variable `case`"

```sh
case $Var in
  apples)
    ...do something because $Var = apples
  ;;
  berries)
    ...do something because $Var = berries
  ;;
esac
```

| **19** :$

```console
gedit 05-case-numlett
```

| **20** :$

```console
./05-case-numlett 1
```

| **21** :$

```console
./05-case-numlett 2
```

| **22** :$

```console
./05-case-numlett 3
```

| **23** :$

```console
./05-case-numlett a
```

| **24** :$

```console
./05-case-numlett b
```

*Now try something that isn't among the `case` options...*

| **25** :$

```console
./05-case-numlett d
```

| **26** :$

```console
gedit 05-case-options
```

*Note `while :` will loop without a test and only stop with a `break` or `exit`*

| **27** :$

```console
./05-case-options
```

*Input any of the following: a, b, f, g, v, z, and others; finally: quit*

| **28** :$

```console
gedit 05-case-chat
```

*Note `:` makes a `while` or `until` loop continue forever, `break` ends a loop*

| **29** :$

```console
./05-case-chat one two three
```

*Input any of the following: verb, ink, hi, yoyo, one, two, three, and others; finally: byebye, done, or quit*

| **30** :$

```console
./05-case-chat apple pineapple pen
```

*Input any of the same, also the following: apple, pineapple, pen; finally: quit*

### IV. `case` with `y/n`

```sh
case $Var in
  [yY] | [yY][eE][sS] )
    echo "Yes to $Var."
  ;;
  [nN] | [nN][oO] )
    echo "No to $Var."
  ;;
esac
```

| **31** :$

```console
gedit 05-case-yn
```

| **32** :$

```console
./05-case-yn
```

*Run it multiple times with: y, n, Y, N, Yes, No, yes, no, YES, NO, yES, nO, yeS, yEs, and other answers*

### V. `case` `y/n` & `exit 1` with `break`

```sh
case $Var in
  [yY] | [yY][eE][sS] )
    echo "Yes to $Var."
    break
  ;;
  [nN] | [nN][oO] )
    echo "No to $Var."
    exit 1
  ;;
esac
```

| **33** :$

```console
gedit 05-case-yn-loop
```

*Note `exit 1` will produce* STDOUT *to `1>` but `exit 0` has no output just as `2>` is from an unwritten `exit 2` event*

| **34** :$

```console
./05-case-yn-loop
```

*Run it multiple times as before*

*Input "wrong" answers to see it loop*

___

# The Take

- `while` & `until` loops work the same way, but with opposite tests
  - "If the `[Test]` is `true`, `while` will `do` through `done`, then take the `[Test]` again."
  - "If the `[Test]` is `false`, `until` will `do` through `done`, then take the `[Test]` again."
- `case` is a multiple choice test for variables
  - "Multiple choice, multiple `case`, a variable is anything of many things."

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
  - `while` `[ Conditions_to_be_tested ]`
  - `while :` will loop without a test until a `break` or `exit`
- See usage and examples here: [Tests: while](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iv-while-do-done)

## `until` (do something while `false` until `true`)
- `until` loops a mini-script that runs as long as a test returns `false`, until a test returns `true`
- `until` is useful to
  1. Count numbers sequentially
  2. Run a script that needs to run multiple times in order to succeed
  3. Keep trying until the "correct" response is input
- Procedure of a `until` loop:
  - `until` opens and defines the test
  - `do` opens the mini-script to be looped
  - `done` closes the mini-script
- Syntax of the `until` line:
  - `until` `[ Conditions_to_be_tested ]`
  - `until :` will loop without a test until a `break` or `exit`
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
- Syntax of the `case` line:
  - `case` `$Variable_being_matched` `in`
- Syntax of a single `case` option:
  ```
  value)
    Do Something Here
  ;;
  ```
- See usage and examples here: [Tests: case](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#vii-case-esac)

___

#### [Lesson 6: exit & journalctl](https://github.com/inkVerb/vip/blob/master/301/Lesson-06.md)
