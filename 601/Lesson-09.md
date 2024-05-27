# Linux 601
## Lesson 9: PAM & Cloud (SSH, LDAP, Docker, Mail)

# The Chalk
## Pluggable Authentication Module (PAM)
- *[Wikipedia article](https://en.wikipedia.org/wiki/Linux_PAM)*
- *[Arch Wiki](https://wiki.archlinux.org/title/PAM)*
- PAM is the underlying login system for Linux users
- PAM is used when you use the log in page on a GUI-based Linux system like GNOME, Xfce, KDE, etc
- PAM is used if you log on to a local or cloud Linux machine that *does not* use any GUI at all
- PAM governs users on the local machine
  - `su`
  - `sudo`
  - `login`
  - `chsh`
  - `passwd`
  - etc
- The Linux PAM lends the native user login capability to other network-based services
  - Telnet
  - FTP
  - SSH
  - SMTP (mail sending)
  - Dovecot (mail boxes)
  - LDAP
  - SSSD
- Configs
  - `/etc/pam.d/`

### Allowing `root` Login
- Make sure the `pam_securetty.so` module is enabled:
  - `cd /etc/pam.d/`
  - `grep pam_securetty.so *`
  - Should output at least one: `auth       required     pam_securetty.so`
- Config: `/etc/securetty`
  - `root` login is allowed from machines listed here

## Secure Shell (SSH)
- Packages:
  - Arch: `openssh` package
  - OpenSUSE: `openssh` package
  - Debian: `openssh-server` & `openssh-client` packages
  - RedHat: `openssh-server` & `openssh-clients` packages
- Uses the native Linux PAM
- Login to a remote Linux/Unix machine
- Can use password or key authentication
- SSH vs SSHD
  - SSH - Client - *local client machine connecting outward*
  - SSHD - Server - *remote host machine receiving incoming connection(s)*
- SCP is a tool that uses SSH to copy files
- The default port is `22` but is often set to something else in the configs

### Client Security Keys & 'Identity Files'
- Usekeys instead of a password; this is part of the advantage and the whole point
- Different types:
  - ECDSA - (Elliptic Curve Digital Signature Algorithm)
  - ECC - (Elliptic Curve Cryptography)
  - RSA - (Rivest-Shamir-Adleman) - Integer
  - DSA - (Digital Signature Algorithm) - Similar to RSA
- Which are better?
  - [Great article by Kontsevoy](https://goteleport.com/blog/comparing-ssh-keys/)
  - [Security.SE](https://security.stackexchange.com/questions/230708/should-i-be-using-ecdsa-keys-instead-of-rsa)
  - RSA & DSA need a kind of known attack to crack RSA, but it takes time
  - ECC & ECDSA use elliptic math formulas
    - Less size, about same level of security as RSA
    - Brings security concern that the mathematical curves provide back doors
    - Could be prone to error on calculation
- Two sets of keys:
  - Keys a local machine uses to login to a remote host (optional, wise)
    - `ssh-keygen` - will default to ECDSA and ask many questions
    - `ssh-keygen -t rsa` will use RSA
    - `ssh-keygen -t rsa -N "" -f ~/.ssh/My_new_key` - No questions, names the file `My_new_key`
    - `ssh-keygen -t rsa -N "" -f ~/.ssh/My_new_key -C my_key_comment` `-C` makes your own comment in the `.pub` key file, useful on the remote server
    - *The contents of `My_new_key.pub` goes in line in `~/.ssh/authorized_keys` on the remote host machine*
  - Host machine **identify files** (required, automatic)
    - *A way for clients to know that this is a server they recognize and "trust"*
      - First login with `ssh` or `sftp` in will ask to "trust" the server based on these identity files
    - Reside at `/etc/ssh/ssh_host_*_key`
    - Recorded by local clients in `~/.ssh/known_hosts` per remote host (*add to known_hosts* message the first time you `ssh` in)
    - Must be different on each host machine
    - New keys
      - Remove old: `rm /etc/ssh/ssh_host_*_key*`
      - Re-create: `ssh-keygen -A`
        - This is wise before first deploying a production server
        - Doing this after production launch will cause all clients to "distrust" this server
- Complete set of commands to create local keys:
```console
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa -N "" -f ~/.ssh/My_new_key -C my_key_comment
chmod 644 ~/.ssh/My_new_key.pub
chmod 600 ~/.ssh/My_new_key
cat ~/.ssh/My_new_key.pub
```
  - That key output to the terminal must be pasted into `~/.ssh/authorized_keys` on a separate line on the remote host machine for you to use `ssh` with
  - That key can also be pased into your GitHub account for pushing repos back to GitHub

### Configs
- `/etc/ssh/ssh_config` - Client - *on local client machine connecting outward*
  - `Port` (whaterver you choose, but both machines must agree; can be overridden with `-p` in the `ssh` command)
- `/etc/ssh/sshd_config` - Server - *on remote host machine receiving incoming connection(s)*
  - `Port` (whaterver you choose, but both machines must agree)
  - `PermitRootLogin` (`prohibit-password` for keys or simply `no` to prohibit any SSH login as `root`)
  - `PubkeyAuthentication` (`yes`)
  - `PasswordAuthentication` (`no`)
    - Change to `yes` to allow password login, such as on private networks, but `no` is best practice

#### SSH Authorised Keys & Known Hosts
- SSH keys are also used by GitHub (*Settings > SSH and GPG keys*)
- Permissions: (`~/.ssh/` or `/etc/ssh/`)
  - `700` - `~/.ssh/` *(the only thing in this list that isn't automatically set by itself)*
  - `600` - `~/.ssh/known_hosts` (added on first login, )
  - `600` - `~/.ssh/config`
  - `600` - `~/.ssh/key_file`
  - `644` - `~/.ssh/key_file.pub`
  - `644` - `~/.ssh/authorized_keys` (`key_file.pub` file contents pasted/`cat` into this file from remote machines to log in)

#### Client SSH Keys
- Keys come in pairs:
  - `key_name` - Private key, local machine
  - `key_name.pub` - Public key, remote host machine
- Key pair locations:
  - `/etc/ssh/`
  - `~/.ssh/`
- Create keys:
  - `ssh-keygen` (may default to `id_ed...` or `id_rsa`)
  - Auto-generated names: `ssh_host_rsa_key` or `ssh_host_ed...`
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

### Commands
- *`ssh` command to login **or** run a command to a remote machine*
- Login:
  - `ssh user@remotehost.tld`
  - `ssh user@ipv.4:or:6:addr`
  - `ssh user@ipv.4:or:6:addr -p 22` (`-p` is for port number)
  - *Specifying the key can become important; **do this if you have trouble!***
  - `ssh user@remotehost.tld -i key_file_name` (specify key file, no `.pub`)
- Remote command:
   - `ssh user@remotehost.tld some command`
- Copy: `scp` command to copy to/from a remote machine (using `ssh` login in the background)
  - `scp localfile user@remotehost.tld:/path/to/destination`
  - `scp -r localdir user@remotehost.tld:/path/to/destination`
  - `scp user@remotehost.tld:/path/to/remotefile /path/to/local/destination`
  - `scp -r user@remotehost.tld:/path/to/remotedir /path/to/local/destination`
  - *`scp` can also copy directories with `-r`, but use `tar -fcJ` please*
- Parallel: `pssh` (parallel SSH)
  - Tool to run same command on several machines (may need separate installation)
  - `pssh -viH user@host1.tld user@host2.tld user@333.333.333.ip4 some command`

### SSH-PAM Settings
- *An SSH server can use PAM to bolster `ssh` log on as POSIX-Linux users on the server*
  - *This is a server-side setting, not for the client*
- The `ssh` server does not necessarily need to use PAM
  - PAM helps track user logon time, etc
  - `ssh` with PAM used to require only `root` login, but that is outdated information; today `ssh` with PAM can authenticate normal users also
- `UsePAM yes` is turned on for `ssh` on many Linux Distros (including Debian, RedHat, and Arch)
- `/etc/ssh/sshd_config` is ***not*** the main place for this setting, tho it shows up there sometimes
  - Many obvious settings in `/etc/` are set by the SysAdmin; distro defaults for many packages are usually deeper in `/etc/`, `/user/lib/`, `/lib/` and such
- Search to find the default settings
  - `grep -R 'UsePAM' /etc/ssh/*`
  - `UsePAM yes` should appear in another setting file, such as in `/etc/ssh/sshd_config.d/`

| **PAM-SSH Authentication Diagram** :

```
[ SSH client login request (likely keys, maybe password) ] --> [ PAM-SSH interface on SSH server ] --> [ SSH client user is granted login permissions as a Linux user on the SSH server ]
```

## Lightweight Directory Access Protocol (LDAP)
- [OpenLDAP](https://www.openldap.org/) (AKA *LDAP*) is kind of online address book that serves user "directory" lookup and authentication
  - AKA contact/address book plus "login via LDAP"
- Primarily used for [Kerberos](https://www.kerberos.org/)
- Also can be used to authenticate other services, including [SSSD](https://sssd.io/), [WebDAV](https://en.wikipedia.org/wiki/WebDAV), [Nextcloud](https://nextcloud.com/), and others
- Uses the native Linux PAM
- Has a client (`ldap`) and server (`slapd`):
  - `ldap` = client nomenclature
  - `slapd` = server nomenclature
- *It is standard to have a client configured on the server so the client can manage entries from the server itself*

### Installation
- Arch: `openldap` package
  - [OpenLDAP](https://wiki.archlinux.org/title/LDAP_authentication) - ([#server](https://wiki.archlinux.org/title/OpenLDAP#The_server)) - ([#client](https://wiki.archlinux.org/title/OpenLDAP#The_client))
  - [Local machine authenticating with LDAP](https://wiki.archlinux.org/title/LDAP_authentication)
- [Ubuntu](https://ubuntu.com/server/docs/service-ldap): `slapd` `ldap-utils` packages
  - client package: `ldap-utils`
  - server package: `slapd`
  - server configure wizard :$ `dpkg-reconfigure slapd`
  - [Debian config](https://wiki.debian.org/LDAP/PAM)
- [OpenSUSE](https://doc.opensuse.org/documentation/leap/security/html/book-security/cha-security-ldap.html#sec-security-ldap-server-install)
  - client package: `openldap2-client` (or alt `yast2-auth-client`)
  - server package: `openldap2` (or alt `389-ds`)
  - *Yeah, OpenSUSE thinks a little differently*
- RedHat (server discontinued in 2022)
  - clients package: `openldap-clients`
  - server package: `openldap-servers` [depreciated in 2022 in favor of Red Hat Directory Server](https://access.redhat.com/solutions/2440481)
  - *Yeah, RedHat thinks they are more than a little different*

#### Server
- Standard, default server ports
  - `389` - Non-secure authentication
  - `636` - TLS authentication

##### Server Configs
- Arch config: `/etc/openldap/config.ldif` ([created manually](https://wiki.archlinux.org/title/OpenLDAP#The_server))
  - Arch data: `/var/lib/openldap/openldap-data/`
- Debian config: `/etc/ldap/slapd.d/` (automated by `slapd`)
  - Debian data: `/var/lib/ldap/`
- OpenSUSE config: `/etc/openldap/slapd.conf`
  - OpenSUSE data: `/var/lib/ldap/`

#### Client
- *LDAP clients have minimal configuration*
- *This tells the client how to reach the server*
- *The server uses a client config to "reach itself"*

##### Client Configs
- Arch: `/etc/openldap/ldap.conf`
- Debian: `/etc/ldap/ldap.conf`
- OpenSUSE: `/etc/openldap/ldap.conf`
- *Note this is minimal configuration for a working example*

| **ldap.conf** : (server)

these always work...

```
BASE            dc=localhost,dc=localdomain   # For server itself
URI             ldap://localhost              # For server itself
```

OR these also work...

```
BASE            dc=somedomain,dc=tld          # from client: /etc/hosts: 127.0.1.1 somehost.somedomain.tld somehost
URI             ldap://IP4.ADD.R3S.XXX:389    # from client: ip a (port :389 optional default)
```

| **ldap.conf** : (client)

```
BASE            dc=somedomain,dc=tld       # For remote server: OR sub.somedomain.tld: dc=sub,dc=somedomain,dc=tld # DNS listing not needed
URI             ldap://somedomain.tld:389  # For remote server: OR ldap://sub.somedomain.tld:389 OR ldap://X.X.X.X:389
```

OR these also work...

```
BASE            dc=somedomain,dc=tld          # from server: /etc/hosts: 127.0.1.1 somehost.somedomain.tld somehost
URI             ldap://IP4.ADD.R3S.XXX:389    # from server: ip a (port :389 optional default)
```

- Debian also needs to run # `dpkg-reconfigure slapd` with reasonably obvious answers on the interactive menus 
- Start the server
  - `systemctl start slapd`
  - Test with: `ldapwhoami -x`
    - `-x` is for "simple authentication", here allowing anonymous/no login
  - See the LDAP config: `sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn`

#### Validating with LDAP
- *Know your LDAP admin*
  - Find the admin entry with this:
    - `sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" "(olcRootDN=*)" olcSuffix olcRootDN olcRootPW -LLL -Q`
      - LDAP accepts `sudo` commands which do not require a specific LDAP user's password
      - This way, other Linux programs can interact with LDAP on the back end
    - Admin `-D` credential is in the line `olcRootDN:`
      - ie: `"cn=admin,dc=somedomain,dc=tld"` (from `/etc/hosts`: somehost.somedomain.tld somehost)
      - This was set during `sudo dpkg-reconfigure slapd`
  - Many `ldap*` commands will need `-D "cn=admin,dc=somedomain,dc=tld" -W`
    - `-D` is your login ID for LDAP
    - `-W` tells LDAP to ask for your password (created on install)
  - Test with: `ldapwhoami -D "cn=admin,dc=somedomain,dc=tld" -W`
  - External (check user's ability to login to other applications)
    - Normal: `ldapwhoami -Y EXTERNAL -H ldapi:/// -Q`
    - `sudo`: `sudo ldapwhoami -Y EXTERNAL -H ldapi:/// -Q`
    - `EXTERNAL` requires `-H ldapi:///` because it considers the command to be outside of the config-defined LDAP server

### LDAP Users
#### Add User
- *On the server:*
  1. Create a user file with basic credentials
    - Basic from can be found in `man ldapadd`
    - This includes `userPassword:` filled with output from `slappasswd`
  2. Add the user with:
    - `ldapadd -f thatuserfilewemade -D "cn=admin,dc=somedomain,dc=tld" -W`
    - `-f` is the file

- With this file...

| **somenewuser** : (normally an `.ldif` file, but not required)

```
dn: cn=John Jensen,dc=somedomain,dc=tld
objectClass: person
cn: John Jensen
sn: John
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
```

| **Admin adds user** :$

`ldapadd -f somenewuser -D "cn=admin,dc=somedomain,dc=tld" -W`

  - Output:

```
adding new entry "cn=John Jensen,dc=somedomain,dc=tld"
```

- Thus the user will authenticate with: `ldap... -D "cn=John Jensen,dc=somedomain,dc=tld" -W`

- Test with: `ldapwhoami -D "cn=John Jensen,dc=somedomain,dc=tld" -W`

#### Validate User
- Search for any user with the `-b` flag
  - `-b "cn=John Jensen,dc=somedomain,dc=tld"`
- Specify the host with the `-H` flag
  - Optional on the LDAP server itself
  - `-H ldap://localhost` is redundant and unnecessary, but included as an example

| **User searches for self** :$ (John Jensen)

```console
ldapsearch -D "cn=John Jensen,dc=somedomain,dc=tld" -W -H ldap://localhost -b "cn=John Jensen,dc=somedomain,dc=tld"
```

- `ldapsearch` is the search command
- `-D "..."` user's login ID
- `-W` asks for password
- `-H ldap://...` specifies LDAP host server
- `-b "..."` specifies search criteria (in this situation the user's login ID)

OR

| **Admin searches for for user** :$

```console
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -H ldap://localhost -b "cn=John Jensen,dc=somedomain,dc=tld"
```

- Look for:
  - `result: 0 Success` (`0` = success from `$?`)
  - `# numEntries: 1`

#### Change User Password
##### Change the LDAP root password

| **rootpass.ldif** : (`olcRootPW:` = `slappasswd` output)

```
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
```

- Initiate the file with: `sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f rootpass.ldif`
- *No LDAP user password was needed*

##### Change and Set Passwords for Users
- LDAP user changes own password:
  - `ldappasswd -D "cn=John Jensen,dc=somedomain,dc=tld" -W -S`
  - New password first, *then old password!*
- LDAP user auto-create new password: (no `-S` flag, still requires old password)
  - `ldappasswd -D "cn=John Jensen,dc=somedomain,dc=tld" -W`
- Admin creates a user with an empty password using `userPassword: {CRYPT}x`

| **nopassuser.ldif** :

```
dn: cn=Jim Jensen,dc=somedomain,dc=tld
objectClass: person
cn: Jim Jensen
sn: Jim
userPassword: {CRYPT}x
```

- Initiate the file with: `ldapmodify -D "cn=admin,dc=somedomain,dc=tld" -W -f nopassuser.ldif`
- LDAP admin can set a new password for user

| **userpass.ldif** : (`userPassword:` = `slappasswd` output)

```
dn: cn=Jim Jensen,dc=somedomain,dc=tld
changetype: modify
replace: userPassword
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
```

- Initiate the file with: `ldapmodify -D "cn=admin,dc=somedomain,dc=tld" -W -f userpass.ldif`

### LDAP Organizational Units
*Groups and users*

- An `objectClass: organizationalUnit` is an LDAP "**node**" schema that can hold records of groups or individual people etc
- These `.ldif` files (below) create schema for Groups and for People:
  - These will create actual Linux users and groups on the system
- When creating actual Linux users (accessible via PAM, viz SSSD et al):
  - We use `objectClass: posixAccount`
  - `UID` and `GID` will be relevant

| **group.ldif** :

```
dn: ou=Groups,dc=somedomain,dc=tld
objectClass: organizationalUnit
ou: Groups
```

| **people.ldif** :

```
dn: ou=People,dc=somedomain,dc=tld
objectClass: organizationalUnit
ou: People
```

- Now we make entries using the schema we just created
- These `.ldif` files (below) add "linuxusers" to Groups and "Bill" to People:
  - GID and UID are important because we don't want them to conflict with the Linux system users
  - These can start with "high" numbers, well above `GID_MIN` and `UID_MIN` as defined in `/etc/login.defs` ([Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md))

| **linuxuser-group.ldif** :

```
dn: cn=linuxusers,ou=Groups,dc=somedomain,dc=tld
objectClass: posixGroup
cn: linuxusers
gidNumber: 5000
```

| **Bill-linuxuser.ldif** : (`userPassword:` = `{CRYPT}x` as "no password")

```
dn: uid=bill,ou=People,dc=somedomain,dc=tld
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: bill
sn: Boba
givenName: Bill
cn: Bill Boba
displayName: Bill Boba
uidNumber: 10000
gidNumber: 5000
userPassword: {CRYPT}x
gecos: Bill Boba
loginShell: /bin/bash
homeDirectory: /home/bill
```

- Add all above four files with this :$ `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f FILENAME.ldif`
  - `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f group.ldif`
  - `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f people.ldif`
  - `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f linuxuser-group.ldif`
  - `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f Bill-linuxuser.ldif`
- *We could also have just put everything into one, huge file to make life easier, but this lesson breaks things up into understanding each part*

##### Find the user
- The user Bill does not use the same search schema we used before, but uses the new schema
- `ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -LLL -b dc=somedomain,dc=tld '(uid=bill)' cn gidNumber`

##### Add the user Bill to the `linuxusers` group

| **Bill-group.ldif** :

```
dn: cn=linuxusers,ou=Groups,dc=somedomain,dc=tld
changetype: modify
add: memberUid
memberUid: 10000
```

- Add the above file with this: `ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f Bill-group.ldif`

##### Change the user Bill's password via admin
- *Because we used `userPassword: {CRYPT}x`, the user can't login even to change their own password*

| **userpass.ldif** : (`userPassword:` = `slappasswd` output)

```
dn: uid=bill,ou=People,dc=somedomain,dc=tld
changetype: modify
replace: userPassword
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
```

- Initiate the file with: `ldapmodify -D "cn=admin,dc=somedomain,dc=tld" -W -f userpass.ldif`

##### Search the nodes
- Search for the user Bill :$
  - `ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -LLL -b dc=somedomain,dc=tld '(uid=bill)' cn gidNumber`
- *Note the `uid` in the member-nodes became the `uidNumber` of the individual entry*
  - We don't search for `uid=bill`, but `uid={bill's uidNumber}`
- These only return `true`/`false` match in the LDAP database
  - `true` = `result: 0 Success` & `# numResponses: 1`
  - Search for user Bill in People (uid=10000) :$
    - `ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "ou=People,dc=somedomain,dc=tld" uid=10000`
  - Search for group linuxusers in Groups (gid=5000) :$
    - `ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "ou=Groups,dc=somedomain,dc=tld" gid=5000`
  - Search for user Bill in the linuxusers group :$
    - `ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=linuxusers,ou=Groups,dc=somedomain,dc=tld" uid=10000`

### LDAP Schema
- Schema are the different settings with values in LDAP entries
- Schema can be added with `.ldif` files
- Schema includes:
  - `attributeype`
  - `objectclass`
- We previously created `organizationalUnit:` `objectclass` schema called `Groups` and `People`
- Many prepared `.schema` files can be found in `/etc/ldap/schema/`
- Add the [CORBA](https://en.wikipedia.org/wiki/Common_Object_Request_Broker_Architecture) schema:
  - `sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/corba.ldif`

### LDAP Commands
- `ldap*`
- List :$ `ls -1 /usr/bin/ldap*`
- How many :$ `ls /usr/bin/ldap* | wc -l`

### `man` Pages
- `ldap`
- `ldapadd`
- `ldapsearch`
- `ldif`
- `ldap.conf`
- `slapd`
- `slapcat`
- `slapadd`
- `slappasswd`
- `slaptest`
- `slapd.conf`
- `slapd.access`

### *Security Note*

*So far, we have a working, basic, bare-bones LDAP server*

*The next step in security is to include PAM authentication with SSSD as another authentication layer*

### System Security Services Daemon (SSSD)
- A remote directory tool
- Integrates with other Linux systems
- Installed for work with LDAP using different packages per distro
  - [Arch](https://wiki.archlinux.org/title/LDAP_authentication#Online_and_offline_authentication_with_SSSD): `sssd`
  - [Debian](https://ubuntu.com/server/docs/service-sssd-ldap): `sssd-ldap`
  - [OpenSUSE](https://software.opensuse.org/download/package?package=sssd&project=network%3Aldap): `sssd`
  - [RedHat](https://access.redhat.com/documentation/fr-fr/red_hat_enterprise_linux/9/html/configuring_authentication_and_authorization_in_rhel/configuring-sssd-to-use-ldap-and-require-tls-authentication_configuring-sssd-to-use-ldap-and-require-tls-authentication): `sssd sssd-ldap oddjob-mkhomedir`

### PAM-SSSD Client Authentication for LDAP
- Industry standard
- OpenSource
- Vendor neutral
- SSL & TLS capable

#### SSSD Client Authentication Process
*SSSD client using native Linux PAM authentication for remote LDAP user login/authentication*

| **PAM-LDAP Authentication Diagram** :

```
[ user auth request via PAM ] --> [ PAM-SSSD sss.so interface ] --net--> [ SSSD remote auth interface ] --> [ LDAP server ]
```

- Client SSSD begins work with the Pluggable Authentication Module (PAM)
  - PAM is Linux's default authentication tool
  - Client SSSD uses the `pam.sss.so` module to communicate with PAM
    - `sss.so` and `sssd` use one SSSD-LDAP config file
- Client config files:
  - SSSD-LDAP: `/etc/sssd/conf.d/00-sssd.conf`
  - PAM-LDAP:
    - Arch & RedHat: `/etc/pam.d/system-auth`
    - Debian: `/etc/pam.d/common-*`
    - OpenSUSE: `/etc/pam.d/common-*`
    - Generally:
      - Add `sufficient pam_ldap.so` before any line with `pam_unix.so`
      - But `session` line uses ` optional`

| **/etc/sssd/conf.d/00-sssd.conf** : (SSSD-LDAP Client)

```
[sssd]
config_file_version = 2
domains = somedomain.tld
services = nss, pam, autofs

[domain/somedomain.tld]
enumerate = true
id_provider = ldap
autofs_provider = ldap
auth_provider = ldap
chpass_provider = ldap
ldap_uri = ldap://192.168.77.X/ # OR ldap://somedomain.tld
ldap_search_base = dc=somedomain,dc=tld
ldap_id_use_start_tls = true
cache_credentials = true
ldap_tls_reqcert = allow
```

| **/etc/pam.d/system-auth** || **/etc/pam.d/common-\*** : (PAM-LDAP Client)

```
<pre>
<b>auth        sufficient  pam_ldap.so</b>
auth        required    pam_unix.so     try_first_pass nullok
auth        optional    pam_permit.so
auth        required    pam_env.so

<b>account     sufficient  pam_ldap.so</b>
account     required    pam_unix.so
account     optional    pam_permit.so
account     required    pam_time.so

<b>password    sufficient  pam_ldap.so</b>
password    required    pam_unix.so     try_first_pass nullok sha512 shadow
password    optional    pam_permit.so

session     required    pam_limits.so
session     required    pam_unix.so
<b>session     optional    pam_ldap.so</b>
session     optional    pam_permit.so
</pre>
```

#### SSSD Server
- An SSSD server:
  - Generally needs to belong to a DNS-listed domain, not merely an IP address
  - Uses SSL certificates, which, like email, are highly domain and DNS dependent
  - Could be configured to use only an IP address, but that takes some extra work for SSL certificates
- A private network is both difficult and not so necessary for services like SSSD
- A larger private network could host its own DNS servers, supporting the SSL certificates and SSSD domain settings
  - Such a large network would also present a higher need for security
- Usually, remote directory services like SSSD are used over the public Internet, not a local IP based private network
- These lessons do not cover domain-based services running in the cloud, including installation of an SSSD server

## Docker
- [Docker](https://docs.docker.com/reference/) runs full-OS containers using the main host machine's kernel
- `docker --help`
- Primarily used in cloud
- Unlike other network-based services, PAM would be used for SSH to access the machine hosting the Docker container, not with Docker directly
- Each container is:
  - Securely isolated from the rest of the system
  - Lightweight (not running another kernel session)
  - Built on the same kernel as the main host machine
- Containers are kept somewhere in: `/var/lib/docker/`
  - Messing with that directory can have catastrophic consequences
  - *Only remove this directory **for a Docker complete uninstall and purge or clean slate** for fresh install*
- Docker uses both `docker` and `docker compose` tools, which are installed separately 
- Docker packages
  - Arch: `docker`, `docker-compose`
  - Debian: `docker`, `docker-compose`
  - OpenSUSE Tumbleweed: `docker`, `docker-compose`, `docker-compose-switch`
  - RedHat: *manually add special repositories*

### Docker Management
- Docker commands work only for the running service :#
  - `systemctl enable docker`
  - `systemctl start docker`
- Container/Image management :$
  - `docker info` - Docker information
  - `docker -v` - Docker version
  - `docker-compose -v` - Docker Compose version
  - `docker images` - List Docker images
    - Won't have any images until running "Pull" commands as below
  - `docker ps` - List Docker running containers
  - `docker ps -a` - List *all* available Docker containers
  - `docker rmi -f IMAGE_ID 2ND_IMAGE_ID ...` - Forcibly remove a Docker image (often needs force)
  - `docker rm -f CONTAINER_ID | NAMES` - Forcibly remove Docker container (force only needed if it is running)
- Container creation :# (inside PWD containing `Dockerfile`, etc)
  - `docker build .` - Build without usable tag
  - `docker build -t some-tag .` - Build using a tag `some-tag` to use in `docker run` commands, etc
- Pull and start "Hello World" :#
  - Hello World: `docker run hello-world`
- Pull, start, and enter BASH :#
  - Ubuntu: `docker run -it ubuntu bash`
  - Alpine: `docker run -it alpine bash`
- Pull only :#
  - Ubuntu: `docker pull ubuntu`
  - Alpine: `docker pull alpine`
  - Hello World: `docker pull hello-world`
- Start :# `docker run -dt`
  - `-d` flag for **detatch** *(daemon, run in background)*
  - `-t` flag for pseudo-**TTY** *(so it actually starts running)*
  - Ubuntu: `docker run -dt ubuntu`
  - Alpine: `docker run -dt alpine`
  - Hello world: `docker run -dt hello-world`
- Start `-p 80:80` :# ***with port** to use at `localhost` on local desktop web browser*
  - `docker run -d -p 80:80 ubuntu` (if it is ready to run a webserver, which it probalby isn't)
  - `docker run -d -p 80:80 some-oob-ready-webserver-container`
- Stop :#
  - `docker ps`
  - `docker stop CONTAINER_ID`
- Custom-named "**bagged**" Alpine image :#
  - `docker pull alpine` - Download a Alpine Docker image
  - `docker run -dt --name bagged alpine` - Start the "bagged" container using the Alpine image we just downloaded
  - `docker exec -it bagged bash` - Enter the *bagged* container's **BASH** CLI
    - `-i` flag for **interface** 
    - `-t` flag for pseudo-**TTY**
  - `exit` - Exit the BASH CLI
  - `docker exec -it bagged sh` - Enter the *bagged* container's **Shell** CLI
- List running Docker containers :#
  - `docker ps` - View all Docker containers

### Docker Compose
- *`docker compose` uses YAML configs for simple or complex workflows*
  - *Workflows chart out things like: external web - network connection - web app - access to database - use of persistent block storage*
  - *Workflows and such server configurations can be well-defined for Docker with `compose.yaml`*
- ***Writing `docker compose` YAML configurations is beyond the scope of this lesson or most SysAdmin work***
  - *SysAdmin work is to properly deploy `compose.yaml` once it has been written by a Docker engineer*
- ***Situat `compose.yaml` in PWD***
  - *Docker prefers `.yaml` for YAML files over `.yml`, but both work*
  - *The config file is `compose.yaml` and must be in the present working directory*
  - *If `compose.yaml` is not present, `docker` will search for the legacy `docker-compose.yaml`*
- **`compose.yaml` in PWD** :# `docker compose up -d` - start
- **`compose.yaml` in PWD** :# `docker compose down` - stop

#### Using `docker compose`
- *See `docker compose` examples from the [Docker docs: compose file](https://docs.docker.com/compose/compose-file/) examples*
- In the software world, a `.yaml` file is created by a Docker engineer, then given to the SysAdmin for deployment
- For a SysAdmin, understanding the `.yaml` file is not as important knowing what one can look like and how to use it
- ***Disambiguation***
  - `docker compose` and `docker-compose` are two command structures that are in flux
  - See [related article](https://stackoverflow.com/questions/66514436/)
  - If the command `docker compose` does not work, instead try `docker-compose` with the same flags and options

##### `.yaml` Examples
- This `.yaml` file will work:

| **compose.yaml** : busybox from [Docker docks: version and name](https://docs.docker.com/compose/compose-file/04-version-and-name/)

```
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
```

  - With this file in the same directory, simply run :# `docker compose up -d`

- These ***example*** files are templates and require other things to be in place
  - Such `.yaml` files are likely budled for the SysAdmin to deploy

| **compose.yaml** : busybox example from [Docker docks: services](https://docs.docker.com/compose/compose-file/05-services/)

```
services:
  foo:
    image: busybox
    blkio_config:
       weight: 300
       weight_device:
         - path: /dev/sda
           weight: 400
       device_read_bps:
         - path: /dev/sdb
           rate: '12mb'
       device_read_iops:
         - path: /dev/sdb
           rate: 120
       device_write_bps:
         - path: /dev/sdb
           rate: '1024k'
       device_write_iops:
         - path: /dev/sdb
           rate: 30
```

| **compose.yaml** : databse example from [Docker docks: volumes](https://docs.docker.com/compose/compose-file/07-volumes/)

```
services:
  backend:
    image: example/database
    volumes:
      - db-data:/etc/data

  backup:
    image: backup-service
    volumes:
      - db-data:/var/lib/backup/data

volumes:
  db-data:
```

| **compose.yaml** : web server example 1 from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    file: ./httpd.conf
```

| **compose.yaml** : web server example 2 from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    external: true
```

| **compose.yaml** : web server example 3 from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    external: true
    name: "${HTTP_CONFIG_KEY}"
```

| **compose.yaml** : webapp config example from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  app_config:
    content: |
      debug=${DEBUG}
      spring.application.admin.enabled=${DEBUG}
      spring.application.name=${COMPOSE_PROJECT_NAME}
```

| **compose.yaml** : webapp example from [Docker docks: networks](https://docs.docker.com/compose/compose-file/06-networks/)

```
services:
  frontend:
    image: example/webapp
    networks:
      - front-tier
      - back-tier

networks:
  front-tier:
  back-tier:
```

| **compose.yaml** : served example certificate from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  server-certificate:
    file: ./server.cert
```

| **compose.yaml** : OAuth example from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  token:
    environment: "OAUTH_TOKEN"
```

| **compose.yaml** : served certificate with lookup example from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  server-certificate:
    external: true
    name: "${CERTIFICATE_KEY}"
```

#### Custom Docker Container
*From the [VIP/Docker-Hello-World](https://github.com/inkVerb/Docker-Hello-World) repo*

- **Three simple files**:

| *DIRECTORY_TREE* :

```
./Dockerfile
./src/html/index.html
./src/html/nib.gif
```

| **/Dockerfile** :

```
# Webserver and the ultra-small Alpine Linux distro
FROM nginx:alpine

# Copy from Docker source to webserver destination on the container
COPY src src/html /usr/share/nginx/html/

# Default port setting (can be removed)
EXPOSE 80/tcp

# Default nginx start command (can be removed)
CMD ["nginx", "-g", "daemon off;"]
```

| **/src/html/index.html** :

```
<!DOCTYPE html>
<html>
<body>
  <h1>Hello world!</h1>
  <p>I don't know half of you half as well as I should like; and I like less than half of you half as well as you deserve.<br>&mdash; <i>Bilbo Baggins</i></p>
  <img src="nib.gif">
</body>
</html>
```

| **Build, run, then remove Docker-Hello-World** :$

```
git clone https://github.com/inkVerb/Docker-Hello-World.git
cd Docker-Hello-World
sudo docker build -t helloworld .
sudo docker images
#sudo docker run helloworld               # WILL NOT WORK ON DESKTOP WEB BROWSER!
sudo docker run -d -p 80:80 helloworld    # Can be seen in desktop web browser at "localhost"
sudo docker ps
sudo docker stop [ helloworld CONTAINER ID | NAMES ]
sudo docker images
sudo docker rmi -f [ helloworld IMAGE ID ]
```

## Mail
- [Mail Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Mail.md)
- Linux servers primarily use one of three email services:
  - Sendmail
  - Postfix
  - Exim
- Email: (note [this article](https://serverfault.com/questions/905886/))
  - Theoretically can work without DNS-registerd domains and only use an IP address
  - Primarily needs a domain name so the email program knows how to handle incoming mail
  - Even on an private LAN network, an email server a private DNS to look up LAN machine names
  - A full private deployment of email with DNS and backup email servers requires at least five servers in addition to client machines on the network
  - These lessons do not cover domain-based services running in the cloud, including installation of a mail server
- *Installing an email server is beyond the scope of core Linux SysAdmin skills*
  - Managing an email server is almost a separate profession to itself
  - In the past, installing postfix was part of SysAdmin training, but not so much in 2024
  - Email is heavily dependent on DNS for security tools like SSL (viz `CAA` records) and [OpenDKIM](http://www.opendkim.org/), SPF (Sender Policy Framework viz [RFC 7208](https://datatracker.ietf.org/doc/html/rfc7208)), and [DMARC](https://dmarc.org/) `TXT` records
  - Backup mail servers are declared in DNS and often synced via the Linux `rsync` tool (see [Rsync on the Samba homepage](https://rsync.samba.org/))
  - Proper setup of an email server can take one full working day for an experienced SysAdmin working on multiple servers in the cloud
- It is important for any SysAdmin to know about the main tools used for email servers
- ***Incoming mail uses port `25`***
  - If your firewall does not allow this port, your server can't receive incoming email
  - This is not the same as using ports `465` or `587` rather than port `25` for SMTP *authentication*
  - Don't use port `25` for SMTP in your email client
  - Don't block port `25` on your email server either
- For some mail server facts, overall Postfix structure, ports, troubleshooting, and mail server interaction via `telnet`, see the [Mail Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Mail.md)
- The `sendmail` command is necessary for Postfix or a server using PHP web apps to send emails, but that command might be from the Postfix package, not from the Sendmail package

### Sendmail
- Maintained by [Proofpoint](https://www.proofpoint.com/us/products/email-protection/open-source-email-solution)
- Old and simple
- Often installed with the `sendmail` package
  - Native to any LAMP or LEMP stack since it may be included with web server tools like PHP
  - Many PHP websites, such as WordPress and Nextcloud, send website emails using `sendmail`
    - Using the [PHP `mail()` function](https://www.php.net/manual/en/function.mail.php) employs `sendmail`
    - Not being integrated with extensive security tools like Postfix affords, many website emails often end up in the recipient's Spam folder because they are only using `sendmail`
    - This does allow for basic email function from a LAMP or LEMP server
- An alternative to `sendmail` is to use `msmtp` ([from Martin Lambers](https://marlam.de/msmtp/))
  - This acts as a minimalist mail client on the backend of the LAMP/LEMP server
  - Employs whatever security anti-spammy tools the corresponding email server uses (OpenDKIM, SPF, DMARC, etc)
  - With this, the `sendmail` command will use the `msmtp` client's email server to send mail rather than the bare bones LAMP/LEMP server itself
- As email security becomes more sophisticated and requires configuring, sending email from the Linux command line becomes less common place
- For dedicated mail on production servers, services like Postfix and Exim are preferred over simply `sendmail`

### Postfix
- [Postfix](https://www.postfix.org/) is maintained by [Wietse Venema](http://www.porcupine.org/wietse/)
  - Started at IBM, then Google, now maintained independently
- Extremely common on Linux email servers
- Highly pluggable and configurable
- Used in concert with:
  - [Dovecot](https://www.dovecot.org/) for IMAP (Internet Messaging Access Protocol) mailbox directory sync (as opposed to POP retrieve mailboxing)
    - [Sieve](https://pigeonhole.dovecot.org/) email filters, from Pigeonhole viz [RFC 5228](https://datatracker.ietf.org/doc/html/rfc5228)
  - [PostfixAdmin](https://postfixadmin.github.io/postfixadmin/) for PHP web app control of Postfix virtual users and mailboxes
  - [Roundcube](https://roundcube.net/) webmail
  - [OpenDKIM](http://www.opendkim.org/) email key signatures to authenticate each email's origin (many email servers use)
  - [Diffie–Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) for security
  - SSL certificates, which [Letsencrypt](https://letsencrypt.org/) supports
  - Others, including spam and virus filters
- With Postfix, the `sendmail` command still works
  - [Postfix and others provide a `sendmail` command](https://unix.stackexchange.com/a/525239/315069) (AKA 'a binary'), even if it does not come from the `sendmail` package
- Read about the [relationship between Postfix and Sendmail](https://serverfault.com/questions/244263/)

### Exim
- [Exim](https://www.exim.org/) was developed by Cambridge for Unix
- Is highly configurable and desired for heavier Internet projects
- Does not support POP or IMAP, but needs separate services to provide these, such as
  - [Courier-IMAP](https://freecode.com/projects/courier-imap)
  - [Cyrus IMAP Server](https://freecode.com/projects/cyrusimapserver)
  - [UW IMAP Server](https://freecode.com/projects/uwimapserver)
  - [EMU Mail](https://freecode.com/projects/emumail)
  - [BEJY](https://freecode.com/projects/bejy)
  - Others
- When working as a SysAdmin on a large project, encountering Exim as the mail service is not unusual

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

## On Debian
*Practice specifically for Debian*

- **These commands should be attempted on practice machines using Debian, such as via [Oracle VirtualBox](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md)**
  - For `ssh`: two VMs should be running on the [hybervisor's virtual network](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md#Networking)
  - Any `ssh` keys on the machine will be replaced
  - LDAP and SSSD use Debian packages and configurations

### Know your VM network IP

| **Client** :$

```console
ip a
```

| **Server** :$

```console
ip a
```

### PAM

| **Client** :$

```console
cd /etc/pam.d
ls
grep pam_securetty.so *
vim /etc/securetty # Add lines with IP address of Machine-2
```

### SSH
#### Setup

| **Client** :$

```console
sudo apt-get install openssh-client
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh

ssh-keygen -t rsa
cat id_rsa.pub # Copy to clipboard
```

| **Server** :$

```console
sudo apt-get install openssh-server
sudo systemctl status ssh
sudo systemctl start ssh
sudo mkdir /root/.ssh
sudo chmod 700 /root/.ssh
cd /root/.ssh
sudo echo 'ssh-rsa THAT_LONG_SSH_KEY= user@machine' > authorized_keys

vim /etc/ssh/sshd_config
  # Uncomment & set:
  # PermitRootLogin prohibit-password
  # PubkeyAuthentication yes
  # PasswordAuthentication no

rm /etc/ssh/ssh_host_*_key*
ssh-keygen -A
```

#### Prepare

| **Client** :$

```console
cd
touch m1
mkdir m1.d
touch m1.d/m1.in
```

| **Server** :$

```console
cd
sudo touch /root/m2
sudo mkdir /root/m2.d
sudo touch /m2.d/m2.in
sudo systemctl start ssh  # May be redundant
ip a

ls
cat m1
```

#### Connect

| **Client** :$

```console
ssh root@192.168.77.X
ls
exit

scp ~/m1 root@192.168.77.X:~/
scp root@192.168.77.X:~/m2 ~/
ls
scp -r ~/m1.d root@192.168.77.X:~/
scp -r root@192.168.77.X:~/m2.d ~/
ls
ssh root@192.168.77.X
vim m1 # Make some changes
```

### LDAP
*The **Client** and **Server** may be either **Machine-1** or **Machine-1** mix-matched how you prefer*

#### Setup

| **Server** :$

```console
sudo apt install slapd ldap-utils # Input the new LDAP password twice
# Start configuration
sudo dpkg-reconfigure slapd
# No
# Any domain, or the pre-defined domain in /etc/hosts
# Organization name
# LDAP Admin password twice (same as during install)
# Database: MDB
# Remove databse when slapd is purged? Yes for practice (No for production)
# Move old databse? Yes
# LDAPv2 protocol? No (Use current LDAP protocol)

vim /etc/ldap/ldap.conf    # Arch is: /etc/openldap/ldap.conf
# Set/uncomment:
  # BASE    dc=localhost,dc=localdomain
  # URI     ldap://localhost:389

sudo systemctl status slapd
sudo systemctl start slapd
sudo systemctl status slapd

ldapsearch -x # count users
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn

ip a # We enter this server's IP on the client in /etc/ldap/ldap.conf
```

| **Client** :$

```console
sudo apt install ldap-utils

vim /etc/ldap/ldap.conf
# Below uses the IP address from `ip a` on the server
# Set/uncomment:
  # BASE    dc=somedomain,dc=tld
  # URI     ldap://192.168.77.X
```

#### LDAP Basic Users

| **Server** :$

```console
# Identify anonymous (since no credentials given)
ldapwhoami -x

# Search for admin user
sudo ldapsearch -H ldapi:// -Y EXTERNAL -b "cn=config" "(olcRootDN=*)" olcSuffix olcRootDN olcRootPW -LLL -Q

# admin self-identity
ldapwhoami -D "cn=admin,dc=somedomain,dc=tld" -W

# Normal Linux user identity
ldapwhoami -Y EXTERNAL -H ldapi:/// -Q

# root Linux user identity
sudo ldapwhoami -Y EXTERNAL -H ldapi:/// -Q

# Add a user

man ldapadd

slappasswd # Password: 123456
# The output becomes the userPassword: hash below

# Can copy-paste the file form from /tmp/newentry in the man page to create this below
## Remove everything below sn:
## Include userPassword: { slappasswd STDOUT }

cat <<EOF > addjohn
dn: cn=John Jensen,dc=somedomain,dc=tld
objectClass: person
cn: John Jensen
sn: Jensen
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
EOF

ldapadd -f addjohn -D "cn=admin,dc=somedomain,dc=tld" -W

# Search for that user
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld"

# Be redundant by indicating localhost
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld -H ldap://localhost"

# User searches for self
ldapsearch -D "cn=John Jensen,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld"

# Change root password
slappasswd
cat <<EOF > rootpass.ldif
dn: olcDatabase={1}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
EOF
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f rootpass.ldif

# User John changes own password
ldappasswd -D "cn=John Jensen,dc=somedomain,dc=tld" -W -S

# New Jim user without password
cat <<EOF > addjim.ldif
dn: cn=Jim Jensen,dc=somedomain,dc=tld
objectClass: person
cn: Jim Jensen
sn: Jim
userPassword: {CRYPT}x
EOF
ldapmodify -D "cn=admin,dc=somedomain,dc=tld" -W -f addjim.ldif

# Modify the Jim user to have a password
slappasswd
cat <<EOF > jimpass.ldif
dn: cn=Jim Jensen,dc=somedomain,dc=tld
changetype: modify
replace: userPassword
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
EOF
ldapmodify -D "cn=admin,dc=somedomain,dc=tld" -W -f jimpass.ldif
```

| **Client** :$

```console
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld -H ldap://192.168.77.X"

# URI ldap://192.168.77.X is already in /etc/ldap/ldap.conf
## So you can omit the -H option
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld"
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=Jim Jensen,dc=somedomain,dc=tld"

# User searches for self
ldapsearch -D "cn=John Jensen,dc=somedomain,dc=tld" -W -b "cn=John Jensen,dc=somedomain,dc=tld"
ldapsearch -D "cn=Jim Jensen,dc=somedomain,dc=tld" -W -b "cn=Jim Jensen,dc=somedomain,dc=tld"
```

#### Groups and `organizationalUnit`

| **Server** :$

```
sudo systemctl start slapd

cat <<EOF > group.ldif
dn: ou=Groups,dc=somedomain,dc=tld
objectClass: organizationalUnit
ou: Groups
EOF
ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f group.ldif

cat <<EOF > people.ldif
dn: ou=People,dc=somedomain,dc=tld
objectClass: organizationalUnit
ou: People
EOF
ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f people.ldif

cat <<EOF > linuxuser-group.ldif
dn: cn=linuxusers,ou=Groups,dc=somedomain,dc=tld
objectClass: posixGroup
cn: linuxusers
gidNumber: 5000
EOF
ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f linuxuser-group.ldif

cat <<EOF > Bill-linuxuser.ldif
dn: uid=bill,ou=People,dc=somedomain,dc=tld
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: bill
sn: Boba
givenName: Bill
cn: Bill Boba
displayName: Bill Boba
uidNumber: 10000
gidNumber: 5000
userPassword: {CRYPT}x
gecos: Bill Boba
loginShell: /bin/bash
homeDirectory: /home/bill
EOF
ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f Bill-linuxuser.ldif

# Set user Bill's password via admin
slappasswd

cat <<EOF > userpass.ldif
dn: uid=bill,ou=People,dc=somdomain,dc=tld
changetype: modify
replace: userPassword
userPassword: {SSHA}lOnGhaSsSh3D/pA55wD+inthisplace0
EOF
ldapmodify -D "cn=admin,dc=somdomain,dc=tld" -W -f userpass.ldif

# User Bill changes own password
ldappasswd -D uid=bill,ou=People,dc=somdomain,dc=tld -W -S

# Search for the user Bill
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -LLL -b dc=somedomain,dc=tld '(uid=bill)' cn gidNumber

# Search for user Bill in People (uid=10000)
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "ou=People,dc=somedomain,dc=tld" uid=10000

# Search for group linuxusers in Groups (gid=5000)
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "ou=Groups,dc=somedomain,dc=tld" gid=5000

# Search for user Bill in the linuxusers group
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=linuxusers,ou=Groups,dc=somedomain,dc=tld" uid=10000

# Add the user Bill to the linuxusers group
cat <<EOF > Bill-group.ldif
dn: cn=linuxusers,ou=Groups,dc=somedomain,dc=tld
changetype: modify
add: memberUid
memberUid: 10000
EOF

ldapadd -D "cn=admin,dc=somedomain,dc=tld" -W -f Bill-group.ldif

# Search for user Bill in the linuxusers group
ldapsearch -D "cn=admin,dc=somedomain,dc=tld" -W -b "cn=linuxusers,ou=Groups,dc=somedomain,dc=tld" uid=10000

# Add schemas
cd /etc/ldap/schema
ls
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/corba.ldif
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/dsee.ldif

# LDAP commands
ls -1 /usr/bin/ldap*         # Flag uses the number 1, not letter L
ls /usr/bin/ldap* | wc -l    # Flag uses letter L
```

### SSSD
*This would be run on the SSSD client machine*

```
sudo apt update
sudo apt install sssd-ldap

ls /etc/sssd/conf.d/00-sssd.conf
vim /etc/sssd/conf.d/00-sssd.conf

sudo cat <<EOF > /etc/sssd/conf.d/00-sssd.conf
[sssd]
config_file_version = 2
domains = somedomain.tld
services = nss, pam, autofs

[domain/somedomain.tld]
enumerate = true
id_provider = ldap
autofs_provider = ldap
auth_provider = ldap
chpass_provider = ldap
ldap_uri = ldap://192.168.77.X/
ldap_search_base = dc=somedomain,dc=tld
ldap_id_use_start_tls = true
cache_credentials = true
ldap_tls_reqcert = allow
EOF

ls /etc/pam.d/
vim /etc/pam.d/common-session

sudo cat <<EOF > /etc/pam.d/common-session.conf
auth        sufficient  pam_ldap.so
auth        required    pam_unix.so     try_first_pass nullok
auth        optional    pam_permit.so
auth        required    pam_env.so

account     sufficient  pam_ldap.so
account     required    pam_unix.so
account     optional    pam_permit.so
account     required    pam_time.so

password    sufficient  pam_ldap.so
password    required    pam_unix.so     try_first_pass nullok sha512 shadow
password    optional    pam_permit.so

session     required    pam_limits.so
session     required    pam_unix.so
session     optional    pam_ldap.so
session     optional    pam_permit.so
EOF

sudo systemctl start sssd
sudo systemctl start slapd
sudo systemctl status sssd
```

## On Any Distro
*Practice commands for any distro*

- **Use the package manager for your distro**

### Docker

| **Docker** :$

```console
# Arch
sudo pacman -Syy docker docker-compose

# Debian
sudo apt install docker docker-compose

# OpenSUSE
sudo zypper install docker docker-compose docker-compose-switch

# System service
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

# Simple run
sudo docker run -it ubuntu
sudo docker run hello-world

# Check status
sudo docker ps

# Start containers
sudo docker run -dt ubuntu
sudo docker run -dt hello-world
sudo docker ps

# Alpine
sudo docker pull alpine
sudo docker run -dt --name bagged alpine
sudo docker ps
sudo docker exec -it bagged bash
## Now in the Docker shell
uname
whoami
lsb_release -d
lsmem
lscpu
ls
lsblk
exit

sudo docker ps

# Stop
sudo docker stop [ helloworld CONTAINER ID | NAMES ]
sudo docker ps
sudo docker stop bagged
sudo docker ps

# Create .yaml files
mkdir .docker
cd .docker
mkdir busybox

cat <<EOF > busybox/compose.yaml
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
EOF
ls *

# Manage .yaml files
cd ../busybox
sudo docker compose up -d
sudo docker ps # No listing
sudo docker compose down

# Custom Docker container
git clone https://github.com/inkVerb/Docker-Hello-World.git
cd Docker-Hello-World
sudo docker build .
sudo docker images
sudo docker build -t helloworld .
sudo docker images

sudo docker run -d nginx       # Downloads new Docker image because no custom image was assigned
sudo docker run -d [ nging alpine IMAGE ID ]
sudo docker exec -it nginx bash

sudo docker ps
sudo docker exec -it [ IMAGE ID ] bash

sudo docker exec -it [ IMAGE ID ] /bin/sh

sudo docker ps
sudo docker run -d helloworld  # Runs immediately because it was tagged
sudo docker ps

# Browser: localhost
# Nothing
sudo docker ps
sudo docker stop [ helloworld CONTAINER ID | NAMES ]
sudo docker run -d -p 80:80 helloworld

sudo docker stop [ nging alpine CONTAINER ID | NAMES ]
sudo docker stop [ helloworld CONTAINER ID | NAMES ]

sudo docker ps -a
sudo docker rm [ ...each... CONTAINER ID | NAMES ]

sudo docker images
sudo docker rmi -f [ nging alpine IMAGE ID ]
sudo docker rmi -f [ helloworld IMAGE ID ]

# Finish
sudo systemctl stop docker
sudo systemctl stop docker.socket
sudo systemctl disable docker
```

## The Take
- This lesson covered a lot of information
- Not all of this information will be on a SysAdmin certification exam
- Many of *The Keys* exercises and information is for perspective to understand what the server is doing
- The important part for a SysAdmin is to know:
  - What each service does
  - What the acranym for each service stands for
  - Where the config files are
  - Some basics about the settings in the config files

### PAM (Pluggable Authentication Module)
- The backbone framework for Linux user login
- Can be used to support login for other tools like `ssh`, `scp`, `ldap`, `sftp`, and more
- Settings often in: `/etc/pam.d/`
  - One of the settings files needs `auth       required     pam_securetty.so`

### SSH (Secure Shell)
- Uses PAM for login
- Operate the terminal on a remote machine
- Commands:
  - `ssh` - terminal login and send commands
  - `scp` - copy files and directories
- Configs in: `~/.ssh`
- Create a key with: `ssh-keygen -t rsa`
  - `.pub` file contents entered into one line on remote machine: `~/.ssh/authorized_keys`
- `.ssh` directory should have `700` permissions
  - Most files should have `644` permissions, including `.pub` keys and `authorized_keys`
  - Private files should have `600` permissions, including private key (`.pub` file counterpart), `config`, and `known_hosts`
- `ssh` into a remote server
  - `ssh user@ip.add.ress.or.domain` (login)
  - `ssh user@ip.add.ress.or.domain some command` (only run a command on the remote machine)
- `scp` copy files
  - `scp localfile user@remotehost.tld:/path/to/destination`
  - `scp user@remotehost.tld:/path/to/remote/file localdestination`

### LDAP (Lightweight Directory Access Protocol)
- Often known as **Open LDAP**
- System service is `slapd`
  - :# `systemctl start slapd` etc
- A phonebook/contacts/directory tool
- Can list users with various contact information, etc
- Can authenticate/login users for services like [Kuberos](https://www.kerberos.org/), [SSSD](https://sssd.io/), [WebDAV](https://en.wikipedia.org/wiki/WebDAV), [Nextcloud](https://nextcloud.com/), and others
- Configs
  - Arch: `/etc/openldap/ldap.conf`
  - Debian: `/etc/ldap/ldap.conf`
  - OpenSUSE: *Uses `389-ds` package anyway*
  - RedHat: *LDAP server is depreciated anyway*

| **Server config** :

```
BASE            dc=localhost,dc=localdomain
URI             ldap://localhost
```

| **Client config** :

```
BASE            dc=somedomain,dc=tld       # OR sub.somedomain.tld: dc=sub,dc=somedomain,dc=tld # DNS listing not needed
URI             ldap://somedomain.tld:389  # OR ldap://sub.somedomain.tld:389 OR ldap://X.X.X.X:389
```

### SSSD (System Security Services Daemon)
- Can use LDAP for authentication
  - Uses PAM for login to LDAP
  - Configured in the PAM config file, *not any separate LDAP-for-PAM config*
- SSSD can be set to use LDAP as part of the config settings
- Configs:

| **/etc/sssd/conf.d/00-sssd.conf** : (SSSD-LDAP)

```
[sssd]
config_file_version = 2
domains = somedomain.tld
services = nss, pam, autofs

[domain/somedomain.tld]
enumerate = true
id_provider = ldap
autofs_provider = ldap
auth_provider = ldap
chpass_provider = ldap
ldap_uri = ldap://192.168.77.X/
ldap_search_base = dc=somedomain,dc=tld
ldap_id_use_start_tls = true
cache_credentials = true
ldap_tls_reqcert = allow
```

| **/etc/pam.d/system-auth** || **/etc/pam.d/common-session.conf** : (PAM-LDAP, note `pam_ldap.so`)

```
<pre>
<b>auth        sufficient  pam_ldap.so</b>
auth        required    pam_unix.so     try_first_pass nullok
auth        optional    pam_permit.so
auth        required    pam_env.so

<b>account     sufficient  pam_ldap.so</b>
account     required    pam_unix.so
account     optional    pam_permit.so
account     required    pam_time.so

<b>password    sufficient  pam_ldap.so</b>
password    required    pam_unix.so     try_first_pass nullok sha512 shadow
password    optional    pam_permit.so

session     required    pam_limits.so
session     required    pam_unix.so
<b>session     optional    pam_ldap.so</b>
session     optional    pam_permit.so
</pre>
```

### Docker
- Debian/Arch/OpenSUSE packages: `docker` & `docker-compose`
- `systemctl start docker` - Start the Docker service
- `docker compose` t- Activate a `.yaml` file in PWD
- `docker build -t MY_TAG .` - Build a container from `Dockerfile` in PWD
- `docker run -dt SOME_CONTAINER` - Start running a containter
- `docker exec -it CONTAINER_ID bash` - Enter the container's running CLI `/bin/bash` shell
- `docker ps` - List running containers
- `docker ps -a` - List all available containers
- `docker images` - List available images
- `docker stop CONTAINER_ID` - Stop a container
- `docker rmi -f IMAGE_ID` - Remove an image
- `docker rm -f CONTAINER_ID` - Stop, remove a container
- `docker info` - Information
- `docker -v` - Version
- `docker-compose -v` - Version of the `docker-compose` package

### Mail
- The main mail server programs are:
  - Sendmail
  - Postfix
  - Exim
- Incoming email uses port `25`
- Client SMTP authentication used to *also* use port `25`, then port `465` for SMTPS, but now uses `587`
- `sendmail` is a Linux command used by Postfix, PHP, and others to send an email
  - The PHP `mail()` function uses the `sendmail` function on the back end
  - The `sendmail` command could be provided by the Sendmail package, but also by Postfix or others
  - The `sendmail` command is necessary for Postfix or a server using PHP web apps to send emails
  - The `sendmail` command can send an email from the CLI
___

#### [Lesson 10: Firewall](https://github.com/inkVerb/vip/blob/master/601/Lesson-10.md)