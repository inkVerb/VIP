# Shell 201
## Lesson 3: Software – apt, lsb_release
*`sudo`, `apt`, `update`, `upgrade`, `install`, `add-apt-repository`, `lsb_release`*

Ready the CLI

`cd ~/School/VIP/201`

___

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

*Those are available from your current "repositories", listed here...*

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

*You may see any of these add-repo methods on websites under "install for Linux" instructions*

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

| **9** :$ *If updates are available, you will need to press Y, then Enter*

```console
sudo apt upgrade
```

### Installing

*Install the `git` package*

| **10** :$ *Unless it is installed already, you will need to press Y, then Enter*

```console
sudo apt install git
```

*Install `cowsay`*

| **11** :$ *Unless it is installed already, you will need to press Y, then Enter*

```console
sudo apt install cowsay
```

*You can install more than one package...*

*Install the `curl` `net-tools` `htop` `odt2txt` `dos2unix` `pandoc` and `pwgen` packages*
- *(the command `netstat` comes from the package `net-tools`, we'll use it in a later lesson)*

| **12** :$ *Use `-y` so you DO NOT need to press Y, then Enter*

```console
sudo apt install -y curl net-tools htop odt2txt dos2unix pandoc pwgen
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
___

**Tip:** If you ever get an `apt upgrade` message with something like "some packages were held back", here are two easy fixes that often work:

1. `sudo apt install PACKAGE` Yes, just install the listed package again*
2. `sudo apt full-upgrade`

___

# The Take

- `lsb_release -a` outputs information about the current version of Linux
- `lsb_release -r -s` will only output the basic version number
- `sudo apt list` outputs a list of *all* software packages that can be installed with `apt`
- `sudo add-apt-repository ppa:NAME-OF-REPOSITORY/ppa` adds a repository as you can install more software packages
- `sudo apt list --upgradable` outputs installed packages that have new versions available
- `sudo apt update` will update the package `list`, including new versions available
- `sudo apt upgrade` will "upgrade" (install updates) for packages with new versions available
- `sudo apt install ...` will install a new package this way:
  - `sudo apt install package-to-install`
- `-y` will tell `apt` to automatically answer "yes" rather than prompting
  - eg:`sudo apt install -y cowsay`
- *Note `sudo apt remove package-to-remove` will remove (uninstall) a package*
## Ways to fix some problems
- `sudo apt update --fix-missing` can fix some problems
- With the **"some packages were held back"** error message , these might fix the problem:
  - `sudo apt full-upgrade`
  - `sudo apt install HELD-BACK-PACKAGE` (install it again)

___

#### [Lesson 4: ls -1 -l -a -r, chmod](https://github.com/inkVerb/vip/blob/master/201/Lesson-04.md)
