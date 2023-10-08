# Shell 301
## Lesson 2: Docs & Pausing (odt2txt, pandoc, sleep, read & wait)

Ready the CLI

```console
cd ~/School/VIP/301
```

**FOR** | **2 - 19** :$

```console
cd one
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

| **19** :$ *(if asked, Discard)*

```console
cd ..
```

### II. `read`

| **20** :$

```console
read
```

*Now type something and press Enter*

*Nothing happened because it should be used with a variable...*

| **21** :$

```console
read Variable
```

*Now type something and press Enter*

| **22** :$

```console
echo $Variable
```

| **23** :$

```console
gedit 02-read-1
```

```sh
read myVariable
echo $myVariable
```

| **24** :$

```console
./02-read-1
```

*Now type something, then press Enter*

| **25** :$

```console
gedit 02-read-2
```

*Note -p is for "prompt", making things simpler*

```sh
read -p "Some message" myVariable
echo $myVariable
```

| **26** :$

```console
./02-read-2
```

| **27** :$

```console
gedit 02-read-3
```

*Space and markers at the end of the "prompt" message is better*

```sh
read -p "Some message: " myVariable
echo $myVariable
```

| **28** :$

```console
ls
```

| **29** :$

```console
./02-read-3
```

*Enter whatever you want, only letters & numbers, no spaces*

| **30** :$

```console
ls
```

*Note it created the file*

| **31** :$

```console
gedit 02-read-4
```

*Escape "quote" marks in the prompt message*

```sh
read -p "Some \"quoted\" message: " myVariable
echo $myVariable
```

| **32** :$

```console
./02-read-4
```

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

*Note `-r` is for "Raw", to allow all special characters*

| **33** :$

```console
gedit 02-read-5
```

*This assumes that the user input will have special characters*

```sh
read -rp "Some  message: " myVariable
echo $myVariable
```

| **34** :$

```console
./02-read-5
```

*Copy-paste this with "special" characters: `Yo & ^^ / hello \ \ \ Dolly! :-)`*

### III. `sleep`

```sh
sleep 5
```

| **35** :$

```console
sleep 1
```

| **36** :$

```console
sleep 3
```

| **37** :$

```console
gedit 02-sleep-1
```

| **38** :$

```console
./02-sleep-1
```

| **39** :$

```console
gedit 02-sleep-2
```

| **40** :$

```console
./02-sleep-2 "I like apples."
```

*Put it together...*

| **41** :$

```console
gedit 02-sleep-3
```

| **42** :$

```console
./02-sleep-3
```

*Now type something, then press Enter*

### IV. `wait`

*`wait` will "wait" until the previous command finishes before moving on. It keeps Shell from stumbling over its own feet. Sometimes, scripts break and the solution is to `wait`.*

```sh
cp -r some/files to/new/dir/; wait
```

***Let's `wait` for LibreOffice Writer:***

*Make sure LibreOffice is not running, ignore any error message...*

| **43** :$

```console
killall soffice.bin
```

*Open LibreOffice Writer from the terminal...*

| **44** :$

```console
lowriter
```

*Now, close Writer in the GUI (click the X to close the window)...*

*...The terminal returns to the prompt*

| **45** :$

```console
lowriter &
```

*Note the terminal returned directly to the prompt because we used `&`*

*Again, close Writer in the GUI*

*Let's use `wait` in a script...*

| **46** :$

```console
gedit 02-waiter-1
```

| **47** :$

```console
./02-waiter-1
```

*Again, close Writer in the GUI, then watch for the message in the terminal*

| **48** :$

```console
gedit 02-waiter-2
```

| **49** :$

```console
./02-waiter-2
```

*Note that the script finished with it's message and the terminal returned to the prompt without closing Writer*

*Again, close Writer in the GUI*

| **50** :$

```console
gedit 02-waiter-3
```

| **51** :$

```console
./02-waiter-3
```

*Note the script did not finish and the terminal is still busy*

*...Now, close Writer in the GUI and watch for the message in the terminal*

*...Now, watch the script open Writer again after "waiting" for the first process to close*

*...Now, close Writer in the GUI again and watch the final message in the terminal*

***Next, do the same thing manually:***

*Start Writer...*

| **52** :$

```console
lowriter &
```

*Now, "wait" for it to close by watching for its PID to close...*

| **53** :$

```console
pgrep lowriter
```

*`wait` for a specific process to end*

```sh
wait [PID]

wait 90210
```

*Note the PID number and replace 55555 with that number below:*

| **54a** :$

```console
wait 55555
```

**OR**

| **54b** :$ *(or you can use this instead)*

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
