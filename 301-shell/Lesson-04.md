# Shell 301
## Lesson 4: for Applied

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. Replacing within Variables

*Note `${VAR%foo}bar` will replace "foo" with "bar" if it appears in the variable*

*.one %one

| **1** : `gedit 04-echo-rename-1`

| **2** : `./04-echo-rename-1`

*t.one %t.one

| **3** : `gedit 04-echo-rename-2`

| **4** : `./04-echo-rename-2`

| **5** : `ls`

### II. Renaming Multiple Files at Once

| **6** : `gedit 04-do-mv-1`

| **7** : `./04-do-mv-1`

| **8** : `ls`

| **9** : `gedit 04-do-mv-2`

| **10** : `./04-do-mv-2`

| **11** : `ls`

| **12** : `gedit 04-do-mv-3`

| **13** : `./04-do-mv-3`

| **14** : `ls`

*Make a backup of today's work*

| **15** : `mkdir -p 04-THREE`

| **16** : `mv *THREE* 04-THREE/`

*Delete*

| **17** : `gedit 04-do-rm`

| **18** : `./04-do-rm`

*Ignore the directory error because we want to keep that directory*

| **19** : `ls`

### III. Applied: `odt2txt`

*Now, use `odt2txt` in a `for` `...` `do` loop*

| **20** : `gedit 04-do-odt2txt-1`

| **21** : `./04-do-odt2txt-1`

| **22** : `ls`

| **23** : `gedit ODT-*.txt`

*Note the files are either empty or on one line because we used `echo`*, this method didn't work*

| **24** : `gedit 04-do-odt2txt-2`

| **25** : `./04-do-odt2txt-2`

*gedit: Reload both .txt files*

| **26** : `gedit 04-do-odt2txt-3`

| **27** : `./04-do-odt2txt-3`

*gedit: Reload both .txt files*

*Backup today's work*

| **28** : `mv ODT-*.txt 04-THREE/`

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
