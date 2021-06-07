# Shell 301
## Lesson 1: if then fi, else & elif

Ready the CLI

`cd ~/School/VIP/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `if`

```sh
if [ Test ]
then
  ...do something
fi
```

Test for an existing *file* by name

| **1** :$ `gedit 01-if-file`

| **2** :$ `./01-if-file`

*Note it says "Yes." because "nothing" technically exists*

| **3** :$ `./01-if-file myfile`

*Note it says nothing because the file "myfile" does not exist*

| **4** :$ `ls`

| **5** :$ `touch myfile`

| **6** :$ `ls`

| **7** :$ `./01-if-file myfile`

*Note the response because the file "myfile" exists*

Test for an existing *directory* by name

| **8** :$ `gedit 01-if-dir`

| **9** :$ `./01-if-dir mydir`

| **10** :$ `mkdir mydir`

| **11** :$ `ls`

| **12** :$ `./01-if-dir mydir`

| **13** :$ `./01-if-file otherfile`

| **14** :$ `./01-if-dir otherdir`

*Note `-d` will return false for a file of the same name*

*This also happens for `-f` testing a directory*

*So, `-d` tests only an existing directory, `-f` tests only an existing file*

| **15** :$ `./01-if-file mydir`

| **16** :$ `./01-if-dir myfile`

### II. `else`

```sh
if [ Test ]
then
  ...do something
else
  ...do another thing
fi
```

| **17** :$ `gedit 01-if-else-file`

| **18** :$ `./01-if-else-file myfile`

| **19** :$ `./01-if-else-file otherfile`

| **20** :$ `gedit 01-if-else-dir`

| **21** :$ `./01-if-else-dir mydir`

| **22** :$ `./01-if-else-dir otherdir`

| **23** :$ `gedit 01-if-else-e`

*Note `-e` checks whether something exists, whether as a file, directory, or link*

| **24** :$ `./01-if-else-e myfile`

| **25** :$ `./01-if-else-e otherfile`

| **26** :$ `./01-if-else-e mydir`

| **27** :$ `./01-if-else-e otherdir`

### III. `elif`

```sh
if [ Test ]
then
  ...do something
elif [ Another Test ]
  ...do another thing
else
  ...do another another thing
fi
```

| **28** :$ `gedit 01-if-elif`

*Note `-z` checks whether a variable is empty (not set)*

| **29** :$ `./01-if-elif`

| **30** :$ `./01-if-elif yoyo`

| **31** :$ `./01-if-elif iamhere`

| **32** :$ `./01-if-elif mydir`

| **33** :$ `./01-if-elif`

### IV. `;` & Whitespace

```sh
if [ Test ]; then
  ...do something
fi
```

This is standard practice for `if` and many other logic statements

| **34** :$ `gedit 01-style`

*Note `;` means "new line of logic" and whitespace at the beginning of lines is ignored*

| **35** :$ `./01-style`

| **36** :$ `./01-style yoyo`

| **37** :$ `./01-style urtheir`

| **38** :$ `gedit 01-minimum`

| **39** :$ `./01-minimum`

| **40** :$ `./01-minimum yoyo`

| **41** :$ `./01-minimum greatagain`

### V. `if` Commands

```sh
if some command succeeds; then
  ...do something
fi

if ! some command fails; then
  ...do something
fi
```

The command runs; if it succeeds, the test answers true

| **42** :$ `gedit markdown.md`

*Note the contents of markdown.md*

| **43** :$ `grep "markdown" markdown.md`

*Show the last exit status (`0` = `true`; `1`, `2`, `3`... = `false`)*

| **44** :$ `echo $?` (`0` because something was found, `if` = `true`)

| **45** :$ `grep "Markdown" markdown.md`

| **46** :$ `echo $?` (`1` because nothing was found, `if` = `false`)

*Only "markdown", not "Markdown"*

| **47** :$ `gedit 01-ifcomm1`

| **48** :$ `./01-ifcomm1`

*Use `grep -q` for no output, only `true`/`false` (`0` or `1`, `2`, `3`...)...*

| **49** :$ `grep -q "markdown" markdown.md`

| **50** :$ `echo $?`

| **51** :$ `grep -q "Markdown" markdown.md`

| **52** :$ `echo $?`

*Use `if !` to reverse the response of a command...*

| **53** :$ `gedit 01-ifcomm2`

| **54** :$ `./01-ifcomm2`

*This works with any command...*

| **55** :$ `gedit 01-ifcomm3`

| **56** :$ `./01-ifcomm3`

___

# The Take

- Shell scripts use logic tests

## `if` (a logical test)
- Procedure of an `if` test:
  - `if` opens the test
  - `then` runs if the test returns `true`
  - `elif` runs another test if the previous test returns `false` (optional)
  - `else` runs if all previous tests return `false` (optional)
  - `fi` closes the test
- Character tests:
  - `-f` tests whether a file exists
  - `-d` tests whether a directory exists
  - `-e` tests whether a something exists at all, file, directory, or even link
  - `-z` tests whether a variable is empty
  - `-n` tests whether a variable is not empty *(not used in this lesson)*
- `;` makes a "logical line break" without putting code on a new line
  - Standard practice uses `;` to combine the first two lines in many logic statements
- Syntax of a standard `if` line:
  - `if [ Conditions To Be Tested ]; then`
## `if` Commands
- `if` can also work with a command
  - The command executes as normal
  - If the command exits with success, the `if` test returns `true`
  - Syntax: `if some command here; then`
- `echo $?` shows the `true`/`false` exit status of the last command
  - `0` = `true`
  - `1`, `2`, `3`... = `false`
  - This is how `if` performs tests
- See usage and examples here: [Tests: if](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#ii-if-then-else--elif-fi)
___

#### [Lesson 2: Docs & Pausing (odt2txt, pandoc, sleep, read & wait)](https://github.com/inkVerb/vip/blob/master/301/Lesson-02.md)
