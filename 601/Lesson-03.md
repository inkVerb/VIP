# Linux 601
## Lesson 3: Users & Groups

# The Chalk
## Users
- Every user has:
  - Username
  - Password
  - UID (user ID number)
  - GID (primary group ID number)
  - Comment / GECOS (full name, email, office, phone number)
  - Home directory (mostly in `/home/`)
  - Login shell (usually `/bin/bash` or `/bin/zsh`, defined in `~/.bashrc`)
- Commands
  - `whoami` (show username)
  - `who` (list users who are logged on)
  - `id` (show user's UID, GID, groups)

### Global Terminal
- Terminal behavior is set by `bashrc` startup files
  - Prompt
  - Aliases
  - Default text editor
  - Terminal interpreter (usually `/bin/bash` or `/bin/zsh`)
  - `$PATH` statement and other environment variables
  - Even functions that can be called from the command line
- Settings are the same, but some address login, others only address terminal sessions
  - `/etc/profile` (global login startup)
  - `/etc/bash.bashrc` (global terminal settings)
  - Possibly additional or similarly named files, depending on distro
- Do **not** change the global startup files in `/etc/` without good reason

### Per-User Terminal
- Change and customize settings per user with hidden files, even in `/root/.bash_rc`
- Any of these address login:
  - `~/.bash_profile`
  - `~/.bash_login`
  - `~/.profile` (will override `/etc/profile`)
- These only address terminal sessions, not the entire user login (and will override `/etc/bash.bashrc`)
  - `~/.bash_rc` or `~/.bashrc`, dependinf on distro; both should work
  - Any terminal customization is best to go here because these files are read in most any scenario and will override all others
- Common settings we can put anywhere
  - `alias rm='rm -i'`
  - `alias l='ls -laF'`
  - `unalias rm`
- `~/.bash_history`
  - `history`
  - `history | head`
  - `history | tail`
  - `!50` (no `50` in bash history)
  - `!echo` (most recent `echo` command)

### User Defaults
- `useradd` initiates many user settings
  - `/etc/skel/` is copied as the new home folder
    - This contains custom startup files, including those like `~/.bashrc` or `~/.bash_profile`
  - UID is incremented from `$UID_MIN` defined in `/etc/login.defs`
  - A group with the same name as the username is added where GID=UID
  - A user setting entry is added to `/etc/passwd`
  - A user password entry is added to `/etc/shadow`
  - Group-related information is added to `/etc/group`
  - Simple usage: `sudo useradd johndoe`
  - Expanded usage: `sudo useradd johndoe -s /bin/zsh -m -k /etc/skel -c "John Doe" johndoe`
- `userdel`
  - Removes entries made in
    - `/etc/passwd`
    - `/etc/shadow`
    - `/etc/group`
  - Home directory is not deleted unless using `userdel -r`
- `usermod -L` will lock a user's account
  - This means the user can't login, but could still be made to execute a command using `su lockeduser -c "some command"` (more later)
  - This is how many auto users work on Linux, such as `mail`, `www`, `httpd`, `nginx`, etc
  - This is done with a `nologin` entry for the user in `/etc/passwd`
  - The no login message is defined in `/etc/nologin.txt`
  - The "no password" setting is usually indicated by `!!` or `!` in `/etc/shadow`
  - Similarly, set a user to expire with:
    - `chage -E 1970-01-01 johndoe` (any date in the past will lock the user account)
- User-related files have important permissions
  - `/etc/passwd` (`644`)
  - `/etc/shadow` (`600`)
  - `/etc/group` (`644`)
- `/etc/shadow` format
  - Username
  - Password (`$6$`, then 8-digit salt, then password hashed with `sha512`)
  - Last change
  - Minimum days before password can change
  - Maximum days after password must change
  - Warning days before password expires
  - Grace days after expired password  before account is disabled
  - Expiration date
  - Reserved field
  - Note that all dates are in the *epoch* time, that is seconds from January 1, 1970
- Changing a password
  - `passwd` changes current user's password (does not `root` or `sudo`)
  - `passwd johndoe` changes another user's password

### Security & `sudo`
- `sudo` configs are in
  - `/etc/sudoers`
  - `/etc/sudoers.d`

### Substitute User (`su`)
- `su` will run a command as a sub shell for another user
  - Syntax: `su someuser -c "some command"`
  - This will run with with that `someuser` user's permissions

### Remote Graphical Login (VNC)
- This requires the `tigervnc` package
- Start by running the `vncserver`

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
  - `-G` lists all groups, removing all others
  - `-a` adds new groups in addition to existing groups
  - `-g` GID of new primary group
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
  - This is a subtraction (`umask 0022` subtracts )
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

### Filesystem Access Control Lists (ACL)
- If specific per user or group, the list of **permissions** is called an [Access Control List](https://en.wikipedia.org/wiki/Access-control_list) (ACL)
- This sets different file permissions per user and group
- This is part of the Linux kernel
- This needs the `-acl` option when mounting
- ACLs are especially relevant on:
  - Some filesystem types (`ext4`, `btrfs`, etc)
  - Linux Security Modules, like SELinux, etc

### ACL Tools: `getfacl` & `setfacl`
- `getfacl somefile` get the ACL permissions for `somefile`
- `setfacl -m u:someuer:rwx somefile` (Modify User `someuser` to have `rwx` permissions on `somefile`)
  - `-m` Modify
  - `u:` User permissions being set
  - `someuser:` the user
  - `rwx` any of `r`. `w`, or `x` for the permissions
  - `setfacl -m d:u:someuer:rwx somedir` for a Directory (`d:`)
- `setfacl -x u:someuser somefile` (remove ACL permissions for `someuser` on `somefile`)


___

#### [Lesson 4: Git](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)