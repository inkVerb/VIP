# Shell 401
## Lesson 10: NEW

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

## Under Construction

Interpreters

`#!/bin/csh`

`#!/bin/ksh`

`#!/bin/zsh`

`#!/bin/sh`

`#!/bin/bash`

Errors & debugging

ON...
`set -e`
`set -x`
`set -v`
`set -ev`
`set -vex`
OR...
#!/bin/bash -ex
#!/bin/sh -vxe
OFF...
`set +e`
`set +x`
`set +v`

Functions: must be declared before called.

In functions, parametets are looped: `funct one two three` will loop if only $1 is used in the function.

Functions: return, local, echo $?


#### [Lesson 11: NEXT](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md)
