# Shell 201
## Lesson 5: adduser, deluser, chown

`cd ~/School/VIP/shell/201`

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

*WARNING: If you already have a user "pinkypink" and/or "pinkypurple", then you are very interesting and should there substitute those names for users not on your system.*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** : `su USERNAME`
>
___

### I. `adduser`

*Look at the `/home` directory to see the users on the machine*

| **1** : `ls /home`

| **2** : `sudo adduser pinkypink` *When prompted, Enter any simple password; press `Enter` for remaining questions.*

*Look at `/home` again to see `pinkypink` has been added*

| **3** : `ls /home`

*See what's at "home"*

| **4** : `ls /home/pinkypink`

*Login as pinkypink in the GUI...*

*..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*

| **5** : `ls /home/pinkypink`

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

| **6** : `su pinkypink`

| **7** : `cd /home/pinkypink`

*Note the path is only `~` because `/home/pinkypink` is home for the user pinkypink*

| **8** : `ls`

*Look at all the new directories*

| **9** : `ls -a`

*Look at all the hidden directories, these are for settings and config files*

| **10** : `exit`

*Note you are no longer in `/home/pinkypink`, but are back where you were when you logged in as pinkypink*

### II. `useradd`

| **11** : `sudo useradd pinkypurple`

*No questions this time!*

*Look at `/home` again, `pinkypurple` doesn't exist!*

| **12** : `ls /home`

*Note `useradd` is simple and doesn't even create a password*

*Note `adduser` makes use of `useradd` and does other tasks, like setting the password*

*Try to login as pinkypurple in the terminal*

| **13** : `su pinkypurple`

*You can't login because pinkypurple doesn't have a password!*

*Set a password for pinkypurple*

| **14** : `sudo passwd pinkypurple` Enter a simple password*

*Look at `/home` again*

| **15** : `ls /home`

*Note pinkypurple doesn't even have a home*

*Now assign a "directory" to home (`-d`) and "move" any existing contents to that directory (`-m`)*

| **16** : `sudo usermod -d /home/ppurple -m pinkypurple`

*Look at `/home` again*

| **17** : `ls /home`

*The directory still doesn't exist!*

*Create the home directory for pinkypurple*

| **18** : `sudo mkdir /home/ppurple`

| **19** : `ls /home`

*Login as pinkypurple in the terminal*

| **20** : `su pinkypurple`

*Now, you are logged in and executing commands as the user "pinkypurple"*

*See where you are*

| **21** : `pwd`

*Same as before you loggeded in*

*Go home*

| **22** : `cd` *(This takes you to your home directory, wherever it is)*

*See where you are*

| **23** : `pwd`

*Try to create a file*

| **24** : `touch newfile`

*Note the error message, you can't create a file in your own home!*

*The home directory exists, it was assigned as home, but pinkypurple doesn't even own its own home!*

| **25** : `exit`

*Let pinkypurple own its own home (this will be explained more in the next section of this lesson)*

| **26** : `sudo chown -R pinkypurple:pinkypurple /home/ppurple`

*Login as pinkypurple in the terminal*

| **27** : `su pinkypurple`

*See where you are*

| **28** : `pwd`

*It didn't remember where you were because this user doesn't even have settings!*

| **29** : `cd`

| **30** : `pwd`

| **31** : `ls`

*Nothing there*

*Create a file*

| **32** : `touch newfile`

| **33** : `ls`

*Everything works, but the command prompt is unstyled because creating a user requires many steps*

*Note `adduser` creates many user settings in creating a user, but `useradd` only does the simple minimum*

*This difference is the same with:*
- `SETTINGS` vs `SIMPLE`
- `adduser` vs `useradd`
- `deluser` vs `userdel`
- `addgroup` vs `groupadd`
- `delgroup` vs `groupdel`

*Now exit as pinkypurple*

| **34** : `exit`

### III. Permissions

| **35** : `ls -l`

*Note the owner of "youown"*

| **36** : `sudo chown pinkypink:pinkypink youown` *Enter your password*

| **37** : `ls -l`

*Note a new owner of "youown" is pinkypink*

| **38** : `chown pinkypurple:pinkypurple youown`

*Note the error message because `chown` requires `sudo`, that's what happens if you don't use `sudo`*

| **39** : `sudo chown pinkypurple:pinkypurple youown`

| **40** : `ls -l`

*Note "youown" now belongs to pinkypurple*

| **41** : `sudo chown pinkypurple:pinkypink theyown`

| **42** : `ls -l`

*Note a new owner of "theyown", the user and group are different*

### IF you logged in as sudoer with `su SUDOER`, `exit` back to your original user
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** : `exit`
>
___

| **43** : `mkdir ownrship`

| **44** : `touch ownrship/file`

### If you need to log back in as a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S3** : `su USERNAME`
>
___

| **45** : `ls -l`

| **46** : `sudo chown pinkypink:pinkypink ownrship`

| **47** : `ls -l`

*Note a new owner of "ownrship"*

| **48** : `ls -l ownrship/`

*Note you own the directory "ownrship", but not the file inside*

*Use `-R` for directories (must be CAPITAL with `chown`!)*

| **49** : `sudo chown -R pinkypink:pinkypink ownrship`

| **50** : `ls -l ownrship/`

*Now you own "ownrship" and the file inside*

*Let's cleanup these files you don't own so they don't cause problems later...*

| **51** : `rm youown`

*Note the error message because you don't own it anymore! Use `sudo`*

| **52** : `sudo rm youown`

| **53** : `ls -l`

*Note `sudo` allows you to delete files and directories you don't own*

*`sudo` acts as "root", meaning files created with `sudo` are owned by root*

*Create a file owned by root*

| **54** : `sudo touch iamroot`

| **55** : `ls -l`

*Note root owns "iamroot"*

| **56** : `rm iamroot`

*Note only root can delete the file "iamroot"*

| **57** : `sudo rm iamroot`

*Let's cleanup after our mess with `sudo` ...*

| **58** : `sudo rm theyown`

| **59** : `sudo rm -r ownrship theyown`

| **60** : `ls -l`

*...also use `sudo` to delete the puppet users we created for this lesson...*

| **61** : `sudo deluser pinkypink`

*Note the message about the "pinkypink" group being empty, that's because `deluser` also deleted the group*

*We don't want to use `userdel` because it is too minimum*

| **62** : `sudo deluser pinkypurple`

*The users still have `/home` directories*

| **63** : `ls /home`

*...remove them both*

| **64** : `sudo rm -r /home/pinkypink /home/ppurple`

| **65** : `ls /home`

*"Own" everything in your home directory, just to make sure all is well (always a good idea)*

| **66** : `sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME`

### IV. Sudoers

*This is the file with settings for "sudoers" (users that can use `sudo`)*

| **67** : `cat /etc/sudoers`

*Note the error, viewing the "sudoers" file requires `sudo` permissions*

| **68** : `sudo cat /etc/sudoers`

*You may not see yourself, this handy little `grep` code shows all sudoers*

| **69** : `grep -Po '^sudo.+:\K.*$' /etc/group`

*You can also `sudo` desktop GUI apps, but it can be dangerous...*

| **70** : `sudo gedit` *Look, then close right away, use Ctrl + C in the terminal*

| **71** : `sudo nautilus` *Look, then close right away, use Ctrl + C in the terminal*


### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S4** : `exit`
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
- Ownership is set with the syntax: `user:group`
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
