# Shell 301
## Lesson 3: for Var in Lst do done

Ready the CLI

```console
cd ~/School/VIP/301
```

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

*Quick prep first: Make symlinks of this lesson's scripts in the directory we will use*

*Note, we aren't in our usual place; we are here: `~/School/VIP/301/one`*

| **1** :$ *Make sure you include that period at the end!*

```console
ln -sfn ~/School/VIP/301/03-* .
```

### I. `for Var in Lst; do`

```sh
for Var in Some_List
do
  ...do something, maybe with $Var
done
```

...This runs many times, every time `$Var` is something different

one*

| **2** :$

```console
gedit 03-do-echo-1
```

| **3** :$

```console
ls one*
```

| **4** :$

```console
./03-do-echo-1
```

one-1*

| **5** :$

```console
gedit 03-do-echo-2
```

| **6** :$

```console
ls one-1*
```

| **7** :$

```console
./03-do-echo-2
```

*.one

| **8** :$

```console
gedit 03-do-echo-3
```

| **9** :$

```console
ls *.one
```

*Note `do` is on the same line as `for` via `;`*

| **10** :$

```console
./03-do-echo-3
```

*t.one

| **11** :$

```console
gedit 03-do-echo-4
```

| **12** :$

```console
ls *t.one
```

| **13** :$

```console
./03-do-echo-4
```

3.*

| **14** :$

```console
gedit 03-do-echo-5
```

| **15** :$

```console
ls 3.*
```

| **16** :$

```console
./03-do-echo-5
```

\*3*

| **17** :$

```console
gedit 03-do-echo-6
```

| **18** :$

```console
ls *3*
```

| **19** :$

```console
./03-do-echo-6
```

\*one* "is a file."

| **20** :$

```console
gedit 03-do-echo-7
```

| **21** :$

```console
ls *one*
```

| **22** :$

```console
./03-do-echo-7
```

**iteration** - *Each loop "cycle" is often called an "iteration"*

### II. `break` & `continue`

#### *Usually, `break` & `continue` are wrapped in an `if` test*

#### `break` will "break out" of a loop

*Note the error message: bash knows `break` is used by `for`...*

| **23** :$

```console
break
```

*Note the two `echo` commands and where the `break` applies...*

| **24** :$

```console
gedit 03-do-echo-8
```

| **25** :$

```console
ls one-*
```

| **26** :$

```console
./03-do-echo-8
```

#### `continue` will skip whatever is left in a loop iteration and "continue" on to the next iteration

*Note the error message: bash knows `continue` is used by `for`...*

| **27** :$

```console
continue
```

*Note the two `echo` commands and where the `continue` applies...*

| **28** :$

```console
gedit 03-do-echo-9
```

| **29** :$

```console
ls one-*
```

| **30** :$

```console
./03-do-echo-9
```

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
- A loop "cycle" is often called an "iteration"
- See usage and examples here: [Tests: for](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iii-for-variabl-in-lst)

##  `break` & `continue`
- `break` will end the loop (usually in an `if` test)
- `continue` will skip to the next loop cycle, doing nothing else (usually in an `if` test)
- Both of these can also be used in `until` and `while` loops (covered later)
- See usage and examples here: [Tests: for – continue & break](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#continue--break)

___

#### [Lesson 4: for Applied](https://github.com/inkVerb/vip/blob/master/301/Lesson-04.md)
