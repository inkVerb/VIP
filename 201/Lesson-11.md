## Lesson 11: more, less, head, tail, sort, tac, diff, nano, vim

Ready the CLI

```console
cd ~/School/VIP/201
```

___

*Let's get another look at `verb.ink.html`*

| **1** :$

```console
cd verb.ink
```

| **2** :$

```console
gedit verb.ink.html
```

### `cat`

| **3** :$

```console
cat verb.ink.html
```

### `more`

*One page at a time: <kbd>Spacebar</kbd>*

*One line at a time: <kbd>Enter</kbd>*

| **4** :$ *(<kbd>Spacebar</kbd> to the end or <kbd>Q</kbd> to quit)*

```console
more verb.ink.html
```

*Eight lines at a time*

| **5** :$ *(<kbd>Q</kbd> to quit)*

```console
more -8 verb.ink.html
```

### `less`

*Up and down: <kbd>Spacebar</kbd>, <kbd>PageUp</kbd>, <kbd>PageDown</kbd>, <kbd>Up</kbd>, <kbd>Down</kbd>*

| **6** :$ *(<kbd>Q</kbd> to quit)*

```console
less verb.ink.html
```

### `head`

*First ten lines*

| **7** :$

```console
head verb.ink.html
```

*First four lines*

| **8** :$

```console
head -4 verb.ink.html
```

### `tail`

*Last ten lines*

| **9** :$

```console
tail verb.ink.html
```

*Last five lines*

| **10** :$

```console
tail -5 verb.ink.html
```

## A few other tools

### `tac` *(`cat` backwards)*

*Lines in reverse order*

| **11** :$

```console
tac verb.ink.html
```

*Next, download some files...*

| **12** :$

```console
cd ..
```

| **13** :$

```console
git clone https://github.com/inkVerb/201-11
```

| **14** :$

```console
cd 201-11
```

### `sort`

| **15** :$

```console
gedit sortme
```

*Lines in alphabetical order*

| **16** :$

```console
sort sortme
```

*Reverse alphabetical order*

| **17** :$

```console
sort -r sortme
```

### `diff`

There are three main commands that compare files:
- `diff` (many options)
- `cmp` (returns position of first difference)
- `comm` (three columns, only processes files sorted with `sort`)

| **18** :$

```console
gedit frc-*
```

*Compare 1 & 2*

| **19** :$

```console
diff frc-1 frc-2
```

*Note "`a`" means that lines are "Added"*

| **20** :$

```console
diff frc-1 frc-3
```

*Note "`d`" means that lines are "Deleted"*

| **21** :$

```console
diff frc-1 frc-4
```

*Note "`c`" means that the lines "Change"*

*Note "13,17" means "lines 13–17"*

| **22** :$

```console
diff frc-1 frc-5
```

*Note `frc-5` line 3 has several spaces at the end of the line; ignore with `-Z`*

| **23** :$

```console
diff -Z frc-1 frc-5
```

*Ignore all white space with `-w`*

| **24** :$

```console
diff -w frc-1 frc-5
```

*Ignore case with `-i`*

| **25** :$

```console
diff -i frc-1 frc-5
```

*Ignore case and white space with `-iw`*

| **26** :$

```console
diff -iw frc-1 frc-5
```

*Note nothing happens if files are the same*

| **27** :$

```console
diff frc-1 frc-6
```

*Get a message to say so with `-s`*

| **28** :$

```console
diff -s frc-1 frc-6
```

*Combine `-s` with other options*

| **29** :$

```console
diff -iws frc-1 frc-5
```

*Get a quiet message if files differ*

| **30** :$

```console
diff -q frc-1 frc-4
```

*Compare side-by-side wtih `-y`*

| **31** :$

```console
diff -y frc-1 frc-4
```

*Remember* frc-2

| **32** :$

```console
diff frc-1 frc-2
```

*Ignore blank lines with `-B`*

| **33** :$

```console
diff -B frc-1 frc-2
```

*There is always more to learn*

| **34** :$ *(<kbd>Q</kbd> to quit)*

```console
man diff
```

#### `cmp`

| **35** :$

```console
cmp frc-1 frc-2
```

| **36** :$

```console
cmp frc-1 frc-3
```

| **37** :$

```console
cmp frc-1 frc-4
```

| **38** :$

```console
cmp frc-1 frc-5
```

| **39** :$

```console
cmp frc-1 frc-6
```

#### `comm`

*First, prepare by creating sorted files*

| **40** :$

```console
mkdir sorted
sort frc-1 > sorted/frc-1
sort frc-2 > sorted/frc-2
sort frc-3 > sorted/frc-3
sort frc-4 > sorted/frc-4
sort frc-5 > sorted/frc-5
sort frc-6 > sorted/frc-6
gedit sorted/*
```

*Remember, these are sorted, so all lines have been re-arranged for alphabetical order...*

| **41** :$

```console
comm sorted/frc-1 sorted/frc-2
```

| **42** :$

```console
comm sorted/frc-1 sorted/frc-3
```

| **43** :$

```console
comm sorted/frc-1 sorted/frc-4
```

| **44** :$

```console
comm sorted/frc-1 sorted/frc-5
```

| **45** :$

```console
comm sorted/frc-1 sorted/frc-6
```

### `nano`

*The simple text editor in the terminal*

| **46** :$

```console
cd ../verb.ink
```

| **47** :$

```console
nano verb.ink.html
```

*Options listed at the bottom*

*Tip:*  ^ = <kbd>Ctrl</kbd>

*Tip:* M- = <kbd>Alt</kbd>

*Take note of:* ^K ^W ^O ^X M-U

*Note* ^Z *will "stop" the nano session, not "undo"*
- If you ^Z back to the terminal, resume with `fg nano`, see [Linux 101 Lesson 0](https://github.com/inkVerb/VIP/blob/master/101/Lesson-00.md)

*(<kbd>Ctrl</kbd> + <kbd>X</kbd> to eXit)*

### `vim`

*The terminal editor used by cool people*

| **48** :$

```console
vim verb.ink.html
```

*To quit, type these two characters:*

`:q`

*Vim has a tutorial*

| **49** :$ *(inside Vim, use* `:q` *to quit)*

```console
vimtutor
```

*Have fun!*

___

# The Take
## **more, less, head & tail** display the contents of a file in small amounts
- `more`
  - One page at a time: <kbd>Spacebar</kbd>
  - One line at a time: <kbd>Enter</kbd>
  - `more -8 file` shows 8 lines at a time
  - **<kbd>Q</kbd>** will quit
- `less`
  - Up and down: <kbd>Spacebar</kbd>, <kbd>PageUp</kbd>, <kbd>PageDown</kbd>, <kbd>Up</kbd>, <kbd>Down</kbd>,
  - **<kbd>Q</kbd>** will quit
- `head`
  - First 10 lines
  - `head -8 file` shows the first 8 lines
- `tail`
  - Last 10 lines
  - `tail -8 file` shows the last 8 lines

## Other file view tools
- `tac` reverse line order
- `sort` re-orders the lines of a file alphabetically
  - `-r` for reverse alphabetical
- `diff` compares two files by line
  - Many options
  - Usage: `diff file1 file2`
  - `a` = "added"
  - `d` = "deleted"
  - `c` = "changed" (different)
  - `13,17` = lines 13 through 17
  - `-i` ignore case
  - `-w` ignore all "white space" (Returns and extra spaces)
  - `-y` displays files side-by-side
- `cmp` returns only the first difference
- `comm` only compares files that have been sorted via `sort`, returning three columns

## Terminal text editors
### `nano` is great for beginners
- `^` = **<kbd>Ctrl</kbd>**
- `M-` = **<kbd>Alt</kbd>**
- If you **<kbd>Ctrl</kbd> + <kbd>Z</kbd>** as "undo" on accident, `fg nano` will take you back
### `vim` is for awesome people
- Anyone can learn `vim`, especially children; so, learn young
- `vim` emulates the terminal text editor `vi` made by Bill Joy, when computers first walked the earth in 1976
  - `vim` is "`vi` improved"
    - `vim` is built on `vi` and does everything `vi` does
    - `vi` does not highlight code syntax with colors, `vim` does
  - Ubuntu starts `vim` when you run `vi`, Red Hat and Arch do not
  - Most `vim` packages include `vi`
  - Read all about the official differences; run: `vim`, then type: `:h vi-differences`
- Learn `vim` by running: `vimtutor`
- `vim` is easier to operate than `nano` after only 30 minutes of the `vimtutor` tutorial
- If your teacher, boss, parents, children, spouse, or family dog force you to learn `vim`, it's because they think you're so awesome that only learning `vim` can make you awesomerer
- Read about the rich history of terminal text editors like `vim` in the dazzling article, *[The Differences Between Vi, Vim, and Emacs](https://danielmiessler.com/blog/differences-vi-vim-emacs/)* by Daniel Miessler

___

#### [Lesson 12: Filesystem Hierarchy Standard (FHS)](https://github.com/inkVerb/vip/blob/master/201/Lesson-12.md)
