# Shell 401
## Lesson 1: Returns & Terminal

`cd ~/School/VIP/shell/401`

___

### I. Carriage Returns: DOS v Unix

| **1** : `vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*No difference*

*Vim: `:q!`*

| **2** : `unix2dos text-doc.txt`

| **3** : `vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*Now* `^M` *at the end of the line, indicating a "carriage return"*

*Vim: `:q!`*

| **4** : `dos2unix text-doc.txt`

| **5** : `vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*No difference*

*Vim: `:q!`*

*Note:*
- DOS text files have "carriage returns" at the end of every line, not Unix
- Text files edited in Windows will have the DOS format, which includes carriage returns
- Carriage returns can create some problems in programming for Unix & Linux
- `dos2unix` & `unix2dos` convert text files between the DOS & Unix format

### II. Multiple lines via `\`

*Enter this in the terminal:*

| **6** :
```sh
echo "Hello there. This is all on one line."
```

*Enter this in the terminal, ONE LINE AT A TIME:*

| **7** :
```sh
echo "Hello there.\
This is a second line."
```

*Enter this in the terminal, ONE LINE AT A TIME:* (including the empty line)

| **8** :
```sh
echo "Hello there.\

This is a second line."
```

*Note the extra line resulted in a single line break*

*Consider this command:*

| **9** : `ls -l ~/School/VIP/shell/401`

*Enter the same thing, but on multiple lines:*

| **10** :
```sh
ls \
-l \
~/School/VIP/shell/401
```

*Spaces matter, try without them:*

*Enter the same thing, but on multiple lines:*

| **11** :
```sh
ls\
-l\
~/School/VIP/shell/401
```

Press: Up *to see your last command was:* `ls-l~/School/VIP/shell/401`

*Even breakup words! Enter ONE LINE AT A TIME:*

| **12** :
```sh
l\
s \
-\
l \
~/School/VIP/shell/401
```

*Same thing, but copy and past ALL AT ONCE:*

| **13** :
```sh
l\
s \
-\
l \
~/School/VIP/shell/401
```

### III. Shell History

| **14** : `history`

| **15** : `cd ~/`

| **16** : `ls .*history`

| **17** : `vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgDown* (until last line)

*Vim: `:q!`*

| **18** : `echo $HISTSIZE`

*History is preserved for the number of lines set in the `$HISTSIZE` environment variable*

*Again...*

| **19** : `vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgUp* (until first line)

*Note the command on line 2*

*Vim: `:q!`*

| **20** : `!-2`

*Note* `!-2` *calles the 2nd to last command, as for all* `!-Nth` *usage*

| **21** : `!echo`

*Note* `!echo` *calls the first BASH command that began with "echo", as for all* `!TEST` *usage*

| **22** : `cd ~/School/VIP/shell/401`


### IV. "Reverse Search"

Press: Ctrl + R

*This is reverse search*

Type: `echo` *and notice the results*

Press: Down *to get back to the normal prompt*

| **23** : `echo Hello world`

*Go again*

Press: Ctrl + R

Type: `echo "` *and notice the DIFFERENT results as you type*

Press: Down *to get back to the normal prompt*

#### [Lesson 2: File System Hierarchy (FSH)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md)
