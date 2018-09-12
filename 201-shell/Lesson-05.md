# Shell 201
## Lesson 5: adduser, deluser, chown

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`

#### [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)

___

*Prepare our "permissions" directory and enter it in one command*

`mkdir permissions && cd permissions`

*WARNING: If you already have a user "pinkypink" and/or "pinkypurple", then you are very interesting and should there substitute those names for users not on your system.*

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
> 
> `su USERNAME`
>
___

### I. `adduser`

*Look at the* `/home` *directory to see the users on the machine*

`ls /home`

`sudo adduser pinkypink` *When prompted, Enter any simple password; press* `Enter` *for remaining questions.*

*Look at* `/home` *again to see* `pinkypink` *has been added*

`ls /home`

`ls /home/pinkypink`

*Look again with "All" files, including anything hidden*

`ls /home/pinkypink -a`

*Login as pinkypink in the GUI...*

*..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*

`ls /home/pinkypink -a`

*Note the user directories & settings were created at the first GUI login*

*Login via the terminal*

`su pinkypink`

`ls`

`ls -a`

`exit`

### II. `useradd`

`sudo useradd pinkypurple`

*No questions this time!*

*Look at* `/home` *again,* `pinkypurple` *doesn't exist!*

`ls /home`

*Note* `useradd` *is simple and doesn't even create a password*

*Note* `adduser` *makes use of* `useradd` *and does other tasks, like setting the password*

*Try to login as pinkypurple in the terminal*

`su pinkypurple`

*You can't login because pinkypurple doesn't have a password!*

*Set a password for pinkypurple*

`sudo passwd pinkypurple` *Enter a simple password*

*Login as pinkypurple in the terminal*

`su pinkypurple`

*Note the message: pinkypurple doesn't even have a home*

`exit`

*Now assign a "directory" to home (*`-d`*) and "move" any existing contents to that directory (*`-m`*)*

`sudo usermod -d /home/ppurple -m pinkypurple`

*Login as pinkypurple in the terminal*

`su pinkypurple`

*The directory still doesn't exist!*

`exit`

*Create the home directory for pinkypurple*

`sudo mkdir /home/ppurple`

*Login as pinkypurple in the terminal*

`su pinkypurple`

*Try to create a file*

`touch newfile`

*The home directory exists, it was assigned as the home, but pinkypurple doesn't even own its own home!*

`exit`

*Let pinkypurple own its own home (this will be explained in the next section of this lesson)*

`sudo chown -R pinkypurple:pinkypurple /home/ppurple`

*Login as pinkypurple in the terminal*

`su pinkypurple`

*Create a file*

`touch newfile`

`ls`

*Everything works, but the command prompt is unstyled because creating a user requires many steps*

*Note* `adduser` *creates many user settings in creating a user, but* `useradd` *only does the simple minimum*

*This difference is the same with:*
- `SETTINGS` vs `SIMPLE`
- `adduser` vs `useradd`
- `deluser` vs `userdel`
- `addgroup` vs `groupadd`
- `delgroup` vs `groupdel`

*Now exit as pinkypurple*

`exit`

### III. Permissions

`ls -l`

*Note the owner of "youown"*

`sudo chown pinkypink:pinkypink youown`

`ls -l`

*Note a new owner of "youown"*

`sudo chown pinkypurple:pinkypink theyown`

`ls -l`

*Note a new owner of "theyown", the user and group are different*

`chown pinkypurple:pinkypurple youown`

*Note the error message because* `chown` *requires* `sudo`

`sudo chown pinkypurple:pinkypurple youown` *Enter your password*

`ls -l`

*"youown" now belongs to pinkypurple*

`mkdir ownrship`

`ls -l`

`sudo chown pinkypink:pinkypink ownrship`

*Note the error message*

*Use* `-R` *for directories (must be CAPITAL with* `chown`*!)*

`sudo chown -R pinkypink:pinkypink ownrship`

`ls -l`

*Note a new owner of "ownrship"*

`rm youown`

*Note the error message because you don't own it anymore! Use* `sudo`

`sudo rm youown`

`ls -l`

*Note* `sudo` *allows you to delete files and directories you don't own*

*Create a file owned by root*

`sudo touch iamroot`

`ls -l`

*Note root owns "iamroot"*

`rm iamroot`

*Note only root can delete the file "iamroot"*

`sudo rm iamroot`

*Let's cleanup with* `sudo` *...*

`sudo rm theyown`

`sudo rm -r ownrship`

`ls -l`

*...also use* `sudo` *to delete the puppet users we created for this lesson...*

`sudo deluser pinkypink`

*Note the message about the "pinkypink" group being empty, delete that group also*

`sudo delgroup pinkypink`

*We don't want to use* `userdel` *because it is too minimum*

`sudo deluser pinkypurple`

`sudo delgroup pinkypurple`

*The users still have* `/home` *directories*

`ls /home`

*...remove them*

`sudo rm -r /home/pinkypink /home/pinkypurple`

`ls /home`

`cd ..`

### IV. sudoers

*This is the list of users that can use* `sudo`

`sudo cat /etc/sudoers`

*Viewing the "sudoers" file requires* `sudo` *permissions*

`cat /etc/sudoers`

*You may not see yourself, this handy little* `grep` *code shows all sudoers*

`grep -Po '^sudo.+:\K.*$' /etc/group`

### For an administrator to use `su`
> 
___
> 
> If running as `su` after runing via `sudo`, input this as your normal user to set everything aright:
> 
> `touch whoown iown theyown youown`
> 
___
> 
> *Try this commands without* `su` *and note the error messages because it requires* `su`:
> 
> `adduser pinkypink`
> 
> `su` *input the password*
> 
> ### I. `adduser`
>
> *Look at the* `/home` *directory to see the users on the machine*
> 
> `ls /home`
> 
> `adduser pinkypink` *When prompted, Enter any simple password; press* `Enter` *for remaining questions.*
> 
> *Look at* `/home` *again to see* `pinkypink` *has been added*
> 
> `ls /home`
>
> `ls /home/pinkypink`
> 
> *Look again with "All" files, including anything hidden*
> 
> `ls /home/pinkypink -a`
> 
> *Login as pinkypink in the GUI...*
> 
> *..."Switch User", login as pinkypink, "Log Out", then return to this GUI session*
> 
> `ls /home/pinkypink -a` 
>
> *Note the user directories & settings were created at the first GUI login*
> 
> *Login via the terminal*
> 
> `su pinkypink`
> 
> `ls`
> 
> `ls -a`
> 
> `exit`
> 
> ### II. `useradd`
> 
> `useradd pinkypurple`
> 
> *No questions this time! Remember, pinkypurple doesn't have a password and thus can't login*
> 
> *Look at* `/home` *again,* `pinkypurple` *doesn't exist!*
> 
> `ls /home`
> 
> *Note* `useradd` *is simple and doesn't even create a password*
> 
> *Note* `adduser` *makes use of* `useradd` *and does other tasks, like setting the password*
> 
> *Login as pinkypurple in the terminal*
> 
> `su pinkypurple` *No password needed because you are root*
> 
> *Note the message: pinkypurple doesn't even have a home*
> 
> `exit`
> 
> *Now assign a "directory" to home (*`-d`*) and "move" any existing contents to that directory (*`-m`*)*
> 
> `usermod -d /home/ppurple -m pinkypurple`
> 
> *Login as pinkypurple in the terminal*
> 
> `su pinkypurple`
> 
> *The directory still doesn't exist!*
> 
> `exit`
> 
> *Create the home directory for pinkypurple*
> 
> `mkdir /home/ppurple`
> 
> *Login as pinkypurple in the terminal*
> 
> `su pinkypurple`
> 
> *Try to create a file*
> 
> `touch newfile`
> 
> *The home directory exists, it was assigned as the home, but pinkypurple doesn't even own its own home!*
> 
> `exit`
> 
> *Let pinkypurple own its own home (this will be explained in the next section of this lesson)*
> 
> `chown -R pinkypurple:pinkypurple /home/ppurple`
> 
> *Login as pinkypurple in the terminal*
> 
> `su pinkypurple`
> 
> *Create a file*
> 
> `touch newfile`
> 
> `ls`
> 
> *Everything works, but the command prompt is unstyled because creating a user requires many steps*
> 
> *Note* `adduser` *creates many user settings in creating a user, but* `useradd` *only does the simple minimum*
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
> `exit`
> 
> ### III. Permissions
> 
> `ls -l`
> 
> *Note the owners of "youown" and "theyown"*
> 
> `chown pinkypink:pinkypink youown`
> 
> `ls -l`
> 
> *Note a new owner of "youown"*
> 
> `chown pinkypurple:pinkypink theyown`
> 
> `ls -l`
> 
> *Note a new owner of "theyown", the user and group are different*
> 
> *Exit from the "root" user*
> 
> `exit`
> 
> *Try to change ownership of a file you don't own*
> 
> `chown pinkypurple:pinkypurple youown`
> 
> *Note the error message because `chown` *requires "root" AKA* `sudo` *or* `su`
> 
> `su` *input the password*
> 
> `chown pinkypurple:pinkypurple youown`
> 
> `ls -l`
> 
> *"youown" now belongs to pinkypurple*
> 
> `mkdir ownrship`
> 
> `ls -l`
> 
> `chown pinkypink:pinkypink ownrship`
> 
> *Note the error message*
> 
> *Use* `-R` *for directories (must be CAPITAL with* `chown`*!)*
> 
> `chown -R pinkypink:pinkypink ownrship`
> 
> `ls -l`
> 
> *Note a new owner of "ownrship"*
> 
> *Exit* `su` *status to see what happened*
> 
> `exit`
> 
> `rm youown`
> 
> *Note the error message because you don't own it!*
> 
> `rm -r ownrship`
> 
> *Note the error message because you created "ownrship" as "root", so "roo" owns it!*
> 
> `ls -l`
> 
> `su` *input the password*
> 
> `rm youown`
> 
> `ls -l`
> 
> *Note* `su` *permissions allow you to delete any files and directories you don't own*
> 
> *Create a file owned by root*
> 
> `sudo touch iamroot`
> 
> `ls -l`
> 
> *Note root owns "iamroot"*
> 
> *Exit* `su` *status to see what happened*
> 
> `exit`
> 
> `rm iamroot`
> 
> *Note only root can delete the file "iamroot"*
> 
> `su` *input the password*
> 
> `rm iamroot`
> 
> *Let's cleanup*
> 
> `rm theyown`
> 
> `rm -r ownrship`
> 
> `ls -l`
> 
> *...also use your* `su` *permissions to delete the puppet users we created for this lesson...*
> 
> `deluser pinkypink`
> 
> *Note the message about the "pinkypink" group being empty, delete that group also*
> 
> `delgroup pinkypink`
> 
> *We don't want to use* `userdel` *because it is too minimum*
> 
> `deluser pinkypurple`
> 
> `delgroup pinkypurple`
> 
> *The users still have* `/home` *directories*
> 
> `ls /home`
> 
> *...remove them*
> 
> `rm -r /home/pinkypink /home/pinkypurple`
> 
> `ls /home`
> 
> `cd ..`
> 
> ### IV. sudoers
> 
> *This is the list of users that can use* `sudo`
> 
> `cat /etc/sudoers`
___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> `exit`
> 
___

*Viewing the "sudoers" file requires* `sudo` *permissions*

`cat /etc/sudoers`

*You may not see yourself, this handy little* `grep` *code shows all sudoers*

`grep -Po '^sudo.+:\K.*$' /etc/group`

#### [Lesson 6: wget, curl, git clone](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-06.md)
