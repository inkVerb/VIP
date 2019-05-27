# Shell 201
## Lesson 5: adduser, deluser, chown

`cd ~/School/VIP/shell/201`

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

*Prepare our "permissions" directory and enter it in one command*

| **1** : `mkdir permissions && cd permissions`

*WARNING: If you already have a user "pinkypink" and/or "pinkypurple", then you are very interesting and should there substitute those names for users not on your system.*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **A1** : `su USERNAME`
>
___

### I. `adduser`

*Look at the `/home` directory to see the users on the machine*

| **2** : `ls /home`

| **3** : `sudo adduser pinkypink` *When prompted, Enter any simple password; press `Enter` for remaining questions.*

*Look at `/home` again to see `pinkypink` has been added*

| **4** : `ls /home`

*See what's at "home"*

| **5** : `ls /home/pinkypink`

*Login as pinkypink in the GUI...*

*..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*

| **6** : `ls /home/pinkypink`

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

| **7** : `su pinkypink`

| **8** : `cd /home/pinkypink`

*Note the path is only `~` because `/home/pinkypink` is home for the user pinkypink*

| **9** : `ls`

*Look at all the new directories*

| **10** : `ls -a`

*Look at all the hidden directories, these are for settings and config files*

| **11** : `exit`

*Note you are no longer in `/home/pinkypink`, but are back where you were when you logged in as pinkypink*

### II. `useradd`

| **12** : `sudo useradd pinkypurple`

*No questions this time!*

*Look at `/home` again, `pinkypurple` doesn't exist!*

| **13** : `ls /home`

*Note `useradd` is simple and doesn't even create a password*

*Note `adduser` makes use of `useradd` and does other tasks, like setting the password*

*Try to login as pinkypurple in the terminal*

| **14** : `su pinkypurple`

*You can't login because pinkypurple doesn't have a password!*

*Set a password for pinkypurple*

| **15** : `sudo passwd pinkypurple` Enter a simple password*

*Login as pinkypurple in the terminal*

| **16** : `su pinkypurple`

*Note the message: pinkypurple doesn't even have a home*

| **17** : `exit`

*Now assign a "directory" to home (`-d`) and "move" any existing contents to that directory (`-m`)*

| **18** : `sudo usermod -d /home/ppurple -m pinkypurple`

*Login as pinkypurple in the terminal*

| **19** : `su pinkypurple`

*The directory still doesn't exist!*

| **20** : `exit`

*Create the home directory for pinkypurple*

| **21** : `sudo mkdir /home/ppurple`

*Login as pinkypurple in the terminal*

| **22** : `su pinkypurple`

*Now, you are logged in and executing commands as the user "pinkypurple"*

*Try to create a file*

| **23** : `touch newfile`

*The home directory exists, it was assigned as the home, but pinkypurple doesn't even own its own home!*

| **24** : `exit`

*Let pinkypurple own its own home (this will be explained in the next section of this lesson)*

| **25** : `sudo chown -R pinkypurple:pinkypurple /home/ppurple`

*Login as pinkypurple in the terminal*

| **26** : `su pinkypurple`

*Create a file*

| **27** : `touch newfile`

| **28** : `ls`

*Everything works, but the command prompt is unstyled because creating a user requires many steps*

*Note `adduser` creates many user settings in creating a user, but `useradd` only does the simple minimum*

*This difference is the same with:*
- `SETTINGS` vs `SIMPLE`
- `adduser` vs `useradd`
- `deluser` vs `userdel`
- `addgroup` vs `groupadd`
- `delgroup` vs `groupdel`

*Now exit as pinkypurple*

| **29** : `exit`

### III. Permissions

| **30** : `ls -l`

*Note the owner of "youown"*

| **31** : `sudo chown pinkypink:pinkypink youown`

| **32** : `ls -l`

*Note a new owner of "youown"*

| **33** : `sudo chown pinkypurple:pinkypink theyown`

| **34** : `ls -l`

*Note a new owner of "theyown", the user and group are different*

| **35** : `chown pinkypurple:pinkypurple youown`

*Note the error message because `chown` requires `sudo`*

| **36** : `sudo chown pinkypurple:pinkypurple youown` *Enter your password*

| **37** : `ls -l`

*"youown" now belongs to pinkypurple*

### IF you logged in as sudoer with `su SUDOER`, `exit` back to your original user
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **A2** : `exit`
>
___

| **38** : `mkdir ownrship`

### If you need to log back in as a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **A3** : `su USERNAME`
>
___

| **39** : `ls -l`

| **40** : `sudo chown pinkypink:pinkypink ownrship`

*Note the error message*

*Use `-R` for directories (must be CAPITAL with `chown`!)*

| **41** : `sudo chown -R pinkypink:pinkypink ownrship`

| **42** : `ls -l`

*Note a new owner of "ownrship"*

| **43** : `rm youown`

*Note the error message because you don't own it anymore! Use `sudo`*

| **44** : `sudo rm youown`

| **45** : `ls -l`

*Note `sudo` allows you to delete files and directories you don't own*

*Create a file owned by root*

| **46** : `sudo touch iamroot`

| **47** : `ls -l`

*Note root owns "iamroot"*

| **48** : `rm iamroot`

*Note only root can delete the file "iamroot"*

| **49** : `sudo rm iamroot`

*Let's cleanup with `sudo` ...*

| **50** : `sudo rm theyown`

| **51** : `sudo rm -r ownrship`

| **52** : `ls -l`

*...also use `sudo` to delete the puppet users we created for this lesson...*

| **53** : `sudo deluser pinkypink`

*Note the message about the "pinkypink" group being empty, delete that group also*

| **54** : `sudo delgroup pinkypink`

*We don't want to use `userdel` because it is too minimum*

| **55** : `sudo deluser pinkypurple`

| **56** : `sudo delgroup pinkypurple`

*The users still have `/home` directories*

| **57** : `ls /home`

*...remove them*

| **58** : `sudo rm -r /home/pinkypink /home/ppurple`

| **59** : `ls /home`

| **60** : `cd ..`

*"Own" everything in your home directory*

| **61** : `sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME`

### IV. Sudoers

*This is the list of users that can use `sudo`*

| **62** : `sudo cat /etc/sudoers`

*Viewing the "sudoers" file requires `sudo` permissions*

| **63** : `cat /etc/sudoers`

*You may not see yourself, this handy little `grep` code shows all sudoers*

| **64** : `grep -Po '^sudo.+:\K.*$' /etc/group`

*You can also `sudo` desktop GUI apps, but it can be dangerous...*

| **65** : `sudo gedit` Look, then close right away, use Ctrl + C in the terminal*

| **66** : `sudo nautilus` Look, then close right away, use Ctrl + C in the terminal*


### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **A4** : `exit`
>
___

___

# The Take

- `adduser` & `deluser` create and delete a complete group of settings for the user
- `useradd` & `userdel` only create and delete a user, no more
- A user's "home" is in `/home/` by default
- File "permissions" relate to users who own the files
- `chown` sets file "ownership" (`chmod` sets permissions, from [401-04](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-04.md)), see usage and examples here: [VIP/Cheet-Sheets: chmod](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)
- `ls -l` includes file ownership in the output list of files
- Ownership is set in: `user:group`
- Normal users have a group by the same name, only that user belongs to that group
  - The user `jason` will belong to the group `jason` as the only user in that group
  - `ls -l` displays this as: `jason:jason`
- "System" (non-human) users, such as a puppet user for a computer program like an email server or web server, may have a different user and group, but those details are not part of this tutorial
- Most users can view all files
- Some users can use `sudo` (they are like admins)
  - Not all users can use `sudo`
  - Users that can use `sudo` are called "sudoers"
  - The user created at installation can use `sudo` and is therefore a "sudoer"
  - There is a list of sudoers somewhere in the system files, which is the settings file, but the desktop settings GUI can also change which users are and are not sudoers on a graphical desktop installation
- "Writing" (changing/moving/removing) files can only be done by the file "owner" or "group" member or a "sudoer" using `sudo`

___

#### [Lesson 6: wget, curl, git clone](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-06.md)
