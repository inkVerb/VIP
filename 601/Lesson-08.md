# Linux 601
## Lesson 8: Packages

# The Chalk
## Architecture & Compiling
- Different Linux "**distributions**" (distros) have different "**architecture**"
  - An **architecture** defines the layout and behavior of a **distro**
  - *The architecture depends on the **package manager** and how packages are structured*
    - Arch (`pacman`)
    - Debian (`dpkg`)
    - RPM (`rpm`)
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

## Building from Source
- Packages can often be distributed by source
- "Source packages" are technically "GNU packages" because they would work on any Linux distro
  - Remember, Linux is built on GNU, so a "GNU source package" is coded at a lower level of the stack than the Linux kernel itself, hence the term *source*
- Usually a source is a tarball downloaded, extracted, then built
- Building a GNU package from source involves three simple commands
  - Inside the package directory :$
```console
./configure
make
sudo make install
```
- It is important to *only* run `make install` as `root`, not the other commands
  - Running `make` as `root` (AKA :$ `sudo make` or :# `make`) can cause serious problems because it is compiling and then `root` would own the compiled code itself

## Creating Packages
- Packages are easier to understand if you have built a few packages first
- The [Package Architectures Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Package-Architectures.md) lists repositories that break down examples of actual Linux installer packages built from scratch
- They are build with:
  - Arch (`makepkg` for `pacman`)
  - Debian (`dpkg` for `apt-get`)
  - RPM (`rpm` for OpenSUSE `zypper` & for RedHat/CentOS `dnf`)
- This Cheat Sheet is part of this lesson and teaching content
  - Complete that Cheat Sheet before continuing

### [Package Architectures](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Package-Architectures.md) Cheat Sheet
- Take-away points:
  - **Arch** uses a single `PKGBUILD` file in a directory named anything you want
    - Meta info and all scripts: `PKGBUILD`
    - If using source files, these can be anywhere in the same directory
  - **Debian** uses a directory of the package name, containing a `DEBIAN/` subdirectory with a `control` file only for meta info:
    - Meta info only: `DEBIAN/control`
    - Separately in `DEBIAN/`, other files for scripts and lists as needed
      - `conffiles`
      - `postinst`
      - `prerm`
      - `postrm`
      - et cetera
    - Outside the `DEBIAN/` directory:
      - If using source files, files reside in relative paths to `/` where they will be installed
  - **RPM** uses a directory named `rpmbuild/`, containing a `SPECS/` subdirectory with a `.spec` file with all meta info and scripts
    - Meta info and all scripts: `SPECS/package-name.spec`
    - If using source files, a peer `SOURCES/` subdirectory contains source files
  - Steps to prepare packages:
    1. Directory structure, files, and configs are put in preparation directory
    2. Package is prepared with low-level package manager (`makepkg`, `dpkg-deb`, `rpmbuild`)
      - This produces the type of package downloadable in repositories
    3. Package is installed with top-level package manager (`pacman`, `dpkg`/`apt-get`, `rpm`/`zypper`/`dnf`)
  - Significant differences:
    - Arch is most simple
    - Debian is most functional
    - RPM is most elaborate
    - Arch does not usually handle post-install scripts, including `systemctl` commands, unlike Debian and RPM
    - RPM will "purge" any config files on every removal, unlike Arch and Debian

## Package Managers
- The game-changing difference in a Linux distibution's "architecture"
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
- Package Repositories: "**repos**"
  - Servers with information for installing packages
  - May host binaries
  - May direct where to download binaries from
  - May host or direct to scripts to compile and install source packages
  - Distro/architecture-specific (some distros may share the same repositories)
  - Types of Repositories:
    - Native (default and come active on each distribution)
    - Extended (known by the distro's architecture, but not active by default)
    - Custom (must be manually added by the SysAdmin)

### Per Distro
#### Arch
- Arch only uses two repositories:
  - [Arch "Official" Repository](https://wiki.archlinux.org/title/official_repositories)
    - `pacman` package manager
    - "stable" is only repo *channel* active by default
      - *(mainly binary, grouped, and meta packages)*
    - *(few optional repos channels also available ie 32bit, testing, staging, etc)*
    - Packages are ready-to-install
  - [Arch User Repository (AUR)](https://aur.archlinux.org/)
    - community maintained
      - *(some binary, but mostly source packages with compile and installation scripts)*
    - `yay` AUR package "helper" (compiler and/or source install scripts)
      - "Yet Another Yogurt"
      - See the `yay` [GitHub project repository](https://github.com/Jguer/yay/blob/next/README.md)
      - Must be [installed manually](https://github.com/Jguer/yay/blob/next/README.md#installation)
      - There are many other package "helpers" in addition to `yay`; in 2024 `yay` is favored and well-supported
    - Packages need preparation in different amounts, depending on the source from the vendor
      - Generally, if you are a software developer or an enthusiast, and your software is not in the Arch Official Repository, then you can write a package to go here so it is easy to install on Arch
  - Both use `makepkg` under the hood
- Arch also has security distro, which uses its own repositories, still `pacman` and `yay`
  - These are used by security proffessionals for penetration and security testing:
    - (Arch Linux pen-testing, comparable to Kali Linux)
      - Both use Arch Linux under the hood and are bonafied Arch
    - [ArchStrike](https://archstrike.org/)
      - Bootstraps packages ("[the Arch way](https://wiki.archlinux.org/title/Arch_terminology#The_Arch_Way)")
      - Customizable nicely alongside standard Arch 
      - More stable
    - [BlackArch](https://blackarch.org/)
      - Hand-rolled packages
      - Has approx 10GB `.iso` to install fully offline
      - Could get bloated
- Only Arch uses different package manager *commands* (ie `pacman` vs `yay`) for different repositories
  - This is because of how the repositories are structured
- *Arch and its security-testing distros are all good for learning `makepkg`, `pacman`, and `yay`*

#### Debian
- Debian's main distro stack is Ubuntu (from [Canonical](https://canonical.com/))
- [Ubuntu uses four repositories](https://help.ubuntu.com/community/Repositories/Ubuntu):
  - **Main** - only repo active by default upon installation
  - **Universe** - community maintained
  - **Restricted** - proprietary drivers
  - **Multiverse** - having licensing/legal restrictions
  - Other custom repos may be added manually, usually maintained directly by software vendors specifically for Ubuntu/Debian
- `apt-get` & `apt` package managers
- Use `dpkg` under the hood
- Debian also has security distro, which uses [its own repositories](https://www.kali.org/docs/general-use/kali-linux-sources-list-repositories/), still `dpkg`, `apt`, and `apt-get`
  - [Kali](https://www.kali.org/)
    - Kali Linux is maintained by [OffSec (Offensive Security)](https://www.offsec.com/)
    - This is used by security proffessionals for penetration and security testing
    - A fork from Debian; functions much the same, but is ***not*** using Debian under the hood!
- *Kali and Ubuntu are both good for learning `dpkg`, `apt`, and `apt-get`*

#### RedHat
- [RedHat](https://www.redhat.com/)'s main Linux distros are:
  - [CentOS](https://www.centos.org/) (free, project by RedHat)
  - [Fedora](https://fedoraproject.org/) (free, project by community, funded by RedHat)
  - [RHEL (RedHat Enterprise Linux)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) (enterprise, RedHat flagship project)
- RedHat distros use some free and some proprietary repositories
  - BaseOS
  - AppStream
  - EPEL (Extra Packages for Enterprise Linux)
  - `dnf` package manager
  - Uses `rpm` (RedHat Package Manager) under the hood

#### OpenSUSE
- [OpenSUSE](https://www.opensuse.org/) is the main Linux distro used by the Linux developers
  - `zypper` package manager
  - Uses `rpm` under the hood

#### Android
- [Android](https://www.android.com/) is the popular smartphone Linux distro
- Uses its own package manager called [Package Manager](https://developer.android.com/reference/android/content/pm/PackageManager)
- As of Linux v2.6.33, Android is [no longer in the Linux kernel](https://kernelnewbies.org/Linux_2_6_33#Android_removed_from_the_Linux_kernel)

> Google doesn't seem to have interest in improving the Android drivers to have minimum quality standards which could allow to merge them in the main Linux tree and share them with the rest of community. Of course, that's totally legal, but it's sad that a project that is doing so much to bring open source to the masses has become an example of how not to interact with an open source community.

- Recommended article: [Android and the Linux kernel community // Linux Kernel Monkey Log](http://www.kroah.com/log/linux/android-kernel-problems.html) *Thu, 09 Dec 2010*

> ...code in the staging tree needs to be worked on to be merged to the main kernel tree, or it will be deleted. ...
> 
> The Android kernel code is more than just the few weird drivers that were in the drivers/staging/android subdirectory in the kernel. In order to get a working Android system, you need the new lock type they have created, as well as hooks in the core system for their security model.
> 
> In order to write a driver for hardware to work on Android, you need to properly integrate into this new lock, as well as sometimes the bizarre security model. ...
> 
> This means that any drivers written for Android hardware platforms, can not get merged into the main kernel tree because they have dependencies on code that only lives in Google's kernel tree, causing it to fail to build in the kernel.org tree.

- This is an important example of how and why software developers split in different directions
- Android is still build on Linux, even while its drivers are not included in the official Linux kernel

#### Others
- [Homebrew](https://brew.sh/) is a popular package manager for Apple Macintosh systems
- [Snap](https://snapcraft.io/) from [Canonical](https://canonical.com/) is a cross-platform package manager that installs and runs packages in containers
  - In theory, the commands and structure will remain the same across Linux architectures
  - It's packages are fully "contained", meaning it is not architecture/distro dependent
  - It keeps running processes in isolated containers to prevent one crashed app from crashing the entire system
  - But, in 2024, `snap` still has a problem:
    - Best used on a high traffic server running a handful of vital processes
    - It can be heavy on system resources needed just to maintain one container per app
    - Not ideal for non-critical small home/office budget desktop machines running many apps
      - Apps on a home or office machine (even for gaming or proffessional software) are unlikely to crash without reason
      - Running containers for every desktop app will slow the app startup and the entire machine, adding to risk of a system-wide crash
      - If apps crash on a home or office system, usually a reboot solves it, not as problematic as on a production server

### High and Low Levels of the PM Stack
- Package managers employ other tools
- ***Always know how to build packages from source***
  - Arch `makepkg`: in PWD where a proper `PKGBUILD` file resides, `.pkg.tar.zst` appearing in same PWD
  - Debian `dpkg`: `dpkg-deb --build package` where `package` is the directory of the package, with `.deb` results appearing in PWD
  - RPM `rpm`: `rpmbuild -ba ~/rpmbuild/SPECS/package.spec` with `.rpm` results appearing in `rpmbuild/`
- Package Tools:
  - **Low level**: minimal installs, dependencies cause warnings or errors
    - `dpkg` (Debian)
    - `rpm` (RedHat)
    - `makepkg` ([Arch](https://wiki.archlinux.org/title/makepkg) compile helper, [explanation](https://unix.stackexchange.com/questions/605928))
  - **High level**: resolves dependencies, handle low-level package tools
    - **`dpkg`**: `apt`, `apt-get`, `apt-cache`
    - **`rpm`**: `zypper`, `dnf`, (legacy `yum`)
    - **`makepkg`**: `pacman`, `yay`
  - *SysAdmins should know how to use both high and low level tools for their distros!*

### Package Formats
- `.deb` - Debian (Ubuntu & Kali)
- `.rpm` - RedHat/CentOS (RHEL & Fedora) & OpenSUSE
- `.pkg.tar.zst` - [Arch](https://wiki.archlinux.org/title/creating_packages) (tarballs handled manually)
  - via :$ `sudo pacman -U package-name-VERSION.pkg.tar.zst`
  - [Arch can install both](https://superuser.com/questions/1312946/) `.deb` and `.rpm` because it has a minimalist architecture
  - `.deb` - via [`debtap` AUR package](https://aur.archlinux.org/packages/debtap) to create Arch `.pkg.tar.zst` package
  - `.rmp` - [somewhat more involved](https://unix.stackexchange.com/questions/115245/)
- `.tgz` - [Slackware](http://www.slackware.com/) (tarballs handled manually)
- `.apk` - [Android](https://www.android.com/)

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
  - Results in a "proper" Arch package file that can be handled locally by `makepkg -i` (or `pacman -U package-name-VERSION.pkg.tar.zst` just the same)
- `pacman` handles packages from the [Official Arch repositories](https://wiki.archlinux.org/title/official_repositories)
- `yay` handles packages from the [Arch User Repository (AUR)](https://aur.archlinux.org/)
- An Arch SysAdmin must know which package is from which repo

#### `pacman`
- *The native Arch Linux package manager*
- Handles packages from the [Official Arch repositories](https://wiki.archlinux.org/title/official_repositories)
- Built on `makepkg` output using the [Arch build system](https://wiki.archlinux.org/title/Arch_build_system)
  - Resolves dependencies
  - Uses standard [Arch package guidelines](https://wiki.archlinux.org/title/Arch_package_guidelines)
- Downloads packages to `/var/cache/pacman/pkg/`
- Package files `package-name-VERSION.pkg.tar.zst`
- Repos listed in `/etc/pacman.conf`
  - [**ArchStrike** can be setup on a current Arch distro](https://archstrike.org/wiki/setup) by motifying this `pacman.conf` file
  - Repo entry examples: `core` and `extra`

| **from /etc/pacman.conf** :

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
  - `package-name-VERSION.pkg.tar.zst` is a likely name of an actual Arch package file
- Read the official Arch `pacman` usage [Tips and tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks)
- Main queries :#
  - Option `--noconfirm` option answers "yes" or "default" to any interactive prompts
  - Option `--needed` chooses the most needed option if for interactive prompts, which `--noconfirm` may not have an answer for
  - Options `--noconfirm --needed` the surest way to be non-interactive
    - `-y` sync
    - `-u` upgrade
    - `-w` only download, do not install
    - `-S` install
    - `-Q` query/search
    - `-R` remove
  - `pacman -Ss findword findotherword` search for words `findword` and `findotherwordd` etc
  - `pacman -Qs findinstalledpackage` search for installed packages for `findword`
  - `pacman -Sy archlinux-keyring` updates the keyring (needed if too long without software updates)
  - `pacman -Syy` update package version lists
  - `pacman -Syyu` update main repo packages (update version lists, then install updates)
    - Only one `-y` is needed as an `-S` subflag; two `-y` subflags will force an upgrade of package lists even if they seem up-to-date
    - Generally, if `installing PACKAGE (...) breaks dependency '...' required by OTHERPACKAGE`, just remove the `OTHERPACKAGE` package, then try `-Syyu` again, *but at your own risk!!*
  - `pacman -U package-name-VERSION.pkg.tar.zst` manually install package from `.tar.zst` file
  - `pacman -S package-name` install `package-name` package
  - `pacman -Syy package-name` update all repo lists, then install `package-name` package
  - `pacman -Sw package-name` only download the `.pkg.tar.zst` file for the package to `/var/cache/pacman/pkg/`
  - `pacman -Syuw` upgrade, but only download
  - `pacman -Syuw package-name-VERSION.pkg.tar.zst --noconfirm` upgrade and install `package-name`, but only download
  - `pacman -Su` make upgrades of whatever packages have already been downloaded
  - `pacman -Scc` clean cache
  - `pacman -R package-name` remove the `package-name` package
  - `pacman -Rsn package-name` remove and purge `package-name` (remove any configs and dependencies also)
    - `-Rs` removes unneeded dependencies
    - `-Rn` purges any altered config files (from `backup=()` array in `PKGBUILD` package file)
  - `pacman -Rsc` remove unneeded dependencies
  - `pacman -Qe` list explicitly-installed packages
  - `pacman -Ql package-name` what file the `package-name` package has
  - `pacman -Qii package-name` info on `package-name` package
  - `pacman -Qo /path/to/some/program` list package that owns `/path/to/some/program`
  - `pactree package-name` what the `package-name` package depends on
  - `pactree -r package-name` what depends on the `package-name` package

#### `yay` (Yet Another Yogurt)
- *[Yay, written in Go, from Jguer](https://github.com/Jguer/yay/blob/next/README.md)*
  - *Must be installed manually, see [Installation instructions](https://github.com/Jguer/yay/blob/next/README.md#installation)*
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
    - This can create a trouble, which is why inkVerb (this VIP Linux class maintainer) wrote the ([`yeo` tool](https://github.com/inkVerb/yeo/blob/main/README.md))
- There are many *other* [AUR helpers](https://wiki.archlinux.org/title/AUR_helpers) than `yay`:
  - `aura`
  - `pacaur`
  - `pakku`
  - `pamac`
  - `trizen`
  - ...
  - *This is why `yay` stands for "Yet Nother Yogurt", all helpers should basically do the same thing: read `PKGBUILD` and run `makepkg`*
- Many `pacman` standard flags also apply, but not `--needed`
- *`yay` must always run as normal user!*
- Main unique `yay` queries :$
  - `yay` alias for `yay -Syu`
  - `yay -Ps` print system stats for yay
  - `yay -G aur-package-name` get (download) AUR package
  - `yay -Gp` print to `STDOUT` the `PKGBUILD` from AUR
  - `yay -Bi dir/path` install dependencies and build from `PKGBUILD` in `dir/path`
  - `yay -Yc` clean unneeded dependencies
  - AUR voting (yes, it does)
    - Requires `AUR_USERNAME` and `AUR_PASSWORD` in the environment
    - `yay -Wv` vote up for package
    - `yay -Wu` unvote for package
  - If messages with `sudo` give trouble, try `--sudoflags "-A"` (at your own risk)

#### `makepkg` - Finalize local packages for `pacman -U`
- [makepkg Arch Wiki](https://wiki.archlinux.org/title/makepkg)
- Create the `pacman` package tarball in PWD :$
  - `makepkg` with prper `PKGBUILD` file in PWD
    - Results in `package-name-VERSION.pkg.tar.zst` in PWD with file name as `PKGBUILD` instructed
- Install a `.pkg.tar.zst` file in PWD :$
  - `makepkg -i` in PWD containing `package-name-VERSION.pkg.tar.zst` (same as `pacman -U ./package-name-VERSION.pkg.tar.zst`)
  - `makepkg -c` clean up leftover files & directories after install (right after `makepkg -i` in same PWD)
- *`makepkg` does not use `sudo`, but may ask for a password if it needs to call `sudo`*
*So, on those "Download for Linux" areas of our favorite software sites with **Ubuntu .deb** and **RedHat/OpenSUSE .rpm** options, we could try convincing the world to include **Arch `.pkg.tar.zst`** also, but we don't need to because we can download install those **.deb** files on Arch with `debtap`...*

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
- Some queries :#
  - `dpkg -s dpkg | grep -i Version` (`-i` for Ignore case)
  - `dpkg -V` verify all installed packages
  - `dpkg -V package-name` verify `package-name` package integrity
  - `dpkg -l` list all installed packages
  - `dpkg -L wget` list packages installed via `wget`
  - `dpkg -s package-name` output info about `package-name` package
  - `dpkg -I some_package-name_amd64.deb` info about package file, probably in `/var/lib/dpkg/`
  - `dpkg -c some_package-name_amd64.deb` contents of package file, probably in `/var/lib/dpkg/`
  - `dpkg -S /etc/openldap/slapd.conf` list package that owns `/etc/openldap/slapd.conf`
  - `dpkg -i package-file.deb` manually install package from `.deb` file
  - `dpkg -r package-name` remove (uninstall) `package-name`, keep config files
  - `dpkg -P package-name` remove (uninstall) `package-name`, purge config files

#### `apt` (Advanced Packaging Tool)
- Based on `dpkg`
- Dependency/conflict aware and resolving
- Mainly uses `apt-get` and `apt-cache`
  - `apt-get` pagkage manager (technical, SysAdmin-friendly, better automation for scripts)
  - `apt` pagkage manager (more user-friendly, may be interactive)
  - `apt` extentions may be able to work with some `.rpm` files
- Some queries :# (`-y` flag can be used to make most `apt` and `apt-get` commands non-interactive)
  - `apt list --installed|--upgradeable|--all-versions` list either of the arguments 
  - `apt-file update` update `apt-file` tool (`apt-file` may need installing first)
  - `apt-cache search package-name` search repositories for `package-name`
  - `apt-cache show package-name` info for `package-name`
  - `apt-cache showpkg package-name` detailed info for `package-name`
  - `apt-cache depends package-name` dependencies for `package-name`
  - `apt-file search somefile.conf` search repositories for `somefile.conf`
  - `apt-file list package-name` list files in `package-name` package
  - `apt-get update` retrieve list of available updates and package version numbers (or `apt-get update`)
  - `apt-get upgrade` install available updates (or `apt-get upgrade`; `update` is prerequisite)
  - `apt-get dist-upgrade` upgrade distro, but not entirely
  - `apt-get install package-name` install `package-name`
  - `apt-get install package-name -y` install `package-name` package non-interactive
  - `apt-get remove package-name` remove `package-name` package
  - `apt-get remove package-name -y` remove `package-name` package non-interactive
  - `apt-get --purge remove package-name` remove and purge `package-name` (remove any configs also)
  - `apt-get autoremove` remove packages no longer needed (clean the downloaded, installed package files, probably from `/var/lib/dpkg/`)
  - `apt-get clean` cleans archived package files, if not in the normal download location
  - `apt update` retrieve list of available updates and package version numbers (or `apt-get update`)
  - `apt upgrade` install available updates (or `apt-get upgrade`; `update` is prerequisite)
  - `apt dist-upgrade` upgrade distro, but not entirely
  - `apt install package-name` install `package-name` package
  - `apt install package-name -y` install `package-name` package non-interactive
  - `apt remove package-name` remove `package-name` package
  - `apt remove package-name -y` remove `package-name` package non-interactive
  - `apt --purge remove package-name` remove and purge `package-name`
  - `apt autoremove` remove packages no longer needed (clean the downloaded, installed package files, probably from `/var/lib/dpkg/`)
  - `apt clean` cleans archived package files, if not in the normal download location

### `rpm` (`dnf` RedHat & `zypper` OpenSUSE)
- `rpm` and its handlers `dnf` and `zypper` will purge any configs by default, so they do not have any "purge" option as `pacman` and `apt-get` do
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
- `rpm -i package-file-VERSION.rpm` manually install package from `.rpm` file
  - `rpm -qpR package-file-VERSION.rpm` check for dependencies needed by `.rpm` file
- Some `-q` (query) co-flags: (ie `-qa`)
  - `-q` (`-q` alone) query installed package version
  - `-a` all installed packages
  - `-f` what package a file came from (`rpm -qf /bin/mv`)
  - `-i` package info (`rpm -qi gedit`)
  - `-l` list file contents hierarchy of a specific package (`rpm -ql gedit`)
  - `--requires` - list dependencies/prerequisites
  - `--whatprovides` - which package meets a requisite
- The `-V` (verify) co-flag: (viz `-Va`)
  - `-a` all packages on system
  - No output = no errors (no `STDOUT`, only `STDERR`; `$?` = `0`)
- `-e package-name` erase (remove/uninstall)

#### `dnf` (RedHat/CentOS)
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
- Some queries :#
- `dnf --disablerepo repo-name` sets `enabled=0` in `.repo` config
- `dnf --enablerepo repo-name` sets `enabled=1` in `.repo` config
- `dnf search findword` search for "findword"
- `dnf info package-name` info about `package-name` package
- `dnf update` update all installed packages from their repos
- `dnf update package-name` update specific package `package-name` from its repo
- `dnf list installed|updates|available` list either of the arguments
- `dnf grouplist` info on installed package groups & available updates
- `dnf groupinfo package-group` info on specific `package-group` package group
- `dnf provides /path/to/some/file` list package that owns `/path/to/some/file`
- `dnf install package-name` install `package-name` package
- `dnf localinstall package-file-name` install from local file `package-file-name.rpm`
- `dnf groupinstall package-group` install software group `package-group`
- `dnf remove package-name` remove `package-name` package
- `dnf list "dnf-plugin*"` list all `dnf` plugins
- `dnf repolist` list enabled repos
- `dnf shell` enter interactive `dnf` shell
- `dnf shell shellfile.txt` executes `dnf` shell script file in its own `dnf` shell
- `dnf install --downloadonly package-name` only download `package-name` package to `/var/cache/dnf/`
- `dnf history` history of `dnf` commands
- `dnf clean packages|metadata|all` clears installed packages from `/var/cache/dnf/`

#### `zypper` (OpenSUSE)
- Installs from repositories
- Resolves dependencies
- Downloads packages to: `/var/cache/zypp/`
- Some queries :#
  - `zypper packages` list available packages
  - `zypper list-updates` list available updates
  - `zypper update` update all packages
    - `--non-interactive` update all packages non-interactive
  - `zypper repos` list available repos
  - `zypper search findword` search for "findword"
  - `zypper info package-name` info about `package-name` package
  - `zypper search --provides /path/to/some/program` list package that owns `/path/to/some/program`
  - `zypper install package-name` install `package-name` package
    - `-f` install `package-name` package, purge any old configs
    - `--non-interactive` install `package-name` package non-interactive
  - `zypper remove package-name` remove `package-name` package
  - `zypper shell` enter interactive `zypper` shell
    - `zypper addrepo http://example.com/path/to/repo some-alias-repo-name` add a repo with `some-alias-repo-name` as your custom repo nickname
  - `zypper removerepo some-alias-repo-name` remove the repo nicknamed `some-alias-repo-name`
  - `zypper clean --all` clears installed packages from `/var/cache/zypp/`

## Security Testing Distro Architectures: Arch vs Kali
The main difference between [Kali](https://www.kali.org/), [ArchStrike](https://archstrike.org/), and [BlackArch](https://blackarch.org/) is how they compare to **[the Arch Way](https://wiki.archlinux.org/title/Arch_terminology#The_Arch_Way)**

- **[Kali](https://www.kali.org/)** is a *fork* from Debian; everything is maintained independently and *by hand*, thus *can get out-dated*
- **[ArchStrike](https://archstrike.org/)** is build on Arch & can be installed alongside Arch; packages are *bootstrapped* and *automatically up-to-date*
- **[BlackArch](https://blackarch.org/)** is built on Arch & can be installed alongside Arch; packages are mainteined *by hand*, thus *can get out-dated*

The Arch Way: [Arch Linux Principles](https://wiki.archlinux.org/title/Arch_Linux#Principles)

- Simplicity (minimalist, plays well with other kids, "[fewer chiefs, more Indians](https://en.wiktionary.org/wiki/too_many_chiefs_and_not_enough_Indians)")
- Modernity (up-to-date, [bleeding edge](https://en.wikipedia.org/wiki/Emerging_technologies#In_the_media), [rolling release](https://en.wikipedia.org/wiki/Rolling_release))
- Pragmatism (vs idealism)
- User centrality (niche-ish: for its own loyal users, not "all things to all users")
- Versatility (installs CLI-only, almost anything can be added; same distro for server, cloud, desktop, engineering, pentesting, etc; "User Repository – AUR" for almost every non-official package)

From [**ArchStrike vs BlackArch** :r/hacking // Reddit](https://www.reddit.com/r/hacking/comments/a9cnvl/black_arch_vs_arch_strike/):

> Kali is point release, and it's an absolute b!tch to get working with any package not available via the official repos whereas on Arch (rolling release FTW) you can install everything kali provides, plus the AUR. Also xfce, kde-plasma, i3-gaps.
>
> Arch linux already lets you expand its base access to packages via very convenient methods, so you can have ArchStrike AND BlackArch on the same system. BlackArch manages its packages using a custom, hand rolled package manager for its packages and iirc keeps them in ~/.hax. ArchStrike manages its packages by bootstrapping pacman with the ArchStrike repositories. In my experience, blackarch's hand rolled manager is bloated and unstable. Since Arch already has a stable and extensible package manager, ArchStrike just uses that. Install both and see what you think.
>
> ...
>
> Kali is a Debian fork that's maintained seperately from Debian itself. ArchStrike and BlackArch are just Arch with extended functionality, but are maintained by the Arch devs at their core.
>
> ...
>
> Any tutorial worth its salt uses particular tools of version X or newer, so that anybody with the necessary tools can follow. If a tutorial specifies Kali but isn't on configuring Kali itself or something along those lines, that should be a red flag.

___

# The Keys
*Practice commands for SysAdmins who already know what these mean*

| **Building from source with `make`** :$

```console
cd /path/of/source
./configure
make
sudo make install
```

| **Arch `pacman`** :#

```console
pacman -Ss findword findotherword
pacman -Qs findinstalledpackage
pacman -Sy archlinux-keyring
pacman -Syy
pacman -Syyu
pacman -S cowsay
pacman -Syy cowsay
pacman -R cowsay
pacman -Sw cowsay
ls /var/cache/pacman/pkg/cowsay*
pacman -U /var/cache/pacman/pkg/cowsay-VERSION.pkg.tar.zst
ls /var/cache/pacman/pkg/
pacman -Scc
ls /var/cache/pacman/pkg/
pacman -Rsc
pacman -Qe
pacman -Ql package-name
pacman -Qii package-name
pacman -Qo /path/to/some/file
pactree package-name
pactree -r package-name
```

| **Arch `yay`** :#

```console
yay -Syyu
yay -Ps
yay -Yc
yay -Gp aur-package-name # Output PKGBUILD for that package
yay -S aur-package-name
yay -R aur-package-name
```

| **Arch `makepkg`** :#

```console
pacman -Sw package-name
cd /var/cache/pacman/pkg/
ls
cd
mkdir pacmanw
cd pacmanw
ls /var/cache/pacman/pkg/
cp /var/cache/pacman/pkg/package-name-VERSION.pkg.tar.zst .
tar xf package-name-VERSION.pkg.tar.zst
ls
# assuming output is "opt"
cd opt
ls
cd package_name
cd ~/pacmanw
makepkg -i
makepkg -c
cd
rm -rf pacmanw
```

| **Debian `dpkg`** :#

```console
dpkg -s dpkg | grep -i Version
dpkg -V
dpkg -V package-name
dpkg -l
dpkg -L wget
dpkg -s package-name
dpkg -I some_package-name_amd64.deb
dpkg -c some_package-name_amd64.deb
cd /etc
ls
dpkg -S /etc/openldap/slapd.conf
dpkg -r package-name
dpkg -P package-name
```

| **Debian `apt-get`** :#

```console
apt-file update
apt-get install package-name
apt-cache search package-name
apt list --installed
apt list --upgradeable
apt list --all-versions
apt-get update
apt-get upgrade -y
apt-get install -y package-name
apt-get remove -y package-name
apt-get --purge -y remove package-name
apt-get dist-upgrade
apt-get autoremove
apt-get clean
```

| **RedHat `rpm`** :#

```console
rpm --rebuilddb
rpm -qa
rpm -qf /bin/mv
rpm -qi gedit
rpm -ql gedit
rpm -Va
rpm -e package name
```

| **RedHat `dnf`** :#

```console
dnf --disablerepo repo-name
dnf --enablerepo repo-name
dnf search findword
dnf list installed
dnf list available
dnf list updates
dnf info git
dnf install --downloadonly git
find /var/cache -iname "*git*" # use this in the next command
dnf localinstall /var/cache/dnf/appstream-l07GNum84/packages/git-2.43.0-1.el9.x86_64.rpm
dnf install git
dnf remove git
dnf groupinstall package-group
dnf grouplist
dnf groupinfo package-group
cd /etc
ls
dnf provides /etc/crontab
dnf update
dnf update git
dnf list "dnf-plugin*"
dnf repolist
dnf shell
dnf history
dnf clean packages
dnf clean metadata
dnf clean all
```

| **OpenSUSE `zypper`** :#

```console
zypper list-updates
zypper repos
zypper search findword
zypper info cowsay
zypper install cowsay
zypper remove cowsay
zypper search --provides /bin/cowsay
zypper install cowsay --non-interactive
zypper update
zypper update --non-interactive
zypper shell
zypper addrepo http://example.com/path/to/repo some-alias-repo-name
zypper removerepo some-alias-repo-name
zypper clean --all
```

___

#### [Lesson 9: PAM & Cloud (SSH, SSL, LDAP, VM, Docker, Mail)](https://github.com/inkVerb/vip/blob/master/601/Lesson-09.md)
