# Shell 401
## Lesson 11: RegEx Character Classes & Heredocs

Ready the CLI

```console
cd ~/School/VIP/401
```

- [Characters for Classes & RegEx](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

___

### I. RegEx Characters Classes

*For more about working with characters, refer to:* [VIP/Cheat-Sheets: Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

1. In `sed` & `grep` use `[[double brackets]]` not `[single brackets]`
2. Carrot `^` means "start of the line or string"
3. Dollar Sign `$` means "end of the line or string"

**Examples:**

| **1** :$

```console
gedit code-of-poetry.txt
```

| **2** :$

```console
grep "^[[:upper:]]" code-of-poetry.txt
```

| **3** :$

```console
grep "^[[:lower:]]" code-of-poetry.txt
```

| **4** :$

```console
grep "^[[:punct:]]" code-of-poetry.txt
```

| **5** :$

```console
grep "^[[:digit:]]" code-of-poetry.txt
```

*Note no results because no digits appear first on any line*

*Search for digits anywhere in each line without the carrot `^`...*

| **6** :$

```console
grep "[[:digit:]]" code-of-poetry.txt
```

*Search the end of each line with the dollar sign `$`...*

| **7** :$

```console
grep "[[:digit:]]$" code-of-poetry.txt
```

| **8** :$

```console
grep "[[:lower:]]$" code-of-poetry.txt
```

| **9** :$

```console
grep "[[:punct:]]$" code-of-poetry.txt
```

*Try some simple replacements...*

| **10** :$

```console
sed "s/[[:digit:]]/#/g" code-of-poetry.txt
```

*Combine that with `grep` to show only what it affects...*

| **11** :$

```console
grep "[[:digit:]]" code-of-poetry.txt | sed "s/[[:digit:]]/#/g"
```

*More...*

| **12** :$

```console
sed "s/[[:upper:]]/X/g" code-of-poetry.txt
```

| **13** :$

```console
sed "s/[[:punct:]]/@/g" code-of-poetry.txt
```

| **14** :$

```console
sed "s/[[:blank:]]/_/g" code-of-poetry.txt
```

*Custom ranges...*

| **15** :$

```console
sed "s/[D-H]/X/" code-of-poetry.txt
```

| **16** :$

```console
sed "s/[2-6]/%/" code-of-poetry.txt
```

| **17** :$

```console
sed "s/[a-u]/x/g" code-of-poetry.txt
```

### II. Space via `echo`

*`echo` a tab*

| **18** :$

```console
echo $'\t'
```

*`echo` a tab inside a string*

| **19** :$

```console
echo Some words$'\t'now a tab$'\t'othertab
```

*`echo` a new line*

| **20** :$

```console
echo $'n'
```

*`echo` a new line inside a string*

| **21** :$

```console
echo "First line"$'\n'now another line
```

*`echo` new lines and tabs and concatenate string segments using "double quotes"*

| **22** :$

```console
echo "First line then"$'\n'now "another" line$'\t'"after tab"
```


### III. Heredoc: `cat <<EOF`

#### Rules of a heredoc
1. A "heredoc" is text in a script treated as a separate text document; useful for large amounts of text.
2. A heredoc is a multi-line argument for a command; the first line can pipe like a normal command.
3. A heredoc's "delimeter" (often `EOF` or `END`) can be anything, as long as both start and finish are the same.
4. A heredoc will render variables; a nowdoc won't.
    - **nowdoc**: Put the "delimeter" in 'single quotes' (`<<'EOF'`) or escape (`<<\EOF`) and variables won't render.
5. In non-Shell languages, "whitespace" can break a heredoc.

Format:
```sh
Shell_Command <<DELIMETER
DOCUMENT TEXT HERE
ON MANY LINES
DELIMETER
```

#### Common Examples:

*Copy-paste as one command, then again line-by-line:*

**Delimeter: `EOF`**

| **23** :

```sh
cat <<EOF
I am a super pumpkin.
I like python, zen, code, and poetry.
EOF
```

*Copy-paste as one command, then again line-by-line:*

**Delimeter: `END`**

| **24** :

```sh
cat <<END
I am a here document.
This is what I am.
I'm at my end.
END
```

#### Heredocs Applied

| **25** :$

```console
ls
```

*Copy-paste as one command, then again line-by-line:*

**Output to file:**

| **26** :

```sh
cat <<EOF > neweof
I am a here document.
This is what I am.
I'm at my end.
EOF
```

| **27** :$

```console
ls
```

*Note the new file created: "neweof"*

| **28** :$

```console
gedit neweof
```

*You can pipe a heredoc this way:*

**Pipe output to another command:**

| **29** :

```sh
cat <<EOF | sed "s/foo/bar/g" | tee neweofpipe
I am foo piped in foo.
foo sed what I am piped for.
I'm at my pipe's foo end.
EOF
```

| **30** :$

```console
ls
```

*Note the new file created: "neweofpipe"*

| **31** :$

```console
gedit neweofpipe
```

*You can start with `tee`:*

**Tee a heredoc:**

| **32** :

```sh
tee neweoftee <<EOF
I am teed out.
Tee is what I am teed for.
I'm at my tee's end.
EOF
```

| **33** :$

```console
ls
```

*Note the new file created: "neweoftee"*

| **34** :$

```console
gedit neweoftee
```

**Heredoc as variable in a script:**

*Edit this script to see the short version*

| **35** :$

```console
gedit eofcomsub
```

*It should look like this:*

| **eofcomsub** :

```sh
#!/bin/sh

# Declare the variable and start the heredoc on one line
EOFvar=$(cat <<EOF
I'm the heredoc variable.
I have multiple lines.
I done.
EOF
)
# End the heredoc with the normal $() format, but on multiple lines

echo "No quote echo:"
echo $EOFvar

echo "Quoted echo:"
echo "$EOFvar"
```

*Run it*

| **36** :$

```console
./eofcomsub
```

*Note echoing without "quotes" makes everything appear on one line.*

**Heredoc containing variables in a script:**

*Edit this script to see the short version*

| **37** :$

```console
gedit eofvarheredoc
```

*It should look like this:*

| **eofvarheredoc** :

```sh
#!/bin/sh

# Set a variable to include
myVariable="I AM A VARIABLE VALUE!"

# Declare the variable and start the heredoc on one line
cat <<EOF
I'm heredoc text.
$myVariable
EOF
```

*Run it*

| **38** :$

```console
./eofvarheredoc
```

**Nowdoc cancels variables in a script:**

*Edit this script to see the short version*

| **39** :$

```console
gedit eofvarnowdoc
```

*It should look like this:*

| **eofvarnowdoc** :

```sh
#!/bin/sh

# Set a variable, but it won't work
myVariable="I AM A VARIABLE VALUE!"

# Declare the variable and start the nowdoc on one line
cat <<'EOF'
I'm nowdoc text.
$myVariable
EOF
```

*Run it*

| **40** :$

```console
./eofvarnowdoc
```

**Write to file via heredoc and nowdoc in a script:**

*Edit this script to see the short version*

| **41** :$

```console
gedit eofherenow
```

*It should look like this:*

| **eofherenow** :

```sh
#!/bin/sh

# Set a variable, but it won't work
myVariable="I AM A VARIABLE VALUE!"

# Do a nowdoc to file "eofout"
cat <<'EOF' >> eofout
I'm nowdoc text.
$myVariable
EOF

# Do a heredoc to append file "eofout"
cat <<EOF >> eofout
I'm heredoc text.
$myVariable
EOF
```

*Run it*

| **42** :$

```console
./eofherenow
```

| **43** :$

```console
gedit eofout
```

**Cancel `$Variables` via `\$` in a heredoc**

*Edit this script to see the short version*

| **44** :$

```console
gedit eofvariables
```

*It should look like this:*

| **eofvariables** :

```sh
#!/bin/sh

# Set a variable, but it won't work
myVariable="I AM A VARIABLE VALUE!"

# Do a heredoc to append file "eofout"
EOFvar=$(cat <<EOF
I have a variable.
Working: $myVariable
Cancel: \$myVariable
EOF
)

# Let's see
echo "$EOFvar"
```

*Run it*

| **45** :$

```console
./eofvariables
```

*Refer to this Wikipedia article about heredocs in Unix: [Here document](https://en.wikipedia.org/wiki/Here_document#Unix_shells)*

___

# The Take

## RegEx Character Classes
- A "character class" is a group of character types
- Character classes are part of creating a "RegEx" (as introduced in [Lesson 101-11](https://github.com/inkVerb/vip/blob/master/101/Lesson-11.md))
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

## Heredocs
- `cat <<EOF` opens a heredoc
- `EOF` closes the same heredoc
- `EOF` could be anything, as long as the open and close are the same text
  - `END`
  - `hErEdoC`
  - `DOC`
  - `LSTeverUwant`
  - *This is called a* ***"delimeter"***
  - All lines between the delimeters will be the heredoc contents
- `cat <<EOF > file-name` will send the heredoc to a file
- `cat <<EOF >> file-name` will append the heredoc to a file
- `cat <<EOF | sed...` will pipe the heredoc to `sed`, same as other commands
- `tee file-name <<EOF` will `tee` the heredoc
- Heredocs can use variables, cancel them with `\$` as in `\$Variable`

## Nowdocs (heredoc without variables)
- `cat <<'EOF'` opens a nowdoc, note the `'single quotes'`
  - Or with escape `cat <<\EOF`
- Variables will be included as code, not as their values
- Everything else is the same as a heredoc

## Applied
- *Heredocs easily have multiple lines and lots of text, this is their advantage.*
- A Shell script treats a heredoc as a separate document
- A heredoc can be very useful
  - Embed an email into a Shell script
  - Put a long set of instructions on the screen for terminal interaction
  - Place a blog post into a script
- *In other languages (ie PHP):* "whitespace" can break a heredoc
  - Don't include extra spaces/tabs inside your heredoc, even for code style
  - This does not apply to Shell and BASH

### Know the [rules of a heredoc](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md#rules-of-a-heredoc)
___

#### [Lesson 12: Secure Scripting & Command Hacks](https://github.com/inkVerb/vip/blob/master/401/Lesson-12.md)
