# Linux 101
## Lesson 1: gedit, echo & sed

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
echo "Output to terminal"
```

*The "**input**" you enter into the terminal is called: "`STDIN`"*

*The "**output**" you see in the terminal is called: "`STDOUT`"*

*Below, the `STDIN` is `echo "Hello ink!"` and the `STDOUT` is `Hello ink!`*

| **2** :$

```console
echo "Hello ink!"
```

| **3** :$

```console
echo "abcdefghijklmnopqrstuvwxyz"
```

| **4** :$

```console
ls
```

*See, there are no **files** here*

*We can send `STDOUT` (output) to a file with: `> somefile`*

| **5** :$

```console
echo "Output to file" > abcd
```

| **6** :$

```console
ls
```

*See, now there's a new file here*

| **7** :$

```console
gedit abcd
```

*See the **contents** of the file*

| **8** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" > abcd
```

*gedit: **Reload***

*Note `>` will **overwrite** file contents, what we had before is gone*

| **9** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" >> abcd
```

*gedit: Reload*

*Note `>>` will **append** file contents, what we had before is still there, plus what we just added*

| **10** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" >> abcd
```

*gedit: Reload*

*Note the **number** of **lines***

| **11** :$

```console
echo "foo :-)" >> abcd
```

*gedit: Reload*

| **12** :$

```console
sed -i "s/foo/bar/" abcd
```

*gedit: Reload*

*Note `foo` ware **replaced** with `bar`*

| **13** :$

```console
sed -i "s/bar//" abcd
```

*gedit: Reload*

| **14** :$

```console
echo "add foo and then some" >> abcd
```

*gedit: Reload*

| **15** :$

```console
sed -i "s/foo/bar/" abcd
```

*gedit: Reload*

*Note the line number of "add bar and then some"*

| **16** :$

```console
sed -i "/bar/d" abcd
```

*gedit: Reload*

*Note the line with "bar" is gone; we **deleted** it*

| **17** :$

```console
echo "Replace this Apple delBar line." >> abcd
```

*gedit: Reload*

| **18** :$

```console
sed -i "/Replace.*/ c\The line with Mr. Apple delBar has been replaced" abcd
```

*gedit: Reload*

*<kbd>Ctrl</kbd> + <kbd>D</kbd> deletes a line in gedit*
- Use <kbd>Ctrl</kbd> + <kbd>D</kbd> to delete the line about "Mr. Apple delBar"
- Then <kbd>Ctrl</kbd> + <kbd>S</kbd> to **save** the file

___

# Glossary
- **append** - adding more contents to the end of a file, not overwriting what was already there
- **contents** - what is inside a file
- **delete** - remove something, either text, a line of a file, or a file itself
- **input** - what we enter into the terminal
- **input/output** - terminal CLI interaction is either input or output
- **file** - individual items on the disk, with names and contents, shown in the terminal with the `ls` command
- **lines** - numberd rows of the contents in a file
- **(line) number** - the numbers that identify each line of a file
- **output** - what the terminal displays in response to input
- **overwrite** - remove any file contents from before, place new file contents in its place
- **reload** - to restart part of a running process
- **replace** - changing specific text to a different text, usually within a file's contents
- **save** - write the contents of a file to the disk so that the changes remain

# The Take
- Computers (the terminal also) work with *input* & *output*
- `STDIN` = input
- `STDOUT` = output
- `echo` is a command that inputs something for simple text output
- `echo` can send output to a file with `>` & `>>`
- `ls` "lists" what's in the current directory as output (`STDOUT`)
- `sed` can replace or delete text in a file
- `sed` uses "d" to delete a line
- Gedit usees **<kbd>Ctrl</kbd> + <kbd>D</kbd>** to delete a line

___

#### [Lesson 2: Arguments & Variables](https://github.com/inkVerb/vip/blob/master/101/Lesson-02.md)
