# Linux 401
## Lesson 12: Secure Scripting & Command Hacks

Ready the CLI

```console
cd ~/School/VIP/401
```

___

### I. Secure Scripts
- ***This lesson is only an introduction.***
- ***Cybersecurity is a career in itself!!***

#### A. Yes, Linux is hackable, but mainly from sloppy scripting

*Consider this:*

```sh
#!/bin/sh

read USERNAME
echo $USERNAME
```

*What if the user types `rm -r *` at the input?*

*This is a normal problem in many programming languages, which is why inputs are "sanitized".*

#### B. Starting Security Solutions

Three Golden Rules of General Security & Safety:
  1. **Don't do more than necessary**
  2. **Don't do less than necessary**
  3. **Be proper: Follow formatting and procedure**

##### 1. Validate a user-input variables with a [character class](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md) test (requires BASH)
- **Validating is generally a good idea anyway, so a user mistake doesn't break your script**
- **Validation** does not remove anything unwanted, but rejects everything if an input has the wrong format or characters
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

##### 2. Sanitize
1. You can use tools like `sed` or `grep` or something else to reject or remove certain characters a user inputs
  - This is called **"sanitizing"**
  - E.g. consider HTML <form><input> tags that do this automatically with the `type` attribute
    - `type="email"` will only allow email addresses
    - `type="url"` will only allow a web address
    - This had to be done with extra code in older versions of HTML and in more basic computer languages
2. Most computer languages automatically sanitize inputs enough, so you don't need to as often
  - So, the above example would only damage an ancient Shell machine, not BASH or other modern interpreters
3. Using quotes, like `echo "$USERNAME"`, also prevents most of the problems, *(but you should be doing that anyway)*
4. There are some other commands, like above, that prevent things like this

##### 3. Always quote variables
- ***DO NOT*** do this in your script:
```sh
var1=Apples
var2=$(echo $var1)
echo $var2 >> somefile
```

- **DO THIS** in your script:
```sh
var1="Apples"
var2="$(echo "$var1")"
echo "$var2" >> somefile
```

- **Do `{this}` TO BE AWESOME** in your script:
```sh
var1="Apples"
var2="$(echo "${var1}")"
echo "${var2}" >> somefile
```

##### 4. Shell script file names get no extension, `.sh` if you must
- Shell scripts get functionality from `#!/bin/...` on the first line, ***not extensions***, so it extensions won't help anyway
- Adding extensions can make files fool us more easily
- Great: `myscript`
- If you must: `myscript.sh`
- NEVER: `myscript.work` `myscript.exe` `myscript.scripts` `sh.myscript`

##### 5. Use absolute paths for basic commands
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

##### 6. Don't put `.` (here) in your `$PATH` setting
- Section I. explained how directories can be added to your `$PATH`
- It's tempting to add `.` to `$PATH` so testing scrips won't need the "here" path `./` like in these VIP Linux lessons
  - Developers might do this on test machines to make work faster
- This would allow a deadly script named `ls` or `sed` do destroy everything
- This security measure is similar to putting absolute paths in your scripts
- Review the `$PATH` environment variable in [Lesson 03](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)

##### 7. Consider guides from Apple and Google
- *(Yep, Google uses Linux and Apple uses Unix, similar)*
- [Shell Style Guide from Google](https://google.github.io/styleguide/shell.xml)
- [Shell Script Security from Apple](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/ShellScriptSecurity/ShellScriptSecurity.html)

### II. Other Command Line Hacks
*Pay close attention to what happens...*

| **1** :$

```console
cd ..
```

| **2** :$

```console
echo $OLDPWD
```

| **3** :$

```console
cd $OLDPWD
```

| **4** :$

```console
mkdir space\ names
```

| **5** :$

```console
ls
```

| **6** :$

```console
cd "space names"
```

| **7** :$

```console
touch "file one" "file also" "file three" "file also also" "file also wik" "wonder llama" normal-file onename
```

| **8** :$

```console
touch .imhiding .hiddenalso .htaccessfake .dotatlantica
```

| **9** :$

```console
ls
```

*What? Only the files from command 7!?*

| **10** :$

```console
ls -a
```

*Oh, there the hidden (`.startswithdot`) files are*

| **11** :$

```console
touch song.mp3 image.png media.ogg jpeg.jpg
```

| **12** :$

```console
ls
```

| **13** :$

```console
touch exec comm execomm
```

| **14** :$

```console
ls
```

*Note the colors*

| **15** :$

```console
chmod ug+x exec comm execomm
```

*...`chmod` works on more than one file at a time*

| **16** :$

```console
ls -a
```

| **17** :$

```console
ls -f
```

| **18** :$

```console
ls -b
```

| **19** :$

```console
touch alpha bravo charlie delta
```

| **20** :$

```console
ls
```

| **21** :$

```console
touch alpha2 bravo2 charlie2 delta2
```

| **22** :$

```console
ls
```

| **23** :$

```console
touch 1 2 3 4
```

| **24** :$

```console
ls
```

*Reverse order...*

| **25** :$

```console
ls -r
```

*Sort by Time...*

| **26** :$

```console
ls -t
```

*Reverse Time order...*

| **27** :$

```console
ls -rt
```

| **28** :$

```console
cd ..
```

| **29** :$

```console
cp -r space\ names "space also"
```

| **30** :$

```console
cp -i space\ also/* space\ names/
```

*You can overwrite each, or not, or <kbd>Ctrl</kbd> + <kbd>C</kbd> to close*

| **31** :$

```console
view code-of-poetry.txt
```

*Try "`i`" for insert*

*Oh no! It's read-only with `view`*

*Exit with: `:q`*

| **32** :$

```console
touch rtfile.md
```

| **33** :$

```console
tail -f rtfile.md
```

Open a new terminal window: <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> (not <kbd>F12</kbd>)

**Run in a new terminal window:** *(...and keep watch in the first terminal)*
>
> Open a new terminal window: <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> (not <kbd>F12</kbd>)
>
> | **T1** :$

```console
cd ~/School/VIP/401
```
>
> | **T2** :$

```console
echo "I am fruit." >> rtfile.md
```
>
> *Did you see that?*
>
> | **T3** :$

```console
echo "I am kruit." >> rtfile.md
```
>
> | **T4** :$

```console
echo "I am vruit." >> rtfile.md
```
>
> | **T5** :$

```console
echo "I am gruit." >> rtfile.md
```
>
> | **T6** :$

```console
exit
```

*In the original terminal: <kbd>Ctrl</kbd> + <kbd>C</kbd>*

It never stops...

*Did you know? `--` terminates flags, like `-l`...*

| **34** :$

```console
ls -l
```

| **35** :$

```console
mkdir -l
```

| **36** :$

```console
mkdir "-l"
```

| **37** :$

```console
mkdir -- -l
```

| **38** :$

```console
ls
```

| **39** :$

```console
touch -l/newfile
```

| **40** :$

```console
touch "-l/newfile"
```

| **41** :$

```console
touch -- -l/newfile
```

| **42** :$

```console
ls -l
```

| **43** :$

```console
ls -l "-l"
```

| **44** :$

```console
ls -l -- -l
```

| **45** :$

```console
cd -l
```

| **46** :$

```console
cd "-l"
```

| **47** :$

```console
cd -- -l
```

| **48** :$

```console
cd ..
```

| **49** :$

```console
rm -r -l
```

| **50** :$

```console
rm -r "-l"
```

| **51** :$

```console
rm -r -- -l
```

| **52** :$

```console
ls
```

___

# The Take
## Secure Scripting
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

Now, for the [BSD games](http://wiki.linuxquestions.org/wiki/BSD_games) (from the package `bsd-games` or `bsdgames`)...

| **A1a** :$

```console
sudo pacman -S bsd-games
```

...OR...

| **A1u** :$

```console
yay -S bsd-games
```

| **D1** :$

```console
sudo apt install bsdgames
```

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

___

## Next: [Linux 501: Web Stack](https://github.com/inkVerb/VIP/blob/master/501/README.md)

## After: [Linux 601: SysAdmin](https://github.com/inkVerb/VIP/blob/master/601/README.md)