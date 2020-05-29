# Shell 301
## Lesson 6: exit & journalctl

Ready the CLI

`cd ~/School/VIP/301`

- [Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** : `su Username` *input the password*
___

### *Note `exit` & `journalctl` are used for logs*

## I. System Logs via `journalctl` & `logger`

*Look at some log entries on your machine*

| **1** : `journalctl` *Space to scroll down, Q to quit*

*Use `-r` to "reverse" the order and view most recent log entries first*

| **2** : `journalctl -r`

*Use `-f` to "follow" the most recent entries in real time*

| **3** : `journalctl -f`

*...now click some actions in the desktop GUI and watch entries appear*

*Ctrl + C to close*

*Create a system log entry...*

| **4** : `logger "I logged this just now."`

*Look for your entry...*

| **5** : `journalctl -r` *Q to quit*

*Use `-t SOME_TAG` to add your own "tag"*

| **6** : `logger -t dazzleTag "I logged this dazzling tag."`

*Now search for only that tag...*

| **7** : `journalctl -t dazzleTag` *Q to quit*

*Set a "priority" level at "info"...*

| **8** : `logger -p info "I logged this info mere moments ago."`

*Look for the "info" priority (`-p info`) in the most recent (`-r`) logs first...*

| **9** : `journalctl -r -p info` *Q to quit*

*Note your "dazzleTag" log also shows up because "info" is the default priority for `logger`*

*...because `info` = `6`, that is the same as...*

| **10** : `logger -p 6 "I also logged this number mere moments ago."`

| **11** : `journalctl -r -p 6` *Q to quit*

*Also use `-p` with a "facility" before the "priority":*

- Usage: `-p FACILITY.PRIORITY`
- Example: `-p local0.alert` = `-p local0.1`
  - `local0` = `16`, `alert` = `1` *(see below)*

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

| **12** : `logger -p daemon.debug "I a text debug daemon."`

| **13** : `journalctl -ro verbose SYSLOG_FACILITY=3 -p debug` *Q to quit*

*Look for:*

- `PRIORITY` *(7 = debug)*
- `SYSLOG_FACILITY` *(3 = daemon)*

*Now do the same thing using the nubmers; facility "user" (1) and priority "info" (6)...*

*Note numbers don't work to enter a facility*

**WILL NOT WORK:** ~~`logger -p 1.6 "I a text debug user."`~~

| **14** : `logger -p user.6 "I a text debug user."`

| **15** : `journalctl -ro verbose SYSLOG_FACILITY=1 -p 6` *Q to quit*

*Look for:*

- `PRIORITY` *(6 = info)*
- `SYSLOG_FACILITY` *(1 = user)*

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** : `exit`
___


*This is just cool:*

| **16** : `journalctl --since today > journalctl-today.txt`

*If you dare: `gedit journalctl-today.txt`*

*Also try: `--since yesterday`*

*Prepare for the next section...*

| **17** : `mkdir logs && cd logs && touch one-file`

## II. Custom Output Logs

Ready the CLI (if needed)

`cd ~/School/VIP/301/logs`

___

### A custom log can be useful for keeping track of what happens on your machine

*First `ls` the directory like normal...*

| **18** : `ls`

*Send the output to a file called "log"...*

| **19** : `ls > log`

| **20** : `gedit log`

*Now `ls` something that doesn't exist, the output is an error...*

| **21** : `ls bozo`

*Try sending that error output to the file called "log"...*

| **22** : `ls bozo > log`

*gedit: Reload log*

*Nothing is there!*

*Error output can't go to a file with `>` or `>>`*

*Error output only goes to a file with `2>` or `2>>`*

| **23** : `ls bozo 2> log`

*gedit: Reload log*

| **24** : `ls 2> log`

*gedit: Reload log*

*Cleanup...*

| **25** : `rm log`

### Ouput to file
- *Send* STDOUT *(output) to a file with: `> outputfile`*
- *Send* STDERR *(error output) to a file with: `2> outputfile`*

*Send our STDOUT and STDERR to different log files*

| **26** : `ls bozo`

*Note the error message in the terminal*

| **27** : `ls bozo 2> error.log`

| **28** : `ls`

*Not the same error message went into the file*

| **29** : `gedit error.log`

*gedit: Reload error.log*

| **30** : `ls bozo 2>> error.log`

*gedit: Reload error.log*

| **31** : `ls >> normal.log`

| **32** : `ls`

| **33** : `gedit normal.log`

*Combine this into one command with: `> STDOUT-file 2> STDERR-file`*

| **34** : `ls bozo >> normal.log 2>> error.log`

*gedit: Reload error.log*

*Send STDERR (error output) into the nothingness with: `> /dev/null 2>&1`...*

| **35** : `ls bozo > /dev/null 2>&1`

*Send STDOUT (normal output) into the nothingness just the same...*

| **36** : `ls > /dev/null 2>&1`

| **37** : `ls`

*See! Nothing at all!*

*Note `journalctl` is for system logs, but you can create your own log files this way*

### Review output numbers

#### Generate normal output

*Outputs nothing to file:*

| **38** : `ls 0> 0.log`

*Outputs STDOUT to file (present):*

| **39** : `ls 1> 1.log`

*Outputs STDERR to file (absent):*

| **40** : `ls 2> 2.log`

*Look at the three ".log" files created...*

| **41** : `ls`

*View each of them in gedit*

| **42** : `gedit 0.log` ...nothing—because "0" (no output) is nothing

| **43** : `gedit 1.log` ...file list—because `ls` succeeded

| **44** : `gedit 2.log` ...nothing—because `ls` didn't fail

#### Generate error output

*Outputs nothing to file:*

| **45** : `ls bozo 0> 0.log`

*Outputs STDOUT to file (absent):*

| **46** : `ls bozo 1> 1.log`

*Outputs STDERR to file (present):*

| **47** : `ls bozo 2> 2.log`

*Review at the three ".log" files just updated...*

- *gedit: Reload `0.log`* ...nothing—because "0" (no output) is nothing

- *gedit: Reload `1.log`* ...nothing—because `ls` didn't succeed

- *gedit: Reload `2.log`* ...error message—because `ls` failed

## III. Logging with `exit` Codes

Ready the CLI (if needed)

*gedit: Ctrl + W to close previous files*

`cd ~/School/VIP/301/logs`

`gedit error.log normal.log`

___

*Note many commands will start with `../` as files are in the parent directory*

### Creat log files for normal STDOUT and error STDERR in Shell

| **48** : `gedit ../06-logging-1`

*Note:*

- *`exec` basically means "whatever the current command is"*
- *Output channel 2 (STDERR) goes to a file*
- *Output channel 1 (STDOUT) is unchanged and goes to the terminal*

*Whatch the output of our two commands in that script...*

| **49** : `ls`

| **50** : `ls bozo`

| **51** : `../06-logging-1`

*gedit Reload:*

- *error.log*

| **52** : `gedit ../06-logging-2`

*Note:*

- *Output channel 1 (STDOUT) goes to a file, just like channel 2 (STDERR)*
- *`> Output-File` is the same as `1> Output-File` because `>` & `1>` are for STDOUT*
- *`2> Output-File` is always for STDERR*

| **53** : `../06-logging-2`

*gedit Reload:*

- *error.log*
- *normal.log*

| **54** : `gedit ../06-logging-3`

*Note:*

- *STDOUT and STDERR both go to the same log file*
- *`2>&1` sends all channel 2 output into channel 1*
  - *So, technically, STDERR will become STDOUT*

| **55** : `../06-logging-3`

| **56** : `ls`

*Note the file all.log was created*

| **57** : `gedit all.log`

*Note all the output is in the same file*

| **58** : `gedit ../06-logging-4`

*Note:*

- *`set -e` causes the script to `exit` instantly if there is any STDERR error*
- *`ls` will not cause an error, only normal STDOUT output*
- *`ls bozo` will cause an error, creating STDERR, then exit*

| **59** : `../06-logging-4`

*Note:*

- *"ls was successful" displayed*
- *"ls bozo was successful" did not display*
  - *`ls bozo` caused an error*
  - *`set -e` makes any errors exit the script*
  - *The error from `ls bozo` caused an exit before `echo "ls bozo was successful"`*

| **60** : `gedit ../06-logging-5`

*Note:*

- *Same commands as 06-logging-4*
- *All output to same file, as with 06-logging-3*

| **61** : `../06-logging-5`

*gedit Reload: all.log*

### Notes about `exit` status (AKA 'exit codes')

> *Logs & `exit` codes are related*
>
> *Errors are important, handle them correctly with `exit`*
>
> *`exit` creates different types of output, depending on the `exit` number, such as `exit 0` or `exit 5` et cetera*
>
> *An `exit` is a way to "break" out of a script, such as `if - then` tests, but always use `exit 0` unless a problem or event needs to be logged!*
>
> *It is considered "bad coding" to use `exit` without a number or to use an exit other than `exit 0` without need for a log entry*
>
> *When tutorials only have `exit` in the example, it is up to you to put the correct number after, probably `exit 0`*
>

| **62** : `gedit ../06-status0`

*Note this only runs a simple, successful command: `ls`*

| **63** : `ls`

*Get the last `exit` status (we learned this in [Lesson 1](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-01.md#v-if-commands))...*

| **64** : `echo $?`

*Note `ls` returns an `exit` status of 0*

| **65** : `../06-status0`

*Get the last `exit` status...*

| **66** : `echo $?`

*Note the `exit` status was 0 because the script simply quit at the end*

| **67** : `gedit ../06-status1`

*Note this only runs a simple, successful command: `ls`, then exists with `exit` status 1*

| **68** : `../06-status1`

*Get the last `exit` status...*

| **69** : `echo $?`

*The last `exit` status was 1 because our script exited via `exit 1`*

| **70** : `gedit ../06-status2`

*Note this only runs a simple, successful command: `ls`, then exists with `exit` status 2*

| **71** : `../06-status2`

*Get the last `exit` status...*

| **72** : `echo $?`

*The last `exit` status was 2 because our script exited via `exit 2`*

#### 0, 1 & 2 are not the only way to exit!

| **73** : `gedit ../06-status3`

*Note this only runs a simple, successful command: `ls`, then exists with `exit` status 3*

| **74** : `../06-status3`

*Get the last `exit` status...*

| **75** : `echo $?`

*The last `exit` status was 3 because our script exited via `exit 3`*

**It can go as high as 87, try something higher...**

| **76** : `gedit ../06-status599`

*Note this only runs a simple, successful command: `ls`, then exists with `exit` status 599*

| **77** : `../06-status599`

*Get the last `exit` status...*

| **78** : `echo $?`

*The last `exit` status was 87 because they can't go higher than 87*

*gedit: Ctrl + W to close previous files*

**How long does an `exit` status persist?**

| **79** : `gedit ../06-exit3 ../06-exit-check-1`

*Note:*

- *06-exit3: only exit with a status, nothing more*
- *06-exit-check-1: this sets `$?` to a variable (`$lastExit`) because `$?` will change to 0 after the `if` test*

| **80** : `../06-exit3`

| **81** : `echo $?`

| **82** : `../06-exit-check-1`

*What? The last `exit` status was 3!*

**The exiting script and `if` test** ***must be in the same script!***

| **83** : `gedit ../06-exit-check-2`

| **84** : `../06-exit-check-2`

*Now it recognizes the last `exit` status because it was generated inside the same script*

*gedit: Ctrl + W to close previous files*

#### Sent custom messages to output channels 3-87

| **85** : `ls`

*Generate an STDOUT channel 1 message...*

| **86** : `gedit ../06-output-1`

| **87** : `../06-output-1`

| **88** : `ls`

*Note the file out-1.log was created*

| **89** : `gedit out-1.log`

*Generate an STDERR channel 2 message...*

| **90** : `gedit ../06-output-2`

| **91** : `../06-output-2`

| **92** : `ls`

*Note the file out-2.log was created*

| **93** : `gedit out-2.log`

**...But we already knew about channels `1>` and `2>`; let's do channel `3>`**

*Generate a custom channel 3 message...*

| **94** : `gedit ../06-output-3`

| **95** : `../06-output-3`

| **96** : `ls`

*Note the file out-3.log was created*

| **97** : `gedit out-3.log`

*Generate a custom channel 0 message...*

*(Normally channel 0 should remain empty, but it technically doesn't have to be...)*

| **98** : `gedit ../06-output-0`

| **99** : `../06-output-0`

| **100** : `ls`

*Note the file out-0.log was created*

| **101** : `gedit out-0.log`

*Sent output messages to many channels from one script...*

| **102** : `gedit ../06-output-4`

| **103** : `../06-output-4`

*gedit: Reload*

- *out-0.log*
- *out-1.log*
- *out-2.log*
- *out-3.log*

*Note we didn't use any `exit` codes to make these log entries!*

**Output channel syntax:**

```sh
exec 0>> Output-File # Optional, if output to file
some command >&0

exec 1>> Output-File # Optional, if output to file
some command >&1

exec 2>> Output-File # Optional, if output to file
some command >&2

exec 3>> Output-File # Necessary for channels 3 and above
some command >&3
```

## IV. Bring Together: `>&3`, `exit 3`, `logger` & `journalctl`

Ready the CLI (if needed)

`cd ~/School/VIP/301/logs`

#### Output channels & `exit` status work together:

If there is some special situation in your script:
- For example, use channel 3...
1. `>&3`: to send output to a file (`exec 3>> Output-File` must come first!)
2. `exit 3`: the last "`exit` status" is the same as the output channel
3. `$?`: trigger something special
4. ...maybe log entries with `logger` & `journalctl`
- This could be for any `exit` status, not only 3

Real life example:

*FYI, preview of [Lesson 8](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-08.md: `date`...*

| **104** : `date +%Y-%m-%d_%H:%M:%S`

*...We will use that to create a timestamp...*

| **routine-check** :

```sh
exec 3>> Check.log

if [ -f "file-3" ]; then
  timestamp="$(date +%Y-%m-%d_%H:%M:%S)" # Lesson 8 teaches date
  echo "file-3 exists at: $timestamp" >&3 # This way there is a record
  exit 3 # This way the next script knows what happened
fi
```
Then, maybe the next script you run is...

| **routine-follow-up** :

```sh
if [ $? = 3 ]; then # Test if the last `exit` status was 3
  # Make an entry with logger:
    # local0 is a custom "Facility" for journalctl and logger...
  logger -t RoutineCheck -p local0.info "Check found a status three."
fi
```

*Try...*

| **105** : `gedit ../06-routine-check ../06-routine-follow-up`

*Note these are basically the same scripts as the above example*

| **106** : `ls`

*Note "file-3" does not exist*

| **107** : `../06-routine-check`

| **108** : `echo $?`

*Note:*
- *the last `exit` status is 0 because "file-3" does not exist*
- *06-routine-check did nothing at all because the test failed*

| **109** : `../06-routine-follow-up`

*Note 06-routine-follow-up basically said that 06-routine-check did nothing*

**On this page: [Resources: journalctl & logger](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#vi-logger--journalctl)...**

- Facility `local0` = `16`
- So, make an `local0`-facility at `info`-priority log entry with:
  - `logger -p local0.info`
- And, filter for only `local0`-facility logs at `info`-priority with:
  - `journalctl SYSLOG_FACILITY=16 -p info`
- Flags:
  - `-r` = reverse listing (most recent first)
  - `-t SomeTag` = filter by tag

| **110** : `journalctl -rt RoutineCheck SYSLOG_FACILITY=16 -p info`

*Note no `journalctl` entries*

*Create the file and try again...*

| **111** : `touch file-3`

| **112** : `ls`

*Note "file-3" exists*

| **113** : `../06-routine-check`

| **114** : `echo $?`

*Note the last `exit` status is 3 because "file-3" exists*

*So, it will work here...*

| **115** : `../06-routine-follow-up`

| **116** : `ls`

*Note "Check.log" now exists*

| **117** : `gedit Check.log`

*Check the logs for:*

- *Tag: RoutineCheck*
- *Facility: `local0` (16)*
- *Priority: `info`*

| **118** : `journalctl -rt RoutineCheck SYSLOG_FACILITY=16 -p info` *Q to quit*

*Review our `exit` status for success and failure...*

| **119** : `ls`

| **120** : `echo $?`

| **121** : `ls bozo`

| **122** : `echo $?`

*Let's add two `ls` commands to process `exit` status 0 and 1...*

| **123** : `gedit ../06-routine-montage`

| **124** : `../06-routine-montage`

| **125** : `journalctl -rt RoutineCheck SYSLOG_FACILITY=16 -p info` *Q to quit*

#### *Moral of the story: always use `exit` with a number!*
- `exit 0` everything is normal, no output *(with `echo "something"` `>&0` ...if you are strange)*
- `exit 1` everything is normal, with STDOUT
- `exit 2` something is wrong, with STDERR error messages
- `exit 3-87` you are cool and make your own exit messages *(with `echo "something"` `>&3`-`>&87`)*
- `exit` you are lazy and something is wrong with YOU!

*FYI, you can create a read-only system log file for your script*

| **126** : `gedit ../06-logging-strong`

___

# The Take

## `journalctl` & `logger`
- These have some common flags
  - `-t Tag` add/filter a tag
  - `-p info` add/filter priority (`info` for example)
- `logger` makes system log entries
- `journalctl` views system logs
  - `-r` reverse order (most recent first)
  - `-f` follows real time entries
  - `-o verbose` shows more
  - `-t SomeTag` filters by tag
  - `SYSLOG_FACILITY=N` filter by `N` = facility number
- Example syntax:
  - Make entry: `logger -p daemon.info` *(`daemon` facility, `info` priority)*
  - Filter entry: `journalctl SYSLOG_FACILITY=3 -p info` *(`daemon` = facility 3)*
- See usage, facility numbers, and examples here: [Resources & Things That Run: journalctl & logger](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md#vi-logger--journalctl)

## `exit` status & app log files
- `exit` code numbers are important, always use an exit code with `exit`!
- This will hide any and all messages: `command > /dev/null 2>&1`
- System `exit` codes:
  - STDOUT = `1` (normal output)
  - STDERR = `2` (error output)
- Custom `exit` codes:
  - Syntax: `exit 0`
  - Most numbers above `2` are either reserved by other processes or customized by the developer (you)
    - Following example uses the custom output channel 3:
      - `exec 3>> Output-File` defines the custom exit channel 3 to output to a specific log file
      - `2>&3` will send all STDERR (channel 2 output) into your custom channel 3
      - `echo "Some message here" >&3` will add a message to your custom channel 3
      - `exit 3` must be your exit method for the output to appear
- Proper `exit` codes allow other scripts to understand what happened after the fact
- Output channels
  - Syntax: `M>&N`
  - Arguments like `3>&5` & `2>&1` redirect the output channels
  - `2>&1` redirects `2` output into `1` output
    - `>&1` redirecs *all* output into `1` output
  - `3>&5` redirects `3` into `5` output
    - `>&7` redirecs *all* output into `7` output
  - Output channel redirects can follow any command
    - ie: `ls 2>&1` or `ls 3>&5`
  - `exec` as a global setting BEFORE relevant commands in the script
    - ie: `exec 2>&1` or `exec 3>&5`
___

#### [Lesson 7: Functions, source & Combining Tests](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-07.md)
