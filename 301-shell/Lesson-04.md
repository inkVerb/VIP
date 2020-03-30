# Shell 301
## Lesson 4: for Applied

Ready the CLI

`cd ~/School/VIP/shell/301/one`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

*Quick prep first: Make symlinks of this lesson's scripts in the directory we will use*

*Note, we aren't in our usual place; we are here: `~/School/VIP/shell/301/one`*

| **1** : `ln -sfn ~/School/VIP/shell/301/04-* .` *Make sure you include that period at the end!*

### I. Replacing within Variables

*Note `${var%foo}bar` will delete "foo", then append "bar" (like find-replace), if "foo" appears in the variable*

| **2** : `gedit 04-var-form-1`

| **3** : `./04-var-form-1 GOOfood`

| **4** : `gedit 04-var-form-2`

| **5** : `./04-var-form-2 GOOfood`

| **6** : `gedit 04-var-form-3`

| **7** : `./04-var-form-3 GOOfood`

*`$Variable` is the same as `${Variable}`, but `${Variable}` can do more...*

| **8** : `gedit 04-var-form-4`

| **9** : `./04-var-form-4 GOOfood`

| **10** : `./04-var-form-4 foodGOO`

*Note `%` only removes from the end of a value*

| **11** : `gedit 04-var-form-5`

| **12** : `./04-var-form-5 GOOfood`

*.one %one

| **13** : `gedit 04-echo-rename-1`

| **14** : `ls *.one`

| **15** : `./04-echo-rename-1`

*t.one %t.one

| **16** : `gedit 04-echo-rename-2`

| **17** : `ls *t.one`

| **18** : `./04-echo-rename-2`

| **19** : `ls`

### II. Renaming Multiple Files at Once

*t.one --> *T-ONE

| **20** : `gedit 04-do-mv-1`

| **21** : `ls *t.one`

| **22** : `./04-do-mv-1`

| **23** : `ls`

*T-ONE --> *t.one

| **24** : `gedit 04-do-mv-2`

| **25** : `ls *T-ONE`

| **26** : `./04-do-mv-2`

| **27** : `ls`

*t.one --> *t.THREE

| **28** : `gedit 04-do-mv-3`

| **29** : `ls *t.one`

| **30** : `./04-do-mv-3`

| **31** : `ls`

*Make a backup of today's work*

| **32** : `mkdir -p 04-FOR`

| **33** : `cp *THREE* 04-FOR/`

*Delete*

| **34** : `gedit 04-do-rm`

| **35** : `./04-do-rm`

*Don't mind the directory error because we want to keep that directory anyway*

| **36** : `ls`

### III. Applied: `odt2txt`

*Now, use `odt2txt` in a `for` `...` `do` loop*

| **37** : `rm ODT*.txt` *(Start with a clean slate, just to be sure)*

| **38** : `ls *.txt *.odt`

*Note there are only .odt files*

| **39** : `gedit 04-do-odt2txt`

| **40** : `./04-do-odt2txt`

| **41** : `ls *.txt && ls *.odt`

*Note the new .txt files, have a look inside...*

| **42** : `gedit ODT*.txt`

*Backup today's work*

| **43** : `mv *.txt 04-FOR/`

| **44** : `ls *.txt`

*...See all gone*

___

# The Take

## `for` has useful application
- It can list items and modify them
- It can rename, move, or delete files
- It can modify or do complex processes on many files
- It does many things in a short time and with a single command

## Replacement within variables
- `${Var%foo}` will remove "foo" from the value of variable `$Var`
- `${Var%foo}bar` will remove "foo", then add "bar" to the end the value of variable `$Var`
  - This can be useful to:
    1. Change a string quickly inside a script
    2. Call a known variable based on arguments or a settings file, etc
- See usage and examples here: [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 5: while, until & case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
