# VIP Cheat Sheets

### [chmod](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/chmod.md)

___
### [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)

___
### [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___
### [Arrays](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Arrays.md)

### Style & Documents

[GitHub's Markdown](https://github.com/sindresorhus/github-markdown-css)

Convert documents that use [Markdown CSS](https://github.com/otsaloma/markdown-css)

Combine and manipulate .pdf files
```shell

# Rotate clockwise
pdftk 1.pdf cat 1-endeast output 1-rotated.pdf

# Rotate counterclockwise
pdftk 1.pdf cat 1-endwest output 1-rotated.pdf
# Thanks https://unix.stackexchange.com/questions/394065/command-line-how-do-you-rotate-a-pdf-file-90-degrees

# Combine .pdf files into one
pdfunite 1.pdf 2.pdf 3.pdf 4.pdf 5.pdf combined-final.pdf

```
