# Linux 501
## Lesson 0: Server, LAMP Setup & HTML Fast

- Manjaro/Ubuntu/CentOS: [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)

___
### Web Address Terminology

A "host" is your website "domain"

The Internet thinks of each "domain" as a separate computer

If the "host" is your own computer, then your "domain" is simply "localhost"

#### A. 'host'
A "host" could be...

- `example.com`
- `inkisaverb.com`
- `subdom.inkisaverb.com`
- `verb.ink`
- `localhost`

#### B. 'protocol'
A "protocol" explains how a "host" is reached
- `http://` insecure Internet (Hyper Text Transfer Protocol)
- `https://` secure Internet (Hyper Text Transfer Protocol Secure)
- `ftp://` insecure Internet file server (File Transfer Protocol)
- `ftps://` secure Internet file server (File Transfer Protocol Secure)
- `file://` file location on your local computer (just for viewing files, can't run PHP)
- `tel:`
- `mailto:`

#### C. 'path'
A "path" is a file location, the word comes from talk about the Linux terminal

A web address "path" starts with `/` after the domain and, in theory, is a file location in the web directory on the computer of the website

Here, "/this/path" is the "path"...

- `https://verb.ink/this/path`

...and, in theory, is located on the computer at...

- `/srv/http/html/verb.ink/this/path`

...and, in theory, you could go see it with the terminal command:

- `cd /srv/http/html/verb.ink/this/path`

#### D. 'URL'
"URL" stands for: Universal Resource Locator

A "URL" has:
1. Protocol (`https://`)
2. Domain
3. Path (maybe)

A "URL" could be...

- `http://example.com/webpage`
- `https://inkisaverb.com/some/path/here`
- `https://subdom.inkisaverb.com/website`
- `https://verb.ink`
- `ftps://inkisaverb.com/something.tgz`
- `file:///home/user/somefile.md`
- `tel:1-555-555-5555`
- `mailto:someone@inkisaverb.com`
- `localhost/some/page` ...'localhost' doesn't use `https://` because it isn't "served" over the Internet

Don't be confused by "URI" and "URL"
- A "URI" is a higher category of a URL
- A "URI" may include the full URL or only part of it
- A "URL" must identify specific information, such as the host and protocol
- URL: `https://inkisaverb.com/some/path/here`
- URI: `/some/path/here`
- URI: `https://inkisaverb.com/some/path/here`

#### E. 'localhost'

We will use **`localhost`** as our "domain" and/or "host" for testing our web pages in this course

On a live, online web server, **`localhost`** could be **`inkisaverb.com`** or **`https://inkisaverb.com`**

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
sudo pacman -S --noconfirm curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc texlive-core pwgen unzip
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
sudo apt install -y curl cowsay dialog git net-tools htop odt2txt dos2unix pandoc pwgen unzip
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
sudo dnf install -y curl cowsay dialog git net-tools htop dos2unix odt2txt pandoc pwgen unzip
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
sudo dnf install -y curl cowsay dialog git net-tools htop dos2unix pwgen unzip redhat-lsb-core
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

### II. Install LAMP

Now, follow all instructions in [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)
- Setup the LAMP server
- Setup MySQL phpMyAdmin
- Setup MySQL via command line

### III. `git clone` our scripts for this lesson

- Arch/Manjaro:

| **AP1** :$

```console
cd ~/School/VIP
```

| **AP2** :$

```console
git clone https://github.com/inkVerb/501
```

| **AP3** :$

```console
sudo mkdir -p /srv/www/html/web
```

| **AP4** :$

```console
ln -sfn /srv/www/html/web ~/School/VIP/501/
```

| **AP5** :$

```console
sudo chown -R www:www /srv/www
```

- Debian/Ubuntu:

| **DP1** :$

```console
cd ~/School/VIP
```

| **DP2** :$

```console
git clone https://github.com/inkVerb/501
```

| **DP3** :$

```console
sudo mkdir /var/www/html/web
```

| **DP4** :$

```console
ln -sfn /var/www/html/web ~/School/VIP/501/
```

| **DP5** :$

```console
sudo chown -R www:www /var/www/html/
```

| **DP7** :$ (Make Debian work with these lessons)

```console
sudo ln -sfn /var/www /srv/
sudo chown -R www:www /srv/www
```

- OpenSUSE:

| **EP1** :$

```console
cd ~/School/VIP
```

| **EP2** :$

```console
git clone https://github.com/inkVerb/501
```

| **EP3** :$

```console
sudo mkdir /srv/www/html/web
```

| **EP4** :$

```console
ln -sfn /srv/www/html/web ~/School/VIP/501/
```

| **EP5** :$

```console
sudo chown -R www:www /srv/www/html/
```

- RedHat/CentOS:

| **CP1** :$

```console
cd ~/School/VIP
```

| **CP2** :$

```console
git clone https://github.com/inkVerb/501
```

| **CP3** :$

```console
sudo mkdir /var/www/html/web
```

| **CP4** :$

```console
ln -sfn /var/www/html/web ~/School/VIP/501/
```

| **CP5** :$

```console
sudo chown -R www:www /var/www/html/
```

| **CP6** :$ (Make CentOS work with these lessons)

```console
sudo ln -sfn /var/www /srv/
sudo chown -R www:www /srv/www
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

### IV. Download and install VSCodium
- This course uses VSCodium instead of gedit
- Arch/Manjaro:
```bash
sudo pacman -S vscodium-bin
```
- Debian/Ubuntu
```bash
sudo apt update && sudo apt upgrade -y
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \ | gpg --dearmor \ | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
| sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update
sudo apt install codium
```
- RedHat/CentOS/openSUSE
```bash
sudo dnf install epel-release
sudo dnf install snapd --skip-broken
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install codium --classic
```
- Or, download and install from **[vscodium.com](https://vscodium.com/)**
  - Debian/Ubuntu: .deb
  - RedHat/CentOS/openSUSE: .rpm

- VSCodium settings
```bash
codium --install-extension emroussel.atomize-atom-one-dark-theme
codium --install-extension opensumi.opensumi-default-themes
codium --install-extension PenumbraTheme.penumbra
codium --install-extension timonwong.shellcheck
codium --enable-proposed-api timonwong.shellcheck
```
  - May want to add these to *File > Preferences > Settings > Extensions > ShellCheck > Exclude:*
```console
SC2076,SC2016,SC1090,SC2034,SC2154,SC1091,SC2206,SC2086,SC2153,SC2231
```

### V. XML CLI Tools (Lesson 12)

```shell
libxml2 # XML Lint
xmlstarlet # XMLStarlet
```

- Arch/Majaro:

| **AL1** :$

```console
sudo pacman -S --noconfirm libxml2 xmlstarlet
```

- Debian/Ubuntu:

| **DL1** :$

```console
sudo apt install -y libxml2-utils xmlstarlet
```

- OpenSUSE:

| **EL1** :$

```console
sudo zypper install -y libxml2 xmlstarlet
```

### VI. HTML-CSS-JS Crash Course
- Timeline:
  - 1993: HTML
  - 1994: PHP
  - 1995: JavaScript
  - 1996: CSS
  - 1998: XML
- "Client languages" (browser language)
  - HTML
  - CSS
  - JavaScript
- JavaScript makes a page "animated"
- PHP is a "Server language" (works on the web server, browsers never know)
- Illustration:
  - HTML is a manikin
  - CSS is the clothing
  - JavaScript "animates", so the manikin moves like a robot and changes clothes
- XML borrows HTML framework, using it to organize information the way HTML organizes a webpage
  - XML can be displayed like a webpage or used silently for software to access information data

- Take the crash course:
  - [HTML CSS JS](https://github.com/inkVerb/HTML-CSS-JS/blob/master/README.md)
___

# The Take

## Terminology
##### A. 'host'
- Could be...
  - `example.com`
  - `inkisaverb.com`
  - `subdom.inkisaverb.com`
  - `verb.ink`
  - `localhost`

##### B. 'protocol'
- How a "host" is reached
  - `http://` (Hyper Text Transfer Protocol)
  - `https://` (Hyper Text Transfer Protocol Secure)
  - `ftp://` (File Transfer Protocol)
  - `ftps://` (File Transfer Protocol Secure)
  - `file://` file location on your local computer (can't run PHP)

##### C. 'path'
- File location, just like the Linux terminal
- Starts with `/` after the domain (`/this/is/a/path`)
- `https://verb.ink/this/path` = `/srv/http/html/verb.ink/this/path`

##### D. 'URL'
- "Universal Resource Locator"
- Has:
  1. Protocol (`https://`)
  2. Domain
  3. Path (maybe)
- Could be...
- `https://inkisaverb.com/some/path/here`
- `localhost/some/page`

##### E. 'localhost'
- Could be `https://inkisaverb.com` on a live, online web server
- Used for developing websites on your local computer

## LAMP Server on your desktop
- You now have a fully-functioning, normal LAMP stack web server on your local machine
  - No tricks or gimmicks, no WAMP, no XAMPP
- You can see websites on your machine, editing them on your machine
- You can access MySQL from your terminal, see the changes in phpMyAdmin on your machine, and vice versa
- You can see the web directory just as it would be on a real webserver, right on your local machine
- You can use this same setup to develop real PHP-language web applications, just as it is
- You can use this for other languages (Phython, Node, etc), just install them as you would on a web server

## XML CLI Tools
- You have some tools to manage XML from the command line
  - XML is not only a language

## HTML, CSS & JS Crash Course
- Timeline:
  - 1993: HTML
  - 1994: PHP
  - 1995: JavaScript
  - 1996: CSS
  - 1998: XML
- "Client languages" (browser language)
  - HTML
  - CSS
  - JavaScript
- JavaScript animates HTML and CSS
- PHP is a "Server language" (works on the web server, browsers never know)

### Render 'naked' HTML on a web page
- `<h1>`, `<h2>`, etc
- `<p>`
- `<ol>` / `<ul>`: `<li>`
- `<form>`
- `<textarea>`
- `<input>` `type=`: `text`, `password`, `radio`, `color`, `datetime-local`, `submit`
- HTML entities

### Style HTML with CSS
- Embed CSS in the `<head>`
- `<link>` CSS in the `<head>`
- Style by:
  - elements
  - `class`
  - `id`

### JavaScript
- Embed JS in `<script>` tags
- Include from an external file with: `<script src="myfile.js"></script>`
- Affects an HTML element by a "method"
  - `getElementById("some_id")`
  - `getElementsByClassName("some_class")`
  - `getElementsByName("some_name")`
- Activates based-on an HTML element with:
  - `onclick="jsFunction()"`
  - `onmouseover="jsFunction()"`
  - `onload="jsFunction()"`
  - These are called "events"

___

#### [Lesson 1: PHP Core](https://github.com/inkVerb/vip/blob/master/501/Lesson-01.md)
