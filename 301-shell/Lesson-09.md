# Shell 301
## Lesson 9: Arithmetic

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `${#VARIABLE}`

| **1** : `gedit 09-count`

| **2** : `./09-count five`

| **3** : `./09-count six`

### II. Basic Math `expr`

| **4** : `expr 5 + 6`

| **5** : `expr 12 - 1`

| **6** : `expr 7 / 2`

*Note it only answers in whole numbers*

*Modulus gives only the remainder*

| **7** : `expr 7 % 2`

*Look, the asterisk must be cancelled because all by itself an asterisk "means something"*

| **8** : `expr 7 \* 2`

| **9** : `expr 7 \* 13` (But, `expr` doesn't know the answer is "28".)

| **10** : `gedit 09-expr`

| **11** : `./09-expr 2 + 72`

| **12** : `./09-expr 55 - 7`

| **13** : `./09-expr 88 / 11`

| **14** : `./09-expr 14 \* 2`

| **15** : `./09-expr 7 % 2`

| **16** : `gedit 09-expr-show`

| **17** : `./09-expr-show 55 + 1`

| **18** : `./09-expr-show 20 \* 3`

| **19** : `./09-expr-show 22 % 3`

### III. Comparison Operators

#### A. `-eq -ne -gt -lt -ge -le`

| **20** : `gedit 09-operators`

| **21** : `./09-operators 4 4 eq`

| **22** : `./09-operators 4 7 eq`

| **23** : `./09-operators 4 4 ne`

| **24** : `./09-operators 4 7 ne`

| **25** : `./09-operators 8 9 gt`

| **26** : `./09-operators 9 8 gt`

| **27** : `./09-operators 8 9 lt`

| **28** : `./09-operators 9 8 lt`

| **29** : `./09-operators 10 23 ge`

| **30** : `./09-operators 10 23 ge`

| **31** : `./09-operators 10 23 le`

| **32** : `./09-operators 10 23 le`

| **33** : `./09-operators 3.14 15 gt`

*Oops, it only works with whole numbers*

*But, it works with negative numbers*

| **34** : `./09-operators 5 -5 ne`

| **35** : `./09-operators -5 -5 ne`

#### B. Substitute the `$VARIABLE`

| **36** : `gedit 09-operators-subvar`

| **37** : `./09-operators-subvar 12 12 lt`

| **38** : `./09-operators-subvar 12 13 lt`

#### C. `== != > < >= <=` (BASH)

| **39** : `gedit 09-operators-symbol`

*Note at the top:* `#!/bin/bash`

*These symbols require BASH. Nemo, we're not in Shellfish anymore...*

| **40** : `./09-operators-symbol 12 12 eq`

| **41** : `./09-operators-symbol 12 13 eq`

___

# The Take

- `expr` runs basic arithmetic
- Arithmetic "operates" are mostly conventional: `+` `-` `/`
- The "times" symbol is `\*` because `*` is a wildcard symbol and needs `\`
- `%` "modulus" refers to the remainder after dividing in whold numbers
- Tests can do number comparisons
  - `-eq` "equal to"
  - `-ne` "not equal to"
  - `-gt` "greater than"
  - `-lt` "less than"
  - `-ge` "greater than or equal to"
  - `-le` "less than or equal to"
- Shell does not allow "operators", only flags
- Comparison "operators" require BASH
  - `==` "equal to"
  - `!=` "not equal to"
  - `>` "greater than"
  - `<` "less than"
  - `>=` "greater than or equal to"
  - `<=` "less than or equal to"
- See usage and examples here: [Tests: Comparison](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#comparison)

___

#### [Lesson 10: BASH Variable Variables & Arrays](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-10.md)
