# Shell 301
## Lesson 4: while & until

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `while`

| **1** : `gedit 04-while-read`

*Note -z means "Zero" or "Zilch" for a variable that is empty*

| **2** : `./04-while-read`

*Only press Enter to see what happens again and again, comply or use Ctrl + C to close*

| **3** : `gedit 04-while-count`

*Note ! means "not"*

| **4** : `./04-while-count`

*Let's put it together into something useful*

| **5** : `gedit 04-while-count-read`

*Note ! means "not"*

| **6** : `./04-while-count-read`

### II. `until`

*Do some prep first...*

| **7** : `mkdir 04COUNT && cp 04-until-count 04COUNT/ && cd 04COUNT`

| **8** : `gedit 04-until-count`

| **9** : `ls *.shell`

| **10** : `./04-until-count 5 shell`

| **11** : `ls *.shell`

| **12** : `ls *.sixtn`

| **13** : `./04-until-count 16 sixtn`

| **14** : `ls *.sixtn`

| **15** : `cd ..`

| **16** : `gedit 04-until-read`

| **17** : `./04-until-read werdup`

*Input wrong "passwords" to see what it does, input "werdup" or use Ctrl + C to close*

| **18** : `./04-until-read thepassword`

*Input wrong "passwords" to see what it does, input "thepassword" or use Ctrl + C to close*

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
___

#### [Lesson 5: case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
