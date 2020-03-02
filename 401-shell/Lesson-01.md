# Shell 401
## Lesson 1: Returns & Terminal

`cd ~/School/VIP/shell/401`

___

### I. Carriage Returns: DOS v Unix

| **1** : `vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*No difference*

*Vim: `:q`*

| **2** : `unix2dos text-doc.txt`

| **3** : `vim text-doc.txt`

*Vim: `:e ++ff=unix`*

*Now see `^M` at the end of the line, indicating a "carriage return"*

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

### II. Multiple Lines, One Command via `\`

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

*Let's look at "401/"...*

| **9** : `cd ~/School/VIP/shell`

*Consider the `ls` command:*

| **10** : `ls -l 401`

*Enter the same thing, but on multiple lines:*

| **11** :
```sh
ls \
-l \
401
```

*Spaces matter, try without them:*

*Enter the same thing, but on multiple lines:*

| **12** :
```sh
ls\
-l\
401
```

*Press Up to see what your last command was: `ls-l~/School/VIP/shell/401`*

*Even breakup character by character, TYPE IN THE ENTIRE COMMAND, INCLUDING SPACES:*

| **13** :
```sh
l\
s\
 \
-\
l\
 \
4\
0\
1
```

*Similar, you may copy and past ALL AT ONCE:*

| **14** :
```sh
l\
s \
-\
l \
~/School/VIP/shell/401
```

### III. Shell History

| **15** : `history`

| **16** : `cd ~/`

| **17** : `ls .*history`

| **18** : `vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgDown (until last line)*

*Vim: `:q!`*

| **19** : `echo $HISTSIZE`

*History is preserved for the number of lines set in the `$HISTSIZE` environment variable*

*Again...*

| **20** : `vim .bash_history` *(or whatever the file name is)*

*Vim: `:set number`*

*Vim: PgUp (repeat until first line)*

*Note the command on line 2*

*Vim: `:q!`*

| **21** : `!-2`

*Note `!-2` calles the 2nd to last command, as for all `!-Nth` usage*

| **22** : `!echo`

*Note `!echo` calls the first BASH command that began with "echo", as for all `!TEST` usage*

| **23** : `cd ~/School/VIP/shell/401`


### IV. "Reverse Search"

*Press Ctrl + R*

*This is reverse search*

*Type `echo` and notice the results*

*Press Down to get back to the normal prompt*

| **24** : `echo Hello world`

*Go again*

*Press Ctrl + R*

*Type `echo "` and notice the DIFFERENT results as you type*

*Press Down to get back to the normal prompt*

___

# The Take

## Carriage Returns
- A "carriage return" is a hidden character at the end of DOS/Windows text lines
- Carriage returns can cause unexpected problems in code
- `vim` will display carriage returns as `^M` by entering the `vim` command: `:e ++ff=unix`
- There are three ways to fix problems relating to carriage returns:
  1. Don't use Windows in the first place
  2. Copy and paste raw text from the questionable file into a Linux text editor like Atom, gedit, `nano`, or `vim`
    - There's a slim chance it might not work
  3. Use `dos2unix FILE-TO-FIX`, installed with `sudo apt install dos2unix`
    - Most certain conversion

## Multiple Lines, One Command: `\`
- Like "working" special characters, `\` also escapes a "return" on the terminal line
- A non-escaped return will render, even if the line before was escaped
- Returns can be escaped even between letters of a word, preserving the word (escaped returns do not become a space)

## Shell History
- View terminal history with `history`
- History is usually kept in `~/.bash_history`
- Search history from the terminal with **Ctrl + R**

___

#### [Lesson 2: File System Hierarchy (FSH)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md)
