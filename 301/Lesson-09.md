# Shell 301
## Lesson 9: Arithmetic

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. Basic Math `expr`

| **1** :$

```console
expr 5 + 6
```

| **2** :$

```console
expr 12 - 1
```

| **3** :$

```console
expr 7 / 2
```

*Note it only answers in whole numbers*

*Modulus gives only the remainder*

| **4** :$

```console
expr 7 % 2
```

*Look, the asterisk must be escaped because all by itself an asterisk "means something"*

| **5** :$

```console
expr 7 \* 2
```

| **6** :$

```console
expr 7 \* 13
```

| **7** :$

```console
gedit 09-expr
```

| **8** :$

```console
./09-expr 2 + 72
```

| **9** :$

```console
./09-expr 55 - 7
```

| **10** :$

```console
./09-expr 88 / 11
```

| **11** :$

```console
./09-expr 14 \* 2
```

| **12** :$

```console
./09-expr 7 % 2
```

| **13** :$

```console
gedit 09-expr-show
```

| **14** :$

```console
./09-expr-show 55 + 1
```

| **15** :$

```console
./09-expr-show 20 \* 3
```

| **16** :$

```console
./09-expr-show 22 % 3
```

### II. Comparison Operators

#### A. `-eq -ne -gt -lt -ge -le`

| **17** :$

```console
gedit 09-operators
```

| **18** :$

```console
./09-operators 4 eq 4
```

| **19** :$

```console
./09-operators 4 eq 7
```

| **20** :$

```console
./09-operators 4 ne 4
```

| **21** :$

```console
./09-operators 4 ne 7
```

| **22** :$

```console
./09-operators 8 gt 9
```

| **23** :$

```console
./09-operators 9 gt 8
```

| **24** :$

```console
./09-operators 8 lt 9
```

| **25** :$

```console
./09-operators 9 lt 8
```

| **26** :$

```console
./09-operators 10 ge 23
```

| **27** :$

```console
./09-operators 23 ge 10
```

| **28** :$

```console
./09-operators 10 le 23
```

| **29** :$

```console
./09-operators 23 le 10
```

| **30** :$

```console
./09-operators 3.14 gt 15
```

*Oops, it only works with whole numbers*

*But, it works with negative numbers*

| **31** :$

```console
./09-operators 5 ne -5
```

| **32** :$

```console
./09-operators -5 ne -5
```

#### B. Substitute the `$Variable`

| **33** :$

```console
gedit 09-operators-subvar
```

| **34** :$

```console
./09-operators-subvar 12 lt 12
```

| **35** :$

```console
./09-operators-subvar 12 lt 13
```

#### C. `== != > < >= <=` (BASH `#!/bin/bash`)

| **36** :$

```console
gedit 09-operators-symbol
```

*Note at the top: `#!/bin/bash`*

*These symbols require BASH. Nemo, we're not in Shellfish anymore...*

| **37** :$

```console
./09-operators-symbol 12 eq 12
```

| **38** :$

```console
./09-operators-symbol 12 eq 13
```

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

#### [Lesson 10: BASH Variable Variables & Arrays](https://github.com/inkVerb/vip/blob/master/301/Lesson-10.md)
