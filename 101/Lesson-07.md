# Linux 101
## Lesson 7: cat vs echo

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
gedit abcd sedoutput.text
```

*Remember `cat` outputs contents of a file as raw output (`STDOUT`)...*

| **2** :$

```console
cat abcd
```

*Remember `echo` sends whatever input (`STDIN`) as raw output (`STDOUT`)...*

| **3** :$

```console
echo $(cat abcd)
```

*...and `echo` doesn't **preserves** new lines for argued command substitution*

| **4** :$

```console
sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd
```

| **5** :$

```console
echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd)
```

| **6** :$

```console
cat abcd | tee sedoutput.text
```

*gedit: Reload `sedoutput.text`*

| **7** :$

```console
echo $(cat abcd) | tee sedoutput.text
```

*gedit: Reload `sedoutput.text`*

| **8** :$

```console
sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd | tee sedoutput.text
```

*gedit: Reload `sedoutput.text`*

| **9** :$

```console
echo $(sed "s/jjjjjjjjj/Apple likes to say abcdefghi and /" abcd) | tee sedoutput.text
```

*gedit: Reload `sedoutput.text`*

| **10** :$

```console
echo OneOneOne > one
```

| **11** :$

```console
echo TwoTwoTwo > two
```

| **12** :$

```console
cat one
```

| **13** :$

```console
cat two
```

| **14** :$

```console
cat one two
```

| **15** :$

```console
cat one two > onetwo
```

| **16** :$

```console
cat onetwo
```

*Note `cat` combined one and two into onetwo*

*Note note also that `cat` preserved the lines*

| **17** :$

```console
echo $(cat one two)
```

*Note `echo $(Command Substitution)` removed the new lines like it always does*

| **18** :$

```console
echo ThreeThreeThree > three
```

| **19** :$

```console
cat three two one >> onetwo
```

| **20** :$

```console
cat onetwo
```

*Note `cat` also appended `onetwo` via `>>`*

| **21** :$

```console
echo $(cat onetwo)
```

*Note `echo $(Command Substitution)` removed the new lines like it always does*

*...But it won't when we use "double quotes"...*

| **22** :$

```console
echo "$(cat onetwo)"
```

| **23** :$

```console
echo "$(cat abcd)"
```

___

# Glossary
- **preserve** - keeping and not changing; applies to many things in computer code
- **remove new lines** - new lines in text are not preserved and all the text resides on only one line

# The Take
- `echo` removes new lines when used to output a `$(cat file)` command substitution
- `cat` preserves new lines when used by itself
- `cat` can source from multiple files separated by spaces, *before* the output file indicator: `>`
- `cat` can append to an existing file with the output file indicator: `>>`

___

#### [Lesson 8: echo, sed, cat, tee & pipe scripts](https://github.com/inkVerb/vip/blob/master/101/Lesson-08.md)
