# PHP 501
## Lesson 0: LAMP Server Setup

### [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)

___
## Prepare

### I. OPTIONAL: If you did Shell 201, but on a different machine

| **P1** : `mkdir -p ~/School/VIP`

>
> ___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** : `su Username`
>
> Install the tools:
>
> | **M1** : `sudo apt update`
>
> | **M2** : `sudo apt install -y git`
>

### II. Install LAMP

Now, follow all instructions in [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md)
- Setup the LAMP server
- Setup MySQL via command line
- Setup MySQL phpMyAdmin


### III. `git clone` our scripts for this lesson

| **P2** : `cd ~/School/VIP`

| **P3** : `git clone https://github.com/inkVerb/501`

| **P4** : `mkdir ~/School/VIP/501/web`

| **P5** : `sudo ln -sfn ~/School/VIP/501/web /var/www/html/`

#### Always own web stuff!

| **P6** : `sudo chown -R www-data:www-data /var/www/html/`

>
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** : `exit`
> ___
>

### IV. HTML & CSS Crash Course

___

# The Take

## LAMP Server on your desktop
- You now have a fully-functioning, normal LAMP stack web server on your local machine
  - No tricks or gimmicks, no WAMP, no XAMPP
- You can see websites on your machine, editing them on your machine
- You can access MySQL from your terminal, see the changes in phpMyAdmin on your machine, and vice versa
- You can see the web directory just as it would be on a real webserver, right on your local machine
- You can use this same setup to develop real PHP-language web applications, just as it is
- You can use this for other languages (Phython, Node, etc), just install them as you would on a web server

## HTML & CSS Crash Course

### Render 'naked' HTML on a webpage
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
- Introduce styling for:
  - elements
  - `class`
  - `id`

___

#### [Lesson 1: PHP](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-01.md)
