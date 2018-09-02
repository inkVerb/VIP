# Shell 301
## Lesson 2: odt2txt, pandoc, rename, sleep & read

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`


___

### I. `odt2txt` & `pandoc`

*Prep, copy, and cd in one command*

`mkdir one && cp *.odt one && cp markdown.md one && cd one`

*Convert .odt files to .txt*

`ls`

`lowriter *.odt &` (may need a few seconds to load, then press Enter)

*Note the contents of the .odt files*

`odt2txt ODT-FILE.odt`

*If you revieve an error because LibreOffice Writer is running, close all LO Writer sessions wtih this simple hack, then try again:*

`killall soffice.bin`

*Now, try this*

`odt2txt ODT-FILE.odt`

`ls`

*Note it either echoed the STDOUT in the terminal or created "ODT-FILE.txt"*

*This more reliably creates a .txt file:*

`odt2txt ODT-FILE.odt > ODT-FILE.txt`

`cat ODT-FILE.txt`

*Delete the .txt file*

`rm ODT-FILE.txt`

`ls`

### Note `pandoc` does more than `odt2txt`

`pandoc -s ODT-FILE.odt -o ODT-FILE.txt`

`ls`

`cat ODT-FILE.txt`

*Let's do markdown*

`pandoc -s markdown.md -o markdown.odt`

`ls`

`lowriter markdown.odt &` *(if asked, Discard)*

*View the rendered file* [markdown.md](https://github.com/inkVerb/301/blob/master/markdown.md)

`killall soffice.bin`

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

`cd ~/School/VIP/shell/301/one`

___

`ls`

`touch 1.t.one 2.t.one 3.t.one 4.t.one 1.c.one 2.c.one 3.c.one 4.c.one one one-1 one-2 one-3 one-4 one-5 one-1-c one-2-c one-3-c one-4-c one-5-c one-1-t one-2-t one-3-t one-4-t one-5-t`

`ls`

`rename "s/one/TWO/" *`

`ls`

`rename "s/TWO/one/" *`

`ls`

`rename "s/\.t\./\.T\./" *`

`ls`

`rename "s/\.T\./\.t\./" *`

`ls`

`cd ..`

### III. `sleep`

`sleep 1`

`sleep 3`

`gedit 02-sleep-1`

`./02-sleep-1`

`gedit 02-sleep-2`

`./02-sleep-2 "I like apples."`

### IV. `read`

`read`

*Now type something and/or press Enter*

`gedit 02-read-1`

`./02-read-1`

*Now you have to type something, then press Enter*

`gedit 02-read-2`

*Note -p is for "Prompt", making things simpler*

`./02-read-2`

`gedit 02-read-3`

`ls`

`./02-read-3`

`ls`

*Note it created the file*

`gedit 02-read-4`

`./02-read-4`

*Copy-paste this with "special" characters:* `Yo & ^^ / hello \ \ \ Dolly! :-)`

*Note -r is for "Raw", to allow all special characters*

`gedit 02-read-5`

`./02-read-5`

*Copy-paste this with "special" characters:* `Yo & ^^ / hello \ \ \ Dolly! :-)`

`gedit 02-read-6`

`./02-read-6`

#### [Lesson 3: for VAR in WUT do done](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-03.md)
