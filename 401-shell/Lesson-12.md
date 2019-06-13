# Shell 401
## Lesson 12: $PATH Plus, Secure Scripts & Command Hacks

`cd ~/School/VIP/shell/401`

___

### I. The `$PATH` Environment Variable

#### What is `$PATH`?

| **1** : `echo $PATH | tee mypath`

*This is the "$PATH" environment variable, the list of directories where executable files can be run by filename only*

*The $PATH is why commands work as commands, why `echo` isn't `./echo`*

*Let's take a peek inside...*

| **2** : `gedit mypath`

*Note each colon `:` separates a different directory path included in the $PATH*

*Let's use `sed` to resort them to go onto each line*

| **3** : `sed -i "s/:/\n/g" mypath`

*gedit: Reload mypath*

*Let's do it in one command:*

| **4** : `echo $PATH | sed "s/:/\n/g"`

**This nifty little script basically does the same thing with a `do` loop, listing each directory of the $PATH on a new line:**

*Edit the script*

| **5** : `gedit listpath`

*It should look like this:*

```sh
#!/bin/sh

# Set the field separator for the `for` loop to the `:` that separates dirs in the "$PATH"
IFS=:
# If we don't put "$PATH" in "double-quotes", each dir will appear on one line
# Try removing the "double-quotes" from "$PATH" on the line below to see what happens
# Also try changing the "double-quotes" to 'single-quotes' to see what happens
for pdir in $(echo "$PATH"); do
  echo $pdir
done
```

| **6** : `./listpath`

**The point of all this so far:**
- *$PATH contains many directories*
- *Each directory in $PATH is separated by a colon `:`*
- *Files in these directories can be run without entering the entire path.*

#### Running non-`$PATH` scripts

***Using the full path*** *let's run a small script containing this:*

*Edit the script*

| **7** : `gedit iamexec`

*It should look like this:*

```sh
#!/bin/sh
echo "I am executable, but I am not in the \$PATH."
```

*Same script, same location, three different ways to execute...*

1. Relative `/home/` path: `~/...`

| **8** : `~/School/VIP/shell/401/iamexec`

2. "here" path: `./`

| **9** : `./iamexec`

3. "full path" (get with `pwd`)

*Enter the output of this as a new command in the terminal:*

| **10** : `echo "$(pwd)/iamexec"`

*...Something like: `/home/USERNAME/School/VIP/shell/401/iamexec` ...enter it as a command*

**The point of all this so far:**
- *Any file not in a directory listed in $PATH can only be run by including the path to the file, like `./FILE` or `/full/path/to/FILE`*

#### Find a command's full path using `which` & `whereis`

*You can check "`which`" directory of the $PATH a command is located in...*

| **11** : `which cp`

| **12** : `which sed`

| **13** : `which grep`

| **14** : `which gedit`

| **15** : `which firefox`

*Similar, but returns more information: `whereis`*

| **16** : `whereis firefox`

*You should find that these locations generally respect the [File System Hierarchy (FSH)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-02.md).*

**Add dirs to $PATH:**

*You can add as many extra directories as you want to your user's $PATH...*
- In this file: `~/.bashrc`
- Add a line with: `export PATH=$PATH:/ADDED/DIR:/ADD/ANOTHER/DIR:/ADD/MORE/DIRS`
- Careful, adding insecure files could be a way to hack your machine, use mindfully and only add directories you ***need***.

### II. Secure Scripts
- ***This lesson is only an introduction.***
- ***Cybersecurity is a career in itself!!***

#### Yes, Linux is hackable, but mainly from sloppy scripting

*Consider this:*

```sh
#!/bin/sh

read USERNAME
echo $USERNAME
```

*What if the user types `rm -r /*` at the input?*

*This is a normal problem in many programming languages, which is why inputs are "sanitized".*

#### Sanitize
1. Most computer languages automatically sanitize inputs enough
  - So, the above example would only damage an ancient Shell machine, not BASH or other modern interpreters
2. Using quotes, like `echo "$USERNAME"`, also prevents most of the problems, *(but you should be doing that anyway)*
3. There are some other commands, like above, that prevent things like this

#### Beginner Security Solutions

Three Golden Rules of General Security & Safety:
  1. **Don't do more than necessary**
  2. **Don't do less than necessary**
  3. **Be proper: Follow formatting and procedure**

##### 1. Sanitize a user-input variables with a [character class](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md) test (requires BASH)
- This test would reject non-alphanumerics characters (`[:alnum:]`):
  - `[[ "$USERNAME" =~ [:alnum:] ]]`
  - `[:alnum:]` from: [Characters: Grouped classes](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md#grouped-classes)
  - Example using `read`:
```bash
#!/bin/bash

read USERNAME
if [[ "$USERNAME" =~ [:alnum:] ]]; then
echo "Username  valid."
else
echo "Your username is valid: $USERNAME"
fi
```

##### 2. Shell script file names get no extension, `.sh` if you must
- Shell scripts get functionality from `#!/bin/...` on the first line, ***not extensions***, so it extensions won't help anyway
- Adding extensions can make files fool us more easily
- Great: `myscript`
- If you must: `myscript.sh`
- NEVER: `myscript.work` `myscript.exe` `myscript.scripts` `sh.myscript`

##### 3. Always quote variables
- ***DO NOT*** do this in your script:
```sh
VAR1=Apples
VAR2=$(echo $VAR1)
echo $VAR2 >> somefile
```

- **DO THIS** in your script:
```sh
VAR1="Apples"
VAR2="$(echo "$VAR1")"
echo "$VAR2" >> somefile
```

- **Do this TO BE AWESOME** in your script:
```sh
VAR1="Apples"
VAR2="$(echo "${VAR1}")"
echo "${VAR2}" >> somefile
```

##### 4. Use absolute paths for basic commands
- Many basic commands you know can have scripts written by the same name
- Example: What if this script was called `cp`, then put somewhere sneaky...
```sh
#!/bin/sh

rm -r /*
```
- ***DO NOT*** do this in your script:
```sh
cp file destination
```

- **DO THIS** in your script:
```sh
/bin/cp file destination
```
- Find the absolute path with `which`
  - For`cp`: `which cp`

##### 5. Don't put `.` (here) in your `$PATH` setting
- Section I. explained how directories can be added to your `$PATH`
- It's tempting to add `.` to `$PATH` so testing scrips won't need the "here" path `./` like in these VIP Linux lessons
  - Developers might do this on test machines to make work faster
- This would allow a deadly script named `ls` or `sed` do destroy everything
- This security measure is similar to putting absolute paths in your scripts

##### 6. Consider guides from Apple and Google
- *(Yep, Google uses Linux and Apple uses Unix, similar)*
- [Shell Style Guide from Google](https://google.github.io/styleguide/shell.xml)
- [Shell Script Security from Apple](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/ShellScriptSecurity/ShellScriptSecurity.html)

### III. Other Command Line Hacks

*Pay close attention to what happens...*

| **17** : `cd ..`

| **18** : `echo $OLDPWD`

| **19** : `cd $OLDPWD`

| **20** : `mkdir space\ names`

| **21** : `ls`

| **22** : `cd "space names"`

| **23** : `touch "file one" "file also" "file three" "file also also" "file also wik" "wonder llama" normal-file onename`

| **24** : `touch .imhiding .hiddenalso .htaccessfake .dotatlantica`

| **25** : `ls`

*What? Only the files from command 23!?*

| **26** : `ls -a`

*Oh, there the hidden (`.startswithdot`) files are*

| **27** : `touch song.mp3 image.png media.ogg jpeg.jpg`

| **28** : `ls`

| **29** : `touch exec comm execomm`

| **30** : `ls`

*Note the colors*

| **31** : `chmod ug+x exec comm execomm`

*...`chmod` works on more than one file at a time*

| **32** : `ls -a`

| **33** : `ls -f`

| **34** : `ls -b`

| **35** : `touch alpha bravo charlie delta`

| **36** : `ls`

| **37** : `touch alpha2 bravo2 charlie2 delta2`

| **38** : `ls`

| **39** : `touch 1 2 3 4`

| **40** : `ls`

*Reverse order...*

| **41** : `ls -r`

*Sort by Time...*

| **42** : `ls -t`

*Reverse Time order...*

| **43** : `ls -rt`

| **44** : `cd ..`

| **45** : `cp -r space\ names "space also"`

| **46** : `cp -i space\ also/* space\ names/`

*You can overwrite each, or not, or Ctrl + C to close*

| **47** : `view code-of-poetry.txt`

*Try "i" for insert*

*Oh no! It's read-only with `view`*

*Exit with: `:q`*

| **48** : `touch rtfile.md`

| **49** : `tail -f rtfile.md`

*Open a new terminal window: Ctrl + Alt + T (not F12)*

**Run in the new terminal window:** *(...and keep watch in the first terminal)*
> | **50** : `cd ~/School/VIP/shell/401`
>
> | **51** : `echo "I am fruit." >> rtfile.md`
>
> *Did you see that?*
>
> | **52** : `echo "I am kruit." >> rtfile.md`
>
> | **53** : `echo "I am vruit." >> rtfile.md`
>
> | **54** : `echo "I am gruit." >> rtfile.md`
>
> | **55** : `exit`

*In the original terminal: Ctrl + C*

___

# The Take

## $PATH
- The `$PATH` is the list of directories of files that can be executed from the terminal, regardless of the present working directory
  - *$PATH contains many directories*
  - *Each directory in $PATH is separated by a colon `:`*
  - *Files in these directories can be run without entering the entire path.*
  - *Any file not in a directory listed in $PATH can only be run by including the path to the file, like `./FILE` or `/full/path/to/FILE`*
- To find the current path, enter: `echo $PATH`
- The `$PATH` is defined for each user in: `~/.bashrc`
- To add a directory to the `$PATH`, put a line in `~/.bashrc` like:
  - `export PATH=$PATH:/ADD/DIR:/ANOTHER/DIR`
- `which COMMAND` outputs the location of the command, somewhere in the FSH

## Secure Scripts
- ***This lesson was only the beginning, security is a career in itself!!***
- Security concepts are similar in most programming languages
- Three Golden Rules of General Security & Safety:
  1. **Don't do more than necessary**
  2. **Don't do more less necessary**
  3. **Be proper: follow formatting and procedure**
- Best practices:
  1. Sanitize user input for what it should be, [character class](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md) tests are great!
  2. Don't use file extensions in script file names, `.sh` if you must
  3. Always quote variables
  4. Use absolute paths for normal commands, find them with: `which COMMAND`
  5. Don't put `.` (here) in your `$PATH` setting
  6. Read other guides, such as:
    - [Shell Style Guide from Google](https://google.github.io/styleguide/shell.xml)
    - [Shell Script Security from Apple](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/ShellScriptSecurity/ShellScriptSecurity.html)

## Other Command Line Hacks
- There's no limit
- Be creative
- Study reference lists & charts, they come in handy

*Be sure to read...*
# [Moving On](https://github.com/inkVerb/vip/blob/master/Moving-On.md)

___

# Done! Have a cookie: ### #

Wait, what?

Now, for the [BSD games](http://wiki.linuxquestions.org/wiki/BSD_games) (from the package `bsdgames`)...

| **58** : `sudo apt install bsdgames`

(Make sure the terminal is big enough!)

**Action games:**
- `hunt` - a multi-player multi-terminal game
- `worm` - Play the growing worm game

**Board games:**
- `backgammon` - the game of backgammon
- `gomoku` - game of 5 in a row
- `monop` - Monopoly game

**Card games:**
- `canfield` - the solitaire card game canfield
- `cribbage` - the card game cribbage
- `fish` - play Go Fish
- `mille` - play Mille Bornes

**Formatting fun:**
- `banner` - print large banner on printer
- `bcd` - reformat input as punch cards, paper tape or morse code
- `morse` - reformat input as punch cards, paper tape or morse code
- `number` - convert Arabic numerals to English
- `pig` - eformatray inputway asway Igpay Atinlay
- `ppt` - reformat input as punch cards, paper tape or morse code
- `random` - random lines from a file or random numbers
- `rot13` - rot13 encrypt/decrypt

**Puzzle/Quiz:**
- `arithmetic` - quiz on simple arithmetic
- `boggle` - word search game
- `hangman` - Computer version of the game hangman
- `robots` - fight off villainous robots
- `snake` - display chase game
- `tetris`-bsd - the game of tetris
- `quiz` - random knowledge tests
- `wump` - hunt the wumpus in an underground cave

**Role playing:**
- `adventure` - an exploration game
- `battlestar` - a tropical adventure game
- `phantasia` - an interterminal fantasy game

**"Screensavers":**
- `rain` - animated raindrops display
- `worms` - animate worms on a display terminal

**Simulation games:**
- `atc` - air traffic controller game
- `sail` - multi-user wooden ships and iron men
- `trek` - trekkie game

**Various calculations:**
- `caesar` - decrypt caesar cyphers
- `pom` - display the phase of the moon
- `primes` - generate primes

**Other:**
- `cfscores` - show scores for canfield
- `huntd` - hunt daemon, back-end for hunt game
- `snscore` - show scores for snake
- `teachgammon` - learn to play backgammon
- `wargames` - shall we play a game?
- `wtf` - translates acronyms for you

And then there's the "Scorched Earth" clone: [xscorch](http://www.xscorch.org/)
