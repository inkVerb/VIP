# Shell 301
## Lesson 3: for VAR in WUT do done

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `for VAR in WUT; do`

one*

| **1** : `ls one*`

| **2** : `gedit 03-do-echo-1`

| **3** : `./03-do-echo-1`

one-1*

| **4** : `ls one-1*`

| **5** : `gedit 03-do-echo-2`

| **6** : `./03-do-echo-2`

*.one

| **7** : `ls *.one`

| **8** : `gedit 03-do-echo-3`

*Note `do` is on the same line as `for` via `;`*

| **9** : `./03-do-echo-3`

*t.one

| **10** : `ls *t.one`

| **11** : `gedit 03-do-echo-4`

| **12** : `./03-do-echo-4`

3.*

| **13** : `ls 3.*`

| **14** : `gedit 03-do-echo-5`

| **15** : `./03-do-echo-5`

\*3*

| **16** : `ls *3*`

| **17** : `gedit 03-do-echo-6`

| **18** : `./03-do-echo-6`

\*one* "is a file."

| **19** : `ls *one*`

| **20** : `gedit 03-do-echo-7`

| **21** : `./03-do-echo-7`

### II. Replacing within Variables

*Note `${VAR%foo}bar` will replace "foo" with "bar" if it appears in the variable*

*.one %one

| **22** : `gedit 03-do-echo-8`

| **23** : `./03-do-echo-8`

*t.one %t.one

| **24** : `gedit 03-do-echo-9`

| **25** : `./03-do-echo-9`

| **26** : `ls`

### III. Renaming Multiple Files at Once

| **27** : `gedit 03-do-mv-1`

| **28** : `./03-do-mv-1`

| **29** : `ls`

| **30** : `gedit 03-do-mv-2`

| **31** : `./03-do-mv-2`

| **32** : `ls`

| **33** : `gedit 03-do-mv-3`

| **34** : `./03-do-mv-3`

| **35** : `ls`

*Make a backup of today's work*

| **36** : `mkdir -p 03-THREE`

| **37** : `mv *THREE* 03-THREE/`

*Delete*

| **38** : `gedit 03-do-rm`

| **39** : `./03-do-rm`

*Ignore the directory error because we want to keep that directory*

| **40** : `ls`

### IV. Applied: `odt2txt`

*Now, use `odt2txt` in a `for` `...` `do` loop*

| **41** : `gedit 03-do-odt2txt-1`

| **42** : `./03-do-odt2txt-1`

| **43** : `ls`

| **44** : `gedit ODT-*.txt`

*Note the files are either empty or on one line because we used `echo`*, this method didn't work*

| **45** : `gedit 03-do-odt2txt-2`

| **46** : `./03-do-odt2txt-2`

*gedit: Reload both .txt files*

| **47** : `gedit 03-do-odt2txt-3`

| **48** : `./03-do-odt2txt-3`

*gedit: Reload both .txt files*

*Backup today's work*

| **49** : `mv ODT-*.txt 03-THREE/`

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
  - `for` `VARIABLE` `in` `CONDITIONS`
- See usage and examples here: [Tests: for](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#iii-for-variabl-in-wut)

## Replacement within variables
- `${VAR%foo}bar` will change the variable $VARfoo to retrieve the value of $VARbar instead
  - This can be useful to:
    1. Set a variable that may be unknown within the script
    2. Call a known variable based on arguments or a settings file, etc
- See usage and examples here: [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 4: while & until](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-04.md)
