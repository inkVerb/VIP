# Shell 301
## Lesson 2: Docs & Pausing (odt2txt, pandoc, rename, sleep, read & wait)

Ready the CLI

`cd ~/School/VIP/shell/301`

___

### I. `odt2txt` & `pandoc`

*Prep, copy, and cd in one command*

| **1** : `mkdir one && cp *.odt one && cp markdown.md one && cd one`

*Convert .odt files to .txt*

| **2** : `ls`

| **3** : `lowriter *.odt &` *(may need a few seconds to load, then press Enter)*

*Note the contents of the .odt files*

*Close the file, just to make sure we don't have any problems...*

| **4** : `killall soffice.bin`

*Try to open one .odt file with gedit...*

| **5** : `gedit ODT-FILE.odt`

*Close the file in gedit with Ctrl + W*

*Note .odt files are very big and can't be opened with text editors, but we can convert them...*

| **6** : `odt2txt ODT-FILE.odt`

| **7** : `ls`

*Note it either echoed the STDOUT in the terminal or created "ODT-FILE.txt"*

*This more reliably creates a .txt file:*

| **8** : `odt2txt ODT-FILE.odt > ODT-FILE.txt`

| **9** : `ls`

| **10** : `gedit ODT-FILE.txt`

*Close the file in gedit with Ctrl + W, then delete the .txt file so we can try another way...*

| **11** : `rm ODT-FILE.txt`

### Note `pandoc` does more than `odt2txt`

| **12** : `pandoc -s ODT-FILE.odt -o ODT-FILE.txt`

| **13** : `ls`

| **14** : `gedit ODT-FILE.txt`

*Let's do markdown*

| **15** : `gedit markdown.md`

*View the rendered markdown file: [markdown.md](https://github.com/inkVerb/301/blob/master/markdown.md)*

*...convert that into LibreOffice Writer document...*

| **16** : `pandoc -s markdown.md -o markdown.odt`

| **17** : `ls`

| **18** : `lowriter markdown.odt &` *(if asked, Discard)*

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

### II. `rename`

`cd ~/School/VIP/shell/301/one` *(make sure we're in the right place)*

___

| **19** : `ls`

| **20** : `touch 1.t.one 2.t.one 3.t.one 4.t.one 1.c.one 2.c.one 3.c.one 4.c.one one one-1 one-2 one-3 one-4 one-5 one-1-c one-2-c one-3-c one-4-c one-5-c one-1-t one-2-t one-3-t one-4-t one-5-t`

| **21** : `ls`

| **22** : `rename "s/one/TWO/" *`

| **23** : `ls`

| **24** : `rename "s/TWO/one/" *`

| **25** : `ls`

| **26** : `rename "s/.t./.T./" *`

| **27** : `ls`

| **28** : `rename "s/.T./.t./" *`

| **29** : `ls`

| **30** : `cd ..`

### III. `read`

| **31** : `read`

*Now type something and/or press Enter*

*Nothing happened because it should be used with a variable...*

| **32** : `read Variable && echo $Variable`

| **33** : `gedit 02-read-1`

| **34** : `./02-read-1`

*Now type something, then press Enter*

| **35** : `gedit 02-read-2`

*Note -p is for "Prompt", making things simpler*

| **36** : `./02-read-2`

| **37** : `gedit 02-read-3`

| **38** : `ls`

| **39** : `./02-read-3`

*Enter whatever you want, only letters & numbers, no spaces*

| **40** : `ls`

*Note it created the file*

| **41** : `gedit 02-read-4`

| **42** : `./02-read-4`

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

*Note `-r` is for "Raw", to allow all special characters*

| **43** : `gedit 02-read-5`

| **44** : `./02-read-5`

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

### IV. `sleep`

| **45** : `sleep 1`

| **46** : `sleep 3`

| **47** : `gedit 02-sleep-1`

| **48** : `./02-sleep-1`

| **49** : `gedit 02-sleep-2`

| **50** : `./02-sleep-2 "I like apples."`

*Put it together...*

| **51** : `gedit 02-sleep-3`

| **52** : `./02-sleep-3`

*Now type something, then press Enter*

### V. `wait`

*`wait` will "wait" until the previous command finishes before moving on. It keeps Shell from stumbling over its own feet. Sometimes, scripts break and the solution is to `wait`.*

***Let's `wait` for LibreOffice Writer:***

*Make sure LibreOffice is not running, ignore any error message...*

| **53** : `killall soffice.bin`

*Open LibreOffice Writer from the terminal...*

| **54** : `lowriter`

*Now, close Writer in the GUI (click the X to close the window)...*

*...The terminal returns to the prompt*

| **55** : `lowriter &`

*Note the terminal returned directly to the prompt because we used `&`*

*Again, close Writer in the GUI*

*Let's use `wait` in a script...*

| **56** : `gedit 02-waiter-1`

| **57** : `./02-waiter-1`

*Again, close Writer in the GUI, then watch for the message in the terminal*

| **58** : `gedit 02-waiter-2`

| **59** : `./02-waiter-2`

*Note that the script finished with it's message and the terminal returned to the prompt without closing Writer*

*Again, close Writer in the GUI*

| **60** : `gedit 02-waiter-3`

| **61** : `./02-waiter-3`

*Note the script did not finish and the terminal is still busy*

*...Now, close Writer in the GUI and watch for the message in the terminal*

*...Now, watch the script open Writer again after "waiting" for the first process to close*

*...Now, close Writer in the GUI again and watch the final message in the terminal*

***Next, do the same thing manually:***

*Start Writer...*

| **62** : `lowriter &`

*Now, "wait" for it to close by watching for its PID to close...*

| **63** : `pgrep lowriter`

*Note the PID number and replace 55555 with that number below:*

| **64a** : `wait 55555`

**OR**

| **64b** : `wait $(pgrep lowriter)` *(or you can use this instead)*

*Note `wait` is "waiting" for Writer's PID to end*

*...Now, close Writer in the GUI, then `wait` will report the process as "Done" in the terminal*

___

# The Take

- `odt2txt` converts an .odt file into a raw text file
- `pandoc` can do many more conversions than `odt2txt`, including markdown, PDF, EPUB, and even MediaWiki!
- `rename` runs a find-and-replace for parts of file names
  - It uses syntax similar to `sed`
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

#### [Lesson 3: for VAR in LST do done](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-03.md)
