# Linux 601
## Lesson 0: 601 
___
## Prepare

| **1** :$

```console
mkdir -p ~/School/VIP/601
```

>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **PS1** :$

```console
su Username
```

Arch/Manjaro:

| **PA1** :$

```console
sudo pacman -Syy
```

| **PA2** :$

```console
sudo pacman -S --noconfirm openssh
```

Debian/Ubuntu:

| **PD1** :$

```console
sudo apt update
```

| **PD2** :$

```console
sudo apt install -y openssh
```

CentOS/Fedora:

| **PC1** :$

```console
sudo dnf update
```

| **PC2** :$

```console
sudo dnf install -y openssh
```

> Optional: IF you logged in as a "sudoer", now exit
>
> | **PS2** :$

```console
exit
```

### OPTIONAL: If you did Linux 201, but on a different machine
>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **TS1** :$
>
```console
su Username
```
>
> Arch/Manjaro:
>
> | **TA1** :$
>
```console
sudo pacman -Syy
```
>
> | **TA2** :$
>
```console
sudo pacman -S --noconfirm curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc texlive-core pwgen unzip
```
>
> Debian/Ubuntu:
>
> | **TD1** :$
>
```console
sudo apt update
```
>
> | **TD2** :$
>
```console
sudo apt install -y curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc pwgen unzip
```
>
> CentOS/Fedora:
>
> | **TC1** :$
>
```console
sudo dnf update
```
>
> | **TC2** :$
>
```console
sudo dnf install -y curl cowsay dialog git net-tools htop dos2unix pwgen unzip redhat-lsb-core
```
> Currently thest are broken and will not work on CentOS: `odt2txt pandoc`
>
>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **TS2** :$
>
```console
exit
```
>
___

# The Take

- Your machine is up to speed with the necessary packages installed

___

#### [Lesson 1: Information Commands & Package Managers](https://github.com/inkVerb/vip/blob/master/601/Lesson-01.md)
