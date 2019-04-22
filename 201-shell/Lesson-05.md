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
> | **2** : `su USERNAME`
>
___

### I. `adduser`

*Look at the `/home` directory to see the users on the machine*

| **3** : `ls /home`

| **4** : `sudo adduser pinkypink` *When prompted, Enter any simple password; press `Enter` for remaining questions.*

*Look at `/home` again to see `pinkypink` has been added*

| **5** : `ls /home`

| **6** : `ls /home/pinkypink`

*Look again with "All" files, including anything hidden*

| **7** : `ls /home/pinkypink -a`

*Login as pinkypink in the GUI...*

*..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*

| **8** : `ls /home/pinkypink -a`

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

| **9** : `su pinkypink`

| **10** : `ls`

| **11** : `ls -a`

| **12** : `exit`

### II. `useradd`

| **13** : `sudo useradd pinkypurple`

*No questions this time!*

*Look at `/home` again, `pinkypurple` doesn't exist!*

| **14** : `ls /home`

*Note `useradd` is simple and doesn't even create a password*

*Note `adduser` makes use of `useradd` and does other tasks, like setting the password*

*Try to login as pinkypurple in the terminal*

| **15** : `su pinkypurple`

*You can't login because pinkypurple doesn't have a password!*

*Set a password for pinkypurple*

| **16** : `sudo passwd pinkypurple` Enter a simple password*

*Login as pinkypurple in the terminal*

| **17** : `su pinkypurple`

*Note the message: pinkypurple doesn't even have a home*

| **18** : `exit`

*Now assign a "directory" to home (*`-d`*) and "move" any existing contents to that directory (*`-m`*)*

| **19** : `sudo usermod -d /home/ppurple -m pinkypurple`

*Login as pinkypurple in the terminal*

| **20** : `su pinkypurple`

*The directory still doesn't exist!*

| **21** : `exit`

*Create the home directory for pinkypurple*

| **22** : `sudo mkdir /home/ppurple`

*Login as pinkypurple in the terminal*

| **23** : `su pinkypurple`

*Now, you are logged in and executing commands as the user "pinkypurple"*

*Try to create a file*

| **24** : `touch newfile`

*The home directory exists, it was assigned as the home, but pinkypurple doesn't even own its own home!*

| **25** : `exit`

*Let pinkypurple own its own home (this will be explained in the next section of this lesson)*

| **26** : `sudo chown -R pinkypurple:pinkypurple /home/ppurple`

*Login as pinkypurple in the terminal*

| **27** : `su pinkypurple`

*Create a file*

| **28** : `touch newfile`

| **29** : `ls`

*Everything works, but the command prompt is unstyled because creating a user requires many steps*

*Note `adduser` creates many user settings in creating a user, but `useradd` only does the simple minimum*

*This difference is the same with:*
- `SETTINGS` vs `SIMPLE`
- `adduser` vs `useradd`
- `deluser` vs `userdel`
- `addgroup` vs `groupadd`
- `delgroup` vs `groupdel`

*Now exit as pinkypurple*

| **30** : `exit`

### III. Permissions

| **31** : `ls -l`

*Note the owner of "youown"*

| **32** : `sudo chown pinkypink:pinkypink youown`

| **33** : `ls -l`

*Note a new owner of "youown"*

| **34** : `sudo chown pinkypurple:pinkypink theyown`

| **35** : `ls -l`

*Note a new owner of "theyown", the user and group are different*

| **36** : `chown pinkypurple:pinkypurple youown`

*Note the error message because `chown` requires `sudo`*

| **37** : `sudo chown pinkypurple:pinkypurple youown` *Enter your password*

| **38** : `ls -l`

*"youown" now belongs to pinkypurple*

### IF you logged in as sudoer with `su SUDOER`, `exit` back to your original user
>
___
>
> | **39** : `exit`
>
___

| **39** : `mkdir ownrship`

### If you need to log back in as a "sudoer" who can use `sudo`
>
___
>
> | **40** : `su USERNAME`
>
___

| **41** : `ls -l`

| **42** : `sudo chown pinkypink:pinkypink ownrship`

*Note the error message*

*Use `-R` for directories (must be CAPITAL with `chown`!)*

| **43** : `sudo chown -R pinkypink:pinkypink ownrship`

| **44** : `ls -l`

*Note a new owner of "ownrship"*

| **45** : `rm youown`

*Note the error message because you don't own it anymore! Use `sudo`*

| **46** : `sudo rm youown`

| **47** : `ls -l`

*Note `sudo` allows you to delete files and directories you don't own*

*Create a file owned by root*

| **48** : `sudo touch iamroot`

| **49** : `ls -l`

*Note root owns "iamroot"*

| **50** : `rm iamroot`

*Note only root can delete the file "iamroot"*

| **51** : `sudo rm iamroot`

*Let's cleanup with `sudo` ...*

| **52** : `sudo rm theyown`

| **53** : `sudo rm -r ownrship`

| **54** : `ls -l`

*...also use `sudo` to delete the puppet users we created for this lesson...*

| **55** : `sudo deluser pinkypink`

*Note the message about the "pinkypink" group being empty, delete that group also*

| **56** : `sudo delgroup pinkypink`

*We don't want to use `userdel` because it is too minimum*

| **57** : `sudo deluser pinkypurple`

| **58** : `sudo delgroup pinkypurple`

*The users still have `/home` directories*

| **59** : `ls /home`

*...remove them*

| **60** : `sudo rm -r /home/pinkypink /home/ppurple`

| **61** : `ls /home`

| **62** : `cd ..`

*"Own" everything in your home directory*

| **63** : `sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME`

### IV. Sudoers

*This is the list of users that can use `sudo`*

| **64** : `sudo cat /etc/sudoers`

*Viewing the "sudoers" file requires `sudo` permissions*

| **65** : `cat /etc/sudoers`

*You may not see yourself, this handy little `grep` code shows all sudoers*

| **66** : `grep -Po '^sudo.+:\K.*$' /etc/group`

*You can also `sudo` desktop GUI apps, but it can be dangerous...*

| **67** : `sudo gedit` Look, then close right away, use Ctrl + C in the terminal*

| **68** : `sudo nautilus` Look, then close right away, use Ctrl + C in the terminal*

___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> | **69** : `exit`
>
___

# Normal user finish point for this lesson

### For an administrator to use `su`
>
___
>
> If running as `su` after runing via `sudo`, input this as your normal user to set everything aright:
>
> | **70** : `touch whoown iown theyown youown`
>
___
>
> *Try this commands without `su` and note the error messages because it requires `su`:*
>
> | **71** : `adduser pinkypink`
>
> | **72** : `su` input the password*
>
> ### I. `adduser`
>
> *Look at the `/home` directory to see the users on the machine*
>
> | **73** : `ls /home`
>
> | **74** : `adduser pinkypink` *When prompted, Enter any simple password; press `Enter` for remaining questions.*
>
> *Look at `/home` again to see `pinkypink` has been added*
>
> | **75** : `ls /home`
>
> | **76** : `ls /home/pinkypink`
>
> *Look again with "All" files, including anything hidden*
>
> | **77** : `ls /home/pinkypink -a`
>
> *Login as pinkypink in the GUI...*
>
> *..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*
>
> | **78** : `ls /home/pinkypink -a`
>
> *Note the user directories & settings were created at the first GUI login*
>
> *Login via the terminal*
>
> | **79** : `su pinkypink`
>
> | **80** : `ls`
>
> | **81** : `ls -a`
>
> | **82** : `exit`
>
> ### II. `useradd`
>
> | **83** : `useradd pinkypurple`
>
> *No questions this time! Remember, pinkypurple doesn't have a password and thus can't login*
>
> *Look at `/home` again, `pinkypurple` doesn't exist!*
>
> | **84** : `ls /home`
>
> *Note `useradd` is simple and doesn't even create a password*
>
> *Note `adduser` makes use of `useradd` and does other tasks, like setting the password*
>
> *Login as pinkypurple in the terminal*
>
> | **85** : `su pinkypurple` No password needed because you are root*
>
> *Note the message: pinkypurple doesn't even have a home*
>
> | **86** : `exit`
>
> *Now assign a "directory" to home (`-d`) and "move" any existing contents to that directory (`-m`)*
>
> | **87** : `usermod -d /home/ppurple -m pinkypurple`
>
> *Login as pinkypurple in the terminal*
>
> | **88** : `su pinkypurple`
>
> *The directory still doesn't exist!*
>
> | **89** : `exit`
>
> *Create the home directory for pinkypurple*
>
> | **90** : `mkdir /home/ppurple`
>
> *Login as pinkypurple in the terminal*
>
> | **91** : `su pinkypurple`
>
> *Try to create a file*
>
> | **92** : `touch newfile`
>
> *The home directory exists, it was assigned as the home, but pinkypurple doesn't even own its own home!*
>
> | **93** : `exit`
>
> *Let pinkypurple own its own home (this will be explained in the next section of this lesson)*
>
> | **94** : `chown -R pinkypurple:pinkypurple /home/ppurple`
>
> *Login as pinkypurple in the terminal*
>
> | **95** : `su pinkypurple`
>
> *Create a file*
>
> | **96** : `touch newfile`
>
> | **97** : `ls`
>
> *Everything works, but the command prompt is unstyled because creating a user requires many steps*
>
> *Note `adduser` creates many user settings in creating a user, but `useradd` only does the simple minimum*
>
> *This difference is the same with:*
> - `SETTINGS` vs `SIMPLE`
> - `adduser` vs `useradd`
> - `deluser` vs `userdel`
> - `addgroup` vs `groupadd`
> - `delgroup` vs `groupdel`
>
> *Now exit as pinkypurple*
>
> | **98** : `exit`
>
> ### III. Permissions
>
> | **99** : `ls -l`
>
> *Note the owners of "youown" and "theyown"*
>
> | **100** : `chown pinkypink:pinkypink youown`
>
> | **101** : `ls -l`
>
> *Note a new owner of "youown"*
>
> | **102** : `chown pinkypurple:pinkypink theyown`
>
> | **103** : `ls -l`
>
> *Note a new owner of "theyown", the user and group are different*
>
> *Exit from the "root" user*
>
> | **104** : `exit`
>
> *Try to change ownership of a file you don't own*
>
> | **105** : `chown pinkypurple:pinkypurple youown`
>
> *Note the error message because `chown` requires "root" AKA `sudo` or `su`*
>
> | **106** : `su` input the password*
>
> | **107** : `chown pinkypurple:pinkypurple youown`
>
> | **108** : `ls -l`
>
> *"youown" now belongs to pinkypurple*
>
> | **109** : `mkdir ownrship`
>
> | **110** : `ls -l`
>
> | **111** : `chown pinkypink:pinkypink ownrship`
>
> *Note the error message*
>
> *Use `-R` for directories (must be CAPITAL with `chown`!)*
>
> | **112** : `chown -R pinkypink:pinkypink ownrship`
>
> | **113** : `ls -l`
>
> *Note a new owner of "ownrship"*
>
> *Exit `su` status to see what happened*
>
> | **114** : `exit`
>
> | **115** : `rm youown`
>
> *Note the error message because you don't own it!*
>
> | **116** : `rm -r ownrship`
>
> *Note the error message because you created "ownrship" as "root", so "roo" owns it!*
>
> | **117** : `ls -l`
>
> | **118** : `su` input the password*
>
> | **119** : `rm youown`
>
> | **120** : `ls -l`
>
> *Note `su` permissions allow you to delete any files and directories you don't own*
>
> *Create a file owned by root*
>
> | **121** : `sudo touch iamroot`
>
> | **122** : `ls -l`
>
> *Note root owns "iamroot"*
>
> *Exit `su` status to see what happened*
>
> | **123** : `exit`
>
> | **124** : `rm iamroot`
>
> *Note only root can delete the file "iamroot"*
>
> | **125** : `su` input the password*
>
> | **126** : `rm iamroot`
>
> *Let's cleanup*
>
> | **127** : `rm theyown`
>
> | **128** : `rm -r ownrship`
>
> | **129** : `ls -l`
>
> *...also use your `su` permissions to delete the puppet users we created for this lesson...*
>
> | **130** : `deluser pinkypink`
>
> *Note the message about the "pinkypink" group being empty, delete that group also*
>
> | **131** : `delgroup pinkypink`
>
> *We don't want to use `userdel` because it is too minimum*
>
> | **132** : `deluser pinkypurple`
>
> | **133** : `delgroup pinkypurple`
>
> *The users still have `/home` directories*
>
> | **134** : `ls /home`
>
> *...remove them*
>
> | **135** : `rm -r /home/pinkypink /home/ppurple`
>
> | **136** : `ls /home`
>
> | **137** : `cd ..`
>
> ### IV. sudoers
>
> *This is the list of users that can use `sudo`*
>
> | **138** : `cat /etc/sudoers`
>
> | **139** : `exit`
>
### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **140** : `su USERNAME`
>
___
>
> *Viewing the "sudoers" file requires `sudo` permissions*
>
> | **141** : `cat /etc/sudoers`
>
> *You may not see yourself, this handy little `grep` code shows all sudoers*
>
> | **142** : `grep -Po '^sudo.+:\K.*$' /etc/group`
>
> *You can also `sudo` desktop GUI apps, but it can be dangerous...*
>
> | **143** : `sudo gedit` Look, then close right away, use Ctrl + C in the terminal*
>
> | **144** : `sudo nautilus` Look, then close right away, use Ctrl + C in the terminal*
>
> *"Own" everything in your home directory (YOURUSERNAME is your username)*
>
> | **145** : `sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME`
>
___

# "root" user finish point for this lesson

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
