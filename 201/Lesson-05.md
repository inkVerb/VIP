# Linux 201
## Lesson 5: su, adduser, deluser, chown

Ready the CLI

```console
cd ~/School/VIP/201
```

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

*WARNING: If you already have a user "`pinkypink`" and/or "`pinkypurple`", then you are very interesting and should there substitute those names for users not on your system.*

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

| **A2** :$ (Arch/Manjaro)

```console
sudo groupadd pinkypink
sudo adduser pinkypink
```

- *Enter `pinkypink` for user group*
- *Press `Enter` for other questions*
- *When prompted Enter any simple password*


| **C2** :$ (RedHat/CentOS)

```console
sudo adduser pinkypink
```

*Note no messages, all is handled*

| **U2** :$ (Ubuntu)

```console
sudo adduser pinkypink
```

- *When prompted Enter any simple password*
- *Press `Enter` for remaining questions*

*Look at `/home` again to see `pinkypink` has been added*

| **3** :$

```console
ls /home
```

*Login via the terminal to be able to see what's at "home"*

| **4** :$

```console
su pinkypink
```

*See what's at "`home`"*

| **5** :$

```console
ls /home/pinkypink
```

| **6** :$

```console
exit
```

*Login as `pinkypink` in the GUI...*

*..."Switch User", login as `pinkypink`, "Log Out", then return to this GUI session*

Ready the CLI (if needed)

```console
cd ~/School/VIP/201
```

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

| **7** :$

```console
su pinkypink
```

| **8** :$

```console
cd /home/pinkypink
```

*Note the path is only `~` because `/home/pinkypink` is home for the user `pinkypink`*

| **9** :$

```console
ls
```

*Look at all the new directories*

| **10** :$

```console
ls -a
```

*Look at all the hidden directories, these are for settings and config files*

| **11** :$

```console
exit
```

*Note you are no longer in `/home/pinkypink`, but are back where you were when you logged in as `pinkypink`*

### II. `useradd`

Ready the CLI (if needed)

```console
cd ~/School/VIP/201
```

| **12** :$

```console
sudo useradd pinkypurple
```

*No questions this time!*

*Look at `/home` again, `pinkypurple` doesn't exist!*

| **13** :$

```console
ls /home
```

*Note `useradd` is simple and doesn't even create a password*

*Note `adduser` makes use of `useradd` and does other tasks, like setting the password*

*Try to login as `pinkypurple` in the terminal*

| **14** :$

```console
su pinkypurple
```

*You can't login because `pinkypurple` doesn't have a password!*

*Set a password for `pinkypurple`*

| **15** :$ *Enter a simple password*

```console
sudo passwd pinkypurple
```

*Look at `/home` again*

| **16** :$

```console
ls /home
```

*Note `pinkypurple` doesn't even have a home*

*Now assign a "directory" to home (`-d`) and "move" any existing contents to that directory (`-m`)*

| **17** :$

```console
sudo usermod -d /home/ppurple -m pinkypurple
```

*Look at `/home` again*

| **18** :$

```console
ls /home
```

*The directory still doesn't exist!*

*Create the home directory for `pinkypurple`*

| **19** :$

```console
sudo mkdir /home/ppurple
```

| **20** :$

```console
ls /home
```

*Login as `pinkypurple` in the terminal*

| **21** :$

```console
su pinkypurple
```

*Now, you are logged in and executing commands as the user "`pinkypurple`"*

*See where you are*

| **22** :$

```console
pwd
```

*Same as before you loggeded in*

*Go home*

| **23** :$ *(This takes you to your home directory, wherever it is)*

```console
cd
```

*See where you are*

| **24** :$

```console
pwd
```

*Try to create a file*

| **25** :$

```console
touch newfile
```

*Note the error message, you can't create a file in your own home!*

| **26** :$

```console
exit
```

*See why...*

| **27** :$

```console
ls -l /home
```

*The home directory exists, it was assigned as home, but `pinkypurple` doesn't even own its own home!*

*Let `pinkypurple` own its own home (this will be explained more in the next section of this lesson)...*

| **28** :$

```console
sudo chown -R pinkypurple:pinkypurple /home/ppurple
```

| **29** :$

```console
ls -l /home
```

*Login as `pinkypurple` in the terminal*

| **30** :$

```console
su pinkypurple
```

*See where you are*

| **31** :$

```console
pwd
```

*It didn't remember where you were because this user doesn't even have settings!*

| **32** :$

```console
cd
```

| **33** :$

```console
pwd
```

| **34** :$

```console
ls
```

*Nothing there*

*Create a file*

| **35** :$

```console
touch newfile
```

| **36** :$

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

*Now exit as `pinkypurple`*

| **37** :$

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

| **38** :$

```console
ls -l
```

*Note the owner of "`youown`"*

| **39** :$ *Enter your password*

```console
sudo chown pinkypink:pinkypink youown
```

| **40** :$

```console
ls -l
```

*Note a new owner of "`youown`" is pinkypink*

| **41** :$

```console
chown pinkypurple:pinkypurple youown
```

*Note the error message because `chown` requires `sudo`, that's what happens if you don't use `sudo`*

| **42** :$

```console
sudo chown pinkypurple:pinkypurple youown
```

| **43** :$

```console
ls -l
```

*Note "`youown`" now belongs to `pinkypurple`*

| **44** :$

```console
sudo chown pinkypurple:pinkypink theyown
```

| **45** :$

```console
ls -l
```

*Note a new owner of "`theyown`", the user and group are different*

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

| **46** :$

```console
mkdir ownrship
```

| **47** :$

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

| **48** :$

```console
ls -l
```

| **49** :$

```console
sudo chown pinkypink:pinkypink ownrship
```

| **50** :$

```console
ls -l
```

*Note a new owner of "`ownrship`"*

| **51** :$

```console
ls -l ownrship/
```

*Note you own the directory "`ownrship`", but not the file inside*

*Use `-R` for directories (must be CAPITAL with `chown`!)*

| **52** :$

```console
sudo chown -R pinkypink:pinkypink ownrship
```

| **53** :$

```console
ls -l ownrship/
```

*Now you own "`ownrship`" and the file inside*

*Remove it...*

| **54** :$ *"y" for Yes, might not work; "n" for No is better for this lesson*

```console
rm youown
```

*Note the error message because you don't own it anymore! Use `sudo`*

| **55** :$

```console
sudo rm youown
```

| **56** :$

```console
ls -l
```

*Note `sudo` allows you to delete files and directories you don't own*

*`sudo` acts as "root", meaning files created with `sudo` are owned by `root`*

*Create a file owned by `root`*

| **57** :$

```console
sudo touch iamroot
```

| **58** :$

```console
ls -l
```

*Note `root` owns "`iamroot`"*

| **59** :$ *"y" for Yes, might not work; "n" for No is better for this lesson*

```console
rm iamroot
```

*Note only `root` can delete the file "`iamroot`"*

| **60** :$

```console
sudo rm iamroot
```

*Let's cleanup these files you don't own so they don't cause problems later ...*

| **61** :$

```console
sudo rm theyown
```

| **62** :$

```console
sudo rm -r ownrship
```

| **63** :$

```console
ls -l
```

*...also use `sudo` to delete the puppet users we created for this lesson...*

| **A64** :$ (Arch/Manjaro)

```console
sudo userdel pinkypink
sudo groupdel pinkypink
```

*Note the message about the "`pinkypink`" group being empty, that's because `deluser` also deleted the group*

| **C64** :$ (RedHat/CentOS)

```console
sudo userdel pinkypink
```

*Note no messages, all is handled*

| **U64** :$ (Ubuntu)

```console
sudo deluser pinkypink
```

*`userdel` does not delete the group*


| **A65** :$ (Arch/Manjaro)

```console
sudo userdel pinkypurple
```

| **C65** :$ (RedHat/CentOS)

```console
sudo userdel pinkypurple
```

| **U65** :$ (Ubuntu)

```console
sudo deluser pinkypurple
```

*The users still have `/home` directories*

| **66** :$

```console
ls -l /home
```

*Note the users' old home directories are still there, but owned by some number!*

*...remove them both*

| **67** :$

```console
sudo rm -r /home/pinkypink /home/ppurple
```

| **68** :$

```console
ls /home
```

*"Own" everything in your home directory, just to make sure all is well (always a good idea)*

| **69** :$

```console
sudo chown -R YOURUSERNAME:YOURUSERNAME /home/YOURUSERNAME
```

### IV. Sudoers

*This is the file with settings for "sudoers" (users that can use `sudo`)*

| **70** :$

```console
cat /etc/sudoers
```

*Note the error, viewing the "sudoers" file requires `sudo` permissions*

| **71** :$

```console
sudo cat /etc/sudoers
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
