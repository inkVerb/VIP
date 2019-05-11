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

*This sets a password for `su` if it has not been done already...*

*You MUST be a "sudoer" for this..."*

*Command 2 is optional, only if you are not a sudoer*

| **2** : `su SUDOER_USERNAME` *Input your password, then the sudoer will be logged into the terminal*

| **3** : `sudo passwd` *Input your password, then input the new password for the `su` user*

*To become `su` after this, just input in the terminal: `su`*

*That's it, all done.*
___

# The Take

## `su`, `sudo` & "root":
- `sudo command` will run `command` as a "super user" AKA "root", what Windows calls an "admin"
- `passwd` will change the user's own login password
- `sudo passwd` creates/changes the password for root login via `su`
- `su OTHER_USER` will log you in as another user in a terminal
- `su` (all by itself) will login as "root" so all commands will run as "root", without needing `sudo`
- To login as "root" with `su`, a password must be set first using: `sudo passwd`
- Logging in as root is generally considered dangerous, best use `sudo command`

___
#### [Lesson 1: cp, mv, ln -s, rm, touch](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-01.md)
