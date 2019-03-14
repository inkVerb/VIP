# Shell 201
## Lesson 0: sudo passwd

___

## Prepare

| **1** : `mkdir -p ~/School/VIP/shell/201`

### Create `su` (Super User) password

The Shell 201 course occasionally requires `sudo` AKA `su` AKA "root" permissions.

If you are not a "sudoer", you need the machine (computer) administrator (mom, dad, owner, teacher?) nearby to input the password for some `su` jobs in the lessons.

___

## Never use `sudo` in a shell script
## Instead, use `sudo ./my-shell-script`, if you need root permissions in your script

___

*This sets a password for* `su` *if it has not been done already...*

*You MUST be a "sudoer" for this..."*

| **2** : `sudo passwd` *Input your password, then input the new password for the* `su` *user*

*To become* `su` *after this, just input in the terminal:* `su`

*That's it, all done.*
___

# The Take

-

___
#### [Lesson 1: cp, mv, ln -s, rm](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-01.md)
