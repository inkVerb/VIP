# Shell 401
## Lesson 9: NEW

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

*Be carful about writing code in too many different shells because your code may not work on all computers.*

*Generally,:*
- `sh` (Bourne shell) *is simple, though mostly standard*
- `bash` (Bourne again shell) *is much the same, but...*
  - tested variables must be in quotes `if [ "$TEST_VAR" ]`, optional in `sh`
  - arithmetic allows comparison operator symbols
  - some arithmetic requires `[[`double brackets`]]`
  - variables can contain arrays
  - *and, there may be other differences you can look into*

*Here's a great Wiki article about shells: [List of command-line interpreters](https://en.wikipedia.org/wiki/List_of_command-line_interpreters)*

## Under Construction

### II. Errors & debugging

ON...
`set -e`
`set -x`
`set -v`
`set -ev`
`set -vex`
OR...
#!/bin/sh -vxe
#!/bin/bash -ex
OFF...
`set +e`
`set +x`
`set +v`

### III. Simple tests via `&&` & `||`

VAR=true
$VAR && echo "Is true."
VAR=false
$VAR || echo "Is false."
VAR="true"
echo "Is $VAR."
VAR="false"
echo "Is $VAR"

### IV. Using `-z` & `unset` "the proper way"

(VAR=$1; $VAR # Is $VAR set? # Use some arithmetic to see.) [top three answers here](https://serverfault.com/questions/7503/how-to-determine-if-a-bash-variable-is-empty)



#### [Lesson 10: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-10.md)
