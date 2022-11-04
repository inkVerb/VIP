# Shell 201
## Lesson 5: su, adduser, deluser, chown

Ready the CLI

```console
cd ~/School/VIP/201
```

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

*WARNING: If you already have a user "pinkypink" and/or "pinkypurple", then you are very interesting and should there substitute those names for users not on your system.*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
___

### I. `adduser`

*Look at the `/home` directory to see the users on the machine*

| **1** :$

```console
ls /home
```

| **U2** :$ (Ubuntu)

- *When prompted Enter any simple password*
- *Press `Enter` for remaining questions*

```console
sudo adduser pinkypink
```

| **A2** :$ (Arch/Manjaro)

- *Enter `pinkypink` for user group*
- *Press `Enter` for other questions*
- *When prompted Enter any simple password*

```console
sudo groupadd pinkypink
sudo adduser pinkypink
```

*Look at `/home` again to see `pinkypink` has been added*

| **3** :$

```console
ls /home
```

*Login via the terminal*

| **4** :$

```console
su pinkypink
```

*See what's at "home"*

| **4** :$

```console
ls /home/pinkypink
```

| **5** :$

```console
ls /home/pinkypink
```

*Login as pinkypink in the GUI...*

*..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*

Ready the CLI (if needed)

```console
cd ~/School/VIP/201
```

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

| **6** :$

```console
su pinkypink
```

| **7** :$

```console
cd /home/pinkypink
```

*Note the path is only `~` because `/home/pinkypink` is home for the user pinkypink*

| **8** :$

```console
ls
```

*Look at all the new directories*

| **9** :$

```console
ls -a
```

*Look at all the hidden directories, these are for settings and config files*

| **10** :$

```console
exit
```

*Note you are no longer in `/home/pinkypink`, but are back where you were when you logged in as pinkypink*

### II. `useradd`

| **11** :$

```console
sudo useradd pinkypurple
```

*No questions this time!*

*Look at `/home` again, `pinkypurple` doesn't exist!*

| **12** :$

```console
ls /home
```

*Note `useradd` is simple and doesn't even create a password*

*Note `adduser` makes use of `useradd` and does other tasks, like setting the password*

*Try to login as pinkypurple in the terminal*

| **13** :$

```console
su pinkypurple
```

*You can't login because pinkypurple doesn't have a password!*

*Set a password for pinkypurple*

| **14** :$ *Enter a simple password*

```console
sudo passwd pinkypurple
```

*Look at `/home` again*

| **15** :$

```console
ls /home
```

*Note pinkypurple doesn't even have a home*

*Now assign a "directory" to home (`-d`) and "move" any existing contents to that directory (`-m`)*

| **16** :$

```console
sudo usermod -d /home/ppurple -m pinkypurple
```

*Look at `/home` again*

| **17** :$

```console
ls /home
```

*The directory still doesn't exist!*

*Create the home directory for pinkypurple*

| **18** :$

```console
sudo mkdir /home/ppurple
```

| **19** :$

```console
ls /home
```

*Login as pinkypurple in the terminal*

| **20** :$

```console
su pinkypurple
```

*Now, you are logged in and executing commands as the user "pinkypurple"*

*See where you are*

| **21** :$

```console
pwd
```

*Same as before you loggeded in*

*Go home*

| **22** :$ *(This takes you to your home directory, wherever it is)*

```console
cd
```

*See where you are*

| **23** :$

```console
pwd
```

*Try to create a file*

| **24** :$

```console
touch newfile
```

*Note the error message, you can't create a file in your own home!*

| **25** :$

```console
exit
```

*See why...*

| **26** :$

```console
ls -l /home
```

*The home directory exists, it was assigned as home, but pinkypurple doesn't even own its own home!*

*Let pinkypurple own its own home (this will be explained more in the next section of this lesson)...*

| **27** :$

```console
sudo chown -R pinkypurple:pinkypurple /home/ppurple
```

| **28** :$

```console
ls -l /home
```

*Login as pinkypurple in the terminal*

| **29** :$

```console
su pinkypurple
```

*See where you are*

| **30** :$

```console
pwd
```

*It didn't remember where you were because this user doesn't even have settings!*

| **31** :$

```console
cd
```

| **32** :$

```console
pwd
```

| **33** :$

```console
ls
```

*Nothing there*

*Create a file*

| **34** :$

```console
touch newfile
```

| **35** :$

```console
ls
```

*Everything works, but the command prompt is unstyled because creating a user requires many steps*

*Note `adduser` creates many user settings in creating a user, but `useradd` only does the simple minimum*

*This difference is the same with:*
- `SETTINGS` vs `SIMPLE`
- `adduser` vs `useradd`
- `deluser` vs `userdel`
- `addgroup` vs `groupadd`
- `delgroup` vs `groupdel`

*Now exit as pinkypurple*

| **36** :$

```console
exit
```

### III. Permissions

Ready the CLI (if needed)

```console
cd ~/School/VIP/201
```

`su Username`

___

| **37** :$

```console
ls -l
```

*Note the owner of "youown"*

| **38** :$ *Enter your password*

```console
sudo chown pinkypink:pinkypink youown
```

| **39** :$

```console
ls -l
```

*Note a new owner of "youown" is pinkypink*

| **40** :$

```console
chown pinkypurple:pinkypurple youown
```

*Note the error message because `chown` requires `sudo`, that's what happens if you don't use `sudo`*

| **41** :$

```console
sudo chown pinkypurple:pinkypurple youown
```

| **42** :$

```console
ls -l
```

*Note "youown" now belongs to pinkypurple*

| **43** :$

```console
sudo chown pinkypurple:pinkypink theyown
```

| **44** :$

```console
ls -l
```

*Note a new owner of "theyown", the user and group are different*

### IF you logged in as sudoer with `su SUDOER`, `exit` back to your original user
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
___

| **45** :$

```console
mkdir ownrship
```

| **46** :$

```console
touch ownrship/file
```

### If you need to log back in as a "sudoer" who can use `sudo`
>
___
> Optional: Login again as a "sudoer" if needed
>
> | **S3** :$

```console
su Username
```
___

| **47** :$

```console
ls -l
```

| **48** :$

```console
sudo chown pinkypink:pinkypink ownrship
```

| **49** :$

```console
ls -l
```

*Note a new owner of "ownrship"*

| **50** :$

```console
ls -l ownrship/
```

*Note you own the directory "ownrship", but not the file inside*

*Use `-R` for directories (must be CAPITAL with `chown`!)*

| **51** :$

```console
sudo chown -R pinkypink:pinkypink ownrship
```

| **52** :$

```console
ls -l ownrship/
```

*Now you own "ownrship" and the file inside*

*Remove it...*

| **53** :$ *"y" for Yes, might not work; "n" for No is better for this lesson*

```console
rm youown
```

*Note the error message because you don't own it anymore! Use `sudo`*

| **54** :$

```console
sudo rm youown
```

| **55** :$

```console
ls -l
```

*Note `sudo` allows you to delete files and directories you don't own*

*`sudo` acts as "root", meaning files created with `sudo` are owned by root*

*Create a file owned by root*

| **56** :$

```console
sudo touch iamroot
```

| **57** :$

```console
ls -l
```

*Note root owns "iamroot"*

| **58** :$ *"y" for Yes, might not work; "n" for No is better for this lesson*

```console
rm iamroot
```

*Note only root can delete the file "iamroot"*

| **59** :$

```console
sudo rm iamroot
```

*Let's cleanup these files you don't own so they don't cause problems later ...*

| **60** :$

```console
sudo rm theyown
```

| **61** :$

```console
sudo rm -r ownrship
```

| **62** :$

```console
ls -l
```

*...also use `sudo` to delete the puppet users we created for this lesson...*

| **U63** :$ (Ubuntu)

```console
sudo deluser pinkypink
```

| **A63** :$ (Arch/Manjaro)

```console
sudo groupdel pinkypink
sudo userdel pinkypink
```

*Note the message about the "pinkypink" group being empty, that's because `deluser` also deleted the group*

*`userdel` does not delete the group*

| **U64** :$ (Ubuntu)

```console
sudo deluser pinkypurple
```

| **A64** :$ (Arch/Manjaro)

```console
sudo userdel pinkypurple
```

*The users still have `/home` directories*

| **65** :$

```console
ls -l /home
```

*Note the users' old home directories are still there, but owned by some number!*

*...remove them both*

| **66** :$

```console
sudo rm -r /home/pinkypink /home/ppurple
```

| **67** :$

```console
ls /home
```

*"Own" everything in your home directory, just to make sure all is well (always a good idea)*

| **68** :$

```console
sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME
```

### IV. Sudoers

*This is the file with settings for "sudoers" (users that can use `sudo`)*

| **69** :$

```console
cat /etc/sudoers
```

*Note the error, viewing the "sudoers" file requires `sudo` permissions*

| **70** :$

```console
sudo cat /etc/sudoers
```

*You may not see yourself, this handy little `grep` code shows all sudoers*

| **71** :$

```console
grep -Po '^sudo.+:\K.*$' /etc/group
```

*You can also `sudo` desktop GUI apps, but it can be dangerous...*

| **72** :$ *Look, then close right away, use <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal*

```console
sudo gedit
```

| **73** :$ *Look, then close right away, use <kbd>Ctrl</kbd> + <kbd>C</kbd> in the terminal*

```console
sudo nautilus
```


### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S4** :$

```console
exit
```
___

___

# The Take

- `adduser` & `deluser` create and delete a complete group of settings for the user
- `useradd` & `userdel` only create and delete a user, no more
- A user's "home" is in `/home/` by default
- File "permissions" relate to users who own the files
- `chown` sets file "ownership" (`chmod` sets permissions, from [401-04](https://github.com/inkVerb/vip/blob/master/201/Lesson-04.md)), see usage and examples here: [VIP/Cheat-Sheets: Permissions](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Permissions.md)
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

#### [Lesson 6: wget, curl, git clone](https://github.com/inkVerb/vip/blob/master/201/Lesson-06.md)
