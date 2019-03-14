# Shell 101
## Lesson 9: find

`cd ~/School/VIP/shell/101`

___

| **1** : `mkdir abc abc-dir`

| **2** : `ls`

*Search for files with* `find`

| **3** : `find "abc*"`

*Note the error message*

| **4** : `find . "abc"`

*Note it found everything, it needs:* `-name`

| **5** : `find . -name "abc"`

| **6** : `find . -name "abc*"`

*...for "Directories":* `-d`

| **7** : `find . -type d -name "abc*"`

*...for "Files":* `-f`

| **8** : `find . -type f -name "abc*"`

| **9** : `touch abcsed.Setting`

| **10** : `touch ink.png ink.PNG ink.jpg ink.JPG`

| **11** : `mkdir png PNG jpg JPG`

| **12** : `find . -name "png"`

| **13** : `find . -name "*.png"`

| **14** : `find . -name "*png"`

*Note* `find` *is case-sensitive, ignore case with:* `-iname`

| **15** : `find . -iname "*png"`

| **16** : `find . -iname "*jpg"`

| **17** : `find . -type f -iname "*png"`

| **18** : `find . -type d -iname "*png"`

___

# The Take

-

___

#### [Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-10.md)
