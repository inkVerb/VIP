# Linux 201
## Lesson 3: Software, pacman, apt, dnf, lsb_release

Ready the CLI

```console
cd ~/School/VIP/201
```

___

Arch & Manjaro use `pacman` to install and update software packages

Debian & Ubuntu use `apt` or `apt-get` to install and update software packages

These tools are called "package managers"

## Arch/Manjaro
s*Check the Linux version info*

| **1** :$

```console
lsb_release -a
```

*Get just the number*

| **2** :$

```console
lsb_release -r -s
```

*Some commands require `sudo`, AKA "run as administrator"*

*Not all users can run with `sudo`*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
>
___

### Packages & Repositories
*See the list of all installed software "packages"*

| **3** :$

```console
pacman -Qm
```

*Those are installed software packages, listed in these directories...*

| **4** :$

```console
ls /var/lib/pacman/
```

*Those are installed from different "mirrors", listed here...*

| **5** :$

```console
cat /etc/pacman.d/mirrorlist
```

*On Arch/Manjaro, all packages are installed from either:*

- Arch Repository (AR, installed wtih `sudo pacman -S some-package`)
- Arch User Repository (AUR, installed wtih `yay -S some-package`)
  - While Debian/Ubuntu will add many repositories for non-native packages, all such "other" packages can often be found in the AUR
  - The AUR also has packages that Debian/Ubuntu may not have, such as for Google Chrome
  - It is important to know whether a package should be installed from:
  	- AR via `sudo pacman -s`
  	- AUR via `yay -S` (never `sudo`)
  - Terminal AUR: `yay`
    - `yay` stands for "Yet Another Yogurt" and must be installed on its own, which should have been done before starting these lessons
  	- Installing `yay` requires `git` and compiling, many tutorials are available online for it
  - Desktop AUR: Enable in Software settings
  	- The AUR can also be accessed from the settings GUI:
  	  - Add/Remove Software > "..." > Preferences > Third Party (or AUR): Then "Enable AUR Support"
  	  - Then, you can install AUR packages from the GUI Software manager, but that does not affect AUR installation from the terminal

### Maintenance & Upgrades
*Update the current software package version lists (no updates are installed)*

| **6** :$

```console
sudo pacman -Syy
```

*See what can packages on your machine have a new version available*

| **7** :$

```console
sudo pacman -Qu
```

*Upgrade (install updates)*

| **8** :$ *If updates are available, you will need to press Y, then Enter*

```console
sudo pacman -Syyu
```

*Remove downloaded packages after they are installed*

| **9** :$

```console
sudo pacman -Scc
```

*Remove unneeded packages, likely made obsolete after an upgrade*

| **11** :$

```console
# AR
sudo pacman -Rs $(pacman -Qdtq)

# AUR
yay -Yc
```

### Installing
*Install the `git` package*

| **11** :$ *You may need to press Y, then <kbd>Enter</kbd>*

```console
sudo pacman -S git
```

*Install `cowsay`*

| **12** :$ *You may need to press Y, then <kbd>Enter</kbd>*

```console
sudo pacman -S cowsay
```

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `texlive-core` `pwgen` and `unzip` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*
- *(the command `pandoc` requires the package `texlive-core` for .pdf files)*

| **13** :$ *Use `--noconfirm` so you DO NOT need to press Y, then Enter*

```console
sudo pacman -S --noconfirm curl net-tools tcpdump htop odt2txt dos2unix pandoc texlive-core pwgen unzip
```

### Uninstalling (for reference)
*Uninstall a package*

```console
# AR
sudo pacman -R some-package-name
sudo pacman -Rs some-package-name # And remove dependencies
sudo pacman -Rns some-package-name # And remove dependencies & configs

# AUR
yay -R some-package-name
yay -Rs some-package-name # And remove dependencies
yay -Rns some-package-name # And remove dependencies & configs
```

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
>

## Debian/Ubuntu
*Check the Linux version info*

| **1** :$

```console
lsb_release -a
```

*Get just the number*

| **2** :$

```console
lsb_release -r -s
```

*Some commands require `sudo`, AKA "run as administrator"*

*Not all users can run with `sudo`*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
>
___

### Packages & Repositories
*See the list of all available software "packages"*

| **3** :$

```console
sudo apt list
```

*Those are available software packages from your current "repositories", listed here...*

| **4** :$

```console
cat /etc/apt/sources.list
```

*A repository (AKA 'repo') is a web server that has software packages for installs and upgrades*

*Some packages are only available from special repositories, which must be added if you want them*

***Adding a repository is a big deal, only do it if you are sure and willing to accept risk***

*This is the Ubuntu-Canonical `multiverse` repository, popular to add because:*
  - *it has more packages*
  - *it is from Ubuntu's company, Canonical, so it is trusted*

| **5** :$ *Probably press <kbd>Ctrl</kbd> + <kbd>C</kbd> to cancel if it asks*

```console
sudo add-apt-repository multiverse
```

*This adds a graphics driver repository and can help if your graphics are slow of glitchy*

| **6** :$ *Probably press <kbd>Ctrl</kbd> + <kbd>C</kbd> to cancel if it asks*

```console
sudo add-apt-repository ppa:graphics-drivers/ppa
```

*Repositories can be added many ways, this is one common way:*
  - `sudo add-apt-repository ppa:NAME-OF-REPOSITORY/ppa`

*A big, long, "proper" way is to include the version number with something like this:*
  - `$(lsb_release -sc)` *simply inserts whatever your version is from `lsb_release`...*
  - *The `partner` repo:*
    - `sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"`
  - *The `multiverse`, `universe`, and `restricted` repos at the same time:*
    - `sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe restricted multiverse`

*Another way requires a "key" to be downloaded, usually from the terminal*

*You may see any of these add-repo methods on websites under "install for Linux" instructions, this is for Debian/Ubuntu*

### Maintenance & Upgrades
*Update the current software package version lists (no updates are installed)*

| **7** :$

```console
sudo apt update
```

*If there is a problem, usually fix it with `--fix-missing`*
- (`sudo apt update --fix-missing`)

*See what can packages on your machine have a new version available*

| **8** :$

```console
sudo apt list --upgradable
```

*Upgrade (install updates)*

| **9** :$ *If updates are available, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo apt upgrade
```

*Remove downloaded packages after they are installed*

| **10** :$

```console
sudo apt-get clean
```

*Remove unneeded packages, likely made obsolete after an upgrade*

| **11** :$

```console
sudo apt-get autoremove
```

### Installing
*Install the `git` package*

| **12** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo apt install git
```

*Install `cowsay`*

| **13** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo apt install cowsay
```

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `pwgen` and `unzip` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*

| **14** :$ *Use `-y` so you DO NOT need to press Y, then <kbd>Enter</kbd>*

```console
sudo apt install -y curl net-tools tcpdump htop odt2txt dos2unix pandoc pwgen unzip
```

### Uninstalling (for reference)
*Uninstall a package*

```console
sudo apt-get remove some-package-name
```

*Uninstall a package and remove its settings*

```console
sudo apt-get remove --purge some-package-name
```

**Tip:** If you ever get an `apt upgrade` message with something like "some packages were held back", here are two easy fixes that often work:

1. `sudo apt install PACKAGE` Yes, just install the listed package again*
2. `sudo apt full-upgrade`

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
>

## OpenSUSE
*Some commands require `sudo`, AKA "run as administrator"*

*Not all users can run with `sudo`*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
>
___

### Packages & Repositories
*See the list of all available software "packages"*

| **1** :$

```console
sudo dnf list
```

### Maintenance & Upgrades
*See what can packages on your machine have a new version available*

| **2** :$

```console
sudo zypper list-updates
```

*Upgrade (install updates)*

| **3** :$ *If updates are available, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo zypper update
```

*Remove unneeded packages, likely made obsolete after an upgrade*

| **4** :$

```console
sudo zypper clean --all
```

### Installing
*Install the `git` package*

| **5** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo zypper install git
```

*Install `cowsay`*

| **6** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo zypper install cowsay
```

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `pwgen` and `unzip` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*

| **7** :$ *Use `-y` so you DO NOT need to press Y, then <kbd>Enter</kbd>*

```console
sudo zypper install -y curl net-tools tcpdump htop dos2unix odt2txt pandoc pwgen unzip
```

*Check the Linux version info*

| **8** :$

```console
lsb_release -a
```

*Get just the number*

| **9** :$

```console
lsb_release -r -s
```

### Uninstalling (for reference)
*Uninstall a package*

```console
sudo zypper remove some-package-name
```

### IF needed, `exit` from the other "sudoer"
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
>

## OpenSUSE & RedHat/CentOS
*Some commands require `sudo`, AKA "run as administrator"*

*Not all users can run with `sudo`*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
>
___

### Packages & Repositories
*See the list of all available software "packages"*

| **1** :$

```console
sudo dnf list
```

### Maintenance & Upgrades
*Update the current software package version lists (no updates are installed)*

| **2** :$

```console
sudo dnf check-update
```

*See what can packages on your machine have a new version available*

| **3** :$

```console
sudo dnf list updates
```

*Upgrade (install updates)*

| **4** :$ *If updates are available, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo dnf update
```

*Remove downloaded packages after they are installed, multiple times you may need to press Y, then <kbd>Enter</kbd>*

| **5** :$

```console
package-cleanup --leaves
```

*Remove unneeded packages, likely made obsolete after an upgrade*

| **6** :$

```console
sudo dnf autoremove
```

### Installing
*Install the `git` package*

| **7** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo dnf install git
```

*Install `cowsay`*

| **8** :$ *Unless it is installed already, you will need to press Y, then <kbd>Enter</kbd>*

```console
sudo dnf install cowsay
```

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` `pwgen` and `unzip` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*
- *Currently thest are broken and will not work on CentOS: `odt2txt pandoc`*

| **9** :$ *Use `-y` so you DO NOT need to press Y, then <kbd>Enter</kbd>*

```console
sudo dnf install -y curl net-tools tcpdump htop dos2unix pwgen unzip redhat-lsb-core
```

*Check the Linux version info*

| **10** :$

```console
lsb_release -a
```

*Get just the number*

| **11** :$

```console
lsb_release -r -s
```

### Uninstalling (for reference)
*Uninstall a package*

```console
sudo dnf remove some-package-name
```

### IF needed, `exit` from the other "sudoer"
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
>

___

# The Take
## Linux Version
- `lsb_release -a` outputs information about the current version of Linux
- `lsb_release -r -s` will only output the basic version number
## Package Managers
- Arch/Manjaro: `pacman` & `yay`
  - `sudo pacman -Qm` outputs a list of *all* software packages that can be installed with `pacman`
  - `sudo pacman -Syyu` will update and install the lastest installed software packages
  - `sudo pacman -S package-to-install` will install a package
    - `--nocnofirm` will tell `pacman` to automatically answer "yes" rather than prompting
  - `sudo pacman -R package-to-remove` will remove (uninstall) a package
  - Arch User Repository (AUR) is extra software maintained by volunteers from the Arch community, where all "other" packages come from
  - `yay -Syyu` will update and install the lastest installed software packages from the AUR
  - `yay -S package-to-install` will install a package from the AUR
  - `yay -R package-to-remove` will remove (uninstall) a package from the AUR
      - `yay -Rns package-to-remove` will also remove unneeded dependencies
      - `--nocnofirm` will tell `yay` to automatically answer "yes" rather than prompting
- Debian/Ubuntu: `apt`
  - `sudo apt list` outputs a list of *all* software packages that can be installed with `apt`
  - `sudo add-apt-repository ppa:NAME-OF-REPOSITORY/ppa` adds a repository as you can install more software packages
  - `sudo apt list --upgradable` outputs installed packages that have new versions available
  - `sudo apt update` will update the package `list`, including new versions available
  - `sudo apt upgrade` will "upgrade" (install updates) for packages with new versions available
  - `sudo apt install package-to-install` will install a package
    - `-y` will tell `apt` to automatically answer "yes" rather than prompting
  - `sudo apt remove package-to-remove` will remove (uninstall) a package
- OpenSUSE: `zypper`
  - `sudo zypper packages` outputs a list of *all* software packages that can be installed with `zypper`
  - `sudo zypper list-updates` list available updates
  - `sudo zypper addrepo http://example.com/path/to/repo some-alias-repo-name` add a repo with `some-alias-repo-name` as your custom repo nickname
  - `sudo zypper update` will install packages with new versions available
    - `--non-interactive` will tell `zypper` to automatically answer "yes" rather than prompting
  - `sudo zypper install package-to-install` will install a package
    - `--non-interactive` will tell `zypper` to automatically answer "yes" rather than prompting
  - `sudo zypper remove package-to-remove` will remove (uninstall) a package
- RedHat/CentOS: `dnf`
  - `sudo dnf list | head` outputs a list of *all* software packages that can be installed with `dnf`
  - `sudo dnf list installed | grep -i httpd` outputs all installed packages
  - `sudo dnf upgrade` will install packages with new versions available
  - `sudo dnf install package-to-install` will install a package
    - `-y` will tell `dnf` to automatically answer "yes" rather than prompting
  - `sudo dnf remove package-to-remove` will remove (uninstall) a package
## Ways to fix some problems in Ubuntu
- `sudo apt update --fix-missing` can fix some problems
- With the **"some packages were held back"** error message , these might fix the problem:
  - `sudo apt full-upgrade`
  - `sudo apt install HELD-BACK-PACKAGE` (install it again)

___

#### [Lesson 4: ls -1 -l -a -r, chmod](https://github.com/inkVerb/vip/blob/master/201/Lesson-04.md)
