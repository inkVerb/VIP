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

*Note `${VAR%foo}bar` will replace "foo" with "bar" if it appears in the variable*

*.one %one

| **2** : `ls *.one`

| **3** : `gedit 04-echo-rename-1`

| **4** : `./04-echo-rename-1`

*t.one %t.one

| **5** : `ls *t.one`

| **6** : `gedit 04-echo-rename-2`

| **7** : `./04-echo-rename-2`

### II. Renaming Multiple Files at Once

*t.one --> *T-ONE

| **8** : `ls`

| **9** : `gedit 04-do-mv-1`

| **10** : `./04-do-mv-1`

| **11** : `ls`

*T-ONE --> *t.one

| **12** : `gedit 04-do-mv-2`

| **13** : `./04-do-mv-2`

| **14** : `ls`

*t.one --> *t.THREE

| **15** : `gedit 04-do-mv-3`

| **16** : `./04-do-mv-3`

| **17** : `ls`

*Make a backup of today's work*

| **18** : `mkdir -p 04-THREE`

| **19** : `cp *THREE* 04-THREE/`

*Delete*

| **20** : `gedit 04-do-rm`

| **21** : `./04-do-rm`

*Don't mind the directory error because we want to keep that directory anyway*

| **22** : `ls`

### III. Applied: `odt2txt`

*Now, use `odt2txt` in a `for` `...` `do` loop*

| **23** : `gedit 04-do-odt2txt-1`

| **24** : `./04-do-odt2txt-1`

| **25** : `ls`

| **26** : `gedit ODT-*.txt`

*Note the files are either empty or on one line because we used `echo`*, this method didn't work*

| **27** : `gedit 04-do-odt2txt-2`

| **28** : `./04-do-odt2txt-2`

*gedit: Reload both .txt files*

| **29** : `gedit 04-do-odt2txt-3`

| **30** : `./04-do-odt2txt-3`

*gedit: Reload both .txt files*

*Backup today's work*

| **31** : `mv ODT-*.txt 04-THREE/`

| **32** : `ls`

*...See all gone*

___

# The Take

## Replacement within variables
- `${VAR%foo}bar` will change the variable $VARfoo to retrieve the value of $VARbar instead
  - This can be useful to:
    1. Set a variable that may be unknown within the script
    2. Call a known variable based on arguments or a settings file, etc
- See usage and examples here: [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
___

#### [Lesson 5: while, until & case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
