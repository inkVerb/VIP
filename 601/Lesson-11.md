# Linux 601
## Lesson 11: Security Modules

# The Chalk
*This lesson presume commands are run as `root`*
## Linux Security Modules (LSM)
- Security is intended to:
  - Minimize changes and overhead for the kernel
  - Allow flexibility in implementation
- Security modules **hook** kernel calls:
  - Insert code for any program calling the kernel
    - Checks valid permissions
    - Protect from malicious action
    - Take security action before/after kernel action
- Read more in Shaun Ruffell's article: [A Brief Tour of Linux Security Modules](https://www.starlab.io/blog/a-brief-tour-of-linux-security-modules)
- Main security modules used today are **SELinux** and **AppArmor**
  - These have special profiles that are best created by security specialists
  - The role of the SysAdmin is usually to implement the security policies and profiles created by those specialists, not to create those security profiles themselves
  - We will examine some tools to modify these security policies and profiles, but only for broader understanding, not for production use or best practice

### Security Module History
- SELinux was the original
  - In 2001, it was sent to be included as a kernel module OOB
  - There was some objection to a monolythic security solution
- In 2003:
  - SELinux was implemented
  - Other security modules could be developed and adopted instead
  - Only one security module could be used at a time
- Combining security modules is possible today, but be cautious doing so
  - Combining consders different sec mods as "major" or "minor"
- Workflow terms:
  - **DAC**: Discretionary Access Control (policy-based, mainly user/file permissions on every Unix/Linux kernel)
  - **MAC**: Mandatory Access Control (user-based, includes ACL, supplemental to Linux DAC)
  - **AVC**: Access Vector Cache (messages about SELinux violations)
  - **ACL**: Access Control Lists (user/file permissions, see [Lesson 3: Users & Groups](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md))
  - Learn more on [UL.SE](https://unix.stackexchange.com/questions/16828)
- Linux v6.7.4 (2024) LSMs include:
  - **SELinux** (v2.6: elaborate MAC)
  - **Simplified Mandatory Access Control (SMACK)** (v2.6.24: MAC)
  - **AppArmor** (v2.6.36: MAC)
  - **TOMOYO** (v2.6.30: MAC)
  - **Yama** (v3.4: extends DAC)
  - **LoadPin** (v4.7: ensures kernel files are from same filesystem)
  - **SafeSetID** (v5.1: UID/GID transitions must match a whitelist)
  - **Lockdown** (v5.4: prevents various changes to the kernel, ie loading modules)

## Security Enhanced Linux (SELinux)
- Developed by United States National Security Agency (NSA)
- Primarily used by RedHat/CentOS (viz [CentOS Stream](https://www.centos.org/download/), [Fedora](https://fedoraproject.org/), or [RHEL](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux))
  - `su` may be inaccessible; try `sudo -i`
- Elaborate MAC
  - Uses file permissions for processes and ports, not only file permissions for users
  - These are stored separately
- Config: (sets **mode**)
  - `/etc/selinux/config` (main)
  - `/etc/sysconfig/selinux` (relocated or linked here)
- Three enforcement terms:
  - **Contexts**: Labels applied files, users, processes, ports (ie seen with `ls -Z`)
  - **Rules**: Limits applied to each context
  - **Policies**: System-wide control (defaults for applying context rules)
- Three **modes**: (uses only one)
  - **Enforcing**: Fully enforced, violations logged with AVC
  - **Permissive**: Only warning, violations logged with AVC (debugging)
  - **Disabled**: SELinux not working at all
- Permanently disable: (either)
  - `SELINUX=disabled` (in `/etc/selinux/config`)
  - `selinux=0` to kernel via the `linux` line of GRUB config: `/boot/grub/grub.cfg`
    - See [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md) for more
  - Only disable SELinux if you ***never*** intend to re-enable it
    - Instead of "disable and re-enable", first use `setenforce Permissive` to disble enforcement, then `setenforce Enforcing` to enforce again
- Tools:
  - `sestatus` - Show current mode and policy
  - `setenforce` - Set mode
  - `getenforce` - Show mode
  - Examples:
    - `sestatus`
    - `getenforce`
    - `setenforce Enforcing`
    - `setenforce Permissive`
    - *No `Disabled` option*

### SELinux Context
- Four contexts:
  - User: `_u`
  - Role: `_r`
  - Type: `_t`
  - Level: `s...`
- Context nomenclature:
  - `ls -Z` shows context rules for files
  - eg: `-rw-------. root root system_u:object_r:admin_home_t:s0 somefile`
  - User: `system_u`
  - Role: `object_r`
  - Type: `admin_home_t`
  - Level: `s0`
- Context rules are defined in `/etc/selinux/targeted/contexts/`
  - `targeted/` may be different, depending on the SELinux distro and deployment
  - Subdirectories `users/` and `files/` contain respective rules
- List of all (requires the `seinfo` package)
  - Types: `seinfo -t`
  - Users: `seinfo -u`
  - Roles: `seinfo -r`

#### User Contexts:
*Linux users are mapped to actual SELinux users (ending with `_u`) as part of employing the security hook in the kernel module*

| User         | Default Role | Additional Roles                                 |
| :----------- | :----------- | :----------------------------------------------- |
| `guest_u`    | `guest_r`    |                                                  |
| `xguest_u`   | `xguest_r`   |                                                  |
| `user_u`     | `user_r`     |                                                  |
| `staff_u`    | `staff_r`    | `auditadm_r`, `secadm_r`, `sysadm_r`             |
| `sysadm_u`   | `sysadm_r`   |                                                  |
| `root`       | `staff_r`    | `auditadm_r`, `secadm_r`, `sysadm_r`, `system_r` |
| `system_u`   | `system_r`   |                                                  |

  - Others:
    - `object_r`
    - `default_t`

#### Role & Type Contexts:

| Role         | Type         | Login via X Window       | `su`/`sudo` | Execute in `~/` & `/tmp/` | Networking   |
| :----------- | :----------- | :----------------------- | :---------- | :------------------------ | :----------- |
| `guest_r`    | `guest_t`    | no                       | no          | yes                       | no           |
| `xguest_r`   | `xguest_t`   | yes                      | no          | yes                       | web browsers |
| `user_r`     | `user_t`     | yes                      | no          | yes                       | yes          |
| `staff_r`    | `staff_t`    | yes                      | only `sudo` | yes                       | yes          |
| `auditadm_r` | `auditadm_t` |                          | yes         | yes                       | yes          |
| `secadm_r`   | `secadm_t`   |                          | yes         | yes                       | yes          |
| `sysadm_r`   | `sysadm_t`   | if `xdm_sysadm_login` on | yes         | yes                       | yes          |

#### Context Inheritance & Preservation
- *`cp`, `mv`, `mkdir`, `touch` and other CLI tools support SELinux if installed*
- New files inherit the context of the parent directory
- Moved files will preserve their original context
- Context Tools:
  - `chcon` & `chcat` are covered later in **Levels**
  - `semanage fcontext` sets policy for files and directories
    - `semanage fcontext -a -t httpd_sys_content_t /somedir`
    - ***Must*** use absolute path
    - ***Must*** follow with `restorecon` command for same file or directory
  - `restorecon` implements file and directory context from `semanage fcontext`
    - `restorecon -RFv /somedir/somefile`
      - `-R` - Recursive
      - `-F` - Force
      - `-v` - Verbose
      - Can use relative path
  - Usage:
```console
semanage fcontext -a -t httpd_tmp_t /somedir
restorecon -R /somedir
semanage fcontext -z -t httpd_tmp_t /somedir/somefile
restorecon /somedir/somefile
```

### SELinux Policies
- Set in configs
- Policies are installed in `/etc/selinux/targeted/`
  - `targeted/` may be different, depending on the SELinux distro and deployment
- Common policies:
  - **targeted**:
    - More restricted to "targeted" processes
    - User and `init` processes not targeted
    - Targets network processes
    - RAM restrictions for all processes
  - **minimum**:
    - Similar to **targeted** policy
    - Targeted processes must be "selected"
  - **Multi Level Security (MLS) & Multi Category Security (MCS)**:
    - Highly restrictive everywhere
    - Every process placed in a **security domain** with specific rules

#### Policy Terms
- ***Subject*** - a *user*, *program*, or *process* assigned *sensitivity level* or *categories*
- ***Sensitivity*** levels (MLS, `s0`-`s15`)
  - Hierarchical *clearance*
  - Subjects with higher clearance can access subjects with lower clearance
  - *Subjects* may each only be assigned one
- ***Categories*** (MCS, `c0`-`c1023`)
  - Unique
  - Subjects must be assigned a category to access it
  - *Subjects* may each be assigned many
- ***Security Level*** - a set of *sensitivity* and *category*
  - eg: `s0`
  - eg: `s1:c15`
  - eg: `s5:c12.c17,c934`
- ***Object*** - a human-readable *security level*
  - Set in `/etc/selinux/targeted/setrans.conf`
    - `targeted/` is the *SELinux type* and could be different depending on the distro and deployment
  - See with:# `chcat -L`
  - eg: `SystemLow` = `s0`
  - eg: `Maintainers` = `s15:c0.c1023`
  - eg: `Accounting` = `s1:c49`

| MLS/MCS Security Levels  |                       |          |          |          |     |               |
| :----------------------- | :-------------------- | :------- | :------- | :------- | :-- | :------------ |
|                          | ***Category &rarr;*** | `c0`     | `c1`     | `c2`     | ... | `c1023`       |
| ***Sensitivity &darr;*** |                       |          |          |          |     |               |
| **Top Secret**           | `s15`                 | `s15:c0` | `s15:c1` | `s15:c2` | ... | `s15:c1023`   |
| ...                      | ...                   | ...      | ...      | ...      | ... | ...           |
| **Secret**               | `s3`                  | `s3:c0`  | `s3:c1`  | `s3:c2`  | ... | `s3:c1023`    |
| **Confidential**         | `s2`                  | `s2:c0`  | `s2:c1`  | `s2:c2`  | ... | `s2:c1023`    |
| **Restricted**           | `s1`                  | `s1:c0`  | `s1:c1`  | `s1:c2`  | ... | `s1:c1023`    |
| **Unclassified**         | `s0`                  | `s0:c0`  | `s0:c1`  | `s0:c2`  | ... | `s0:c1023`    |

- Level syntax:
  - **`:`** sensitivity-category delimiter
  - **`.`** category range
  - **`,`** category list
  - `c2.c7` = `c2,c4,c5,c6,c7`
  - `c1.c4,c11` = `c1,c2,c3,c4,c11`
- Level examples:
  - `s0:c7`
  - `s3:c8.c12`
  - `s5:c31.c52,c89`
- Level tools:#
  - `chcat` - change category
    - `-l` apply to users, not files
    - `chcat -- +c5,-c32 /some/file` (add `c5`, remove `c32` for `/some/file`)
    - `chcat -l -- +c9,-c2 someuser` (add `c9`, remove `c2` for `someuser`)
    - `chcat -L` lists available category *objects*
      - Set in `/etc/selinux/targeted/setrans.conf`
    - `chcat -- +SystemHigh,-SystemLow /some/file` (add/remove `setrans.conf` *objects*)
  - `chcon` - change context
    - `-r` role
    - `-t` type
    - `-l` level/category
    - `chcon -R -l s5 /home/someuser`
    - `chcon -l s12 /etc/some.config`
    - `chcon -t etc_t onefile` - `etc_t` context for `onefile`
    - `chcon --reference=onefile otherfile` - context of `onefile` for `otherfile`
  - `restorecon` - restore context to parent directory
    - `restorecon -RFv` - `-R` recursive, `-F` force, `-v` verbose
  - `semanage fcontext` - sets a directory's context policy (`policycoreutils-python` package)
  - `ls -Z`  - see rule labels for files
  - `ps auZ` - see context labels for users
  - `ps axZ` - see context labels for processes

### SELinux Booleans
- ***Booleans** in SELinux set behavior without changing policy*
  - Customizes SELinux, not a backdoor change
- Boolean tools:
  - `getsebool` - get booleans
    - `-a` flag only to list all available and their values
  - `setsebool` - set booleans
    - `-P` for persistent (default is non-persistent)
  - `semanage boolean -l` - list persistent boolean settings
- Examples:
  - `getsebool -a` - see all available booleans and their value
  - `getsebool cluster_manage_all_files` - see whether `cluster_manage_all_files` is `on` or `off`
  - `setsebool cluster_manage_all_files on` - set `cluster_manage_all_files` `on` (non-persistent)
    - `getsebool cluster_manage_all_files` = `on` (current)
    - `semanage boolean -l cluster_manage_all_files` = `off` (persistant?)
  - `setsebool -P cluster_manage_all_files on` - set `cluster_manage_all_files` `on` (persistent)
    - `getsebool cluster_manage_all_files` = `on` (current)
    - `semanage boolean -l cluster_manage_all_files` = `on` (persistant?)

### Monitor SELinux Access
- *SELinux has a tool to monitor and logs issues*
- `setroubleshoot-server` package
- Configs:
  - `/var/log/audit/audit.log` - raw issue messages
  - `/var/log/messages` - where they get moved to
- `sealert` views messages
- Example: create a problem
  - `echo 'Wrong place' > /root/rootfile`
  - `mv /root/rootfile /srv/www/html/`
  - `wget -O - localhost/rootfile` - that will be a problem
  - `tail /var/log/messages` - see what SELinux thought

## AppArmor
- Started by Immunex (Linux distro) in 1998
  - [OpenSUSE](https://get.opensuse.org/tumbleweed/?type=desktop#download) via Novell took from 2005-2009
  - Canonical maintained since 2009
- May be default for Debian distros and [Manjaro](https://manjaro.org/download/) (not [Arch](https://archlinux.org/download/))
- **Security profiles** for programs
- Considered "easier" for admins to onboard than SELinux (debated)
- Filesystem-neutral (no context labels)
- Allows "learning/complaining" mode: not enforced, but logged to create new **security profiles**
  - Comparable to SELinux "permissive" mode
- Runs as a service controlled by `systemctl`

### Service Status
- `systemctl status apparmor`
- `apparmor_status`

### Modes & Profiles
- Profiles' location:
  - `/etc/apparmor.d`
  - Installed with `apparmor-profiles` package
    - Or per distro
    - Or by individual packages as they are installed
- `man apparmor.d`
- Modes **enforce** or **compalin** apply to each executable program
  - `aa-complain` set AppArmor mode to **complain**
  - `aa-enforce` set Apparmor mode to **enforce**

### AppArmor Utilities
- `ls -l /usr/bin/aa-*` - AppArmor utilities
- See their `man` descriptions: `for aa in aa-*; do man -k $aa; done`
  - Output:
```
aa-audit (8)         - set an AppArmor security profile to audit mode.
aa-autodep (8)       - guess basic AppArmor profile requirements
aa-cleanprof (8)     - clean an existing AppArmor security profile.
aa-complain (8)      - set an AppArmor security profile to complain mode.
aa-decode (8)        - decode hex-encoded in AppArmor log files
aa-disable (8)       - disable an AppArmor security profile
aa-easyprof (8)      - AppArmor profile generation made easy.
aa-enabled (1)       - test whether AppArmor is enabled
aa-enforce (8)       - set an AppArmor security profile to enforce mode from being disabled or complain mode.
aa-exec (1)          - confine a program with the specified AppArmor profile
aa-features-abi (1)  - Extract, validate and manipulate AppArmor feature abis
aa-genprof (8)       - profile generation utility for AppArmor
aa-logprof (8)       - utility for updating AppArmor security profiles
logprof.conf (5)     - configuration file for expert options that modify the behavior of the AppArmor aa-logprof(1) program.
aa-mergeprof (8)     - merge AppArmor security profiles.
aa-notify (8)        - display information about logged AppArmor messages.
aa-remove-unknown (8) - remove unknown AppArmor profiles
aa-status (8)        - display various information about the current AppArmor policy.
aa-teardown (8)      - unload all AppArmor profiles
aa-unconfined (8)    - output a list of processes with tcp or udp ports that do not have AppArmor profiles loaded
```

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

- **These commands should be attempted on practice machines, such as via [Oracle VirtualBox](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/VirtualBox.md), using:**
  - ***CentOS Stream* with SELinux** for **SELinux** command practice
    - Simple Virtualbox SELinux option is *PCI-DSS (Payment Card Industry Data Security Standard)* because it doesn't have partition mounting requirements
  - ***Debian*** or ***OpenSUSE*** for **AppArmor** command practice

| **SELinux** :$ *CentOS Stream*

```console
sudo -i

ls -l /etc/selinux/config
ls -l /etc/sysconfig/selinux

grep SELINUX= /etc/selinux/config
grep SELINUX= /etc/sysconfig/selinux
grep selinux= /boot/grub/grub.cfg

chcat -L
cd /etc/selinux
find . -name setrans.conf
cat /etc/selinux/targeted/setrans.conf
cd /etc/selinux/targeted/contexts
ls
cd /etc/selinux/targeted/contexts/users
ls
cd /etc/selinux/targeted/contexts/files
ls

sestatus
getenforce

ls /etc/selinux/ | wc -l
ls -l /etc/selinux/
setenforce Permissive
getenforce
setenforce Enforcing
getenforce

ps auZ
ps axZ
ls -Z
ls -aZ

mkdir /srv/lv
cd /srv/lv
touch onefile otherfile
ls -Z
chcon -t etc_t onefile
ls -Z
chcon --reference=onefile otherfile
ls -Z
touch levelfile
chcon -l s12 levelfile
ls -Z
chcon -t s5:c14 levelfile
ls -Z
chcat -- +c5 levelfile
ls -Z
chcat -- +s7,-c14 levelfile
ls -Z
chcat -l -- +s15 someuser
chcat -L
chcat -- +SystemLow levelfile
ls -Z
chcat -- +SystemHigh,-SystemLow levelfile
ls -Z

cd /
ls -Z
ls -lZ
ls -aZ
ls -lZ /home/
ls -lZ /tmp/
ls -lZ /home/ /tmp/

cd /tmp/
touch tmpfile
ls -Z

cd
touch homefile
ls -Z homefile
mv /tmp/tmpfile .
ls -Z
restorecon -Rv tmpfile
ls -Z

dnf install seinfo
seinfo -t # choose a type for below (to replace httpd_tmp_t), not all types will work
mkdir /srv/vm
ls -Z /srv
semanage fcontext -a -t httpd_tmp_t /srv/vm
ls -Z /srv
restorecon -RFv /srv/vm
ls -Z /srv
touch /srv/vm/somefile
semanage fcontext -a -t httpd_tmp_t /srv/vm/somefile
ls -Z /srv/vm
restorecon /srv/vm/somefile
ls -Z /srv/vm

getsebool -a
getsebool ftpd_anon_write

setsebool ftpd_anon_write on
semanage boolean -l | grep ftpd_anon_write

setsebool -P ftpd_anon_write on
semanage boolean -l | grep ftpd_anon_write

ls -l /var/log/audit/audit.log
ls -l /var/log/messages
dnf install setroubleshoot-server
ls -l /var/log/audit/audit.log
ls -l /var/log/messages
sealert

echo 'Wrong place' > /root/rootfile
mv /root/rootfile /srv/www/html/
wget -O - localhost/rootfile
tail /var/log/messages

exit
```

| **AppArmor** :$ *Debian* or *OpenSUSE*

```console
su

apparmor_status
systemctl status apparmor
systemctl stop apparmor
apparmor_status
systemctl start apparmor
systemctl status apparmor
apparmor_status

ps aux

ls /etc/apparmor.d | wc -l
ls -l /etc/apparmor.d

# OpenSUSE
rpm -qil apparmor-utils | grep bin
zypper install apparmor-utils

# Debian
apt install apparmor-profiles
apt install apparmor-utils
dpkg -L apparmor-utils | grep bin


cd /etc/apparmor.d
ls -l
ls /usr/sbin/*complain | wc -l
ls -l /usr/sbin/*complain
ls /usr/bin/aa-* | wc -l
ls -l /usr/bin/aa-*

aa-complain git
aa-enforce git
aa-complain git

man apparmor.d

exit
```

___

#### [Lesson 12: Backup & System Rescue](https://github.com/inkVerb/vip/blob/master/601/Lesson-12.md)