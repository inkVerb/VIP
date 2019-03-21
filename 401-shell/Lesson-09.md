# Shell 401
## Lesson 9: Interpreters, errors, logic, and empty testing

`cd ~/School/VIP/shell/401`

___

### I. Interpreters (Shells)

*That first "she-bang" line* **(#!/...)** *defines the "interpreter" or the shell.*

*There are many shells to choose from...*

- `#!/bin/sh`     Bourne shell
- `#!/bin/bash`   Bourne again shell
- `#!/bin/ash`    Almquist shell
- `#!/bin/dash`   Debian almquist shell
- `#!/bin/csh`    C shell *(Ha, get it?)*
- `#!/bin/tcsh`   TENEX C shell
- `#!/bin/ch`     Ch shell
- `#!/bin/eshell` Emacs shell
- `#!/bin/fish`   Friendly interactive shell
- `#!/bin/psh`    Pearl shell
- `#!/bin/rc`     rc shell
- `#!/bin/ksh`    Korn shell
- `#!/bin/zsh`    Z shell

*Be careful about writing code in too many different shells because your code may not work on all computers.*

*Generally,:*
- `[ "$QUOTING_TEST_VARIABLES" ]` can be important at different times in different shells
- safest is to always "quote", usually "double quote"; if you have problems try 'single quotes'
- `sh` (Bourne shell) *is simple, though mostly standard*
  - arithmetic comparison must use alphabet operators [`-lt`, `-gt`, `-le`, `-ge`, `-eq`, `-ne`]
  - arrays **are not** allowed in variables
- `bash` (Bourne again shell) *is much the same, more useful, but...*
  - arithmetic allows comparison symbol operators ((`<`, `>`, `=<`, `>=`, `==`, `!=`))
  - comparison operators require `((`double parentheses`))`
  - variables may contain arrays
  - *and, there may be other differences you can look into*

*Consider comparisons in Shell vs BASH:*

Shell:

*Edit this script*

| **1** : `gedit math-sh`

*It should look like this:*

```sh
#!/bin/sh

_5=5
_6=6

# Shell:
echo "Trying Shell..."
if [ $_5 -lt $_6 ]; then
echo "Less than! It works!"
fi

# BASH:
echo "Trying BASH..."
if (( $_5 < $_6 )); then
echo "Less than! It works!"
fi

```

| **2** : `./math-sh`

*Note the BASH operators only work with `#!/bin/bash`*

BASH:

*Edit this script*

| **3** : `gedit math-bash`

*It should look like this:*

```bash
#!/bin/bash

_5=5
_6=6

# Shell:
echo "Trying Shell..."
if [ $_5 -lt $_6 ]; then
echo "Less than! It works!"
fi

# BASH:
echo "Trying BASH..."
if (( $_5 < $_6 )); then
echo "Less than! It works!"
fi

```

| **4** : `./math-bash`

*Refer to this cheat-sheet section for more about Shell-BASH differences:* [VIP/Cheet-Sheets: Tests – Welcome to BASH](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Tests.md#welcome-to-bash)

*Here's a great Wiki article about shells: [List of command-line interpreters](https://en.wikipedia.org/wiki/List_of_command-line_interpreters)*

### II. `set` Errors & Debugging

**Main `set` commands:** *(there are more than these)*
- `set -a` ***A****ll* variables to be exported to environment
- `set -e` ***E****xit* immediately if a command returns an exit code other than zero
- `set -n` Do ***N****ot* execute commands, only read them
- `set -t` *Exi****T*** after executing only one command
- `set -u` Treat ***U****nset* variables as errors
- `set -v` ***V****erbose* (Print shell inputs line by line as the script executes)
- `set -x` Print *e****X****ecuted* commands and their arguments line by line

**ON/OFF**
- `-X` turns an option on
- `+X` turns an option off

**ON...**
- `set -e`
- `set -v`
- `set -x`

**OFF...**
- `set +e`
- `set +v`
- `set +x`

**Combining options** *(into one line)*
- `set -ev`
- `set -vex`
- `set +ev`
- `set +vex`
- `#!/bin/sh -axe`
- `#!/bin/bash -etx`
- `#!/bin/sh +axe`
- `#!/bin/bash +etx`

*A `set` declaration is placed before the lines of a script it affects*

*A `set` declaration usually goes at the beginning of the script file:*

```sh
#!/bin/sh
set -ev
```

OR
```sh
#!/bin/sh set -ev
```

*A `set` declaration is for debugging and should not normally be standard in a script.*

*If you need to handle errors in a normal-production script, use `if` tests with `$?` exit codes.*
-See: [Lesson 5: More with Variables](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-05.md)

### III. Simple Tests via `&&` & `||`

1. If a condition is `true`, the the test `&&` runs next
2. If a condition is `false`, then the test `||` runs next

*Consider these simple patterns:*
```sh
true && EXECUTE_COMMAND_IF_TRUE
false || EXECUTE_COMMAND_IF_FALSE
```

*Example in a Script:*
```sh
#!/bin/sh
VAR=true
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."

VAR=false
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."
```

*Consider three scripts:*

Stating `true`/`false`:

*Edit this script*

| **5** : `gedit truefalse`

*It should look like this:*

```sh
#!/bin/sh

echo "No variable, stating \"true\""
# Simple test: true
true && echo "AND/OR is true." || echo "AND/OR is false."
true && echo "AND is true."
true || echo "OR is false."

echo "No variable, stating \"false\""
# Same simple test: false
false && echo "AND/OR is true." || echo "AND/OR is false."
false && echo "AND is true."
false || echo "OR is false."

```

| **6** : `./truefalse`

*It works whether* `true`/`false` *is stated or a variable:*

Variable as `true`/`false`:

*Edit this script*

| **7** : `gedit truefalsevar`

*It should look like this:*

```sh
#!/bin/sh

VAR=true
echo "Variable set to: $VAR"

# Simple test:
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."

VAR=false
echo "Variable set to: $VAR"

# Same simple test:
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."

```

| **8** : `./truefalsevar`

*It does* ***NOT*** *work*

Variable as other **"string"**:

*Edit this script*

| **9** : `gedit truefalsevarstring`

*It should look like this:*

```sh
#!/bin/sh

VAR=apples
echo "Variable set to: $VAR"

# Simple test:
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."

VAR=pencils
echo "Variable set to: $VAR"

# Same simple test:
$VAR && echo "AND/OR is true." || echo "AND/OR is false."
$VAR && echo "AND is true."
$VAR || echo "OR is false."
```

| **10** : `./truefalsevarstring`

### IV. Using `-z`/`-n` & `unset` "the Proper Way"

*Use `-z` & `-n` to determine if a variable is set or empty.*
- `-z` Tests if a variable is NOT set
- `-n` Tests if a variable is "***N****ot* empty" (IS set)

*Consider two scripts:*

Test with `-z`:

*Edit this script*

| **11** : `gedit varset-z`

*It should look like this:*

```sh
#!/bin/sh

# The variable $VAR is NOT set
echo "1. \$VAR is NOT yet set!"

if [ -z $VAR ]; then
echo "NOT set: $VAR"
else
echo "IS set: $VAR"
fi

# Now, the variable $VAR IS set:
VAR=varSet
echo "2. \$VAR has been set!"

if [ -z $VAR ]; then
echo "NOT set: $VAR"
else
echo "IS set: $VAR"
fi

# Now, the variable $VAR is unset:
unset VAR
echo "3. \$VAR has been UNset!"

if [ -z $VAR ]; then
echo "NOT set: $VAR"
else
echo "IS set: $VAR"
fi
```

| **12** : `./varset-z`

Test with `-n`:

*Edit this script*

| **13** : `gedit varset-n`

*It should look like this:*

 ```bash
#!/bin/bash

# The variable $VAR is NOT set
echo "1. \$VAR is NOT yet set!"

if [ -n $VAR ]; then
echo "NOT empty set: $VAR"
else
echo "IS empty set: $VAR"
fi

# Now, the variable $VAR IS set:
VAR=varSet
echo "2. \$VAR has been set!"

if [ -n $VAR ]; then
echo "NOT empty set: $VAR"
else
echo "IS empty set: $VAR"
fi

# Now, the variable $VAR is unset:
unset VAR
echo "3. \$VAR has been UNset!"

if [ -n $VAR ]; then
echo "NOT empty set: $VAR"
else
echo "IS empty set: $VAR"
fi
```

| **14** : `./varset-n`

___

# The Take

## Interpreters
- In `#!/bin/sh`, "sh" is the interpreter
- There are many interpreters for Linux, "bash" & "sh" are probably the most common
- Different interpreters can do different things, much how "bash" & "sh" are mostly similar, but a little different

## Errors & Debugging
- `set` will make Shell report errors to help find problems
- `set` has several one-letter flags
  - `+` turns a flag/option off
  - `-` turns a flag/option on
  - `-e` exits the script immediately if an error is reported
  - `-n` will not execute commands, only read them
- Examples:
  - `set -e`
  - `set -n`
  - `set -en`

## Simple Tests
- `&&` = "and"
  - If the first test is `true`, then the next test runs
  - If all tests answer `true`, the final return is `true`
- `||` = "or"
  - If the first test is `false`, then the next test runs
  - If once a test answers `true`, the final return is `true`

## Using `-z`/`-n` & `unset` "the Proper Way"
- `-z` tests if a variable is not set
- `-n` tests if a variable is not empty
- If a variable has been set:
  - `-z` answers `true`
  - `-n` answers `false`
- If a variable has not been set OR been `unset`:
  - `-z` answers `false`
  - `-n` answers `true`
- Examples:
  - `if [ -z "$1" ]` will return `false` if the script had a first argument from the terminal
  - `if [ -z "$IFS" ]` will return `true` if the Internal Field Separator (IPS) is still set to something
  - `if [ -n "$(cat SOME-FILE)" ]` will return `false` if "SOME-FILE" as no contents
    - This is because the contents of SOME-FILE would be the value of the Command Substitute; no contents = nothing to set as the value, so it would be "empty"

___

#### [Lesson 10: Dynamics of Functions](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-10.md)
