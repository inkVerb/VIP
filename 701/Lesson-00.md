# Linux 701
## Lesson 0: LENG Server Setup

### Cheat Sheets

- [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)

___


## Prepare

### I. OPTIONAL: If you did Linux 201, but on a different machine
>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$
>
```console
su Username
```
>
> Arch/Manjaro:
>
> | **A1** :$
>
```console
sudo pacman -Syy
```
>
> | **A2** :$
>
```console
sudo pacman -S --noconfirm curl cowsay dialog git net-tools tcpdump htop odt2txt dos2unix pandoc texlive-core pwgen unzip
```
>
> Debian/Ubuntu:
>
> | **D1** :$
>
```console
sudo apt update
```
>
> | **D2** :$
>
```console
sudo apt install -y curl cowsay dialog git net-tools tcpdump htop odt2txt dos2unix pandoc pwgen unzip
```
>
> OpenSUSE:
>
> | **E1** :$
>
```console
sudo zypper update
```
>
> | **E2** :$
>
```console
sudo dnf install -y curl cowsay dialog git net-tools tcpdump htop dos2unix odt2txt pandoc pwgen unzip
```
>
> RedHat/CentOS:
>
> | **C1** :$

```console
sudo dnf update
```
>
> | **C2** :$
>
```console
sudo dnf install -y curl cowsay dialog git net-tools tcpdump htop dos2unix pwgen unzip redhat-lsb-core
```
> Currently thest are broken and will not work on CentOS: `odt2txt pandoc`
>
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$
>
```console
exit
```
> ___
>
> | **M3** :$
>
```console
mkdir -p ~/School/VIP
```
>

### II. Install LENG Desktop

Now, follow all instructions in [LENG Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LENG-Desktop.md)
- Setup the LENG server
  - This includes Nginx
- Make sure Code-OSS and extensions are installed
- Install and setup everything for:
  - Node.js
  - Go
  - Python
  - MongoDB
  - SQLite
  - MySQL/MariaDB
  - PostgreSQL

### IV. `git clone` our scripts for this lesson

| **0** :$ (If the `School/VIP` directory doesn't already exist)

```console
mkdir -p ~/School/VIP
```

| **1** :$

```console
cd ~/School/VIP
```

| **2** :$

```console
git clone https://github.com/inkVerb/701
```

#### Always own the web directory with `chown -R www...`!

>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
> ___
>




___

#### [Lesson 1: Web Hosting](https://github.com/inkVerb/vip/blob/master/701/Lesson-01.md)
