# Shell 301
## Lesson 3: for VAR in WUT do done

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `for VAR in WUT; do`

one*

`ls one*`

`gedit 03-do-echo-1`

`./03-do-echo-1`

one-1*

`ls one-1*`

`gedit 03-do-echo-2`

`./03-do-echo-2`

*.one

`ls *.one`

`gedit 03-do-echo-3`

*Note* `do` *is on the same line as* `for` *via* `;`

`./03-do-echo-3`

*t.one

`ls *t.one`

`gedit 03-do-echo-4`

`./03-do-echo-4`

3.*

`ls 3.*`

`gedit 03-do-echo-5`

`./03-do-echo-5`

\*3*

`ls *3*`

`gedit 03-do-echo-6`

`./03-do-echo-6`

\*one* "is a file."

`ls *one*`

`gedit 03-do-echo-7`

`./03-do-echo-7`

### II. Replacing within Variables

*Note* `${VAR%foo}bar` *will replace "foo" with "bar" if it appears in the variable*

*.one %one

`gedit 03-do-echo-8`

`./03-do-echo-8`

*t.one %t.one

`gedit 03-do-echo-9`

`./03-do-echo-9`

`ls`

### III. Renaming Multiple Files at Once

`gedit 03-do-mv-1`

`./03-do-mv-1`

`ls`

`gedit 03-do-mv-2`

`./03-do-mv-2`

`ls`

`gedit 03-do-mv-3`

`./03-do-mv-3`

`ls`

*Make a backup of today's work*

`mkdir -p 03-THREE`

`mv *THREE* 03-THREE/`

*Delete*

`gedit 03-do-rm`

`./03-do-rm`

*Ignore the directory error because we want to keep that directory*

`ls`

### IV. Applied: `odt2txt`

*Now, use* `odt2txt` *in a* `for` `...` `do` *loop*

`gedit 03-do-odt2txt-1`

`./03-do-odt2txt-1`

`ls`

`gedit ODT-*.txt`

*Note the files are either empty or on one line because we used* `echo`*, this method didn't work*

`gedit 03-do-odt2txt-2`

`./03-do-odt2txt-2`

*gedit: Reload both .txt files*

`gedit 03-do-odt2txt-3`

`./03-do-odt2txt-3`

*gedit: Reload both .txt files*

*Backup today's work*

`mv ODT-*.txt 03-THREE/`

#### [Lesson 4: while & until](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-04.md)
