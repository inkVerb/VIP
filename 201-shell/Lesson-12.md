# Shell 201
## Lesson 12: more, less, head, tail, sort, diff, nano, vi

`cd ~/School/VIP/shell/201`

___

*Let's get another look at verb.ink.html*

| **1** : `cd verb.ink`

| **2** : `cat verb.ink.html`

### `more`

*One page at a time: Spacebar*

*One line at a time: Enter*

| **3** : `more verb.ink.html`

*Eight lines at a time*

| **4** : `more -8 verb.ink.html` (Q to quit)*

### `less`

*Up and down: Spacebar, PageUp, PageDown, Up, Down*

| **5** : `less verb.ink.html` (Q to quit)*

### `head`

*First ten lines*

| **6** : `head verb.ink.html`

*First four lines*

| **7** : `head -4 verb.ink.html`

### `tail`

*Last ten lines*

| **8** : `tail verb.ink.html`

*Last five lines*

| **9** : `tail -5 verb.ink.html`

### `sort`

*Lines in alphabetical order*

| **10** : `sort verb.ink.html`

*Reverse alphabetical order*

| **11** : `sort -r verb.ink.html`

*Lots more you can do*

| **12** : `man sort` *(Q to quit)*

| **13** : `cd ..`

### `diff`

*First, download some files*

| **14** : `git clone https://github.com/inkVerb/201-12`

| **15** : `cd 201-12`

*Look inside*

| **16** : `gedit frc-*`

*Compare 1 & 2*

| **17** : `diff frc-1 frc-2`

*Note "a" means that lines are "Added"*

| **18** : `diff frc-1 frc-3`

*Note "d" means that lines are "Deleted"*

| **19** : `diff frc-1 frc-4`

*Note "c" means that the lines "Change"*

*Note "13,17" means "lines 13–17"*

| **20** : `diff frc-1 frc-5`

*Note frc-5 line 3 has several spaces at the end of the line; ignore with `-Z`*

| **21** : `diff -Z frc-1 frc-5`

*Ignore all white space with `-w`*

| **22** : `diff -w frc-1 frc-5`

*Ignore case with `-i`*

| **23** : `diff -i frc-1 frc-5`

*Ignore case and white space with `-iw`*

| **24** : `diff -iw frc-1 frc-5`

*Note nothing happens if files are the same*

| **25** : `diff frc-1 frc-6`

*Get a message to say so with `-s`*

| **26** : `diff -s frc-1 frc-6`

*Combine `-s` with other options*

| **27** : `diff -iws frc-1 frc-5`

*Get a quiet message if files differ*

| **28** : `diff -q frc-1 frc-4`

*Compare side-by-side wtih `-y`*

| **29** : `diff -y frc-1 frc-4`

*Remember* frc-2

| **30** : `diff frc-1 frc-2`

*Ignore blank lines with `-B`*

| **31** : `diff -B frc-1 frc-2`

*There is always more to learn*

| **32** : `man diff` *(Q to quit)*

| **33** : `cd ..`

### nano

*The simple text editor in the terminal*

| **34** : `cd verb.ink`

| **35** : `nano verb.ink.html`

*Options listed at the bottom*

*Tip:*  ^ = Ctrl

*Tip:* M- = Alt

*Take note of:* ^K ^W ^O ^X M-U

*Note* ^Z *will "stop" the nano session, not "undo"*
- If you ^Z back to the terminal, resume with `fg nano`, see [Shell 101 Lesson 0](https://github.com/inkVerb/VIP/blob/master/101-shell/Lesson-00.md)

### vi (Vim)

*The terminal editor used by cool people*

| **36** : `vi verb.ink.html`

*To quit, type these to characters:*

:q

*Vim has a tutorial*

| **37** : `vimtutor` *(inside Vim, use* :q *to quit)*

*Have fun!*

# Done! Have a cookie: ### #

Oh, what's this?

| **38** : `alsamixer`

Don't have it yet?

| **39** : `sudo apt install alsamixer`

*Some older Linux distros not supported*

Learn more at the [alsamixer manual page](https://linux.die.net/man/1/alsamixer)

___

# The Take

- `alsamixer` controls audio volume from the terminal

## **more, less, head & tail** display the contents of a file in small amounts
- `more`
  - One page at a time: Spacebar
  - One line at a time: Enter
  - `more -8 file` shows 8 lines at a time
  - **Q** will quit
- `less`
  - Up and down: Spacebar, PageUp, PageDown, Up, Down
  - **Q** will quit
- `head`
  - First 10 lines
  - `head -8 file` shows the first 8 lines
- `tail`
  - Last 10 lines
  - `tail -8 file` shows the last 8 lines

## Other file view tools
- `sort` re-orders the lines of a file alphabetically
  - `-r` for reverse alphabetical
- `diff` compares two files by line
  - Usage: `diff file1 file2`
  - a = "added"
  - d = "deleted"
  - c = "changed" (different)
  - 13,17 = lines 13 through 17
  - `-i` ignore case
  - `-w` ignore all "white space" (Returns and extra spaces)
  - `-y` displays files side-by-side

## Terminal text editors
### `nano` is great for beginners
- ^ = **Ctrl**
- M- = **Alt**
- If you **Ctrl + Z** as "undo" on accident, `fg nano` will take you back
### `vim` is for awesome people
- It should be on every kindergarten's entry exam because kindergartners can learn it easily (if kindergartens had entry exams, but they don't)
- `vim` emulates the terminal text editor `vi` made by Bill Joy, billions of years ago, when computers first walked the earth in 1976
  - `vim` is "`vi` improved", is built on `vi`, and does everything `vi` does
  - Ubuntu starts `vim` when you run `vi`
  - Read all about the official differences; run: `vim`, then type: `:h vi-differences`
- Learn `vim` by running: `vimtutor`
- `vim` is easier to operate than `nano` after only 30 minutes of the `vimtutor` tutorial
- If your teacher, boss, parents, children, spouse, or family dog force you to learn `vim`, it's because they think you're so awesome that only learning `vim` can make you awesomerer
- Read about the rich history of terminal text editors like `vim` in the dazzling article, *[The Differences Between Vi, Vim, and Emacs](https://danielmiessler.com/blog/differences-vi-vim-emacs/)* by Daniel Miessler
