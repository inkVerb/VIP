# Shell 101
## Lesson 9: find

`cd ~/School/VIP/shell/101`

___

| **1** : `mkdir abc abc-dir`

| **2** : `ls`

*Search for files with `find`*

| **3** : `find "abc*"`

*Note the error message*

| **4** : `find . "abc"`

*Note it found everything, it needs: `-name`*

| **5** : `find . -name "abc"`

| **6** : `find . -name "abc*"`

*...for "Directories": `-d`*

| **7** : `find . -type d -name "abc*"`

*...for "Files": `-f`*

| **8** : `find . -type f -name "abc*"`

| **9** : `touch abcsed.Setting`

| **10** : `touch ink.png ink.PNG ink.jpg ink.JPG`

| **11** : `mkdir png PNG jpg JPG`

| **12** : `find . -name "png"`

| **13** : `find . -name "*.png"`

| **14** : `find . -name "*png"`

*Note `find` is case-sensitive, ignore case with: `-iname`*

| **15** : `find . -iname "*png"`

| **16** : `find . -iname "*jpg"`

| **17** : `find . -type f -iname "*png"`

| **18** : `find . -type d -iname "*png"`

___

# The Take

- `find` searches for files
- `find` needs two arguments in order to work:
  - Location
  - `-name TEXT-TO-SEARCH-FOR`
  - Order: `find /path/to/search -name what-to-search-for`
- `*` is a "wildcard" for text
- `.` is considered text to search for, not "concatenate" as in some languages
  - `file.*` can return with "file.jpg", "file.png", and "file." (must contain a period)
  - `file*` can return with "file.jpg", "file.png", and "files.jpg" and "files" (even with no period)
  - `*.png` is a normal way to search for all PNG files
- ".png", ".jpg", ".pdf", ".doc", etc are called "(file) extensions"
- `find` is normally case-sensitive, unless using the `-iname` flag
- It may be best to name files with lowercase extensions because of how `find` works
- `find` uses `-type` flags to narrow results
  - `-type d` (directories only)
  - `-type f` (files only)

___

#### [Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-10.md)
