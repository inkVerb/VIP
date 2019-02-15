# Shell 401
## Lesson 9: Interpreters, errors, logic, and empty testing

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

### I. Interpreters (shells)

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

`gedit math-sh`

`./math-sh`

*Note the BASH operators only work with `#!/bin/bash`*

BASH:

`gedit math-bash`

`./math-bash`

*Refer to this cheat-sheet section for more about Shell-BASH differences:* [VIP/Cheet-Sheets: Tests – Welcome to BASH](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Tests.md#welcome-to-bash)

*Here's a great Wiki article about shells: [List of command-line interpreters](https://en.wikipedia.org/wiki/List_of_command-line_interpreters)*

### II. `set` errors & debugging

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

ON...
`set -e`
`set -v`
`set -x`

OFF...
`set +e`
`set +v`
`set +x`

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

### III. Simple tests via `&&` & `||`

1. If a condition is `true`, after the `&&` executes
2. If a condition is `false`, after the `||` executes

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

`gedit truefalse`

`./truefalse`

*It works whether* `true`/`false` *is stated or a variable:*

Variable as `true`/`false`:

`gedit truefalsevar`

`./truefalsevar`

*It does* ***NOT*** *work*

Variable as other **"string"**:

`gedit truefalsevarstring`

`./truefalsevarstring`

### IV. Using `-z`/`-n` & `unset` "the proper way"

*Use `-z` & `-n` to determine if a variable is set or empty.*
- `-z` Tests if a variable is NOT set
- `-n` Tests if a variable is "***N****ot* empty" (IS set)

*Consider two scripts:*

Test with `-z`:

`gedit varset-z`

`./varset-z`

Test with `-n`:

`gedit varset-n`

`./varset-n`

#### [Lesson 10: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-10.md)
