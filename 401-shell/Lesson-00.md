# Shell 401
## Lesson 0: Setup

#### If you did Shell 201, but on a different machine
Install the tools:

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> `su USERNAME`
>
___


`sudo apt install -y curl net-tools htop odt2txt dos2unix pandoc rename pwgen`

## Install Atom

`mkdir -p .atom-key.tmp`

`cd .atom-key.tmp`

`sudo curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -`

`sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'`

`cd ..`

`sudo rm -r .atom-key.tmp`

`sudo apt update`

`sudo apt install atom`

## Prepare

*F12 (guake) OR Ctrl + Alt + T (new terminal)*

`mkdir -p ~/School/VIP/shell`

`cd ~/School/VIP/shell`

`git clone https://github.com/inkVerb/401`

`cd 401`

### [Lesson 1: Text & Terminal](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-01.md)
