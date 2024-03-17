# Linux 401
## Lesson 1: Returns & Terminal

Ready the CLI

```console
cd ~/School/VIP/401
```

___

### I. Carriage Returns: DOS v Unix

| **1** :$

```console
vim text-doc.txt
```

| **vim** :] `:e ++ff=unix`

*No difference*

| **vim** :] `:q`

| **2** :$

```console
unix2dos text-doc.txt
```

| **3** :$

```console
vim text-doc.txt
```

| **vim** :] `:e ++ff=unix`

*Now see `^M` at the end of the line, indicating a "carriage return"*

| **vim** :] `:q!`

| **4** :$

```console
dos2unix text-doc.txt
```

| **5** :$

```console
vim text-doc.txt
```

| **vim** :] `:e ++ff=unix`

*No difference*

| **vim** :] `:q!`

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

| **9** :$

```console
cd ~/School/VIP
```

*Consider the `ls` command:*

| **10** :$

```console
ls -l 401
```

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

*Press Up to see what your last command was: `ls-l~/School/VIP/401`*

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
~/School/VIP/401
```

### III. Shell History

| **15** :$

```console
history
```

| **16** :$

```console
cd ~/
```

| **17** :$

```console
ls .*history
```

| **18** :$ *(or whatever the file name is)*

```console
vim .bash_history
```

| **vim** :] `:set number`

| **vim** :] PgDown *(until last line)*

| **vim** :] `:q!`

| **19** :$

```console
echo $HISTSIZE
```

*History is preserved for the number of lines set in the `$HISTSIZE` environment variable*

*Again...*

| **20** :$ *(or whatever the file name is)*

```console
vim .bash_history
```

| **vim** :] `:set number`

| **vim** :] PgUp *(repeat until first line)*

*Note the command on line 2*

| **vim** :] `:q!`

| **21** :$

```console
!-2
```

*Note `!-2` calles the 2nd to last command, as for all `!-Nth` usage*

| **22** :$

```console
!echo
```

*Note `!echo` calls the first BASH command that began with "echo", as for all `!TEST` usage*

| **23** :$

```console
cd ~/School/VIP/401
```

### IV. "Reverse Search"
*Press <key>Ctrl</key> + <key>R</key>*

*This is reverse search*

*Type `echo` and notice the results*

*Press Down to get back to the normal prompt*

| **24** :$

```console
echo Hello world
```

*Go again*

*Press <key>Ctrl</key> + R*

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
  3. Use `dos2unix File-to-Fix`, installed with `sudo apt install dos2unix`
    - Most certain conversion

## Multiple Lines, One Command: `\`
- Like "working" special characters, `\` also escapes a "return" on the terminal line
- A non-escaped return will render, even if the line before was escaped
- Returns can be escaped even between letters of a word, preserving the word (escaped returns do not become a space)

## Shell History
- View terminal history with `history`
- History is usually kept in `~/.bash_history`
- Search history from the terminal with **<key>Ctrl</key> + R**

___

#### [Lesson 2: netstat -natu, tcpdump, man, info](https://github.com/inkVerb/vip/blob/master/401/Lesson-02.md)
