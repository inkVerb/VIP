# Linux 601
## Lesson 8: Packages

# The Chalk
## Architecture & Compiling
- Different Linux "**distributions**" (distros) have different "**architecture**"
  - An **architecture** defines the layout and behavior of a **distro**
  - Many times, the terms **distro** and **artitecture** are used interchangeably, but they are not identical
  - Directories and files may have different names and locations in `/etc/`, `/usr/lib/`, `/srv/`, or `/var/`
  - These also may use different package managers
- Programs are written in human-readable language, like C, Python, Go, or BASH
- **Compiled** programs have been converted to computer **binary** code, which humans cannot read
  - Once compiled, returning to human-readable code is nearly impossible
- Programs can run if not compiled through **interpreters** (compile while reading), listed on the first line of a script
  - BASH: `#!/bin/bash`
  - PHP: `<?php`
  - HTML: `<!DOCTYPE html>`
  - XML: `<?xml version="1.0" encoding="UTF-8"?>`
- Some programs *must* be compiled
- Scripts often run by interpreters (HTML, BASH, XML) *may* also be compiled
- So: programs are either **compiled** or **interpreted**

## Package Managers
- Benefits:
  - Automated
  - Scalable
  - Duplicatable
  - Predictable
  - Secure
  - Consistent
- Package Concepts:
  - Single package
  - Dependencies known and automated
  - Easy installation and removal
  - Verify download integrity and origin
  - Handle upgrades
  - Grouping by logical features
  - Versioning
  - Update handling
- Package Contents:
  - Executable files
  - Libraries and data
  - Documentation
  - Installation scripts
  - Configuration files
- Package Types:
  - **Binary**: pre-compiled, distro-specific
  - **Source**: not compiled, from vendor, not distro-specific
  - **Distro-Independent**: uncompiled scripts, docs, and configs
  - **Meta/Group-Packages**: basic architecture, multiple packages: ie desktop environment, office suite ([read more](https://wiki.archlinux.org/title/Meta_package_and_package_group))
  - *Binary packages are most common for package managers*
- Package Repositories: (**repos**)
  - Servers with information for installing packages
  - May host binaries
  - May direct where to download binaries from
  - May host or direct to scripts to compile and install source packages
  - Distro/architecture-specific (some distros may share the same repositories)
  - Types of Repositories:
    - Native (default and come active on each distribution)
    - Extended (known by the distro's architecture, but not active by default)
    - Custom (must be manually added by the SysAdmin)
  - Arch only uses two repositories:
    - [Arch "Official" Repository](https://wiki.archlinux.org/title/official_repositories) - "stable" is only repo active by default (mainly binary, grouped, and meta packages, few optional repos also available ie 32bit, testing, staging, etc)
      - `pacman` package manager
    - [Arch User Repository](https://aur.archlinux.org/) - community maintained (some binary, but mostly source packages with compile and installation scripts)
      - `yay` AUR package "helper" (compiler and/or source install scripts)
  - [Ubuntu uses four repositories](https://help.ubuntu.com/community/Repositories/Ubuntu):
    - **Main** - only repo active by default upon installation
    - **Universe** - community maintained
    - **Restricted** - proprietary drivers
    - **Multiverse** - having licensing/legal restrictions
    - Other custom repos may be added manually, usually maintained directly by software vendors specifically for Ubuntu/Debian
    - `apt-get` & `apt` package managers
  - CentOS/Fedora (RHEL - Red Hat Enterprise Linux) uses some free and some proprietary repositories
    - BaseOS
    - AppStream
    - EPEL (Extra Packages for Enterprise Linux)
    - `dnf` package manager
  - SUSE
    - `zypper` package manager
- ***Always know how to rebuild packages from source***
  - Eg `rpm`: `rpmbuild --rebuild -rb package-00.00.00.src.rpm` with results appearing in `/root/rpmbuild/`
  - Eg `makepkg`: 
- Package Tools:
  - **Low level**: minimal installs, dependencies cause warnings or errors
    - `dpkg` (Debian)
    - `rpm` (Red Hat)
    - `makepkg` ([Arch](https://wiki.archlinux.org/title/makepkg) compile helper, [explanation](https://unix.stackexchange.com/questions/605928))
  - **High level**: resolves dependencies, handle low-level package tools
    - **`rpm`**: `zypper`, `dnf`, (legacy `yum`)
    - **`dpkg`**: `apt`, `apt-get`, `apt-cache`
    - **`makepkg`**: `pacman`, `yay`
  - *SysAdmins should know how to use both high and low level tools for their distros!*
- Package Formats:
  - `.deb` - Debian/Ubuntu
  - `.rpm` - CentOS/Fedora/RHEL & SUSE
  - `.pkg.tar.zst` - [Arch Linux](https://wiki.archlinux.org/title/creating_packages) (tarballs handled manually)
    - [Arch can install both](https://superuser.com/questions/1312946/) `.deb` and `.rpm` because it has a minimalist architecture
    - `.deb` - via `debtap` [AUR package](https://aur.archlinux.org/packages/debtap)
    - `.rmp` - [somewhat more involved](https://unix.stackexchange.com/questions/115245/)
  - `.tgz` - Slackware (tarballs handled manually)
  - `.apk` - Android
- Revision Control Systems (AKA Source Control Systems)
  - [GitHub](https://github.com) - most widely used, hosts Linux source
  - [Subversion](https://subversion.apache.org/) (SVN) - hosts WordPress plugins
  - [Concurrent Versions System](https://cvs.nongnu.org/) (CVS)
  - [Revision Control System](https://www.gnu.org/software/rcs/) (GNU RCS)
  - [Mercurial](https://www.mercurial-scm.org/)
  - [Monotone](https://www.monotone.ca/)
  - [GNU Arch](https://www.gnu.org/software/gnu-arch/) - discontinued

### `dpkg` (`apt` Debian)
#### `dpkg`
- Dependency/conflict unaware
- Blocks install/remove action that would cause problems
- `.deb` files downloaded to `/var/lib/dpkg/`
  - `NAME_VERSION-REVISION_ARCHITECTURE.deb`
- Contains:
  - `.tar.gz` tarball from upstream (vendor, compiled source, etc)
  - `.dsc` description file
  - `.debian.tar.gz` or `.diff.gz` tarball patches and files created
- View `.deb` package with: `apt-get source`
  - `apt-get source package-name && ls`
- Some queries: #
  - `dpkg -s dpkg | grep -i Version` (`-i` for Ignore case)
  - `dpkg -V` verify all installed packages
  - `dpkg -V package-name` verify `package-name` package integrity
  - `dpkg -l` list all installed packages
  - `dpkg -L wget` list packages installed via `wget`
  - `dpkg -s package-name` output info about `package-name` package
  - `dpkg -I some_package-name_amd64.deb` info about package file, probably in `/var/lib/dpkg/`
  - `dpkg -c some_package-name_amd64.deb` contents of package file, probably in `/var/lib/dpkg/`
  - `dpkg -S /etc/openldap/slapd.conf` list package that owns `/etc/openldap/slapd.conf`
  - `dpkg -r package-name` remove (uninstall) `package-name`, keep config files
  - `dpkg -P package-name` remove (uninstall) `package-name`, purge config files

#### `apt` (Advanced Packaging Tool)
- Based on `dpkg`
- Dependency/conflict aware and resolving
- Mainly uses `apt-get` and `apt-cache`
  - `apt-get` pagkage manager (technical, SysAdmin-friendly, better automation for scripts)
  - `apt` pagkage manager (more user-friendly, may be interactive)
  - `apt` extentions may be able to work with some `.rpm` files
- Some queries: #
  - `apt-file update` update `apt-file` tool (`apt-file` may need installing first)
  - `apt-get install package-name` install `package-name`
  - `apt-cache search package-name` search repositories for `package-name`
  - `apt-cache show package-name` info for `package-name`
  - `apt-cache showpkg package-name` detailed info for `package-name`
  - `apt-cache depends package-name` dependencies for `package-name`
  - `apt-file search somefile.conf` search repositories for `somefile.conf`
  - `apt-file list package-name` list files in `package-name` package
  - `apt install package-name` install `package-name` package
  - `apt install package-name -y` install `package-name` package non-interactive
  - `apt remove package-name` remove `package-name` package
  - `apt remove package-name -y` remove `package-name` package non-interactive
  - `apt --purge remove package-name` remove and purge `package-name`
  - `apt update` retrieve list of available updates and package version numbers (or `apt-get update`)
  - `apt upgrade` install available updates (or `apt-get upgrade`; `update` is prerequisite)
  - `apt dist-upgrade` upgrade distro, but not entirely
  - `apt autoremove` remove packages no longer needed (clean the downloaded, installed package files, probably from `/var/lib/dpkg/`)
  - `apt clean` cleans archived package files, if not in the normal download location

### `rpm` (`dnf` RedHat & `zypper` OpenSUSE)
#### `rpm` (RedHat Package Manager)
- Installs only from local files unless an absolute path is given for a package
- Knows, but does not resolve dependencies
- `.rpm` files
  - Standard package: `NAME-VERSION-RELEASE.DISTRO.ARCHITECTURE.rpm`
  - Source package: `NAME-VERSION-RELEASE-DISTRO.src.rpm`
  - `-DISTRO.` often identifies repository
  - Include much information to install, remove, find versions, completely remove, separately install docs
  - Not downloaded; no download-to location
- RPM databases at: `/var/lib/rpm/`
  - Stored as Berkeley DB hash files
  - :# `rpm --rebuilddb` rebuild the database
  - :# `rpm --dbpath ...` specifies specific database (in other directory)
- RPM helper tools and scripts: `/usr/lib/rpm/`
  - `rpmrc` file sets defaults for `rpm`, *all* are read in this order:
    1. `/usr/lib/rpm/rpmrc`
    2. `/etc/rpmrc`
    3. `~/.rpmrc`
    - Specify using `--rcfile`
- Some `-q` (query) co-flags: (ie `-qa`)
  - `-q` (`-q` alone) query installed package version
  - `-a` all installed packages
  - `-f` what package a file came from (`rpm -qf  /bin/mv`)
  - `-i` package info (`rpm -qi git`)
  - `-l` list contents of a specific file
  - `-p` query package file, not package database
  - `--requires` - list dependencies/prerequisites
  - `--whatprovides` - which package meets a requisite
- Some `-V` (verify) co-flags: (ie `-Va`)
  - `-a` -all packages on system
  - `-5` MD5 differs
  - `-S` file size differs
  - `-T` mtime differs
  - `-D` dev major/minor number differs
  - `-M` mode differs (permissions)
  - `-L` readlink path doesn't match
  - `-U` user ownership differs
  - `-G` group ownership differs
  - No output = no errors (no `STDOUT`, only `STDERR`; `$?` = `0`)
- Some `-i` (install) & `-e` (erase) flags
  - `-v` verbose
  - `-h` progress hash marks (as in `########`)
  - `--test` see if it would succeed or fail & what errors would be reported
- Some queries: #
  - `rpm -ivh NAME-VERSION-RELEASE.DISTRO.ARCHITECTURE` installs
  - Replaced config files are saved as `.rpmsave`
  - If no need to replace config files, new potential files are saved as `.rpmnew`
  - `rpm -e package-name` erase (remove/uninstall)

#### `dnf` (RedHat: CentOS/Fedora)
- Replaced `yum`; mostly backward compatible
- Installs from repositories
- Resolves dependencies
- Packages downloaded to: `/var/cache/dnf/`
- Repo configs: `/etc/yum.repos.d/*.repo`

| **dnf-example.repo** :

```
[repo-name]
name=Pretty name of repo
baseurl=http://example.com/path/to/repo
enabled=1
gpgcheck=1
```
- Some queries: #
- `dnf --disablerepo repo-name` sets `enabled=0` in `.repo` config
- `dnf --enablerepo repo-name` sets `enabled=1` in `.repo` config
- `dnf search findword` search for "findword"
- `dnf info package-name` info about `package-name` package
- `dnf list installed|updates|available` list either of the arguments
- `dnf grouplist` info on installed package groups & available updates
- `dnf groupinfo package-group` info on specific `package-group` package group
- `dnf provides /path/to/some/file` list package that owns `/path/to/some/file`
- `dnf install package-name` install `package-name` package
- `dnf localinstall package-file-name` install from local file `package-file-name.rpm`
- `dnf groupinstall 'package-group` install software group `package-group`
- `dnf remove package-name` remove `package-name` package
- `dnf update` update all installed packages from their repos
- `dnf update package-name` update specific package `package-name` from its repo
- `dnf list "dnf-plugin*"` list all `dnf` plugins
- `dnf repolist` list enabled repos
- `dns shell` enter interactive `dnf` shell
- `dnf shell shellfile.txt` executes `dnf` shell script file in its own `dnf` shell
- `dnf install --downloadonly package-name` only download `package-name` package to `/var/cache/dnf/`
- `dnf history` history of `dnf` commands
- `dnf clean packages|metadata|expired-cache|rpmdb|plugins|all` clears installed packages from `/var/cache/dnf/`

#### `zypper` (OpenSUSE)
- Installs from repositories
- Resolves dependencies
- Downloads packages to: `/var/cache/zypp/`
- Some queries: #
  - `zypper list-updates` list available updates
  - `zypper repos` list available repos
  - `zypper search findword` search for "findword"
  - `zypper info package-name` info about `package-name` package
  - `zypper search --provides /path/to/some/file` list package that owns `/path/to/some/file`
  - `zypper install package-name` install `package-name` package
  - `zypper install packagename --non-interactive` install `package-name` package non-interactive
  - `zypper update` update all packages
  - `zypper update --non-interactive` update all packages non-interactive
  - `zypper remove package-name` remove `package-name` package
  - `zypper shell` enter interactive `zypper` shell
  - `zypper addrepo http://example.com/path/to/repo some-alias-repo-name` add a repo with `some-alias-repo-name` as your custom repo nickname
  - `zypper removerepo some-alias-repo-name` remove the repo nicknamed `some-alias-repo-name`
  - `zypper clean --all` clears installed packages from `/var/cache/zypp/`

### `pacman` & `yay` (Arch)
- *`pacman` and `yay` are not built one atop the other, as stacks are with `dpkg` and `rpm`*
- Both based on the work of `makepkg` (see [Arch makepkg site](https://wiki.archlinux.org/title/Makepkg))
  - Simplifies Arch package compiling steps [from same explanation as above](https://unix.stackexchange.com/questions/605928))
  - Basically, `makepkg` looks at `PKGBUILD`, then runs whatever is needed, probably something like:
```
configure
make
make install DESTDIR=/usr
```
  - or `cmake` or `cargo` or `npm --build` etc (see an [article on make vs makepkg](https://unix.stackexchange.com/questions/605928/))
  - Results in a "proper" Arch package file that can be handled locally by `makepkg -i` (or `pacman -U package-file.pkg.tar.zst` just the same)
- `pacman` handles packages from the [Official Arch repositories](https://wiki.archlinux.org/title/official_repositories)
- `yay` handles packages from the [Arch User Repository (AUR)](https://aur.archlinux.org/)
- An Arch SysAdmin must know which package is from which repo

#### `pacman`
- *The native Arch Linux package manager*
- Handles packages from the [Official Arch repositories](https://wiki.archlinux.org/title/official_repositories)
- Built on `makepkg` output using the [Arch build system](https://wiki.archlinux.org/title/Arch_build_system)
  - Resolves dependencies
  - Uses standard [Arch package guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)
- Downloads packages to: `/var/cache/pacman/pkg/`
- Package files: `PACKAGE_NAME-VERSION.pkg.tar.zst`
- Repos listed in `/etc/pacman.conf`
  - Repo entry examples: `core` and `extra`

| **from /etc/pacman.conf**:
```
[core]
SigLevel = PackageRequired
Include = /etc/pacman.d/mirrorlist

[extra]
SigLevel = PackageRequired
Include = /etc/pacman.d/mirrorlist
```
- Uses official packages by default, which more or less don't need extensive compiling
- Each package is:
  - Built on a `git` repo, main repo is the [Arch Linux GitLab Packages](https://gitlab.archlinux.org/archlinux/packaging/packages) site
  - Contains a [PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD) file with `make` instructions used by `makepkg`
- Read the official Arch `pacman` usage [Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
- Main queries: #
  - Option `--noconfirm` option answers "yes" or "default" to any interactive prompts
  - Option `--needed` chooses the most needed option if for interactive prompts, which `--noconfirm` may not have an answer for
  - Options `--noconfirm --needed` the surest way to be non-interactive
  - `pacman -Ss findword findotherword` search for words `findword` and `findotherwordd` etc
  - `pacman -Qs findword` search for installed packages for `findword`
  - `pacman -Sy archlinux-keyring` updates the keyring (needed if too long without software updates)
  - `pacman -Syy` update package version lists
  - `pacman -Syyu` update main repo packages (update version lists, then install updates)
    - Only one `-y` is needed as an `-S` subflag; two `-y` subflags will force an upgrade of package lists even if they seem up-to-date
  - `pacman -S package-name` install `package-name` package
  - `pacman -Syy package-name` update all repo lists, then install `package-name` package
  - `pacman -U package_name-version.pkg.tar.zst` manually install `package_name-version.pkg.tar.zst` from that downloaded file
  - `pacman -Scc` clean cache
  - `pacman -Rsc` remove unneeded dependencies
  - `pacman -Qe` list explicitly-installed packages
  - `pacman -Ql package-name` what file the `package-name` package has
  - `pacman -Qii package-name` info on `package-name` package
  - `pacman -Qo /path/to/some/file` list package that owns `/path/to/some/file`
  - `pactree package-name` what the `package-name` package depends on
  - `pactree -r package-name` what depends on the `package-name` package

#### `yay` (Yet Another Yogurt)
- *[Yay, written in Go, from Jguer](https://github.com/Jguer/yay/blob/next/README.md)*
  - *Must be installed manually, see [Installation instructions](https://github.com/Jguer/yay/blob/next/README.md#installation*
- Handles packages from the [Arch User Repository (AUR)](https://aur.archlinux.org/)
- May employ `makepkg` as needed to create `makepkg -i` -ready packages compliant with the [Arch build system](https://wiki.archlinux.org/title/Arch_build_system)
  - Resolves dependencies
  - Uses standard [Arch package guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)
- Downloads packages to: `~/.cache/yay/`
- All packages are listed on the AUR in `https://aur.archlinux.org/packages/`
  - Download and `makepkg` information is in `PKGBUILD`, so additional repo settings are not needed
- An [AUR helper](https://wiki.archlinux.org/title/AUR_helpers), which largely substitutes for `pacman`, but:
  - May compile some programs more extensively from source
  - Handles more diverse `PKGBUILD` instructions depending on what a source code needs
  - *Must not be run with `sudo` or as `root`!*
    - Because this often compiles source code, which requires a normal user
    - Compiling as `root` can create many strange permissions-related issues
    - Installing on the [Linux FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) requires `root` or `sudo`, but not compiling code itself
    - This can create a trouble, which is why inkVerb (this VIP Linux class maintainer) wrote the ([yeo tool](https://github.com/inkVerb/yeo/blob/main/README.md))
- There are many [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers) other than `yay`:
  - `aura`
  - `pacaur`
  - `pakku`
  - `pamac`
  - `trizen`
  - ...
  - *This is why `yay` stands for "Yet Nother Yogurt", all helpers should basically do the same thing: read `PKGBUILD` and run `makepkg`*
- Main queries: $ *(Must run as normal user!)*
  - Many `pacman` standard flags also apply, but not `--needed`
  - `yay` alias for `yay -Syu`
  - `yay -Ps` print system stats for yay
  - `yay -G aur-package-name` get (download) AUR package
  - `yay -Gp` print to STDOUT the `PKGBUILD` from AUR
  - `yay -Bi dir/path` install dependencies and build from `PKGBUILD` in `dir/path`
  - `yay -Yc` clean unneeded dependencies
  - AUR voting (yes, it does)
    - Requires `AUR_USERNAME` and `AUR_PASSWORD` in the environment
    - `yay -Wv` vote up for package
    - `yay -Wu` unvote for package
  - If `sudo` gives trouble, try `--sudoflags "-A"` (at your own risk)

#### `makepkg` - Finalize local packages for `pacman -U`
- [makepkg Arch Wiki](https://wiki.archlinux.org/title/makepkg)
- Creates the package tarball in PWD
- `makepkg` with prper `PKGBUILD` file in PWD
  - Results in `package_name-version.pkg.tar.zst` in PWD with file name as `PKGBUILD` instructed
- `makepkg -i` in PWD containing `package_name-version.pkg.tar.zst` (same as `pacman -U ./package_name-version.pkg.tar.zst`)
- `makepkg -c` clean up leftover files & directories after install (right after `makepkg -i` in same PWD)
- *`makepkg` does not use `sudo`, but may ask for a password if it needs to call `sudo`*
*So, on those "Download for Linux" areas of our favorite software sites with **Ubuntu .deb** and **RedHat/OpenSUSE .rpm** options, we could try convincing the world to include **Arch .pkg.tar.zst** also, but we don't need to because we can download install those **.deb** files on Arch with `debtap`...*

#### `debtap` - Convert local `.deb` packages for `pacman -U`
- *Only when a package cannot be found via `pacman` or `yay`!*
  - *We don't want conflicts with "proper" packages that Arch already knows how to maintain*
  - ***Use with care!***
- Install [debtap from the AUR](https://aur.archlinux.org/packages/debtap)
  - `yay -S debtap`
  - `sudo debtap -u` (to properly update the `debtap` tool)
- Download and install a `.deb` package
  - `debtap manually-downloaded-package.deb`
  - Now that should create a proper Arch package named something like `manually-downloaded-package.pkg.tar.zst`
- Install with Arch tools, either:
  - `sudo pacman -U manually-downloaded-package.pkg.tar.zst`
  - `makepkg -i` (from the same PWD)

___

# The Type

```console

```

___

#### [Lesson 9: PAM, SSH, LDAP & Docker](https://github.com/inkVerb/vip/blob/master/601/Lesson-03.md)
