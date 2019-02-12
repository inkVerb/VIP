# Shell 401
## Lesson 9: NEW

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Construction

### I. Interpreters

`#!/bin/sh`

`#!/bin/bash`

`#!/bin/csh`

`#!/bin/ksh`

`#!/bin/zsh`

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
