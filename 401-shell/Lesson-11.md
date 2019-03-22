# Shell 401
## Lesson 11: Characters & Heredocs

`cd ~/School/VIP/shell/401`

___

### I. Heredoc `cat <<EOF`

#### Rules of Heredocs
1. A "heredoc" is text in a script treated as a separate text document.
2. A heredoc's "delimeter" (often 'EOF' or 'END') can be anything, as long as both uses are the same.
3. A heredoc is a multi-line argument for a command.
4. A heredoc conveniently handles large amounts of text.

Format:
```sh
SHELL_COMMAND <<DELIMETER
DOCUMENT TEXT HERE
ON MANY LINES
DELIMETER
```

#### Common Examples:

*Copy-paste as one command, then again line-by-line:*

**Delimeter: `EOF`**
```sh
cat <<EOF
I am a super pumpkin.
I like python, zen, code, and poetry.
EOF
```

*Copy-paste as one command, then again line-by-line:*

**Delimeter: `END`:**
```sh
cat <<END
I am a here document.
This is what I am.
I'm at my end.
END
```

#### Heredocs Applied

| **1** : `ls`

**Write text to a file:**
| **2** :
```sh
cat <<EOF | cat > neweof
I am a here document.
This is what I am.
I'm at my end.
EOF
```

| **3** : `ls`

*Note the new file created: "neweof"*

| **4** : `gedit neweof`

**Variable in a script:**

*Edit this script*

| **5** : `gedit eofvar`

*It should look like this:*

```sh
#!/bin/sh

# Declare the variable and start the heredoc on one line
EOFVAR=$(cat <<EOF
I'm the heredoc variable.
I have multiple lines.
I done.
EOF
)
# End the heredoc with the normal $() format, but on multiple lines

echo "No quote echo:"
echo $EOFVAR

echo "Quoted echo:"
echo "$EOFVAR"
```

*Run it*

| **6** : `./eofvar`

*Note echoing without "quotess" makes everything appears on one line.*

*Refer to this Wikipedia article about heredocs in Unix:* [Here document](https://en.wikipedia.org/wiki/Here_document#Unix_shells)

### II. Characters Classes

*Refer to this cheat-sheet section for more about working with characters:* [VIP/Cheet-Sheets: Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

1. In `sed` & `grep` use `[[double brackets]]` not `[single brackets]`
2. Carrot `^` means "only first in the line".

**Examples:**

| **7** : `grep "^[[:upper:]]" code-of-poetry.txt`

| **8** : `grep "^[[:punct:]]" code-of-poetry.txt`

| **9** : `grep "^[[:digit:]]" code-of-poetry.txt`

*Note no results because no digits appear first on any line.*

*Try without the carrot `^`...*

| **10** : `grep "[[:digit:]]" code-of-poetry.txt`

| **11** : `grep "^[[:lower:]]" code-of-poetry.txt`

*Try some simple replacements...*

| **12** : `sed "s/[[:digit:]]/#/g" code-of-poetry.txt`

*Cpombine that with `grep` to show only what it affects...*

| **13** : `grep "[[:digit:]]" code-of-poetry.txt | sed "s/[[:digit:]]/#/g"`

*More...*

| **14** : `sed "s/[[:upper:]]/X/g" code-of-poetry.txt`

| **15** : `sed "s/[[:punct:]]/@/g" code-of-poetry.txt`

| **16** : `sed "s/[[:blank:]]/_/g" code-of-poetry.txt`

*Custom ranges...*

| **17** : `sed "s/[A-Z]/X/" code-of-poetry.txt`

| **18** : `sed "s/[1-6]/%/" code-of-poetry.txt`

| **19** : `sed "s/[a-z]/x/g" code-of-poetry.txt`

___

# The Take

## Heredocs
- `cat <<EOF` opens a heredoc
- `EOF` closes the same heredoc
- `EOF` could be anything, as long as the open and close are the same text
  - `END`
  - `hErEdoC`
  - `DOC`
  - `WUTeverUwant`
  - *This is called a* ***"delimeter"***
- The opening `cat <<EOF | cat > file-name` will send the heredoc directly to a file
  - The lines after this, until `EOF`, will contain the heredoc sent to the file
- *Heredocs easily have multiple lines and lots of text, this is their advantage.*
- A Shell script treats a heredoc as a separate document
- A heredoc can be very useful
  - Embed an email into a Shell script
  - Putting a long set of instructions on the screen for terminal interaction
  - Placing a blog post into a script
  - Many, many more
- Know the rules of heredocs

## Character Classes
- A "character class" is a group of character types
- Examples
  - All uppercase
  - All lowercase
  - All letters
  - All numerals
  - All hexadecimal numerals (0-f, any case)
  - All numbers and letters
  - Punctuation characters
- Character classes are used by text tools, like `sed` & `grep`
- Classes use shortcuts Like
  - `[A-Z]` = `[:upper:]` = uppercase
  - `[0-9]` = `[:digit:]` = numeral digits
- See usage and examples here: [Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

##
___

#### [Lesson 12: $PATH Plus](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-12.md)
