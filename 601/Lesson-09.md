# Linux 601
## Lesson 9: PAM, SSH, LDAP & Docker

# The Chalk
## Pluggable Authentication Module (PAM)
- *[Wikipedia article](https://en.wikipedia.org/wiki/Linux_PAM)*
- *[Arch Wiki](https://wiki.archlinux.org/title/PAM)*
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
  - SMTP
  - Dovecot
  - LDAP
- Configs
  - `/etc/pam.d/`
### Allowing `root` Login
- Config: `/etc/securetty`
  - Enable the `pam_securetty.so` module
  - `root` login is allowed from machines listed here

## Secure Shell (SSH)
- `openssh` package
- Uses the native Linux PAM
- Login to a remote Linux/Unix machine
- Can use password or key authentication
- SSH vs SSHD
  - SSH runs on the client to login elsewhere
  - SSHD accepts remote clients trying to login
- SCP is a tool that uses SSH to copy files
- The default port is `22` but is often set to something else in the configs
- Configs:
  - `/etc/ssh/ssh_config` - Local client machine
    - `Port` (whaterver you choose, but both machines must agree; can be overridden with `-p` in the `ssh` command)
  - `/etc/ssh/sshd_config` - Remote host machine
    - `PermitRootLogin` (`prohibit-password` for keys or simply `no` to prohibit any SSH login as `root`)
    - `PubkeyAuthentication` (`yes`)
    - `PasswordAuthentication` (`no`)
    - `Port` (whaterver you choose, but both machines must agree)

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

### Security Keys & 'Identity Files'
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
    - `ssh-keygen -t rsa -N "" -f ~/.ssh/My_new_key` - No questions, names the file `My_new_key`
    - `ssh-keygen -t rsa -N "" -f ~/.ssh/My_new_key -C my_key_comment` `-C` makes your own comment in the `.pub` key file, useful on the remote server
    - *The contents of `My_new_key.pub` goes in line in `~/.ssh/authorized_keys` on the remote host machine*
    - 
  - Host machine **identify files** (required, automatic)
    - Reside at `/etc/ssh/*_key`
    - Recorded by local clients in `~/.ssh/known_hosts` per remote host (*add to known_hosts* message the first time you `ssh` in)
    - Must be different on each host machine
    - Re-create: `ssh-keygen -A`
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

#### SSH Authorised Keys & Known Hosts
- SSH keys are also used by GitHub (*Settings > SSH and GPG keys*)
- Permissions: (`~/.ssh/` or `/etc/ssh/`)
  - `700` - `~/.ssh/`
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

### SSH-PAM Settings
- `ssh` does not necessarily need to use PAM
  - PAM helps track user logon time, etc
  - `ssh` with PAM used to require only `root` login, but that is outdated information; today `ssh` with PAM can authenticate normal users also
- `UsePAM yes` is turned on for `ssh` on many Linux Distros (including Ubuntu, CentOS, and Arch)
- `/etc/ssh/sshd_config` is ***not*** the main place for this setting!
  - Many obvious settings in `/etc/` are set by the SysAdmin; distro defaults for many packages are usually deeper in `/etc/`, `/user/lib/`, `/lib/` and such
- Search to find the default settings
  - `grep -R 'UsePAM' /etc/ssh/*`
  - `UsePAM yes` should appear in another setting file, such as in `/etc/ssh/sshd_config.d/`

## Lightweight Directory Access Protocol (LDAP)
- [OpenLDAP](https://www.openldap.org/) (AKA *LDAP*) is kind of online address book that serves user "directory" lookup and authentication
  - AKA contact/address book plus "login via LDAP"
- Primarily used for [Kerberos](https://www.kerberos.org/)
- Uses the native Linux PAM
- Has a client (`ldap`) and server (`slapd`):
  - `ldap` = client nomenclature
  - `slapd` = server nomenclature
- *It is standard to have a client configured on the server so the client can manage entries from the server itself*

### Installation
- Arch: `openldap` package
  - [OpenLDAP](https://wiki.archlinux.org/title/LDAP_authentication) - ([#server](https://wiki.archlinux.org/title/OpenLDAP#The_server)) - ([#client](https://wiki.archlinux.org/title/OpenLDAP#The_client))
  - [Local machine authenticating with LDAP](https://wiki.archlinux.org/title/LDAP_authentication)
- [Ubuntu](https://ubuntu.com/server/docs/service-ldap) `slapd` `ldap-utils` packages
  - [Debian config](https://wiki.debian.org/LDAP/PAM)

#### Server
- Arch: `/etc/openldap/config.ldif` (created [manually](https://wiki.archlinux.org/title/OpenLDAP#The_server))
- Debian: `/etc/ldap/slap.d/` (automated by `slapd`)
- Arch data: `/var/lib/openldap/openldap-data/`
- Debian data: `/var/lib/ldap/`
- Standard, default server ports
  - `389` - Non-secure authentication
  - `636` - TLS authentication

#### Client
- *LDAP clients need only minimal configuration*
- Arch: `/etc/openldap/ldap.conf`
- Debian: `/etc/ldap/ldap.conf`

| **ldap.conf** : (client on same server)

```
BASE            dc=localhost,dc=localdomain   # For remote: eg sub.somedomain.tld: dc=sub,dc=somedomain,dc=tld
URI             ldap://localhost              # For remote: eg ldap://somedomain.tld or ldap://sub.somedomain.tld
```

### Commands
- `ldap*` - client commands
- `slap*` - server commands

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

### Authentication
- Industry standard
- OpenSource
- Vendor neutral
- SSL & TLS capable

#### Client Authentication Process

| **PAM-LDAP Authentication Diagram** :

```
[ user auth request via PAM ] --> [ PAM-SSSD interface via sss.so ] --> [ SSSD interface for remote auth ] --> [ LDAP server ]
```

- Begins with the Pluggable Authentication Module (PAM)
  - PAM is Linux's default authentication tool
- `pam.sss.so` module
- `sss.so` and `sssd` use one SSSD-LDAP config file

- Config files:
  - SSSD: `/etc/sssd/conf.d/00-sssd.conf`
  - PAM:
    - Arch & CentOS: `/etc/pam.d/system-auth`
    - Ubuntu: `/etc/pam.d/common-session.conf`
    - Generally:
      - Add `sufficient pam_ldap.so` before any line with `pam_unix.so`
      - But `session` line uses ` optional`

| **/etc/pam.d/system-auth`** :

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

## Docker
- [Docker docs: Reference](https://docs.docker.com/reference/) runs full-OS containers using the main host machine's kernel
- `docker --help`
- Primarily used in cloud

- Each container is:
  - Securely isolated from the rest of the system
  - Lightweight (not running another kernel session)
  - Built on the same kernel as the main host machine

### Manage
- Install Docker with the `docker` package
- Docker commands work only for the running service: #
  - `systemctl enable docker`
  - `systemctl start docker`
- Container management: #
  - `docker pull centos` - Download a CentOS Docker image
  - `docker run -d -t --name bagged centos` - Start the "bagged" container using the CentOS image we just downloaded
  - `docker ps` - View all Docker containers
  - `docker exec -it bagged bash` - Enter the *bagged* container's **BASH** CLI
  - `exit` - Exit the BASH CLI
  - `docker exec -it bagged sh` - Enter the *bagged* container's **Shell** CLI

### `docker compose`
- *`docker compose` uses YAML configs for simple or complex workflows*
  - *Workflows chart out things like: external web - network connection - web app - access to database - use of persistent block storage*
  - *Workflows and such server configurations can be well-defined for Docker with `compose.yaml`*
- ***Writing `docker compose` YAML configurations is beyond the scope of this lesson or most SysAdmin work***
  - *SysAdmin work is to properly deploy `compose.yaml` once it has been written by a Docker engineer*
- ***Situat `compose.yaml` in PWD***
  - *Docker prefers `.yaml` for YAML files over `.yml`, but both work*
  - *The config file is `compose.yaml` and must be in the present working directory*
  - *If `compose.yaml` is not present, `docker` will search for the legacy `docker-compose.yaml`*
- | **`compose.yaml` PWD** :# `docker compose up -d` - start
- | **`compose.yaml` PWD** :# `docker compose down` - stop

#### `docker compose` Examples
- *See `docker compose` examples from the [Docker docs: compose file](https://docs.docker.com/compose/compose-file/) examples*
- For a SysAdmin, understanding these is not important, but you should know what they can look like

| **compose.yaml** : webapp from [Docker docks: networks](https://docs.docker.com/compose/compose-file/06-networks/)

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

| **compose.yaml** : busybox from [Docker docks: version and name](https://docs.docker.com/compose/compose-file/04-version-and-name/)

```
services:
  foo:
    image: busybox
    environment:
      - COMPOSE_PROJECT_NAME
    command: echo "I'm running ${COMPOSE_PROJECT_NAME}"
```

| **compose.yaml** : databse from [Docker docks: volumes](https://docs.docker.com/compose/compose-file/07-volumes/)

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

| **compose.yaml** : web server from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    file: ./httpd.conf
```

| **compose.yaml** : web server from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    external: true
```

| **compose.yaml** : web server from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  http_config:
    external: true
    name: "${HTTP_CONFIG_KEY}"
```

| **compose.yaml** : webapp config from [Docker docks: configs](https://docs.docker.com/compose/compose-file/08-configs/)

```
configs:
  app_config:
    content: |
      debug=${DEBUG}
      spring.application.admin.enabled=${DEBUG}
      spring.application.name=${COMPOSE_PROJECT_NAME}
```

| **compose.yaml** : busybox from [Docker docks: services](https://docs.docker.com/compose/compose-file/05-services/)

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

| **compose.yaml** : served certificate from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  server-certificate:
    file: ./server.cert
```

| **compose.yaml** : OAuth from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  token:
    environment: "OAUTH_TOKEN"
```

| **compose.yaml** : served certificate with lookup from [Docker docks: secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

```
secrets:
  server-certificate:
    external: true
    name: "${CERTIFICATE_KEY}"
```

___

# The Type

```console

```

___

#### [Lesson 10: Firewall](https://github.com/inkVerb/vip/blob/master/601/Lesson-11.md)