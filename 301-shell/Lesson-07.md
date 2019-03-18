# Shell 301
## Lesson 7: Combo && || Include

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. Read a max number and count

| **1** : `gedit 07-while-count-read`

| **2** : `./07-while-count-read`

*Enter nothing, then enter letters, then enter nothing*

| **3** : `./07-while-count-read`

*Enter a high number, such as 9001*

### II. Read files & types, then check

| **4** : `gedit 07-create`

| **5** : `./07-create`

| **6** : `ls`

| **7** : `gedit 07-check`

*Note* `&&` *means "AND"* `||` *means "OR"*

| **8** : `./07-check`

*Run* `07-check` *many times, consider these:*

Files: `1.z` `2.z` `3.z` `4.z` `5.z` `6.z` `7.z` `8.z` `9.z` `0.z`

Dirs: `1-Z` `2-Z` `3-Z` `4-Z` `5-Z` `6-Z` `7-Z` `8-Z` `9-Z` `0-Z`

Links: `1.l` `2.l` `3.l` `4.l` `5.l` `6.l` `7.l` `8.l` `9.l` `0.l`

*These will be added*

### III. Include `.`

| **9** : `gedit 07-include 07-included`

| **10** : `ls -l 07-include*`

*Note "07-include" is executable, but "07-included" is not*

*And "07-included" has no* `#!/bin/sh` *declaration*

| **11** : `./07-include`

*Uncomment the line with* `. ~/School/VIP/shell/301/07-included` *and run it again*

| **12** : `./07-include`

*It can be good practice to include the shebang* (`#!/bin/sh`) *in any "included" files for formatting purposes*

___

# The Take

- `while` can be used to count up to a given number, producing output at each count
- `while` can be used to repeatedly request the human user input a response until the response is accepted
- `&&` and `||` combine tests
  - `&&` means "and": the test after is run if the previous test answers `true`
  - `||` means "or": the test after is run if the previous test answers `false`
- Files can be invluded via `source` or a period `.`
- Variables can be declared in "included" files

___

#### [Lesson 8: date & pwgen](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-08.md)
