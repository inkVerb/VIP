# Shell 501
## Lesson 5: RewriteMod (Pretty Permalinks)

Ready the CLI

`cd ~/School/VIP/501`

- [Characters for Classes & RegEx](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)
___

### RewriteMod: Apache Web Server Setting

**RewriteMod:** an apache web server settings that changes what a web address looks like

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

| **1** :
```
sudo cp core/05-pretty1.php web/pretty_page.php && \
sudo cp core/05-htaccess1 /var/www/html/web/.htaccess && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/pretty_page.php /var/www/html/web/.htaccess && \
ls web
```

*Anything after `localhost/web/` made of letters and underscore should simply echo in the browser...*

| **B-1** :// `localhost/web/My_Long_Name`

*...Feel free to try different strings after `localhost/web/`*

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
```

*We just tried number 2 above, now let's try 1...*

| **2** :
```
sudo cp core/05-htaccess2 /var/www/html/web/.htaccess && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

  - *.htaccess*

| **B-2** :// `localhost/web/My_Long_Name`

*...Feel free to try different strings after `localhost/web/`*

*We just tried number 2 above, now let's try 3...*

| **3** :
```
sudo cp core/05-pretty3.php web/pretty_page.php && \
sudo cp core/05-htaccess3 /var/www/html/web/.htaccess && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

  - *.htaccess*
  - *pretty_page.php*

*Notice in the RegEx, this requies a `/` in the middle, otherwise it won't work...*

| **B-3a** :// `localhost/web/My_Long_Name`

*...It doesn't work because the RegEx only recognizes a string with a `/` in the middle*

*So, try one with a `/`...*

| **B-3b** :// `localhost/web/My_Long_Name/Name-2`

*...Feel free to try different strings after `localhost/web/`, before and after the `/`*

*We just tried number 2 above, now let's try 3...*

| **4** :
```
sudo cp core/05-pretty4.php web/pretty_page.php && \
sudo cp core/05-htaccess4 /var/www/html/web/.htaccess && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

  - *.htaccess*
  - *pretty_page.php*

*Notice in the RegEx, this allows a `/` in the middle, but it isn't required...*

| **B-4a** :// `localhost/web/My_Long_Name`

*...It works without a `/` in the middle...*

*So does it work with `/` in the middle...*

| **B-4b** :// `localhost/web/My_Long_Name/Name-2`

*...Feel free to try different strings after `localhost/web/`, before and after the `/`*

### The Settings

**RewriteMod** requires two settings to work:

1. Apache config: `/etc/apache2/sites-available/website-config.conf` in the `<Directory>` tags
2. .htaccess: `/var/www/html/your/web/dir/.htaccess`

*Edit the Apache web server settings file...*

| **5** : `vim /etc/apache2/sites-available/000-default.conf`

*vim will open the settings file as "read-only"...*

*In vim, type:*

| **vim-5a** :] `/<Directory` Enter

*This takes you to the settings between the `<Directory>` tags*

**Required dettings:**
```
AllowOverride All               # Apache config

Options Indexes FollowSymLinks  # either file
Require all granted             # either file
Order allow,deny                # either file
allow from all                  # either file

RewriteEngine on                # .htaccess
```

*To exit vim, type:*

| **vim-5b** :] Esc `:q!` Enter
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
  | **/etc/apache2/sites-available/website-config.conf** :
  ```
  <Directory "/var/www/html"> # (or /var/www/html/...something)
    AllowOverride All
  </Directory>
  ```
  2. .htaccess (a hidden file in the web directory)
  | **/var/www/html/your/web/dir/.htaccess** :
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
#RewriteRule RegEx path [options]

# Arguments:
RewriteRule (RegEx one)(RegEx two)(RegEx three) path/to/$1/somefile.php?foo=$2&bar=$3

# Actual working example:
RewriteRule ^/?([a-zA-Z0-9_-]+)(.*/)?([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$3 [L]
```

## Handling
- Usually, send your RewriteRule to a page with a GET method
- For example:

  "Pretty URL"...
  ```
  https://verb.ink/part-one/part-two

  ```
  ...becomes...
  ```
  https://verb.ink/mypage.php?a=part-one&b=part-two

  ```
  ...with GET processed as...

  | **.htaccess** :
  ```php
  $a = $_GET['a'];
  $b = $_GET['b'];
  ```
- Probably use the "pretty URL" wherever you can

___

#### [Lesson 6: AJAX](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-06.md)
