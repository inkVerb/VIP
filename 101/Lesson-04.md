# Linux 101
## Lesson 4: Setting Variables & Setting Files

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
gedit abcsed abcsed.setting abcd
```

*Update `abcsed` to version 05:*

| **abcsed** : v05

```sh
#!/bin/sh

myFOO=$1
myBAR=$2
myFILE=$3

sed -i "s/$myFOO/$myBAR/g" $myFILE
# Set the variables first, then use them in the sed command
# v05
```

*Note we **set** the variables*

| **2** :$

```console
./abcsed h z abcd
```

*gedit: Reload `abcd`*

| **3** :$

```console
./abcsed z j abcd
```

*gedit: Reload `abcd`*

*Update `abcsed` to version 06:*

| **abcsed** : v06

```sh
#!/bin/sh

myFOO=$1
myBAR=$2
. ./abcsed.setting

sed -i "s/$myFOO/$myBAR/g" $myFILE
# The variable $myFile comes from the setting file, include it this way:
#. ./abcsed.setting
# v06
```

*Create `abcsed.setting` as this:*

| **abcsed.setting** :

```sh
myFILE=abcd
```

| **4** :$

```console
./abcsed i z
```

*gedit: Reload `abcd`*

| **5** :$

```console
./abcsed z j
```

*gedit: Reload `abcd`*

*Note this line starting with a `.` period will "**source**" or "include" the text of any file as if it was text of the script itself*

```sh
. some/file/with/text/to/be/included
```

___

# Glossary
- **set** - assign a value to a variable, eg "set the variable"
- **source** - include another file's contents as part of the contents in a script; Shell starts a line with `.` to do this
  - ***include*** - the term for "source" in other computer languages, not the Shell language

# The Take
## Variables
- A variable (`$variable`) or argument (`$1`, `$2`, etc) can be used to set the value of another variable
- A variable name **must**:
  - Start with an uppercase or lowercase letter or underscore `_`
  - Contain only uppercase or lowercase letters, underscore `_`, or numerals `0–9`
- Variables are declared with NO spaces between the variable and equals sign `=`
  - `variable=VALUE` (no space before or after `=`)

## Source (include)
- A file can be "included" in a Shell script using: `. /included/file/here`
- This file path: `/included/file/here` is not an actual file, but represents any file you may use
- "Including" files with a small amount of content is one way to keep a "settings" file
- A "settings file" keeps track of "settings" changes without changing the actual Shell script file

___

#### [Lesson 5: Variables from Pipe & Command Substitution](https://github.com/inkVerb/vip/blob/master/101/Lesson-05.md)
