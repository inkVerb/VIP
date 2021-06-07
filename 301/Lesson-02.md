# Shell 301
## Lesson 2: Docs & Pausing (odt2txt, pandoc, sleep, read & wait)

Ready the CLI

```console
cd ~/School/VIP/301
```

___

### I. `odt2txt` & `pandoc`

*Prep, copy, and cd in one command*

| **1** :$

```console
mkdir one && cp *.odt one && cp markdown.md one && cd one
```

*Convert .odt files to .txt*

| **2** :$

```console
ls
```

| **3** :$ *(may need a few seconds to load, then press Enter)*

```console
lowriter *.odt &
```

*Note the contents of the .odt files*

*Close the file, just to make sure we don't have any problems...*

| **4** :$

```console
killall soffice.bin
```

*Try to open one .odt file with gedit...*

| **5** :$

```console
gedit ODT-FILE.odt
```

*Close the file in gedit with <kbd>Ctrl</kbd> + <kbd>W</kbd>*

*Note .odt files are very big and can't be opened with text editors, but we can convert them...*

| **6** :$

```console
odt2txt ODT-FILE.odt
```

| **7** :$

```console
ls
```

*Note it either echoed the STDOUT in the terminal or created "ODT-FILE.txt"*

*This more reliably creates a .txt file:*

| **8** :$

```console
odt2txt ODT-FILE.odt > ODT-FILE.txt
```

| **9** :$

```console
ls
```

| **10** :$

```console
gedit ODT-FILE.txt
```

*Close the file in gedit with <kbd>Ctrl</kbd> + <kbd>W</kbd>, then delete the .txt file so we can try another way...*

| **11** :$

```console
rm ODT-FILE.txt
```

### Note `pandoc` does more than `odt2txt`

| **12** :$

```console
pandoc -s ODT-FILE.odt -o ODT-FILE.txt
```

| **13** :$

```console
ls
```

| **14** :$

```console
gedit ODT-FILE.txt
```

*Let's do markdown*

| **15** :$

```console
gedit markdown.md
```

*View the rendered markdown file: [markdown.md](https://github.com/inkVerb/301/blob/master/markdown.md)*

*...convert that into LibreOffice Writer document...*

| **16** :$

```console
pandoc -s markdown.md -o markdown.odt
```

| **17** :$

```console
ls
```

| **18** :$ *(if asked, Discard)*

```console
lowriter markdown.odt &
```

*You may close LibreOffice Writer from the GUI, or the terminal with: `killall soffice.bin`*

#### The `pandoc` tool can be glitchy if you do something too complex, but it handles:
- plain text
- LaTex
- ConTeXt
- TeX math
- HTML (incl TOC & CSS)
- markdown
- RTF
- PDF
- ODT
- DOCX
- EPUB
- MediaWiki
- `man` page
- ...and more!

### II. `read`

| **19** :$

```console
read
```

*Now type something and/or press Enter*

*Nothing happened because it should be used with a variable...*

| **20** :$

```console
read Variable
```

| **21** :$

```console
echo $Variable
```

| **22** :$

```console
gedit 02-read-1
```

| **23** :$

```console
./02-read-1
```

*Now type something, then press Enter*

| **24** :$

```console
gedit 02-read-2
```

*Note -p is for "Prompt", making things simpler*

| **25** :$

```console
./02-read-2
```

| **26** :$

```console
gedit 02-read-3
```

| **27** :$

```console
ls
```

| **28** :$

```console
./02-read-3
```

*Enter whatever you want, only letters & numbers, no spaces*

| **29** :$

```console
ls
```

*Note it created the file*

| **30** :$

```console
gedit 02-read-4
```

| **31** :$

```console
./02-read-4
```

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

*Note `-r` is for "Raw", to allow all special characters*

| **32** :$

```console
gedit 02-read-5
```

| **33** :$

```console
./02-read-5
```

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

### III. `sleep`

| **34** :$

```console
sleep 1
```

| **35** :$

```console
sleep 3
```

| **36** :$

```console
gedit 02-sleep-1
```

| **37** :$

```console
./02-sleep-1
```

| **38** :$

```console
gedit 02-sleep-2
```

| **39** :$

```console
./02-sleep-2 "I like apples."
```

*Put it together...*

| **40** :$

```console
gedit 02-sleep-3
```

| **41** :$

```console
./02-sleep-3
```

*Now type something, then press Enter*

### IV. `wait`

*`wait` will "wait" until the previous command finishes before moving on. It keeps Shell from stumbling over its own feet. Sometimes, scripts break and the solution is to `wait`.*

***Let's `wait` for LibreOffice Writer:***

*Make sure LibreOffice is not running, ignore any error message...*

| **42** :$

```console
killall soffice.bin
```

*Open LibreOffice Writer from the terminal...*

| **43** :$

```console
lowriter
```

*Now, close Writer in the GUI (click the X to close the window)...*

*...The terminal returns to the prompt*

| **44** :$

```console
lowriter &
```

*Note the terminal returned directly to the prompt because we used `&`*

*Again, close Writer in the GUI*

*Let's use `wait` in a script...*

| **45** :$

```console
gedit 02-waiter-1
```

| **46** :$

```console
./02-waiter-1
```

*Again, close Writer in the GUI, then watch for the message in the terminal*

| **47** :$

```console
gedit 02-waiter-2
```

| **48** :$

```console
./02-waiter-2
```

*Note that the script finished with it's message and the terminal returned to the prompt without closing Writer*

*Again, close Writer in the GUI*

| **49** :$

```console
gedit 02-waiter-3
```

| **50** :$

```console
./02-waiter-3
```

*Note the script did not finish and the terminal is still busy*

*...Now, close Writer in the GUI and watch for the message in the terminal*

*...Now, watch the script open Writer again after "waiting" for the first process to close*

*...Now, close Writer in the GUI again and watch the final message in the terminal*

***Next, do the same thing manually:***

*Start Writer...*

| **51** :$

```console
lowriter &
```

*Now, "wait" for it to close by watching for its PID to close...*

| **52** :$

```console
pgrep lowriter
```

*Note the PID number and replace 55555 with that number below:*

| **53a** :$

```console
wait 55555
```

**OR**

| **53b** :$ *(or you can use this instead)*

```console
wait $(pgrep lowriter)
```

*Note `wait` is "waiting" for Writer's PID to end*

*...Now, close Writer in the GUI, then `wait` will report the process as "Done" in the terminal*

___

# The Take

- `odt2txt` converts an .odt file into a raw text file
- `pandoc` can do many more conversions than `odt2txt`, including markdown, PDF, EPUB, and even MediaWiki!
- `read` accepts STDIN input and sets it as a variable
  - It has many options, but it is a simple way to let the human input variables during a script
- `sleep` will wait a number of seconds, then continue
  - This can be useful in scripts, such as pausing the needed 2 seconds between Apache web server restarts
- `wait` "waits" for the previous process to finish until moving on
  - This can prevent busy scripts from breaking
  - `wait` without arguments will simply wait for the previous process
  - `wait PID` will wait for a specific process to end, by PID
  - You can add `; wait` to the end of a command line in a script, if you go for that sort of thing
  - *Note do not use `command &; wait` because `&` and `;` can't work together*

___

#### [Lesson 3: for Var in Lst do done](https://github.com/inkVerb/vip/blob/master/301/Lesson-03.md)
