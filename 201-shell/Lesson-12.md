# Shell 201
## Lesson 12: more, less, head, tail, sort, diff, nano, vi

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`

___

*Let's get another look at verb.ink.html*

`cat verb.ink.html`

### `more`

*One page at a time: Spacebar*

*One line at a time: Enter*

`more verb.ink.html`

*Eight lines at a time*

`more -8 verb.ink.html` *(Q to quit)*

### `less`

*Up and down: Spacebar, PageUp, PageDown, Up, Down*

`less verb.ink.html` *(Q to quit)*

### `head`

*First ten lines*

`head verb.ink.html`

*First four lines*

`head -4 verb.ink.html`

### `tail`

*Last ten lines*

`tail verb.ink.html`

*Last five lines*

`tail -5 verb.ink.html`

### `sort`

*Lines in alphabetical order*

`sort verb.ink.html`

*Reverse alphabetical order*

`sort -r verb.ink.html`

*Lots more you can do*

`man sort` *(Q to quit)*

### `diff`

*First,* `wget` *some files*

`git clone https://github.com/inkVerb/201-12`

`cd 201-12`

*Look inside*

`gedit frc-*`

*Compare 1 & 2*

`diff frc-1 frc-2`

*Note* "a" *means that lines are* "Added"

`diff frc-1 frc-3`

*Note* "d" *means that lines are* "Deleted"

`diff frc-1 frc-4`

*Note* "c" *means that the lines* "Change"

*Note* "13,17" *means* "lines 13–17"

`diff frc-1 frc-5`

*Note* frc-5 line 3 *has several spaces at the end of the line; ignore with* `-Z`

`diff -Z frc-1 frc-5`

*Ignore all white space with* `-w`

`diff -w frc-1 frc-5`

*Ignore case with* `-i`

`diff -i frc-1 frc-5`

*Ignore case and white space with* `-iw`

`diff -iw frc-1 frc-5`

*Note nothing happens if files are the same*

`diff frc-1 frc-6`

*Get a message to say so with* `-s`

`diff -s frc-1 frc-6`

*Combine* `-s` *with other options*

`diff -iws frc-1 frc-5`

*Get a quiet message if files differ*

`diff -q frc-1 frc-4`

*Compare side-by-side wtih* `-y`

`diff -y frc-1 frc-4`

*Remember* frc-2

`diff frc-1 frc-2`

*Ignore blank lines with* `-B`

`diff -B frc-1 frc-2`

*There is always more to learn*

`man diff` *(Q to quit)*

`cd ..`

### nano

*The simple text editor in the terminal*

`nano verb.ink.html`

*Options listed at the bottom*

*Tip:*  ^ = Ctrl

*Tip:* M- = Alt

*Take note of:* ^K ^W ^O ^X M-U

*Note* ^Z *will "stop" the nano session, not "undo"*
- If you ^Z back to the terminal, resume with `fg nano`, see [Shell 101 Lesson 0](https://github.com/inkVerb/VIP/blob/master/101-shell/Lesson-00.md)

### vi (Vim)

*The terminal editor used by cool people*

`vi verb.ink.html`

*To quit, type these to characters:*

:q

*Vim has a tutorial*

`vimtutor` *( :q to quit)*

*Have fun!*

# Done! Have a cookie: ### #

Oh, what's this?

`alsamixer`

Don't have it yet?

`sudo apt install alsamixer`

*Some older Linux distros not supported*

[alsamixer](https://linux.die.net/man/1/alsamixer)
