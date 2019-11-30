# Shell 301
## Lesson 2: Docs & Pausing (odt2txt, pandoc, rename, sleep, read & wait)

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

| **15** : `pandoc -s markdown.md -o markdown.odt`

| **16** : `ls`

| **17** : `lowriter markdown.odt &` *(if asked, Discard)*

*...that file came from this...*

| **18** : `gedit markdown.md`

*View the rendered markdown file: [markdown.md](https://github.com/inkVerb/301/blob/master/markdown.md)*

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

## II. `rename`

| **19** : `cd ~/School/VIP/shell/301/one` *(make sure we're in the right place)*

___

| **20** : `ls`

| **21** : `touch 1.t.one 2.t.one 3.t.one 4.t.one 1.c.one 2.c.one 3.c.one 4.c.one one one-1 one-2 one-3 one-4 one-5 one-1-c one-2-c one-3-c one-4-c one-5-c one-1-t one-2-t one-3-t one-4-t one-5-t`

| **22** : `ls`

| **23** : `rename "s/one/TWO/" *`

| **24** : `ls`

| **25** : `rename "s/TWO/one/" *`

| **26** : `ls`

| **27** : `rename "s/\.t\./\.T\./" *`

| **28** : `ls`

| **29** : `rename "s/\.T\./\.t\./" *`

| **30** : `ls`

| **31** : `cd ..`

### III. `sleep`

| **32** : `sleep 1`

| **33** : `sleep 3`

| **34** : `gedit 02-sleep-1`

| **35** : `./02-sleep-1`

| **36** : `gedit 02-sleep-2`

| **37** : `./02-sleep-2 "I like apples."`

### IV. `read`

| **38** : `read`

*Now type something and/or press Enter*

| **39** : `gedit 02-read-1`

| **40** : `./02-read-1`

*Now type something, then press Enter*

| **41** : `gedit 02-read-2`

*Note -p is for "Prompt", making things simpler*

| **42** : `./02-read-2`

| **43** : `gedit 02-read-3`

| **44** : `ls`

| **45** : `./02-read-3`

*Enter whatever you want, only letters & numbers, no spaces*

| **46** : `ls`

*Note it created the file*

| **47** : `gedit 02-read-4`

| **48** : `./02-read-4`

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

*Note -r is for "Raw", to allow all special characters*

| **49** : `gedit 02-read-5`

| **50** : `./02-read-5`

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

| **51** : `gedit 02-read-6`

| **52** : `./02-read-6`

*Now type something, then press Enter*

### V. `wait`

*`wait` will "wait" until the previous command finishes before moving on. It keeps Shell from stumbling over its own feet. Sometimes, scripts break and the solution is to `wait`.*

***Let's `wait` for LibreOffice Writer:***

*Open LibreOffice Writer from the terminal...*

| **53** : `lowriter &`

*Terminate all LibreOffice apps from the terminal...*

| **54** : `killall soffice.bin`

*Let's use `wait` in a script...*

| **55** : `gedit 02-waiter-1`

| **56** : `./02-waiter-1`

*Note that the script finished with it's message and the terminal returned to the prompt without closing Writer*

*...Now, close Writer in the GUI*

| **57** : `gedit 02-waiter-2`

| **58** : `./02-waiter-2`

*Note the script did not finish and the terminal is still busy*

*...Now, close Writer in the GUI and watch for the message in the terminal*

*...Now, watch the script open Writer again after "waiting" for the first process to close*

*...Now, close Writer in the GUI again and watch the final message in the terminal*

***Next, do the same thing manually:***

*Make sure LibreOffice is not running...*

| **59** : `killall soffice.bin`

*Start Writer...*

| **60** : `lowriter &`

*Now, "wait" for it to close by watching for its PID to close...*

| **61** : `pgrep lowriter`

*Note the PID number and replace 55555 with that number below:*

| **62a** : `wait 55555`

**OR**

| **62b** : `wait $(pgrep lowriter)` *(or you can use this instead)*

*Note `wait` is "waiting" for Writer's PID to end*

*...Now, close Writer in the GUI, then `wait` will report the process as "Done" in the terminal*

___

# The Take

- `odt2txt` converts an .odt file into a raw text file
- `pandoc` can do many more conversions than `odt2txt`, including markdown, PDF, EPUB, and even MediaWiki!
- `rename` runs a find-and-replace for parts of file names
  - It uses syntax similar to `sed`
- `sleep` will wait a number of seconds, then continue
  - This can be useful in scripts, such as pausing the needed 2 seconds between Apache web server restarts
- `read` accepts STDIN input and sets it as a variable
  - It has many options, but it is a simple way to let the human input variables during a script
- `wait` "waits" for the previous process to finish until moving on
  - This can prevent busy scripts from breaking
  - `wait` without arguments will simply wait for the previous process
  - `wait PID` will wait for a specific process to end, by PID
  - You can add `; wait` to the end of a command line in a script, if you go for that sort of thing
  - *Note do not use `command &; wait` because `&` and `;` can't work together*

___

#### [Lesson 3: for VAR in WUT do done](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-03.md)
