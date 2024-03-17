# Linux 301
## Lesson 1: if then fi, else & elif

Ready the CLI

```console
cd ~/School/VIP/301
```

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

```sh
[ -f $1 ]
```

| **1** :$

```console
gedit 01-if-file
```

| **2** :$

```console
./01-if-file
```

*Note it says "Yes." because "nothing" technically exists*

| **3** :$

```console
./01-if-file myfile
```

*Note it says nothing because the file "`myfile`" does not exist*

| **4** :$

```console
ls
```

| **5** :$

```console
touch myfile
```

| **6** :$

```console
ls
```

| **7** :$

```console
./01-if-file myfile
```

*Note the response because the file "`myfile`" exists*

Test for an existing *directory* by name

```sh
[ -d $1 ]
```

| **8** :$

```console
gedit 01-if-dir
```

| **9** :$

```console
./01-if-dir mydir
```

| **10** :$

```console
mkdir mydir
```

| **11** :$

```console
ls
```

| **12** :$

```console
./01-if-dir mydir
```

| **13** :$

```console
./01-if-file otherfile
```

| **14** :$

```console
./01-if-dir otherdir
```

*Note `-d` will return false for a file of the same name*

*This also happens for `-f` testing a directory*

*So, `-d` tests only an existing directory, `-f` tests only an existing file*

| **15** :$

```console
./01-if-file mydir
```

| **16** :$

```console
./01-if-dir myfile
```

### II. `else`

```sh
if [ Test ]
then
  ...do something
else
  ...do another thing
fi
```

| **17** :$

```console
gedit 01-if-else-file
```

| **18** :$

```console
./01-if-else-file myfile
```

| **19** :$

```console
./01-if-else-file otherfile
```

| **20** :$

```console
gedit 01-if-else-dir
```

| **21** :$

```console
./01-if-else-dir mydir
```

| **22** :$

```console
./01-if-else-dir otherdir
```

| **23** :$

```console
gedit 01-if-else-e
```

*Note `-e` checks only whether something "exists", whether as a file, directory, or link*

```sh
[ -e $1 ]
```

| **24** :$

```console
./01-if-else-e myfile
```

| **25** :$

```console
./01-if-else-e otherfile
```

| **26** :$

```console
./01-if-else-e mydir
```

| **27** :$

```console
./01-if-else-e otherdir
```

### III. `elif`

```sh
if [ Test ]
then
  ...do something
elif [ Another Test ]
then
  ...do another thing
else
  ...do another another thing
fi
```

| **28** :$

```console
gedit 01-if-elif
```

*Note `-z` checks whether a variable is empty (not set)*

| **29** :$

```console
./01-if-elif
```

| **30** :$

```console
./01-if-elif yoyo
```

| **31** :$

```console
./01-if-elif iamhere
```

| **32** :$

```console
./01-if-elif mydir
```

| **33** :$

```console
./01-if-elif
```

### IV. `;` & Whitespace

```sh
if [ Test ]; then
  ...do something
fi
```

This is standard practice for `if` and many other logic statements

| **34** :$

```console
gedit 01-style
```

*Note `;` means "new line of logic" and **whitespace** at the beginning of lines is ignored*

```sh
if [ -z $1 ]; then

elif [ $1 = "foobar" ]; then
```

| **35** :$

```console
./01-style
```

| **36** :$

```console
./01-style yoyo
```

| **37** :$

```console
./01-style urthere
```

| **38** :$

```console
gedit 01-minimum
```

*Note the entire `if` statement can go on one line using `;`

```sh
if [ -z $1 ];then echo "Empty";elif [ $1 = "foobar" ];then echo "Foo Bar";else echo "Something else";fi
```

| **39** :$

```console
./01-minimum
```

| **40** :$

```console
./01-minimum yoyo
```

| **41** :$

```console
./01-minimum greatagain
```

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

| **42** :$

```console
gedit markdown.md
```

*Note the contents of `markdown.md`*

| **43** :$

```console
grep "markdown" markdown.md
```

*Show the last exit status (`0` = `true`; `1`, `2`, `3`... = `false`)*

| **44** :$ (`0` because something was found, `if` = `true`)

```console
echo $?
```

| **45** :$

```console
grep "Markdown" markdown.md
```

| **46** :$ (`1` because nothing was found, `if` = `false`)

```console
echo $?
```

*Only "`markdown`", not "`Markdown`"*

| **47** :$

```console
gedit 01-ifcomm1
```

```sh
if grep "foobar" somefile.txt; then
```

| **48** :$

```console
./01-ifcomm1
```

*Use `grep -q` for no output, only `true`/`false` (`0` or `1`, `2`, `3`...)...*

| **49** :$

```console
grep -q "markdown" markdown.md
```

| **50** :$

```console
echo $?
```

| **51** :$

```console
grep -q "Markdown" markdown.md
```

| **52** :$

```console
echo $?
```

*Use `if !` to reverse the response of a command...*

| **53** :$

```console
gedit 01-ifcomm2
```

```sh
if grep -q "foobar" somefile.txt; then

if ! grep -q "foobar" somefile.txt; then
```

| **54** :$

```console
./01-ifcomm2
```

*This works with any command...*

| **55** :$

```console
gedit 01-ifcomm3
```

```sh
if echo "Hello"; then

if ls somefile.txt; then

if ! ls nofile.txt; then
```

| **56** :$

```console
./01-ifcomm3
```

*You can put this inside the actual terminal...*

| **57** :$

```console
if grep -q "markdown" markdown.md; then echo "Yes: markdown"; fi
```
___

# The Take
- Shell scripts use logic tests
- **whitespace** - any extra space, including more than one continguous space, leading or trailing space on a line or string, or tabs
  - Often seen as a problem and removed by many text operations
  - A kind of metacharacter (see [Characters](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md#RegEx-Metacharacters) cheat sheet) and dealt with in RegEx ([401 Lesson 11](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md))

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
- `if` tests can be used just as they are in the reminal directly
- See usage and examples here: [Tests: if](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#ii-if-then-else--elif-fi)
___

#### [Lesson 2: Docs & Pausing (odt2txt, pandoc, sleep, read & wait)](https://github.com/inkVerb/vip/blob/master/301/Lesson-02.md)
