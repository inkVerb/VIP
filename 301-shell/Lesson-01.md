# Shell 301
## Lesson 1: if then fi, else & elif

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `if`

Test for an existing *file* by name

`gedit 01-if-file`

`./01-if-file`

*Note it says "Yes." because "nothing" technically exists*

`./01-if-file myfile`

*Note it says nothing because "myfile" does not exist*

`ls`

`touch myfile`

`ls`

`./01-if-file myfile`

*Note the response because the file exists*

Test for an existing *directory* by name

`gedit 01-if-dir`

`./01-if-dir mydir`

`mkdir mydir`

`ls`

`./01-if-dir mydir`

`./01-if-file otherfile`

`./01-if-dir otherdir`

*Note* `-d` *will return false for a file of the same name*

*This also happens for* `-f` *testing a directory*

*So,* `-d` *tests only an existing directory,* `-f` *tests only an existing file*

`./01-if-file mydir`

`./01-if-dir myfile`

### II. `else`

`gedit 01-if-else-file`

`./01-if-else-file myfile`

`./01-if-else-file otherfile`

`gedit 01-if-else-dir`

`./01-if-else-dir mydir`

`./01-if-else-dir otherdir`

`gedit 01-if-else-e`

`./01-if-else-e myfile`

`./01-if-else-e otherfile`

`./01-if-else-e mydir`

`./01-if-else-e otherdir`

### III. `elif`

`gedit 01-if-elif`

`./01-if-elif`

`./01-if-elif yoyo`

`./01-if-elif iamhere`

`./01-if-elif mydir`

`./01-if-elif`

### IV. `;` & Whitespace

`gedit 01-lines`

*Note* `;` *means "new line of logic" and whitespace at the beginning of lines is ignored*

`./01-lines`

`./01-lines yoyo`

`./01-lines urtheir`

`gedit 01-line`

`./01-line`

`./01-line yoyo`

`./01-line greatagain`

#### [Lesson 2: odt2txt, rename, sleep & read](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-02.md)
