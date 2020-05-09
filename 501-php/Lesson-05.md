# PHP 501
## Lesson 5: RewriteMod (Pretty Permalinks)

Ready the CLI

`cd ~/School/VIP/501`

- [Characters for Classes & RegEx](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)
___

### RewriteMod: Apache Web Server Setting

**RewriteMod:** an apache web server settings that changes what a web address looks like

1. Rewrite uses a RegEx, just like PHP `preg_match()` and `preg_replace()`
2. Rewrite often hides GET value syntax in the URL
3. Each `(parenthetical set)` in the RegEx becomes an argument in the URL as `$1`, `$2`, `$3`, etc
```
RewriteRule RegEx URL [options]

RewriteRule (one)(two)(three) path/to/$1/somefile.php?foo=$2&bar=$3
```

For example:

What looks like...

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

| **B-1** :// `localhost/web/My_Long_Name`

*Anything after `localhost/web/` made of letters and underscore should simply echo in the browser*

### RewriteMod Other Settings


```
RewriteEngine on

# localhost/whatever/Value_Here ...to absolute path (notice the slash in /pretty_page.php)
RewriteRule ^/?([a-zA-Z0-9_]+)$ /pretty_page.php?n=$1 [L]

# localhost/whatever/Value_Here ...to relative path (no slash in pretty_page.php)
RewriteRule ^/?([a-zA-Z0-9_]+)$ pretty_page.php?n=$1 [L]

# localhost/whatever/Value_One/Value_Two (certainly a middle slash)
RewriteRule ^/?([a-zA-Z0-9_-]+)/([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$2 [L]

# localhost/whatever/Valye_One/Value_Maybe (maybe a middle slash, if so it becomes $2)
RewriteRule ^/?([a-zA-Z0-9_-]+)(.*/)?([a-zA-Z0-9_-]+)?$ pretty_page.php?n=$1&o=$3 [L]
```

___

# The Take

## Format

## Handling

___

#### [Lesson 6: AJAX](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-06.md)
