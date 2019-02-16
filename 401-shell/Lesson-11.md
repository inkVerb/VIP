# Shell 401
## Lesson 11: Characters & 'heredoc' `cat <<EOF`

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Construction

### I. heredoc `cat <<EOF`

cat <<EOF (https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash)

### II. Characters Classes

*Refer to this cheat-sheet section for more about working with characters:* [VIP/Cheet-Sheets: Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

1. In `sed` & `grep` use `[[double brackets]]` not `[single brackets]`
2. Carrot `^` means "only first in the line".

**Examples:**

`grep "^[[:upper:]]" code-of-poetry.txt`

`grep "^[[:punct:]]" code-of-poetry.txt`

`grep "^[[:digit:]]" code-of-poetry.txt`

*Note no results because no digits appear first on any line.*

*Try without the carrot `^`...*

`grep "[[:digit:]]" code-of-poetry.txt`

`grep "^[[:lower:]]" code-of-poetry.txt`

*Try some simple replacements...*

`sed "s/[[:digit:]]/#/g" code-of-poetry.txt`

*Cpombine that with `grep` to show only what it affects...*

`grep "[[:digit:]]" code-of-poetry.txt | sed "s/[[:digit:]]/#/g"`

*More...*

`sed "s/[[:upper:]]/X/g" code-of-poetry.txt`

`sed "s/[[:punct:]]/@/g" code-of-poetry.txt`

`sed "s/[[:blank:]]/_/g" code-of-poetry.txt`

*Custom ranges...*

`sed "s/[A-Z]/X/" code-of-poetry.txt`

`sed "s/[1-6]/%/" code-of-poetry.txt`

`sed "s/[a-z]/x/g" code-of-poetry.txt`

#### [Lesson 12: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-12.md)
