# Shell 501
## Lesson 0: Server, LAMP Setup & HTML Fast

- Arch/Manjaro: [LEMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LEMP-Desktop.md)
- Debian/Ubuntu: [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)

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

#### C. 'path'
A "path" is a file location, the word comes from talk about the Linux terminal

A web address "path" starts with `/` after the domain and, in theory, is a file location in the web directory on the computer of the website

Here, "/this/path" is the "path"...

- `https://verb.ink/this/path`

...and, in theory, is located on the computer at...

- `/var/www/html/verb.ink/this/path`

...and, in theory, you could go see it with the terminal command:

- `cd /var/www/html/verb.ink/this/path`

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
- `localhost/some/page` ...'localhost' doesn't use `https://` because it isn't "served" over the Internet

#### E. 'localhost'

We will use **`localhost`** as our "domain" and/or "host" for testing our web pages in this course

On a live, online web server, **`localhost`** could be **`inkisaverb.com`** or **`https://inkisaverb.com`**

## Prepare

### I. OPTIONAL: If you did Shell 201, but on a different machine

| **P1** :$ `mkdir -p ~/School/VIP`

### This lesson requires a "sudoer" who can use `sudo`
>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$ `su Username`
>
> Install the tools:
>
> | **M1** :$ `sudo apt update`
>
> | **M2** :$ `sudo apt install -y git`
>

### II. Install LAMP

Now, follow all instructions in [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)
- Setup the LAMP server
- Setup MySQL via command line
- Setup MySQL phpMyAdmin

### III. `git clone` our scripts for this lesson

- Debian/Ubuntu:

| **DP2** :$ `cd ~/School/VIP`

| **DP3** :$ `git clone https://github.com/inkVerb/501`

| **DP4** :$ `sudo mkdir /var/www/html/web`

| **DP5** :$ `ln -sfn /var/www/html/web ~/School/VIP/501/`

| **DP6** :$ `ln -sfn /var/www/rewrite ~/School/VIP/501/`

| **DP7** :$ `sudo chown -R www:www /var/www/html/`

- Arch/Manjaro:

| **AP2** :$ `cd ~/School/VIP`

| **AP3** :$ `git clone https://github.com/inkVerb/501`

| **AP4** :$ `sudo mkdir /srv/www/html/web`

| **AP5** :$ `ln -sfn /srv/www/html/web ~/School/VIP/501/`

| **AP6** :$ `ln -sfn /srv/www/rewrite ~/School/VIP/501/`

| **AP7** :$ `sudo chown -R www:www /srv/www`

#### Always own the web directory with `chown -R www...`!

>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$ `exit`
> ___
>

### IV. Download and install Atom
- This course uses Atom instead of gedit
- Download and install from **[atom.io](https://atom.io/)**
  - Debian/Ubuntu: .deb
  - Fedora/CentOS/openSUSE: .rpm
- Archlinux: (packages already available)
```bash
sudo pacman -S apm
apm install atom
```

### V. HTML-CSS-JS Crash Course
- Timeline:
  - 1993: HTML
  - 1994: PHP
  - 1995: JavaScript
  - 1996: CSS
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
- `https://verb.ink/this/path` = `/var/www/html/verb.ink/this/path`

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

## HTML, CSS & JS Crash Course
- Timeline:
  - 1993: HTML
  - 1994: PHP
  - 1995: JavaScript
  - 1996: CSS
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

#### [Lesson 1: PHP Core](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-01.md)
