# Linux 101
## Lesson 2: Arguments & Variables

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
gedit abcsed abcd
```

*Note the two tabs in gedit; abcsed is open, but the file does not exist*

### Say "HaSHSHSH" `#`

### Say "BANG!" `!`

### Say "shebang" `#!`

## shebang in Shell scripts

*"**shebang**" is what we call the `#!` in a Shell **script***

*Now, to our first Shell script...*

*Create abcsed as this:*

| **abcsed** : v01

```sh
#!/bin/sh

sed -i "s/$1/z/" abcd

# v01
```

*Look at the first line*

*Note line one with the "shebang" `#!/bin/sh` is what makes this file a "Shell script" that we can run or "execute"*

| **2** :$

```console
./abcsed
```

*Note the **error message***

| **3** :$

```console
ls -l
```

*Note the colors of the files and letters "-rw-"*

| **4** :$

```console
chmod ug+x abcsed
```

| **5** :$

```console
ls -l
```

*Note the colors of the files and letters "-rwx"*

*The `x` and the file beeing green means the file is now **executable***

| **6** :$

```console
./abcsed a
```

*Now, it works, no error message*

*gedit: Reload `abcd`*

| **7** :$

```console
./abcsed b
```

*gedit: Reload `abcd`*

| **8** :$

```console
./abcsed c
```

*gedit: Reload `abcd`*

***Update** `abcsed` to **version** 02:*

| **abcsed** : v02

```sh
#!/bin/sh

sed -i "s/$1/$2/" abcd

# v02
```

| **9** :$

```console
./abcsed d z
```

*gedit: Reload `abcd`*

| **10** :$

```console
./abcsed e z
```

*gedit: Reload `abcd`*

| **11** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

| **12** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

| **13** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

*Update `abcsed` to version 03:*

| **abcsed** : v03

```sh
#!/bin/sh

sed -i "s/$1/$2/g" abcd

# v03
```

*Note "`g`" to "globally" replace every occurance per line*

| **14** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

| **15** :$

```console
./abcsed f z
```

*gedit: Reload `abcd`*

| **16** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

| **17** :$

```console
echo "Apples like foo." >> applefoog
```

| **18** :$

```console
gedit applefoo
```

*Update `abcsed` to version 04:*

| **abcsed** : v04

```sh
#!/bin/sh

sed -i "s/$1/$2/g" $3

# v04
```

| **19** :$

```console
./abcsed foo bar applefoo
```

*gedit: Reload `applefoo`*

| **20** :$

```console
./abcsed g z abcd
```

*gedit: Reload `abcd`*

| **21** :$

```console
./abcsed z j abcd
```

*gedit: Reload `abcd`*

___

# Glossary
- **error message** - text output that explains why there is a problem with the input or process
- **executable** - a setting on a file so the file can be "run" as a process, needed for scripts
- **global** - in all places, everywhere
- **script** - a file with many CLI commands which run automatically from a file
- **shebang** - the code `#!` which works at a file's first line
- **update** - make changes to the newest available version
- **version** - the new code when a file or program is changed, each has its own number

# The Take
- Gedit can open multiple files from the terminal
- Sometimes, programmers create a Shell script or any file by copying and pasting the entire contents of the file from a webpage
- `#!` is read "shebang"
- `#!/bin/sh` on line 1 of a file makes it a Shell script
- "Running" a command in the terminal may also be called "executing" the command
- Shell scripts can't be run unless they are made "executable", usually with: `chmod ug+x SHELL-SCRIPT-FILE`
- `sed` commands can work inside a Shell script just as in a terminal
- A command is followed by "arguments", which are separated by spaces
  - In `sed -i "s/foo/bar/" file`, the "arguments" are: `-i "s/foo/bar/" file`
  - In `gedit file1 file2`, the "arguments" are: `file1 file2`
- Shell scripts can also be followed by "arguments" separated by spaces
- `$1`, `$2`, `$3`, etc, are the Shell "arguments" that change things inside their Shell script

___

#### [Lesson 3: Arguments & Variables Review](https://github.com/inkVerb/vip/blob/master/101/Lesson-03.md)
