# Shell 301
## Lesson 4: for Applied

`cd ~/School/VIP/shell/301/one`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

*Quick prep first: Make symlinks of this lesson's scripts in the directory we will use*

*Note, we aren't in our usual place; we are here: `~/School/VIP/shell/301/one`*

| **1** : `ln -sfn ~/School/VIP/shell/301/04-* .` *Make sure you include that period at the end!*

### I. Replacing within Variables

*Note `${VAR%foo}bar` will delete "foo", then append "bar" (like find-replace), if "foo" appears in the variable*

*.one %one

| **2** : `gedit 04-echo-rename-1`

| **3** : `ls *.one`

| **4** : `./04-echo-rename-1`

| **5** : `ls`

*t.one %t.one

| **6** : `gedit 04-echo-rename-2`

| **7** : `ls *t.one`

| **8** : `./04-echo-rename-2`

| **9** : `ls`

### II. Renaming Multiple Files at Once

*t.one --> *T-ONE

| **10** : `gedit 04-do-mv-1`

| **11** : `ls *t.one`

| **12** : `./04-do-mv-1`

| **13** : `ls`

*T-ONE --> *t.one

| **14** : `gedit 04-do-mv-2`

| **15** : `ls *T-ONE`

| **16** : `./04-do-mv-2`

| **17** : `ls`

*t.one --> *t.THREE

| **18** : `gedit 04-do-mv-3`

| **19** : `ls *t.one`

| **20** : `./04-do-mv-3`

| **21** : `ls`

*Make a backup of today's work*

| **22** : `mkdir -p 04-THREE`

| **23** : `cp *THREE* 04-THREE/` *(Don't mind the directory error)*

*Delete*

| **24** : `gedit 04-do-rm`

| **25** : `./04-do-rm` *(Don't mind the directory error)*

*Don't mind the directory error because we want to keep that directory anyway*

| **26** : `ls`

### III. Applied: `odt2txt`

*Now, use `odt2txt` in a `for` `...` `do` loop*

| **27** : `rm ODT*.txt` *(start with a clean slate, just to be sure)*

| **28** : `ls *.txt *.odt`

*Note there are only .odt files*

| **29** : `gedit 04-do-odt2txt-1`

| **30** : `./04-do-odt2txt-1`

| **31** : `ls *.txt *.odt`

*Note the new .txt files, have a look inside...*

| **32** : `gedit ODT*.txt`

*Note the files are either empty or on one line because we used `echo`, this method isn't best*

| **33** : `gedit 04-do-odt2txt-2`

| **34** : `./04-do-odt2txt-2`

*gedit: Reload all .txt files*

| **35** : `gedit 04-do-odt2txt-3`

| **36** : `./04-do-odt2txt-3`

*gedit: Reload all .txt files*

*Backup today's work*

| **37** : `mv ODT*.txt 04-THREE/`

| **38** : `ls *.txt`

*...See all gone*

___

# The Take

## Replacement within variables
- `${VAR%foo}` will remove "foo" from the value of variable $VAR
- `${VAR%foo}bar` will remove "foo", then add "bar" to the end the value of variable $VAR
  - This can be useful to:
    1. Change a string quickly inside a script
    2. Call a known variable based on arguments or a settings file, etc
- See usage and examples here: [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 5: while, until & case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
