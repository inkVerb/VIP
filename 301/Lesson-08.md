# Shell 301
## Lesson 8: date & pwgen

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

___

### I. `date`

| **1** :$

```console
date
```

*Different format*

| **2** :$

```console
date +%c
```

*MM/DD/YY*

| **3** :$

```console
date +%D
```

*YYYY-MM-DD*

| **4** :$

```console
date +%F
```

*HH:mm:SS (Note MM is a two-digit month)*

| **5** :$

```console
date +%T
```

*YYYY*

| **6** :$

```console
date +%Y
```

*Mon*

| **7** :$

```console
date +%b
```

*Month*

| **8** :$

```console
date +%B
```

*MM*

| **9** :$

```console
date +%m
```

*DD*

| **10** :$

```console
date +%d
```

*Dy*

| **11** :$

```console
date +%a
```

*Day*

| **12** :$

```console
date +%A
```

*HH*

| **13** :$

```console
date +%H
```

*mm (minute)*

| **14** :$

```console
date +%M
```

*SS (seconds)*

| **15** :$

```console
date +%S
```

*Nifty combos*

| **16** :$

```console
date +%Y_%m_%d_%T
```

| **17** :$

```console
date +%Y/%m/%d_%T
```

| **18** :$

```console
date +%Y/%m/%d_%H:%M:%S
```

| **19** :$

```console
date +%Y-%m-%d.%H-%M-%S
```

### II. `pwgen`

| **20** :$

```console
pwgen
```

*Only 1 character set `-1`*

| **21** :$

```console
pwgen -1
```

*36 characters long `36`*

| **22** :$

```console
pwgen -1 36
```

*Include at least 1 special character `-y`*

| **23** :$

```console
pwgen -1 10 -y
```

*No numerals `-0`*

| **24** :$

```console
pwgen -1 10 -0
```

*No caps `-A`*

| **25** :$

```console
pwgen -1 10 -A
```

*Combine options into one*

| **26** :$

```console
pwgen -A01y 10
```

### III. `pwgen` + `date` is useful

| **27** :$

```console
echo $(date +%Y-%m-%d_%H-%M-%S)_$(pwgen -1 9)
```

| **28** :$

```console
gedit 08-date-name
```

*See your new mad skills with `date` and `pwgen` at work in this script...*

| **29** :$

```console
./08-date-name yoyo
```

*Let's see what we just made...*

| **30** :$

```console
ls yoyo*
```

___

# The Take

## `date`
- `date` outputs information about time ranging from year to seconds
- `date` options
  - all options begin with `+`
  - each option begins with `%`
  - other characters may be included as a means of formatting the output
- Syntax: `date +Options`
- See usage and examples here: [Resources & Things That Run: journalctl & logger](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#vii-date)

## `pwgen`
- `pwgen` is often used to create random sets of characters (AKA passwords)
- `pwgen` outputs many passwords by default, `-1` (number 'one') will output only one password
- `pwgen` has many options
  - number of characters (use numeral digits to declare the amount of characters, no flag needed)
  - whether to include special characters
  - whether to include capital letters
  - whether to include numerals
- See usage and examples here: [Resources & Things That Run: journalctl & logger](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#viii-pwgen)

___

#### [Lesson 9: Arithmetic](https://github.com/inkVerb/vip/blob/master/301/Lesson-09.md)
