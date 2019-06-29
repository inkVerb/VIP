# Shell 401
## Lesson 12: Secure Scripting & Command Hacks

`cd ~/School/VIP/shell/401`

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

#### B. Sanitize
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

#### C. Starting Security Solutions

Three Golden Rules of General Security & Safety:
  1. **Don't do more than necessary**
  2. **Don't do less than necessary**
  3. **Be proper: Follow formatting and procedure**

##### 1. Sanitize a user-input variables with a [character class](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md) test (requires BASH)
- **Sanitizing is generally a good idea anyway, so a user mistake doesn't break your script**
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
- Review the `$PATH` environment variable in [Lesson 03](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-03.md)

##### 6. Consider guides from Apple and Google
- *(Yep, Google uses Linux and Apple uses Unix, similar)*
- [Shell Style Guide from Google](https://google.github.io/styleguide/shell.xml)
- [Shell Script Security from Apple](https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/ShellScriptSecurity/ShellScriptSecurity.html)

### II. Other Command Line Hacks

*Pay close attention to what happens...*

| **1** : `cd ..`

| **2** : `echo $OLDPWD`

| **3** : `cd $OLDPWD`

| **4** : `mkdir space\ names`

| **5** : `ls`

| **6** : `cd "space names"`

| **7** : `touch "file one" "file also" "file three" "file also also" "file also wik" "wonder llama" normal-file onename`

| **8** : `touch .imhiding .hiddenalso .htaccessfake .dotatlantica`

| **9** : `ls`

*What? Only the files from command 23!?*

| **10** : `ls -a`

*Oh, there the hidden (`.startswithdot`) files are*

| **11** : `touch song.mp3 image.png media.ogg jpeg.jpg`

| **12** : `ls`

| **13** : `touch exec comm execomm`

| **14** : `ls`

*Note the colors*

| **15** : `chmod ug+x exec comm execomm`

*...`chmod` works on more than one file at a time*

| **16** : `ls -a`

| **17** : `ls -f`

| **18** : `ls -b`

| **19** : `touch alpha bravo charlie delta`

| **20** : `ls`

| **21** : `touch alpha2 bravo2 charlie2 delta2`

| **22** : `ls`

| **23** : `touch 1 2 3 4`

| **24** : `ls`

*Reverse order...*

| **25** : `ls -r`

*Sort by Time...*

| **26** : `ls -t`

*Reverse Time order...*

| **27** : `ls -rt`

| **28** : `cd ..`

| **29** : `cp -r space\ names "space also"`

| **30** : `cp -i space\ also/* space\ names/`

*You can overwrite each, or not, or Ctrl + C to close*

| **31** : `view code-of-poetry.txt`

*Try "i" for insert*

*Oh no! It's read-only with `view`*

*Exit with: `:q`*

| **32** : `touch rtfile.md`

| **33** : `tail -f rtfile.md`

*Open a new terminal window: Ctrl + Alt + T (not F12)*

**Run in the new terminal window:** *(...and keep watch in the first terminal)*
> | **34** : `cd ~/School/VIP/shell/401`
>
> | **35** : `echo "I am fruit." >> rtfile.md`
>
> *Did you see that?*
>
> | **36** : `echo "I am kruit." >> rtfile.md`
>
> | **37** : `echo "I am vruit." >> rtfile.md`
>
> | **38** : `echo "I am gruit." >> rtfile.md`
>
> | **39** : `exit`

*In the original terminal: Ctrl + C*

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

Now, for the [BSD games](http://wiki.linuxquestions.org/wiki/BSD_games) (from the package `bsdgames`)...

| **D1** : `sudo apt install bsdgames`

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
