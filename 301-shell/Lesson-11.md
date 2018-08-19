# Shell 301
## Lesson 11: BASH Functions

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/301-shell/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/301-shell/Tests.md)
___

`gedit 11-function`

*Note functions require* `#!/bin/bash` *on the first line, not* `#!/bin/sh`

`./11-function`

`gedit 11-function-breakdown`

*Note a few things before we continue...*

Create the function: `functionName() {`

Put your code between the curlies *starting on a new line*.

`$1` and `$2` and all their friends work just the same within the function.

Create a variable that only exists inside the function with this:

`local` `myVariable=Saucy`

Make sure you do something...

`echo "VIP Linux tutorials are $myVariable!"`

`}` And close the function

Then, call the function with its name...

`functionName`

*Let's get back to work...*

`./11-function-breakdown`

#### [Lesson 12: BASH select, getopts, getopt & SH dialog](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-12.md)
