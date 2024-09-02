# Linux 601
## Lesson 3: Users & Groups

# The Chalk
## Users
- Every user has:
  - Username
  - Password
  - UID (user ID number)
  - GID (primary group ID number)
  - Comment / [GECOS](https://en.wikipedia.org/wiki/Gecos_field) (full name, email, office, phone number)
  - Home directory (mostly in `/home/`)
  - Login shell (usually `/bin/bash` or `/bin/zsh`, defined in `/etc/passwd`)
- Commands
  - `whoami` - show username
  - `who` - list users who are logged on
    - `who -b` - boot time
  - `id` - show user's UID, GID, groups
  - `last` - show a history of user logins
- Every command must be executed by a *user*, even if the user is `root`
  - This is why every user must *log in*, even if the user is `root`
  - The only exception is `init`, which is run by the kernel at boot time

### Terminal - Global Settings
- Terminal behavior is set by `bashrc` startup files
  - Prompt
  - Aliases
  - Default text editor
  - Terminal Shell interpreter (usually `/bin/bash` or `/bin/zsh`)
  - `$PATH` statement and other environment variables
  - Even functions that can be called from the command line
- Shell
  - `echo $SHELL` your shell
  - `ps -p $$` ps information on your shell (`$$` is the terminal's PID)
  - `cat /etc/shells` available shells
  - `chsh -s /bin/zsh` changes your shell to `zsh`
    - Recoeded in `/etc/passwd`
  - `sudo chsh -s /bin/bash someuser` changes shell of `someuser` to `bash`
- Settings are the same, but some address login, others only address terminal sessions
  - `/etc/profile` (global login startup)
  - `/etc/bash.bashrc` (global terminal settings)
  - Possibly additional or similarly named files, depending on distro
- Do **not** change the global startup files in `/etc/` without good reason

### Terminal - Per-User Settings
- Change and customize settings per user with hidden files, even in `/root/.bash_rc`
- Any of these address login:
  - `~/.bash_profile`
  - `~/.bash_login`
  - `~/.profile` (will override `/etc/profile`)
- These only address terminal sessions, not the entire user login (and will override `/etc/bash.bashrc`)
  - `~/.bash_rc` or `~/.bashrc`, dependinf on distro; both should work
  - Any terminal customization is best to go here because these files are read in most any scenario and will override all others
- Common settings we can put in any `.bash_*` settings file ( or `~/.profile`)
  - `alias rm='rm -i'`
  - `alias l='ls -laF'`
  - `unalias rm`
  - `alias` all current aliases
- `~/.bash_history`
  - `history`
  - `history | head`
  - `history | tail`
- Check `bash` history
  - `!50` (no `50` in bash history)
  - `!echo` (most recent `echo` command)

### User Defaults
- `useradd` :#
  - initiates many user settings
  - `/etc/skel/` is copied as the new home folder (Arch requires the `-k /etc/skel` flag and argument)
    - This contains custom startup files, including those like `~/.bashrc` or `~/.bash_profile`
  - UID is incremented from `UID_MIN` defined in `/etc/login.defs`
    - `100`-`UID_MIN` are "special" (`UID_MIN`, usually `1000` is set in `/etc/login.defs`)
    - Over `UID_MIN` are for normal users, AKA User Prive Groups (UPG)
  - A group with the same name as the username is added where GID=UID
  - A user setting entry is added to `/etc/passwd`
  - A user password entry is added to `/etc/shadow`
  - Group-related information is added to `/etc/group`
  - Simple usage: `sudo useradd johndoe`
  - Expanded usage: `sudo useradd johndoe -s /bin/zsh -U -m -k /etc/skel -c "John Doe"`
    - `-s /bin/zsh` shell: `zsh`
    - `-U` create and add to group of same name
    - `-m` make user's default directory
    - `-k /etc/skel` default directory and settings
    - `-c` comment (display name)
- `userdel` :#
  - Removes entries made in
    - `/etc/passwd` (user info)
    - `/etc/shadow` (user's hadhed password)
    - `/etc/group` (group settings & users)
  - Home directory is not deleted unless using `userdel -r`
- `usermod` :#
  - `usermod -L someuser` will lock the account for `someuser`
    - This means the user can't login, but still...
      - Any user can be made to execute a command using `su someuser -c "some command"` (more later)
    - The "no password" setting usually prefixes `!!` or `!` to the user's pasword string in `/etc/shadow`
    - This is how many auto users work on Linux, such as `mail`, `www`, `httpd`, `nginx`, etc
      - :$ `grep 'nologin' /etc/passwd` shows the list on your machine
    - This is done with a `nologin` shell entry for the user in `/etc/passwd`
      - :# `chsh -s /usr/sbin/nologin someuser` changes the shell for `someuser` to `/usr/sbin/nologin`
        - This will also prevent the user from running scripts with `sudo su someuser -c ...` because that also needs a shell to execute the command
      - A custom `nologin` message can be defined in `/etc/nologin.txt`, overridden by `/etc/nologin` for non-`root` users; it might not always display
  - `usermod -U` will unlock a user's account
    - Similarly, set a user to expire with :#
      - :# `chage -E 1970-01-01 johndoe` (any date in the past will lock the user account)
    - User password lock info is stored in one line at the end of `/etc/shadow`
      - change the last three `:` colons to `:::` to easily unlock an account locked wich `chage`
- User-related files have important permissions
  - `/etc/passwd` (`644`)
  - `/etc/group` (`644`)
  - `/etc/shadow` (`600`)
- `/etc/passwd`
  - Username
  - Password (usually `x` with the password hashed in `/etc/shadow`)
  - UID
  - GID
  - Comment / GECOS
  - Home directory
  - Login shell
- `/etc/shadow` format
  - Username
  - Password
    - Hashed: `$6$`|`$y$`, then 8-digit salt, then password hashed with `sha512`
    - `!` = login blocked
    - `!!`|`*`|`!*` = password never set, login blocked
    - empty (`USER::...`) no password required; <kbd>Enter</kbd> itself will login
  - Last change
  - Minimum days before password can change
  - Maximum days after password must change
  - Warning days before password expires
  - Grace days after expired password  before account is disabled
  - Expiration date
  - Reserved field
  - Note that all dates are in the *epoch* time, that is seconds from January 1, 1970
- Changing a password
  - :$ `passwd` changes current user's password (does not `root` or `sudo`)
  - :# `passwd someuser` changes the password for `someuser`

### Security & `sudo`
- `sudo` configs are in
  - `/etc/sudoers`
  - `/etc/sudoers.d`
    - "`@includedir /etc/sudoers.d`" must be added to `/etc/sudoers`
- Many users are made sudoers by being in the `sudo` group in `/etc/group`
  - `/etc/sudoers` needs `%sudo   ALL=(ALL:ALL) ALL` uncommented
- Add individual users with this line in any of the `/etc/sudoers` or `/etc/sudoers.d/` files
  - `someuser ALL=(ALL:ALL) ALL` (same line as `root ALL=(ALL:ALL) ALL`)
- Only edit `/etc/sudoers` with `visudo` :$ `sudo visudo`
  - This adds security to prevent attacks
### Substitute User (`su`)
- `su someuser` will login as `someuser`
- `su someuser -c ...` will run a command as a sub shell for `someuser`
  - Syntax: `su someuser -c "some command"`
  - This will run `some command` with the permissions of `someuser`

### Local GUI Login
- On boot to a GUI, a list of users appears
- Each of these has a file named by the user in `/var/lib/AccountsService/users/`
  - Users appear having `SystemAccount=false` in their file appear on the GUI login list
- To prevent a user from being on this list, such as `root`, add a line with `SystemAccount=true` to the user's file there
  - eg user `root`: `echo 'SystemAccount=true' >> /var/lib/AccountsService/users/root`
  - eg user `pinky`: `echo 'SystemAccount=true' >> /var/lib/AccountsService/users/pinky`
  - Make sure you don't have duplicate entries: `cat /var/lib/AccountsService/users/pinky`

### Remote Graphical Login (VNC)
- This requires the `tigervnc` package
- Start by running the `vncserver`
- These lessons don't cover this in depth

## Groups
- Recorded in `/etc/group`
  - One group per line
    - `group:password:GID:johndoe,user2,uzrthree,bill`
- Groups can have passwords if the system has `/etc/gshadow`
- GID:
  - `0`-`99` reserved for system groups
  - `100`-`GID_MIN` are "special" (`GID_MIN`, usually `1000` is set in `/etc/login.defs`)
  - Over `GID_MIN` are for normal users, AKA User Prive Groups (UPG)
- A user's primary group is listed in `/etc/passwd`
  - That primary group is also listed in `/etc/group`, but the user doesn't need to be listed here
- `groups` command
  - `groups` list current user's groups
  - `groups someuser` list argued user's groups
  - `id -Gn user1 user2 user3` list many users' groups
  - `id user1 user2 user3` also gives UID and GID

### Group Management
- `groupadd`
  - `groupadd -g 1005 somegroup`
  - `-r` make system group (use `/etc/login.defs` `SYS_GID_MIN`-`SYS_GID_MAX` instead of `GID_MIN`-`GID_MAX`)
- `groupmod`
  - `groupmod -g 1005 somegroup`
  - `-g` new GID
  - `-p` new password
- `groupdel`
  - `groupdel somegroup`
- `usermod`
  - `-G` declare new list of all groups, removing all other groups
  - `-a` adds new groups in addition to existing groups
  - `-g` GID of new primary group
  - eg :# `usermod someuser -aG alsogroup`
- Get a GID from the line in `/etc/group`
  - `getent group somegroup`
    - `somegroup:x:1001:` (`1001` is the GID)

### Ownership
- `chown user somefile`
- `chgrp group somefile`
- `chown user:group somefile`
- `chown -R user:group somedir`

### Permissions
- [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)
- `uuu`-`ggg`-`ooo` (User - Group - Other)
- `rwx`-`rwx`-`rwx` (Read Write eXecute)
  - Represented by `0`-`7`
  - Simple algorithm:
    - + 1 = eXecute
    - + 2 = Write
    - + 4 = Read
- `chmod 755 somefile`
  - `chmod ug+x,o-x somefile`
  - `chmod ugo=r,ug=w somefile`

### Default Permissions via `umask`
- Defines permissions for new files
  - This is a subtraction (`umask 0022` subtracts from `0666` to set new file default permissions)
  - With a mask of `0022` a new file's default will be `0644`
- Then denied by `umask` value
  - `umask` shows the mask
  - `umask -S` shows defauls in letters
  - `umask` is normally set to `0002` or `0022`
  - Change with one argument
    - `umask 0022`
    - `umask u=rw,g=r,o=r`
- Results of defaults with `umask 0022`:
  - `0666` - `0022` = `0644` (file default)
  - `0777` - `0022` = `0755` (directory default)

## Filesystem Access Control Lists (ACL)
- If specific per user or group, the list of **permissions** is called an [Access Control List](https://en.wikipedia.org/wiki/Access-control_list) (ACL)
- This sets different file permissions per user and group
- This is part of the Linux kernel
- This needs the `-acl` option when mounting
- ACLs are especially relevant on:
  - Some filesystem types (`ext4`, `btrfs`, etc)
  - Linux Security Modules, like SELinux, etc

#### ACL Tools: `getfacl` & `setfacl`
- `getfacl somefile` get the ACL permissions for `somefile`
- `setfacl -m u:someuer:rwx somefile` (Modify User `someuser` to have `rwx` permissions on `somefile`)
  - `-m` Modify
  - `u:` User permissions being set
  - `someuser:` the user
  - `rwx` any of `r`. `w`, or `x` for the permissions
  - `setfacl -m d:u:someuer:rwx somedir` for a Directory (`d:`)
- `setfacl -x u:someuser somefile` (remove ACL permissions for `someuser` on `somefile`)

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

- *Broken into sections because some are prerequesite*

| **user & shell settings** :$

```console
whoami
who
id

ls ~/.bash*
cat ~/.bashrc
echo $PATH
echo $SHELL
ps -p $$
cat /etc/shells

cat /etc/profile
less /etc/profile
cat /etc/bash.bashrc
less /etc/bash.bashrc

grep alias ~/.bashrc
cat ~/.profile
grep alias ~/.profile

alias voovoo="echo hello"
voovoo
unalias voovoo
voovoo
echo 'alias voovoo="echo hello"' >> ~/.profile
vim ~/.profile
sed -i '/alias voovoo=/d' ~/.profile

history
cat ~/.bash_history
cat ~/.zsh_history
history | head
history | tail

echo $SHELL
ps -p $$
cat /etc/shells

cd /etc/skel
ls -a
```

| **add/remove users & shells** :$

```console
cd /home
ls
sudo useradd pinky
ls
grep pinky /etc/passwd
grep $USER /etc/passwd
sudo grep pinky /etc/shadow
sudo passwd pinky
# 123456 x2
sudo grep pinky /etc/shadow
echo $SHELL
su pinky
# 123456
whoami
who
echo $SHELL
exit
ls
sudo userdel pinky
grep pinky /etc/passwd

sudo useradd pinky -d /home/pinky
ls
grep pinky /etc/passwd
sudo passwd pinky
# 123456 x2
su pinky
# 123456
whoami
echo $SHELL
exit
sudo userdel pinky
grep pinky /etc/passwd
ls
sudo rm -r /home/pinky
ls
```

| **create test users & settings** :$

```console
cd /home

sudo useradd pinky -m -k /etc/skel
ls
grep pinky /etc/passwd
sudo grep pinky /etc/shadow
sudo passwd pinky
# 123456 x2
sudo grep pinky /etc/shadow
su pinky
# 123456
echo $SHELL
chsh -s /bin/bash
exit
su pinky
# 123456
echo $SHELL
exit
sudo chsh -s /bin/sh pinky
su pinky
# 123456
echo $SHELL
exit

sudo useradd binky -s /bin/bash -m -k /etc/skel
grep binky /etc/passwd
sudo grep binky /etc/shadow
sudo passwd binky
# 123456 x2
sudo grep binky /etc/shadow

sudo useradd zinky -s /bin/zsh -m -k /etc/skel
grep zinky /etc/passwd
sudo grep zinky /etc/shadow
sudo passwd zinky
# 123456 x2
sudo grep zinky /etc/shadow

su binky
# 123456
whoami
echo $SHELL
exit

su zinky
# 123456
whoami
echo $SHELL
exit
```

| **user login** :$

```console
sudo cat /etc/shadow
sudo grep pinky /etc/shadow
sudo usermod -L pinky
sudo grep pinky /etc/shadow
su pinky
#123456
grep pinky /etc/passwd
sudo chsh -s /usr/sbin/nologin pinky
grep pinky /etc/passwd
su pinky
#123456
sudo grep pinky /etc/shadow
sudo usermod -U pinky
sudo grep pinky /etc/shadow
su pinky
#123456
grep pinky /etc/passwd
sudo chsh -s /bin/sh pinky
grep pinky /etc/passwd
su pinky
#123456
exit

sudo grep pinky /etc/shadow
sudo chage -l pinky 
sudo chage -E 1970-01-01 pinky
sudo grep pinky /etc/shadow
sudo chage -l pinky
su pinky
#123456
sudo chage -I -1 -m 0 -M 99999 -E -1 pinky
sudo chage -l pinky
su pinky
sudo passwd pinky
# 123456 x2
su pinky
#123456
exit

sudo visudo
sudo vim /etc/sudoers
su
cd /etc/sudoers.d
ls
exit

su pinky
#123456
sudo touch here
exit
sudo usermod pinky -aG sudo
su pinky
sudo touch here
exit

su pinky -c ls ~/
su pinky -c 'ls -la ~/'

su
cd /var/lib/AccountsService/users/
ls
grep SystemAccount *
exit
cd /home
```

| **groups** :$

```console
sudo less /etc/group
sudo less /etc/gshadow
less /etc/login.defs
vim /etc/login.defs # Search for GID_MIN
groups pinky
groups binky
groups zinky
groups root
groups $(whoami)
id pinky binky zinky
id -Gn pinky binky zinky
id $(whoami)
id -Gn $(whoami)
groups $(whoami)
sudo groupadd inky
sudo usermod pinky -aG inky
groups pinky
sudo usermod binky -aG inky
sudo usermod zinky -aG inky
groups binky
groups zinky
sudo usermod pinky -aG binky
sudo usermod pinky -aG zinky
id pinky
id -Gn pinky
groups pinky

getent group inky
getent group pinky
getent group binky
getent group zinky
getent group inky
sudo groupmod -g 1155 inky
id pinky
getent group inky
```

| **create test files** :$

```console
su pinky
# 123456
cd
pwd
mkdir touchy
cd touchy
touch one two three
ls -l
exit
```

| **ownership** :$

```console
su
cd /home/pinky/touchy
ls -l
chown pinky:inky one
chown binky:inky two
chown zinky:zinky three
ls -l
chgrp inky three
ls -l
chown zinky one
ls -l
chgrp zinky one
ls -l
chown zinky two
ls -l
cd /home/pinky
chown binky:binky /home/pinky/touchy
ls -l
cd touchy
ls -l
chown -R binky:binky /home/pinky/touchy
ls -l
exit

su binky
# 123456
cd /home/zinky
touch canttouchthis
exit
su pinky
# 123456
cd ~/touchy
pwd
ls
mv one four
ls -l
mv four one
ls -l
cd
ls -l
mv touchy wuchy
ls -l
mv wuchy touchy
ls -l
exit

su pinky
# 123456
cd ~/touchy
ls -l
chown pinky:pinky one
chown -R pinky:pinky /home/pinky/touchy
exit
cd /home/pinky
ls -l
ls -l /home/pinky/touchy
sudo chown -R pinky:pinky /home/pinky/touchy
ls -l
ls -l /home/pinky/touchy
```

| **permissions** :$

```console
su pinky
# 123456
cd ~/touchy
ls -l
chmod ug+x one two
ls -l
chmod o-r three
ls -l
chmod 775 one
ls -l
chmod 755 two
ls -l
chmod 644 three
ls -l
exit

su pinky
# 123456
cd ~/touchy
umask
umask 0002
umask
touch four
ls -l
umask 0022
touch five
ls -l
rm four five
exit
```

| **ACL management** :$

```console
su pinky
# 123456
cd ~/touchy
getfacl *
getfacl one
exit

cd /home/pinky/touchy
getfacl one
ls -l one
sudo setfacl -m u:binky:rwx one
ls -l one
getfacl one

ls -l two
getfacl two
sudo setfacl -m u:zinky:w two
ls -l two
getfacl two
sudo setfacl -m u:binky:rw two
ls -l two
getfacl two

ls -l three
getfacl three
sudo setfacl -m u:zinky:r three
ls -l three
getfacl three
sudo setfacl -m u:binky:rwx three
ls -l three
getfacl three

getfacl *
ls -l
sudo setfacl -x u:binky one two three
getfacl *
ls -l
sudo setfacl -x u:zinky one two three
getfacl *
ls -l
```

| **remove test users & settings** :$

```console
grep pinky /etc/passwd
grep binky /etc/passwd
grep zinky /etc/passwd
sudo grep pinky /etc/shadow
sudo grep binky /etc/shadow
sudo grep zinky /etc/shadow
sudo userdel pinky
sudo userdel binky
sudo userdel zinky
grep pinky /etc/passwd
grep binky /etc/passwd
grep zinky /etc/passwd
sudo grep pinky /etc/shadow
sudo grep binky /etc/shadow
sudo grep zinky /etc/shadow
cd /home
ls
sudo rm -r /home/pinky /home/binky /home/zinky
ls
```

___

#### [Lesson 4: Git](https://github.com/inkVerb/vip/blob/master/601/Lesson-04.md)