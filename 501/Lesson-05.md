# Linux 501
## Lesson 5: RewriteMod (Pretty Permalinks)

Ready the CLI

```console
cd ~/School/VIP/501
```

Ready services

Arch/Manjaro, OpenSUSE, RedHat/CentOS
```console
sudo systemctl start httpd mariadb
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mariadb
```

If teaching multiple students

Prep directory
```console
cd ~/School/VIP
```

Backup Student 1 schoolwork directory
```console
rm 501/web
sudo mv /srv/www/html/web 501/
mv 501 STUDENT_1/
```

Restore Student 2 schoolwork directory
```console
mv STUDENT_2/501 .
sudo mv 501/web /srv/www/html/
sudo chown -R www:www /srv/www/html/web
sudo ln -sfn /srv/www/html/web 501/
sudo chown -R www:www 501/web
```

Re-ready the CLI

```console
cd ~/School/VIP/501
```

- [Characters for Classes & RegEx](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

___

### RewriteMod: Apache Web Server Setting
**RewriteMod:** a web server settings that changes what a web address looks like

1. Rewrite uses a RegEx, just like PHP `preg_match()` and `preg_replace()`
2. Rewrite often hides GET method syntax in the URL
3. Each `(parenthetical set)` in the RegEx becomes an argument in the path as `$1`, `$2`, `$3`, etc
```
RewriteRule RegEx path [options]

RewriteRule (RegEx one)(RegEx two)(RegEx three) path/to/$1/somefile.php?foo=$2&bar=$3
```

For example:

"Pretty URL" (What looks like)...

```
https://verb.vip/My_Long_Name
```

...could actually be...

```
https://verb.vip/pretty_page.php?n=My_Long_Name
```

...using the setting...

| **.htaccess** :

```
RewriteEngine on
RewriteRule ^/?([a-zA-Z0-9_]+)$ pretty_page.php?n=$1 [L]
```

*Let's try...*

| **1** :$

```console
sudo cp core/05-pretty1.php web/pretty_page.php && \
sudo cp core/05-htaccess1 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-pretty1.php core/05-htaccess1 && \
ls web
```

*Anything after `localhost/web/` made of letters and underscore should simply echo in the browser...*

| **B-1** ://

```console
localhost/web/My_Long_Name
```

*...Feel free to try different strings after `localhost/web/`*

*We just tried number 1 below...*

### RewriteMod Other Settings

```
RewriteEngine on

# Absolute path destination

## 1. localhost/whatever/Value_Here ...to absolute path (notice the slash in /pretty_page.php)
RewriteRule ^/?([a-zA-Z0-9_-]+)$ /web/pretty_page.php?n=$1 [L]


# Relative path destinations

## 2. localhost/whatever/Value_Here ...to relative path (no slash in pretty_page.php)
RewriteRule ^/?([a-zA-Z0-9_-]+)$ pretty_page.php?n=$1 [L]

## 3. localhost/whatever/Value_One/Value_Two (certainly a middle slash)
RewriteRule ^/?([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$2 [L]

## 4. localhost/whatever/Valye_One/Value_Maybe (maybe a middle slash, if so it becomes $2)
RewriteRule ^/?([a-zA-Z0-9_-]+)(.*/)?([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$3 [L]

## 5. localhost/pretty (no ReGex, plain text)
RewriteRule ^pretty$ pretty_page.php [L]
```

*We just tried number 1 above, now let's try 2...*

| **2** :$

```console
sudo cp core/05-htaccess2 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-htaccess2 && \
ls web
```

| **B-2** ://

```console
localhost/web/My_Long_Name
```

*...Feel free to try different strings after `localhost/web/`*

*We just tried number 2 above, now let's try 3...*

| **3** :$

```console
sudo cp core/05-pretty3.php web/pretty_page.php && \
sudo cp core/05-htaccess3 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-pretty3.php core/05-htaccess3 && \
ls web
```
*Notice in the RegEx, this requies a `/` in the middle, otherwise it won't work...*

| **B-3a** ://

```console
localhost/web/My_Long_Name
```

*...It doesn't work because the RegEx only recognizes a string with a `/` in the middle*

*So, try one with a `/`...*

| **B-3b** ://

```console
localhost/web/My_Long_Name/Name-2
```

*...Feel free to try different strings after `localhost/web/`, before and after the `/`*

*We just tried number 3 above, now let's try 4...*

| **4** :$

```console
sudo cp core/05-pretty4.php web/pretty_page.php && \
sudo cp core/05-htaccess4 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-pretty4.php core/05-htaccess4 && \
ls web
```

*Notice in the RegEx, this allows a `/` in the middle, but it isn't required...*

| **B-4a** ://

```console
localhost/web/My_Long_Name
```

*...It works without a `/` in the middle...*

*So does it work with `/` in the middle...*

| **B-4b** ://

```console
localhost/web/My_Long_Name/Name-2
```

*...Feel free to try different strings after `localhost/web/`, before and after the `/`*

*And, we don't need any RegEx...*

| **5** :$

```console
sudo cp core/05-pretty5.php web/pretty_page.php && \
sudo cp core/05-htaccess5 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-pretty5.php core/05-htaccess5 && \
ls web
```

| **B-5** ://

```console
localhost/web/pretty
```

### The Settings
Note, Apache .conf is probably:

- `/etc/httpd/conf/httpd.conf` (master - Arch)
- `/etc/httpd/sites-available/inkisaverb.com.conf` (per-site - Arch)
- `/etc/apache2/sites-available/000-default.conf` (default - Ubuntu)
- `/etc/apache2/sites-available/inkisaverb.com.conf` (per-site - Ubuntu)

**RewriteMod** requires three settings to work:

1. Module enabled, in `.conf`: `LoadModule rewrite_module modules/mod_rewrite.so`
- Ubuntu can also use in the terminal: `sudo a2enmod rewrite`
2. Directory tags, in `.conf`:  Between the `<Directory>` tags: `AllowOverride All`
3. `.htaccess` file in web directory: `/srv/www/html/your/web/dir/.htaccess`

*Edit the Apache web server settings file...*

Choose either Arch/Manjaro (5a) or Ubuntu (5u):

| **6a** :$ (Arch/Manjaro)

```console
vim /etc/httpd/conf/httpd.conf
```

| **6u** :$ (Ubuntu)

```console
vim /etc/apache2/sites-available/000-default.conf
```

*vim will open the settings file as "read-only"...*

*In vim, type:*

| **vim-6a** :] `/<Directory` Enter

*This takes you to the settings between the `<Directory>` tags*

**Required settings:**

```
AllowOverride All               # Apache config

Options Indexes FollowSymLinks  # either file
Require all granted             # either file
Order allow,deny                # either file
allow from all                  # either file

RewriteEngine on                # .htaccess
```

*To exit vim, type:*

| **vim-6b** :] Esc `:q!` Enter

### Avoid Bugs
**Remove a trailing slash:**

```
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{REQUEST_URI} (.+)/$
RewriteRule ^ %1 [R=301,L]
```

Without this, a trailing slash with nothing after could trigger a false GET argument

| **B-7a** ://

```console
localhost/web/webapp.php/
```

*Note RewriteRule used the file name as the GET argument*

*This doesn't happen without the trailing slash `/`*

| **B-7b** ://

```console
localhost/web/webapp.php
```

*Try another file...*

| **B-7c** ://

```console
localhost/web/account.php/
```

| **B-7d** ://

```console
localhost/web/account.php
```

*Use all these in our new `.htaccess` file and restore our last `pretty_page.php` file...*

| **8** :$

```console
sudo cp core/05-pretty4.php web/pretty_page.php && \
sudo cp core/05-htaccess6 /srv/www/html/web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
code core/05-htaccess6 && \
ls web
```

*...Now, RewriteMod will simply remove the trailing slash `/`, not get fooled by it...*

| **B-8a** ://

```console
localhost/web/webapp.php/
```

| **B-8b** ://

```console
localhost/web/account.php/
```

*Everything else still works...*

| **B-8c** ://

```console
localhost/web/My_Long_Name
```

*...with and without a `/` in the middle...*

| **B-8d** ://

```console
localhost/web/My_Long_Name/Name-2
```

___

# The Take
### This is only a basic overview!
- RewriteMod has much, much more involved in terms of:
  - What it can do
  - How to be secure
  - How to adjust settings
  - How to make the RegEx fit your needs
- This is only an introduction to show:
  - That it exists
  - Where it exists
  - What its settings can look like
  - How it can work

## RewriteMod
- Is an Apache web server setting
- Changes the URL shown in a browser from what it actually is on the server
- Requires certain settings:
  1. The Apache config file in the `<Directory>` tags
  | **/etc/httpd/sites-available/inkisaverb.com.conf** :
  ```
  <Directory "/srv/www/html"> # (or /srv/www/html/...something)
    AllowOverride All
  </Directory>
  ```
  2. `.htaccess` (a hidden file in the web directory)
  | **/srv/www/html/your/web/dir/.htaccess** :
  ```
  RewriteEngine on
  ```
  3. .htaccess and/or Apache config `<Directory>` tags
  ```
  Options Indexes FollowSymLinks
  Require all granted
  Order allow,deny
  allow from all
  ```

## Format

| **.htaccess** :

```
RewriteEngine on

# Format:
RewriteRule RegEx path [options]

# Arguments:
RewriteRule (RegEx one)(RegEx two)(RegEx three) path/to/$1/somefile.php?foo=$2&bar=$3

# Actual working example:
RewriteRule ^/?([a-zA-Z0-9_-]+)(.*/)?([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$3 [L]
```

## Handling
- Usually, send your RewriteRule to a page with a GET method
- For example:

  With...

  | **.htaccess** :

  ```
  RewriteRule ^/?([a-zA-Z0-9_-]+)(.*/)?([a-zA-Z0-9_-]+)?$ pretty_page.php?a=$1&b=$3 [L]
  ```

  ...a "pretty URL"...
  ```
  https://verb.ink/part-one/part-two

  ```
  ...becomes...
  ```
  https://verb.ink/mypage.php?a=part-one&b=part-two

  ```
  ...with GET processed as...

  | **mypage.php** :
  
  ```php
  $a = $_GET['a'];
  $b = $_GET['b'];
  ```
- Probably use the "pretty URL" wherever you can

___

#### [Lesson 6: AJAX](https://github.com/inkVerb/vip/blob/master/501/Lesson-06.md)
