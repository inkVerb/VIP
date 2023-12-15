# Linux 601
## Lesson 6: Users

Ready the CLI

```console
cd ~/School/VIP/601
```

___

### I. Section 1

| **1** :$

```console
command 1
```


___

# The Take
## Global Terminal
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
## Per-User Terminal
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
## Security & `sudo`
- `sudo` configs are in
  - `/etc/sudoers`
  - `/etc/sudoers.d`
### Substitute User (`su`)
- `su` will run a command as a sub shell for another user
  - Syntax: `su someuser -c "some command"`
  - This will run with with that `someuser` user's permissions
### Secure Shell (SSH)
- Login config: `/etc/ssh/sshd_config`
  - This governs rules for users logging in to this machine
  - `/etc/ssh/` contains "identity files"
    - A remote machine logging in will check this to confirm it is the correct machine
    - Usually `ssh_host_rsa_key` or `ssh_host_ed...`
- `ssh` command to login **or** run a command to a remote machine
  - Login:
     - `ssh user@remotehost.tld` (host/domain)
    - `ssh user@111.111.111.ip4` (IPv4 address)
    - `ssh user@111::111:ip6` (IPv6 address)
  - Remote command:
    - `ssh user@remotehost.tld some command` (host or IP)
- `scp` command to copy to/from a remote machine (using `ssh` login in the background)
  - `scp localfile user@remotehost.tld:/path/to/destination`
  - `scp -r localdir user@remotehost.tld:/path/to/destination`
  - `scp user@remotehost.tld:/path/to/remotefile /path/to/local/destination`
  - `scp -r user@remotehost.tld:/path/to/remotedir /path/to/local/destination`
- `pssh` (parallel SSH)
  - Tool to run same command on several machines (may need separate installation)
  - `pssh -viH user@host1.tld user@host2.tld user@333.333.333.ip4 some command`
- User configs: `~/.ssh/`
  - These govern the shell user logging in to remote machines or remote logins as this user
  - Permissions:
    - `700` - `~/.ssh/`
    - `600` - `~/.ssh/known_hosts`
    - `600` - `~/.ssh/config`
    - `600` - `~/.ssh/key_file`
    - `644` - `~/.ssh/key_file.pub`
    - `644` - `~/.ssh/authorized_keys` (`key_file.pub` file contents from remote machines to log in)
  - `ssh-keygen` (may default to `id_ed...` or `id_rsa`)
    - Creates a key to log in to a remote machine *with no password*
    - The `key.pub` contents must be listed on one line in `~/.ssh/authorized_keys` in the remote user's home
  - `~/.ssh/authorized_keys`
    - `somek_key.pub` contents per line of remote users that can log in
  - `~/.ssh/known_hosts`
    - Lists `some_hose_key.pub` contents from remote machines in current user's home
    - The first time you `ssh` into a remote machine, you are often asked if you trust the key
      - If you answer yes, the key is added to `~/.ssh/known_hosts`
      - If the key changes in the future, it must be removed from `~/.ssh/known_hosts`, otherwise `ssh` login to that machine will be rejected
    - `~/.ssh/known_hosts` will grow larger as you log in to more machines
  - Host nicknames
    - Usage:
      - `ssh some_nickname`
      - `ssh some_nickname some command`
    - `~/.ssh/config` (User config)
    - `/etc/ssh/ssh_config` (Global config)
    - `config` entry example:
```
Host some_nickname
  HostName remotehost.tld
  User someuser
  Port 2222
  IdentityFile ~/.ssh/key_file
``` 
### Remote Graphical Login (VNC)
- This requires the `tigervnc` package
- Start by running the `vncserver`
### Pluggable Authentication Modules (PAM)
- Config: `/etc/securetty`
  - Engable the `pam_securetty.so` module
  - Root login is allowed from machines listed here
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
## Ownership
- `chown user somefile`
- `chgrp group somefile`
- `chown user:group somefile`
- `chown -R user:group somedir`
## Permissions
- [Permissions Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Permissions.md)
- `chmod 755 somefile`
  - `chmod ug+x,o-x somefile`
  - `chmod ugo=r,ug=w somefile`
- `uuu`-`ggg`-`ooo` (User - Group - Other)
- `rwx`-`rwx`-`rwx` (Read Write eXecute)
  - Represented by `0`-`7`
  - Simple algorithm:
    - + 1 = eXecute
    - + 2 = Write
    - + 4 = Read
### Default Permissions via `umask`
- `0666` for files
- `0777` for directories
- Then denied by `umask` value
  - `umask` show the mask
  - `umask -S` show defauls in letters
  - `umask` is normally set to `0002` or `0022`
  - Change with one argument
    - `umask 0022`
    - `umask u=rw,g=r,o=r`
- Results:
  - `0666` - `0022` = `0644`
  - `0777` - `0022` = `0755`
## Filesystem Access Control Lists (F ACL)
- This sets different file permissions per user and group
- This is part of the Linux kernel
- This needs the `-acl` option when mounting
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

#### [Lesson 7: Mail](https://github.com/inkVerb/vip/blob/master/601/Lesson-07.md)