# Shell 201
## Lesson 0: sudo passwd

___

## Prepare

| **1** :$ `mkdir -p ~/School/VIP/201`

### Create `su` (Super User) password

The Shell 201 course occasionally requires `sudo` AKA `su` AKA "root" permissions.

If you are not a "sudoer", you need the machine (computer) administrator (mom, dad, owner, teacher?) nearby to input the password for some `sudo` jobs in the lessons.

___

## Never use `sudo` in a shell script
## Instead, use `sudo ./my-shell-script`, if you need root permissions in your script

___

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$ `su Username`
___

*This sets a password for `su` if it has not been done already...*

*You MUST be a "sudoer" for this..."*

| **2** :$ `sudo passwd` *Input your password, then input the new password for the `su` user*

*To become `su` after this, just input in the terminal: `su`*

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$ `exit`
___

*Login as `su` to see what it's like*

| **3** :$ `su` *Input the password you just set*

*Look, you're root!*

About `sudo` and "root"...

### Prompts show power

*Remember from [0-Rientation](https://github.com/inkVerb/vip/blob/master/101-shell/0-Rientation.md):*

- *`$` indicates a normal "user" prompt*
  - *This includes a sudoer and non-sudoer*
- *`#` indicates a "root" user prompt*
  - *Everything done is owned by "root" and never needs `sudo`*
  - *This is generally dangerous*

*Bye*

| **4** :$ `exit`

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
- Never use `sudo` inside a shell script
- Always use `sudo ./my-shell-script`, if your script needs root permissions
- `$` indicates a normal "user" prompt
- `#` indicates a "root" user prompt

___

#### [Lesson 1: cp, mv, ln -s, rm, touch](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-01.md)
