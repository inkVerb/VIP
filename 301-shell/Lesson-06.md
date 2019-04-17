# Shell 301
## Lesson 6: exit & journalctl

`cd ~/School/VIP/shell/301`

- [Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: If you need, you may login as a "sudoer" first
>
> | **1** : `su USERNAME` input the password*
___

### *Note `exit` & `journalctl` are used for logs*

## I. System Logs via `journalctl` & `logger`

*Look at some log entries on your machine*

*Space to scroll down*

*Ctrl+C to close*

| **2** : `journalctl`

*Q to quit*

*Use `-r` to "reverse" the order and view most recent log entries first*

| **3** : `journalctl -r`

*Use `-f` to "follow" the most recent entries in real time*

| **4** : `journalctl -f`

*...now click some actions in the desktop GUI and watch entries appear*

*Ctrl + C to close*

*Create a system log entry...*

| **5** : `logger "I logged this just now."`

*Look for your entry...*

| **6** : `journalctl -r` Q to quit*

*Use `-t SOME_TAG` to add your own "tag"*

| **7** : `logger -t dazzleTag "I logged this dazzling tag."`

*Now search for only that tag...*

| **8** : `journalctl -t dazzleTag` Q to quit*

*Set a "priority" level at "info"...*

| **9** : `logger -p info "I logged this info mere moments ago."`

*Look for the "info" priority* (`-p info`) *in the most recent* (`-r`) *logs first...*

| **10** : `journalctl -r -p info` Q to quit*

*Note your "dazzleTag" log also shows up because "info" is the default priority for `logger`*

*...because `info` = `6`, that is the same as...*

| **11** : `logger -p 6 "I also logged this number mere moments ago."`

| **12** : `journalctl -r -p 6` Q to quit*

*Also use `-p` with a "facility" before the "priority":*

- Usage: `-p FACILITY.PRIORITY`
- Example: `-p local0.alert` = `-p local0.1` Note `local0` = `16`, `alert` = `1` (see below)*

*Note numbers don't work to enter the facility via `logger`*

**There are many "facilities", some include:** ***(input ONLY TEXT!)***

- `0` = `kern` (kernel)
- `1` = `user`
- `2` = `mail`
- `3` = `daemon`
- `7` = `news` (network news subsystem)

*Note for your own "local facilities", you can use "local0–7"*

- `16`–`23` = `local0`–`local7`

**"Priority" has seven levels:** *(input either text or the number)*

- `0` = `emerg` (emergency, system unusable)
- `1` = `alert` (alert, take immediate action)
- `2` = `crit` (critical)
- `3` = `err` (error)
- `4` = `warn` (warning)
- `5` = `notice` (notice, normal but significant)
- `6` = `info` (information)
- `7` = `debug` (debug, so much info that only geeks & developers are interested)

*Note the "facility" doesn't show up in most log views, it needs "verbose"*

*Use `-o verbose` with `-r` (`-ro verbose`) to see enough info to find the "facility"*

*Make an entry with the facility "daemon" (3) and priority "debug" (7)*

***...enter these quickly, before another entry gets made...***

| **13** : `logger -p daemon.debug "I a text debug daemon."`

| **14** : `journalctl -ro verbose` Q to quit*

*Look for:*

- `PRIORITY` (7 = debug)*
- `SYSLOG_FACILITY` (3 = daemon)*

*Now do the same thing using the nubmers; facility "user" (1) and priority "info" (6)...*

*Note numbers don't work to enter a facility*

**WILL NOT WORK:** ~~`logger -p 1.6 "I a text debug daemon."`~~

| **15** : `logger -p user.6 "I a text debug daemon."`

| **16** : `journalctl -ro verbose` Q to quit*

*Look for:*

- `PRIORITY` (6 = info)*
- `SYSLOG_FACILITY` (1 = user)*

*This is just cool:*

| **17** : `journalctl --since today > journalctl-today.txt`

*If you dare: `gedit journalctl-today.txt`

*Also try: `--since yesterday`

### IF logged in as a separate "sudoer"
>
___
>  Optional: `exit` from the "sudoer"
>
> | **18** : `exit`
>
___


## II. Custom output logs

### *Notes about `exit` codes

*Logs & `exit` codes are both important, but different*

*Errors are important, handle them correctly in Shell scripts!*

> *An `exit` is a way to "break" out of a script, such as `if - then` tests, but always use `exit 0` unless a problem or event needs to be logged!*
>
> *It is considered "bad coding" to use `exit` without a number or to use an exit other than `exit 0` without need for a log entry*
>
> *When tutorials only have `exit` in the example, it is up to you to put the correct number after, probably `exit 0`
>

### A custom log can be useful for keeping track of what happens in your own software

| **19** : `mkdir logs`

| **20** : `cd logs`

*Send* STDOUT *(output) to a file with: `> OUTPUTFILE`

*Send* STDERR *(error output) to a file with: `2> OUTPUTFILE`

| **21** : `ls dumbo`

*Note the error message in the terminal*

| **22** : `ls dumbo 2> error.log`

*Not the same error message went into the file*

| **23** : `gedit error.log`

*gedit: Reload error.log*

| **24** : `ls dumbo 2>> error.log`

*gedit: Reload error.log*

| **25** : `ls >> normal.log`

| **26** : `gedit normal.log`

*Combine this into one command with: `> STDOUT 2> STDERR`

| **27** : `ls bozo >> normal.log 2>> error.log`

*gedit: Reload error.log*

*Send* STDERR *(error output) into the nothingness with: `> /dev/null 2>&1`

| **28** : `ls dumbo > /dev/null 2>&1`

| **29** : `ls`

*See! Nothing at all!*

*Note `journalctl` is for system logs, but you can create your own log files this way*

### Review output numbers

#### Generate normal output

*Outputs nothing:*

| **30** : `ls 0> 0.log`

| **31** : `cat 0.log`

*Outputs STDOUT (present):*

| **32** : `ls 1> 1.log`

| **33** : `cat 1.log`

*Outputs STDERR (absent):*

| **34** : `ls 2> 2.log`

| **35** : `cat 2.log`

#### Generate error output

*Outputs nothing:*

| **36** : `ls bozo 0> 0.log`

| **37** : `cat 0.log`

*Outputs STDOUT (absent):*

| **38** : `ls bozo 1> 1.log`

| **39** : `cat 1.log`

*Outputs STDERR (present):*

| **40** : `ls bozo 2> 2.log`

| **41** : `cat 2.log`

### Creat log files for normal STDOUT and error STDERR in Shell

| **42** : `gedit ../06-logging-1`

*Note `exec` basically means "whatever the current command is", don't lose sleep over it, just see how it is used*

| **43** : `./06-logging-1`

| **44** : `ls`

*gedit Reload: error.log*

| **45** : `gedit ../06-logging-2`

*Note `> OUTFILE` is the same as `1> OUTFILE` because `>` & `1>` are for* STDOUT (`exit 1`) *while `2>` is always for* STDERR (`exit 2`)

| **46** : `./06-logging-2`

*gedit Reload: error.log*

*gedit Reload: normal.log*

| **47** : `gedit ../06-logging-3`

| **48** : `./06-logging-3`

*Note, the file all.log was created*

| **49** : `gedit all.log`

*Both* STDOUT *and* STDERR *went to the same file because this makes errors behave like normal output: `2>&1`

| **50** : `gedit ../06-logging-4`

| **51** : `./06-logging-4`

| **52** : `ls`

*Note the file exit-3.log was created*

| **53** : `gedit exit-3.log`

*Note setting exit messages only works 3-9*

| **54** : `gedit ../06-logging-5`

| **55** : `./06-logging-5`

| **56** : `ls`

*Note the file exit-2.log was created*

| **57** : `gedit exit-2.log`

*Note setting exit 2 messages will appear before STDERR error messages in a 2> error log*

*Note you can set exit 0 also, but that's strange*

| **58** : `gedit ../06-logging-6`

| **59** : `./06-logging-6`

| **60** : `ls`

*Note the file exit-0.log was created*

| **61** : `gedit exit-0.log`

| **62** : `cd ..`

*Moral of the story: always use `exit` with a number!*
- `exit 0` everything is normal, no output  ( with `echo "something"` `>&0` ...if you are strange )
- `exit 1` everything is normal, with STDOUT
- `exit 2` something is wrong, with STDERR error messages
- `exit 3-9` you are cool and make your own exit messages ( with `echo "something"` `>&3`-`>&9` )
- `exit` you are lazy and something is wrong with YOU!

*FYI, you can create a read-only system log file for your script*

| **63** : `gedit ../06-logging-7`

___

# The Take

## `journalctl` & `logger`
- These have some common flags
  - `-t TAG` add/search a tag
  - `-p` add/search priority
- `journalctl` views system logs
  - `-r` reverse order (most recent first)
  - `-f` follows real time entries
  - `-o verbose` shows more
- `logger` makes system log entries
- See usage and examples here: [Resources & Things That Run: journalctl & logger](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#vi-logger--journalctl)

## `exit` codes & app log files
- `exit` code numbers are important, always use an exit code with `exit`!
- This will hide any and all messages: `command > /dev/null 2>&1`
- System `exit` codes:
  - STDOUT = `1` (normal output)
  - STDERR = `2` (error output)
  - `2>&1` redirects `2` into `1` output
  - `>&1` redirecs *all* output into `1` output
- Custom `exit` codes:
  - Most numbers above `2` are either reserved by other processes or customized by the developer (you)
  - `3>&5` redirects `3` into `5` output
  - `>&7` redirecs *all* output into `7` output
  - This may not always be useful to a developer, but it makes everything easier to understand
  - Custom exit methods require `set -o errexit` early in the script
  - `exec N>> file` (`N` = exit number) defines the custom exit log file
- Arguments like `3>&5` & `2>&1` can follow:
  - Any command, ie: `ls 2>&1` or `ls 3>&5`
  - `exec` as a global setting BEFORE relevant commands in the script, ie: `exec 2>&1` or `exec 3>&5`

___

#### [Lesson 7: Functions, source & Combining Tests](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-07.md)
