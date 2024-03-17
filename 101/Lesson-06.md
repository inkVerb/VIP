# Linux 101
## Lesson 6: tee & < file input

Ready the CLI

```console
cd ~/School/VIP/101
```

___

## `tee` = T

| **1** :$

```console
gedit applefoo
```

| **2** :$

```console
sed "s/foo/bar/" applefoo
```

| **3** :$

```console
sed "s/foo/bar/" applefoo > sedoutput.text
```

| **4** :$

```console
gedit sedoutput.text
```

| **5** :$

```console
echo "Add a line" >> sedoutput.text
```

*gedit: Reload sedoutput.text*

*Both `echo` and `sed` (without `-i`) will send output to the terminal*

*But, `sed -e ... > ` and `echo ... > ` will output to a file*

*But better yet, piping into `tee` will do both!*

| **6** :$

```console
sed "s/foo/bar/" applefoo | tee sedoutput.text
```

*gedit: Reload sedoutput.text*

*Note `tee` used two **output destinations***

| **7** :$

```console
echo "Add a line" >> sedoutput.text
```

*gedit: Reload sedoutput.text*

| **8** :$

```console
sed "s/foo/bar/" applefoo | tee -a sedoutput.text
```

*gedit: Reload sedoutput.text*

| **9** :$

```console
echo "Add a line" | tee -a sedoutput.text
```

*gedit: Reload sedoutput.text*

## `<` File Input Source
- Many commands use a file as the final argument to indicate the source of the command's input, eg: `somefile`
  - `cat somefile`
  - `sed 's/foo/bar/' somefile`
- The input file can be prefixed with an input indicator `<`, which is often redundant, eg:
  - `cat < somefile`
  - `sed 's/foo/bar/' < somefile`
- An input file can be very useful to automate input responses to an interactive script

We will explore more of the `read` command in [Linux 301 Lesson 2](https://github.com/inkVerb/vip/blob/master/301/Lesson-02.md)

*Create a simple, **interactive** script*

| **10** :$

```console
gedit interact
```

*Create `interact` as this:*

| **interact** :

```sh
#!/bin/sh

read input1
echo $input1

read input2
echo $input2

read input3
echo $input3
```

*Make it executable*

| **11** :$

```console
chmod ug+x interact
```

*Run the command; each time it prompts, type anything and then press <key>Enter</key>

| **12** :$

```console
./interact
```

*Now, let's create a file to input those prompt responses automatically*

| **13** :$

```console
gedit answers
```

*Create `answers` as this:*

| **answers** :

```
answer one
Second
my last answer
```

*Run `interact` automatically getting prompted response input from `< answers`*

| **14** :$

```console
./interact < answers
```

*Freely change and save `answers`, running the command many times to see the difference*

| **15** :$

```console
./interact < answers
```

*We can also send all interactive responses we used in `answers` through a **heredoc***

We will explore more about heredocs in [Linux 401 Lesson 11](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md)

| **16** :$

```console
./interact <<EOF
answer one
Second
my last answer
EOF
```

*The heredoc consists of everything between the `EOF` **delimiters**, behaving the same as an input file, but all included within the same command*

*The delimeter can be anything, `EOF` is common, as is `EOS`, but it can be anything*

___

# Glossary
- **file source input** - indicates a file that becomes input for a command; done with `< somefile` at the end of a command
- **delimeter** - text that starts and stops parts of longer text operation
  - A heredoc uses `EOF`, `EOS`, or anything
  - Our `sed` commands have been using `/` slash, but it also could be `:` as in `sed "s:foo:bar:"` or `?` as in `sed "s?foo?bar?"` etc
- **heredoc** - file contents placed inside a command, usually using `<<EOF` or `<<EOS` or something similar
- **interactive** - a script or running program asking questions for responses inside the CLI terminal
- **output destination** - where output goes; `tee` uses two while almost every other command only uses one
- **response** - the "answer" to an interactive script or running program
  - A user can type the response to questions in the terminal
  - Or the responses can be given by a file source input

# The Take
## `tee`
- Several commands can be combined into one command, including an output file
- "Piping" output into "tee" (`command | tee output-file`) sends the `STDOUT` output to both the output file *and* is displayed as raw output in the terminal
- `| tee` will overwrite the destination file!
- `| tee -a` will append the destination file instead of overwriting
- `| tee` can be used with many commands

## File Input
- `command < inputfile` indicates input from a file
  - For many commands, this would be redundant
  - For interactive commands, each line of the input file can be an `STDIN` input response
  - A [heredoc](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md#iii-heredoc-cat-eof) can also be used in place of the input file, which we will explore in depth in [Linux 401 Lesson 11](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md)

___

#### [Lesson 7: cat vs echo](https://github.com/inkVerb/vip/blob/master/101/Lesson-07.md)
