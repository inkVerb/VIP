# Shell 401
## Lesson 0: 401 Cheat Sheets & Setup

### [Cron](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md)

### [Resources](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Resources.md)

### [LAMP-Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)

### [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)

### [Tests: BASH](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#welcome-to-bash)

### [Characters](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md)
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
sudo pacman -S --noconfirm curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc pwgen unzip
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
git clone https://github.com/inkVerb/401
```

| **3** :$

```console
ls
```

| **4** :$

```console
cd 401
```

| **5** :$

```console
ls
```
___

# The Take

- Your machine is up to speed with the necessary packages installed
- You have the GitHub "401" files needed for this course

___

#### [Lesson 1: Returns & Terminal](https://github.com/inkVerb/vip/blob/master/401/Lesson-01.md)
