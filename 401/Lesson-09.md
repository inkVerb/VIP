# Linux 401
## Lesson 9: Interpreters, errors, logic, and empty testing

Ready the CLI

```console
cd ~/School/VIP/401
```

___

### I. Interpreters (Shells)
*That first "she-bang" line* **(#!/...)** *defines the "interpreter" or the shell.*

*There are many shells to choose from...*

- `#!/bin/sh`     Bourne Shell
- `#!/bin/bash`   Bourne Again Shell
- `#!/bin/ash`    Almquist Shell
- `#!/bin/dash`   Debian Almquist Shell
- `#!/bin/csh`    C Shell *(Ha, get it?)*
- `#!/bin/tcsh`   TENEX C Shell
- `#!/bin/ch`     Ch Shell
- `#!/bin/eshell` Emacs Shell
- `#!/bin/fish`   Friendly Interactive shell
- `#!/bin/psh`    Pearl Shell
- `#!/bin/rc`     RC Shell
- `#!/bin/ksh`    Korn Shell
- `#!/bin/zsh`    Z Shell

#### In the Terminal
**Run in a new terminal window:**
>
> Open a new terminal window: <key>Ctrl</key> + <key>Alt</key> + <key>T</key> (not <key>F12</key>)
>
> | **T1** :$

```console
exit
```
>
> Open a new terminal window: <key>Ctrl</key> + <key>Alt</key> + <key>T</key> (not <key>F12</key>)
>
> *Open up a Shell (`sh`) interpreter session...*
>
> | **T2** :$

```console
sh
```
>
> *You are in a new Shell session*
>
> *Try some non-changing commands if you want, like `ls`*
>
> *Get your current interpreter...*
>
> | **T4** :$

```console
ps -p $$
```
>
> *Now, exit that Shell session...*
>
> | **T5** :$

```console
exit
```
>
> *Now, you are back to your original terminal interpreter session*
>
> *Watch and exit that terminal to know that you are in no other interpreter session*
>
> | **T6** :$

```console
exit
```
>
> Open a new terminal window: <key>Ctrl</key> + <key>Alt</key> + <key>T</key> (not <key>F12</key>)
>
> *Now, open up a BASH (`bash`) interpreter session...*
>
> | **T7** :$

```console
bash
```
>
> *You are in a new BASH session, but it doesn't look different*
>
> *Try some non-changing commands if you want, like `ls`*
>
> *Get your current interpreter...*
>
> | **T8** :$

```console
ps -p $$
```
>
> *Now, exit that BASH session...*
>
> | **T9** :$

```console
exit
```
>
> *Now, you are back to your original terminal interpreter session*
>
> *Watch and exit that terminal to know that you are in no other interpreter session*
>
> | **T10** :$

```console
exit
```

#### Different Interpreters Interpret Differently
*Avoid writing code in too many different shells because your code may not work on all machines*

*Generally:*
- `sh` (Bourne Shell) *is simple, though mostly standard*
  - arithmetic comparison must use alphabet operators [`-lt`, `-gt`, `-le`, `-ge`, `-eq`, `-ne`]
  - arrays **are not** allowed in variables
- `bash` (Bourne Again Shell) *is much the same, more useful, but...*
  - arithmetic allows comparison symbol operators ((`<`, `>`, `=<`, `>=`, `==`, `!=`))
  - comparison operators require `((`double parentheses`))`
  - variables may contain arrays
  - *and, there may be other differences you can look into*

*Consider a comparison in Bourne Shell vs BASH:*

#### Arithmetic
Shell:

*Edit this script to see the short version*

| **1** :$

```console
gedit math-sh
```

*It should look like this:*

| **math-sh** :

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

| **2** :$

```console
./math-sh
```

*Note the BASH operators only work with `#!/bin/bash`*

BASH:

*Edit this script to see the short version*

| **3** :$

```console
gedit math-bash
```

*It should look like this:*

| **math-bash** :

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

| **4** :$

```console
./math-bash
```

*Consider another comparison in Bourne Shell vs BASH:*

#### Arrays
Shell:

*Edit this script to see the short version*

| **5** :$

```console
gedit array-sh
```

*It should look like this:*

| **array-sh** :

```sh
#!/bin/sh

Array=(one two three)

echo ${Array[0]}
echo ${Array[1]}
echo ${Array[2]}
echo ${Array[@]}

```

| **6** :$

```console
./array-sh
```

*Note the array is not recognized in Borune shell (`#!/bin/sh`)*

BASH:

*Edit this script to see the short version*

| **7** :$

```console
gedit array-bash
```

*It should look like this:*

| **array-bash** :

```bash
#!/bin/bash

Array=(one two three)

echo ${Array[0]}
echo ${Array[1]}
echo ${Array[2]}
echo ${Array[@]}

```

| **8** :$

```console
./array-bash
```

*...the array works in BASH (`#!/bin/bash`)*

*Refer to this cheat-sheet section for more about Shell-BASH differences:* [VIP/Cheat-Sheets: Tests – Welcome to BASH](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Tests.md#welcome-to-bash)

*Here's a great Wiki article about shells: [List of command-line interpreters](https://en.wikipedia.org/wiki/List_of_command-line_interpreters)*

### II. `set` Errors & Debugging
**Main `set` commands:** *(there are more than these)*
- `set -a` ***A****ll* variables to be exported to environment
- `set -e` ***E****xit* immediately if a command returns an exit code other than zero
- `set -n` Do ***N****ot* execute commands, only read them
- `set -t` Exi****T*** after executing only one command
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

Or
```sh
#!/bin/sh -ev
```

*Try some examples*


**Normal script**

*Edit this script to see the short version*

| **9** :$

```console
gedit set-normal
```

*It should look like this:*

| **set-normal** :

```sh
#!/bin/sh

# echo that we started
echo "Starting verbchacho test"

# ls a directory that DOES NOT work!
ls iamnothere

# echo
echo "Done with verbchacho test"

```

*Run it and watch carefully*

| **10** :$

```console
./set-normal
```

*Edit this script to see the short version*

| **11** :$

```console
gedit set-e
```

*It should look like this:*

| **set-e** :

```sh
#!/bin/sh

set -e

# echo that we started
echo "Starting verbchacho test"

# ls a directory that DOES NOT work!
ls iamnothere

# echo
echo "Done with verbchacho test"

```

*Run it and watch carefully*

| **12** :$

```console
./set-e
```

*Edit this script to see the short version*

| **13** :$

```console
gedit set-x
```

*It should look like this:*

| **set-x** :

```sh
#!/bin/sh

set -x

# echo that we started
echo "Starting verbchacho test"

# ls a directory that DOES NOT work!
ls iamnothere

# echo
echo "Done with verbchacho test"

```

*Run it and watch carefully*

| **14** :$

```console
./set-x
```

*Edit this script to see the short version*

| **15** :$

```console
gedit set-v
```

*It should look like this:*

| **set-v** :

```sh
#!/bin/sh -v

# echo that we started
echo "Starting verbchacho test"

# ls a directory that DOES NOT work!
ls iamnothere

# echo
echo "Done with verbchacho test"

```

*Run it and watch carefully*

| **16** :$

```console
./set-v
```

*So, `-v` and `-x` are basically the same, but `-x` has the pretty `+`*

*Edit this script to see the short version*

| **17** :$

```console
gedit set-xe
```

*It should look like this:*

| **set-xe** :

```sh
#!/bin/sh -xe

# echo that we started
echo "Starting verbchacho test"

# ls the directory, this works
ls

# echo
echo "Done with verbchacho test"

```

*Run it and watch carefully*

| **17** :$

```console
./set-xe
```




***Summary:***

*A `set` declaration is for debugging and should not normally be standard in a script.*

*Remember `$?` is the variable for the last `exit` code*

*If you need to handle errors in a normal-production script, use `if` tests with `$?` `exit` codes.*
-See: [Lesson 5: More with Variables](https://github.com/inkVerb/vip/blob/master/401/Lesson-05.md)

### III. Simple Tests via `&&` & `||`

1. If a condition is `true`, the the test `&&` runs next
2. If a condition is `false`, then the test `||` runs next

*Consider these simple patterns:*
```sh
true && EXECUTE_COMMAnd_IF_TRUE
false || EXECUTE_COMMAnd_IF_FALSE
```

*Yes, `true` and `false` can be run in the terminal as commands*

| **19** :$

```console
true
```

| **20** :$

```console
false
```

*They don't return any output, only an "exit" code: `0` (true) or `1` (false)*

*Remember `$?` is the last exit code, watch...*

| **21** :$

```console
true && echo $?
```

| **22** :$

```console
false || echo $?
```

*These work because:*
- `true &&` **THIS WILL HAPPEN**
- `false ||` **THIS WILL HAPPEN**

*But:*
- `true ||` **THIS WON'T HAPPEN**
- `false &&` **THIS WON'T HAPPEN**

| **23** :$

```console
true || echo $?
```

| **24** :$

```console
false && echo $?
```

*Example in a Script:*

```sh
true && echo "And/Or is true." || echo "And/Or is false."
true && echo "And is true."
true || echo "Or is false."

false && echo "And/Or is true." || echo "And/Or is false."
false && echo "And is true."
false || echo "Or is false."
```

*Consider four scripts:*

#### 1. Stating `true`/`false`:
*Edit this script to see the short version*

| **25** :$

```console
gedit truefalse
```

*It should look like this:*

| **truefalse** :

```sh
#!/bin/sh

echo "No variable, simply stating \"true\""
# Simple test: true
true && echo "And/Or is true." || echo "And/Or is false."
true && echo "And is true."
true || echo "Or is false."

echo "No variable, simply stating \"false\""
# Same simple test: false
false && echo "And/Or is true." || echo "And/Or is false."
false && echo "And is true."
false || echo "Or is false."

```

*Run it and watch carefully*

| **26** :$

```console
./truefalse
```

*It works whether `true`/`false` is stated or a variable:*

#### 2. Variable as `true`/`false`:
*Edit this script to see the short version*

| **27** :$

```console
gedit truefalsevar
```

*It should look like this:*

| **truefalsevar** :

```sh
#!/bin/sh

Var=true
echo "Variable set to: $Var"

# Simple test:
$Var && echo "And/Or is true." || echo "And/Or is false."
$Var && echo "And is true."
$Var || echo "Or is false."

Var=false
echo "Variable set to: $Var"

# Same simple test:
$Var && echo "And/Or is true." || echo "And/Or is false."
$Var && echo "And is true."
$Var || echo "Or is false."

```

*Run it and watch carefully*

| **28** :$

```console
./truefalsevar
```

*This next script does* ***NOT*** *work...*

#### 3. Variable as Other *"string"*:
*Edit this script to see the short version*

| **29** :$

```console
gedit truefalsevarstring
```

*It should look like this:*

| **truefalsevarstring** :

```sh
#!/bin/sh

Var=apples
echo "Variable set to: $Var"

# Simple test:
$Var && echo "And/Or is true." || echo "And/Or is false."
$Var && echo "And is true."
$Var || echo "Or is false."

Var=pencils
echo "Variable set to: $Var"

# Same simple test:
$Var && echo "And/Or is true." || echo "And/Or is false."
$Var && echo "And is true."
$Var || echo "Or is false."
```

*Run it and watch carefully*

| **30** :$

```console
./truefalsevarstring
```

*Note the errors...*

*...So, this only works with `true` & `false` or some other command that returns a `0` or `1` exit code*

*Let's try a real command: `ls /directory`*

#### 4. Test with Example Command `ls` & `$?` for Numeric `true`/`false`:
*Watch this...*

| **31** :$

```console
true
```

| **32** :$

```console
echo $?
```

| **33** :$

```console
false
```

| **34** :$

```console
echo $?
```

*Now, let's put that to use...*

| **35** :$

```console
mkdir iamhere && touch iamhere/file1 iamhere/file2
```

*Edit this script to see the short version*

| **36** :$

```console
gedit ls-test
```

*It should look like this:*

| **ls-test** :

```sh
#!/bin/sh

echo "Listing a real directory: iamhere"
# ls a real directory
ls iamhere && echo "And/Or is true, exit code: $?" || echo "And/Or is false, exit code: $?"
ls iamhere && echo "And is true, exit code: $?"
ls iamhere || echo "Or is false, exit code: $?"

echo "Listing a fake directory: nothere"
# ls a fake directory
ls nothere && echo "And/Or is true, exit code: $?" || echo "And/Or is false, exit code: $?"
ls nothere && echo "And is true, exit code: $?"
ls nothere || echo "Or is false, exit code: $?"
```

*Run it and watch carefully*

| **37** :$

```console
./ls-test
```

*So, `&&` and `||` work with any command that returns*

### IV. Using `-z`/`-n` & `unset` "the Proper Way"
*Use `-z` & `-n` to determine if a variable is set or empty.*
- `-z` Tests if a variable is NOT set
- `-n` Tests if a variable is "***N****ot* empty" (IS set)

*Consider two scripts:*

Test with `-z`:

*Edit this script to see the short version*

| **38** :$

```console
gedit varset-z
```

*It should look like this:*

| **varset-z** :

```sh
#!/bin/sh

# The variable $Var is NOT set
echo "1. \$Var is NOT yet set!"

if [ -z "$Var" ]; then
echo "NOT set: $Var"
else
echo "IS set: $Var"
fi

# Now, the variable $Var IS set:
Var=varSet
echo "2. \$Var has been set!"

if [ -z "$Var" ]; then
echo "NOT set: $Var"
else
echo "IS set: $Var"
fi

# Now, the variable $Var is unset:
unset Var
echo "3. \$Var has been UNset!"

if [ -z "$Var" ]; then
echo "NOT set: $Var"
else
echo "IS set: $Var"
fi
```

*Run it and watch carefully*

| **39** :$

```console
./varset-z
```

Test with `-n`:

*Edit this script to see the short version*

| **40** :$

```console
gedit varset-n
```

*It should look like this:*

| **varset-n** :

 ```bash
#!/bin/sh

# The variable $Var is NOT set
echo "1. \$Var is NOT yet set!"

if [ -n "$Var" ]; then
echo "NOT empty set: $Var"
else
echo "IS empty set: $Var"
fi

# Now, the variable $Var IS set:
Var=varSet
echo "2. \$Var has been set!"

if [ -n "$Var" ]; then
echo "NOT empty set: $Var"
else
echo "IS empty set: $Var"
fi

# Now, the variable $Var is unset:
unset Var
echo "3. \$Var has been UNset!"

if [ -n "$Var" ]; then
echo "NOT empty set: $Var"
else
echo "IS empty set: $Var"
fi
```

*Run it and watch carefully*

| **41** :$

```console
./varset-n
```

### V. Pass child `exit` to parent
We looked at different `exit` codes in [301 Lesson 6](https://github.com/inkVerb/vip/blob/master/301/Lesson-06.md)

Now, we will pass a child script's exit code to make the parent script exit with the same code using this one line exit pass:

| **one line exit pass** :

```bash
e="$?"; [[ "$e" = "0" ]] || exit "$e"
```

*Note, this only works in BASH (`#!/bin/bash`)*

*This would be the Shell version, which we are not using!*

```sh
e="$?"; if [ "$e" != "0" ]; then exit "$e"; fi
```

| **42** :$

```console
gedit child-exit parent-exit
```

| **parent-exit** :

 ```bash
#!/bin/bash

# We pass the first argument to the child script
./child-exit "$1"

# Uncomment to use the one line exit pass:
#e="$?"; [[ "$e" = "0" ]] || exit "$e"

# Without this, the one line exit pass isn't needed because the script ends
if [ "$noargument" = "true" ]; then
  exit
fi

echo "Parent is finished."
```

| **child-exit** :

 ```bash
#!/bin/bash

willexit="$1"

if [ -n "$willexit" ]; then
  if [ "$willexit" = "three" ]; then
    exit 3
  elif [ "$willexit" = "fortyfive" ]; then
    exit 45
  else
    exit 1
  fi
else
  noargument="true"
fi
```

*Note the parent script passes arguments directly to the child script, so the only difference is the exit code*

*Run the script...*

| **43** :$

```console
./parent-exit
```

*Display the exit code...*

| **44** :$

```console
echo $?
```

*Now do the same with the child script to see what happened inside...*

| **45** :$

```console
./child-exit
```

| **46** :$

```console
echo $?
```

*Note they use "success" `exit` if we don't use an argument; that's how the logic is intended*

| **47** :$

```console
./parent-exit three
```

| **48** :$

```console
echo $?
```

| **45** :$

```console
./child-exit three
```

| **49** :$

```console
echo $?
```

*The exit code is different because the parent does not exit with the same exit code as the child*

*This could be a problem; the child script exited with an error, but the parent script continued anyway*

| **50** :$

```console
./parent-exit fortyfive
```

| **51** :$

```console
echo $?
```

| **52** :$

```console
./child-exit fortyfive
```

| **53** :$

```console
echo $?
```

*Entering `echo $?` in the terminal as a separate command is getting annoying, let's combine the commands from now on...*

| **54** :$

```console
./parent-exit nine; echo $?
```

| **55** :$

```console
./child-exit nine; echo $?
```

*...Anything other than "three" or "fortyfive" will `exit 1`...*

| **56** :$

```console
./parent-exit chocolate; echo $?
```

| **57** :$

```console
./child-exit chocolate; echo $?
```

*Uncomment the one line exit pass in parent-exit...*

| **parent-exit** : (uncommented)

 ```bash
#!/bin/bash

# We pass the first argument to the child script
./child-exit "$1"

# Uncomment to use the one line exit pass:
e="$?"; [[ "$e" = "0" ]] || exit "$e"

# Without this, the one line exit pass isn't needed because the script ends
if [ "$noargument" = "true" ]; then
  exit
fi

echo "Parent is finished."
```

*Run everything again to see that child exit code passes*

| **58** :$

```console
./parent-exit three; echo $?
```

| **59** :$

```console
./child-exit three; echo $?
```

*Now they are the same because we are using the one line exit pass*

| **60** :$

```console
./parent-exit fortyfive; echo $?
```

*The parent script didn't finish when the child script exited with an error; that's better if we need the child script to succeed*

| **61** :$

```console
./parent-exit nine; echo $?
```

| **62** :$

```console
./parent-exit flowers; echo $?
```

*Try putting the one line exit pass* ***after*** *the `if` test, the test changes `$?` value!*

| **parent-exit** : (MPEL is after the test)

 ```bash
#!/bin/bash

# We pass the first argument to the child script
./child-exit "$1"

# Without this, the one line exit pass isn't needed because the script ends
if [ "$noargument" = "true" ]; then
  exit
fi

# Uncomment to use the one line exit pass:
e="$?"; [[ "$e" = "0" ]] || exit "$e"

echo "Parent is finished."
```

| **63** :$

```console
./parent-exit three; echo $?
```

*Note other commands and even a test in the script will change the `$?` value*

*This is why we need the one line exit pass immediately after a vital child script*

*There are other ways to exit when a vital child script fails, such as putting the entire child script in an `if` test or trailing the child script with an `|| exit`, but that makes the script difficult to read and may not properly pass the `exit` status*

___

# The Take
## Interpreters
- In `#!/bin/sh`, "`sh`" is the interpreter
- There are many interpreters for Linux, "`bash`" & "`sh`" are probably the most common
- Different interpreters can do different things, much how "`bash`" & "`sh`" are mostly similar, but a little different
- BASH (`bash`) allows arrays and arithmetic operator symbols ((`<`, `>`, `=<`, `>=`, `==`, `!=`))
- Bourne Shell (`sh`) disallows arrays and only uses normal arithmetic operators [`-lt`, `-gt`, `-le`, `-ge`, `-eq`, `-ne`]

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

## `true`/`false` in Tests
- `&&` = "and"
  - If the first command/test returns `0`/`true`, then the next command/test runs
  - If all commands/test returns `0`/`true`, the final return is `true`
- `||` = "or"
  - If the first command/test is `1`/`false`, then the next command/test runs
  - If once a command/test answers `0`/`true`, the final return is `0`/`true`
- `$?` is the variable for the last `exit` code
  - `$?` = `0` if it was `true`
  - `$?` = `1` if it was `false`

## Using `-z`/`-n` & `unset` "the Proper Way"
- `-z` tests if a variable is not set
- `-n` tests if a variable is not empty
- If a variable has been set:
  - `-z` answers `true`
  - `-n` answers `false`
- If a variable has not been set Or been `unset`:
  - `-z` answers `false`
  - `-n` answers `true`
- Examples:
  - `if [ -z "$1" ]` will return `false` if the script had a first argument from the terminal
  - `if [ -z "$IFS" ]` will return `true` if the Internal Field Separator (IPS) is still set to something
  - `if [ -n "$(cat SOME-FILE)" ]` will return `false` if "SOME-FILE" as no contents
    - This is because the contents of SOME-FILE would be the value of the Command Substitute; no contents = nothing to set as the value, so it would be "empty"

## one line exit pass (MPEL)
- `e="$?"; [[ "$e" = "0" ]] || exit "$e"`
  - This line should be added right after every essential child script, if the success of the child script matters
  - MPEL will exit if the child script fails, passing the exit status to the final exit of the parent script
- We need the MPEL because other scripts and even an `if` test or `wait` will change the last exit code `$?` value
- **Caution:**
 - Do not run `wait` after the MPEL, otherwise you will wait forever
 - Do not run `wait` before the MPEL because the MPEL will be testing `wait` rather than the the child script you want to test
 - The MPEL may actually be able to run instead of `wait`
 
 ___

#### [Lesson 10: Dynamics of Functions](https://github.com/inkVerb/vip/blob/master/401/Lesson-10.md)
