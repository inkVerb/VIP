## Lesson 12: more, less, head, tail, sort, tac, diff, nano, vi

Ready the CLI

`cd ~/School/VIP/shell/201`

___

*Let's get another look at verb.ink.html*

| **1** : `cd verb.ink`

| **2** : `gedit verb.ink.html`

### `cat`

| **3** : `cat verb.ink.html`

### `more`

*One page at a time: Spacebar*

*One line at a time: Enter*

| **4** : `more verb.ink.html` *(Space to the end or Q to quit)*

*Eight lines at a time*

| **5** : `more -8 verb.ink.html` *(Q to quit)*

### `less`

*Up and down: Spacebar, PageUp, PageDown, Up, Down*

| **6** : `less verb.ink.html` *(Q to quit)*

### `head`

*First ten lines*

| **7** : `head verb.ink.html`

*First four lines*

| **8** : `head -4 verb.ink.html`

### `tail`

*Last ten lines*

| **9** : `tail verb.ink.html`

*Last five lines*

| **10** : `tail -5 verb.ink.html`

## A few other tools

### `tac` *(`cat` backwards)*

*Lines in reverse order*

| **11** : `tac verb.ink.html`

*Next, download some files...*

| **12** : `cd ..`

| **13** : `git clone https://github.com/inkVerb/201-12`

| **14** : `cd 201-12`

### `sort`

| **15** : `gedit sortme`

*Lines in alphabetical order*

| **16** : `sort sortme`

*Reverse alphabetical order*

| **17** : `sort -r sortme`

### `diff`

| **18** : `gedit frc-*`

*Compare 1 & 2*

| **19** : `diff frc-1 frc-2`

*Note "a" means that lines are "Added"*

| **20** : `diff frc-1 frc-3`

*Note "d" means that lines are "Deleted"*

| **21** : `diff frc-1 frc-4`

*Note "c" means that the lines "Change"*

*Note "13,17" means "lines 13–17"*

| **22** : `diff frc-1 frc-5`

*Note frc-5 line 3 has several spaces at the end of the line; ignore with `-Z`*

| **23** : `diff -Z frc-1 frc-5`

*Ignore all white space with `-w`*

| **24** : `diff -w frc-1 frc-5`

*Ignore case with `-i`*

| **25** : `diff -i frc-1 frc-5`

*Ignore case and white space with `-iw`*

| **26** : `diff -iw frc-1 frc-5`

*Note nothing happens if files are the same*

| **27** : `diff frc-1 frc-6`

*Get a message to say so with `-s`*

| **28** : `diff -s frc-1 frc-6`

*Combine `-s` with other options*

| **29** : `diff -iws frc-1 frc-5`

*Get a quiet message if files differ*

| **30** : `diff -q frc-1 frc-4`

*Compare side-by-side wtih `-y`*

| **31** : `diff -y frc-1 frc-4`

*Remember* frc-2

| **32** : `diff frc-1 frc-2`

*Ignore blank lines with `-B`*

| **33** : `diff -B frc-1 frc-2`

*There is always more to learn*

| **34** : `man diff` *(Q to quit)*

| **35** : `cd ..`

### `nano`

*The simple text editor in the terminal*

| **36** : `cd verb.ink`

| **37** : `nano verb.ink.html`

*Options listed at the bottom*

*Tip:*  ^ = Ctrl

*Tip:* M- = Alt

*Take note of:* ^K ^W ^O ^X M-U

*Note* ^Z *will "stop" the nano session, not "undo"*
- If you ^Z back to the terminal, resume with `fg nano`, see [Shell 101 Lesson 0](https://github.com/inkVerb/VIP/blob/master/101-shell/Lesson-00.md)

*(Ctrl + X to eXit)*

### `vim`

*The terminal editor used by cool people*

| **38** : `vim verb.ink.html`

*To quit, type these two characters:*

:q

*Vim has a tutorial*

| **39** : `vimtutor` *(inside Vim, use* :q *to quit)*

*Have fun!*

___

# The Take

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
- `tac` reverse line order
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

___

# Done! Have a cookie: ### #

Oh, what's this?

| **D1** : `alsamixer`

Don't have it yet?

| **D2** : `sudo apt install alsamixer`

*Some older Linux distros not supported*

Learn more at the [alsamixer manual page](https://linux.die.net/man/1/alsamixer)

Oh, and then there's this...

| **D3** : `sudo apt install gnome-nibbles`

___

## Next: [Shell 301: Logic](https://github.com/inkVerb/VIP/blob/master/301-shell/README.md)
