# Shell 301
## Lesson 0: 301 Cheat Sheets & Setup

### [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)

### [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

### [Arrays](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Arrays.md)

### [Resources](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md)

___
## Prepare

### I. OPTIONAL: If you did Shell 201, but on a different machine
>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
>
> Arch/Manjaro:
>
> | **A1** :$

```console
sudo pacman -Syy
```
>
> | **A2** :$

```console
sudo pacman -S --noconfirm curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc texlive-core pwgen unzip
```
>
> Debian/Ubuntu:
>
> | **D1** :$

```console
sudo apt update
```
>
> | **D2** :$

```console
sudo apt install -y curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc pwgen unzip
```
>
> CentOS/Fedora:
>
> | **C1** :$

```console
sudo dnf update
```
>
> | **C2** :$

```console
sudo dnf install -y curl cowsay dialog git net-tools htop dos2unix pwgen unzip
```
> Currently thest are broken and will not work on CentOS: `odt2txt pandoc`
>
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
> ___
>
> | **M3** :$

```console
mkdir -p ~/School/VIP
```
>

### II. `git clone` our scripts for this lesson

| **1** :$

```console
cd ~/School/VIP
```

| **2** :$

```console
git clone https://github.com/inkVerb/301
```

| **3** :$

```console
ls
```

| **4** :$

```console
cd 301
```

| **5** :$

```console
ls
```

___

# The Take

- Your machine is up to speed with the necessary packages installed
- You have the GitHub "301" files needed for this course

___

#### [Lesson 1: if then fi, else & elif](https://github.com/inkVerb/vip/blob/master/301/Lesson-01.md)
