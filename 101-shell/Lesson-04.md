# Shell 101
## Lesson 4: Setting Variables & Setting Files

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit abcsed abcsed.setting abcd`

*Update abcsed to version 05:*
```sh
#!/bin/sh

myFOO=$1
myBAR=$2
myFILE=$3

sed -i "s/$myFOO/$myBAR/g" $myFILE
# Set the variables first, then use them in the sed command
# v05
```

| **2** : `./abcsed h z abcd`

*gedit: Reload abcd*

| **3** : `./abcsed z j abcd`

*gedit: Reload abcd*

*Update abcsed to version 06:*
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

*Create abcsed.setting as this:*
```sh
myFILE=abcd
```

| **4** : `./abcsed i z`

*gedit: Reload abcd*

| **5** : `./abcsed z j`

*gedit: Reload abcd*

*Note this format "includes" or "sources" the text of any file as if it was text of the script itself*

```sh
. some/file/with/text/to/be/included
```

___

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

#### [Lesson 5: Variables from Pipe & Command Substitution](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-05.md)
