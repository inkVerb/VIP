# Shell 301
## Lesson 2: odt2txt, pandoc, rename, sleep & read

`cd ~/School/VIP/shell/301`

___

### I. `odt2txt` & `pandoc`

*Prep, copy, and cd in one command*

| **1** : `mkdir one && cp *.odt one && cp markdown.md one && cd one`

*Convert .odt files to .txt*

| **2** : `ls`

| **3** : `lowriter *.odt &` (may need a few seconds to load, then press Enter)

*Note the contents of the .odt files*

| **4** : `odt2txt ODT-FILE.odt`

*If you revieve an error because LibreOffice Writer is running, close all LO Writer sessions wtih this simple hack, then try again:*

| **5** : `killall soffice.bin`

*Now, try this*

| **6** : `odt2txt ODT-FILE.odt`

| **7** : `ls`

*Note it either echoed the STDOUT in the terminal or created "ODT-FILE.txt"*

*This more reliably creates a .txt file:*

| **8** : `odt2txt ODT-FILE.odt > ODT-FILE.txt`

| **9** : `cat ODT-FILE.txt`

*Delete the .txt file*

| **10** : `rm ODT-FILE.txt`

| **11** : `ls`

### Note `pandoc` does more than `odt2txt`

| **12** : `pandoc -s ODT-FILE.odt -o ODT-FILE.txt`

| **13** : `ls`

| **14** : `cat ODT-FILE.txt`

*Let's do markdown*

| **15** : `pandoc -s markdown.md -o markdown.odt`

| **16** : `ls`

| **17** : `lowriter markdown.odt &` *(if asked, Discard)*

*View the rendered file* [markdown.md](https://github.com/inkVerb/301/blob/master/markdown.md)

| **18** : `killall soffice.bin`

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

| **19** : `cd ~/School/VIP/shell/301/one`

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

*Now you have to type something, then press Enter*

| **41** : `gedit 02-read-2`

*Note -p is for "Prompt", making things simpler*

| **42** : `./02-read-2`

| **43** : `gedit 02-read-3`

| **44** : `ls`

| **45** : `./02-read-3`

| **46** : `ls`

*Note it created the file*

| **47** : `gedit 02-read-4`

| **48** : `./02-read-4`

*Copy-paste this with "special" characters:* `Yo & ^^ / hello \ \ \ Dolly! :-)`

*Note -r is for "Raw", to allow all special characters*

| **49** : `gedit 02-read-5`

| **50** : `./02-read-5`

*Copy-paste this with "special" characters:* `Yo & ^^ / hello \ \ \ Dolly! :-)`

| **51** : `gedit 02-read-6`

| **52** : `./02-read-6`

___

# The Take

-

___

#### [Lesson 3: for VAR in WUT do done](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-03.md)
