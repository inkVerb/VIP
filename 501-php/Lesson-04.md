# PHP 501
## Lesson 4: App Install & User Login

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser windows!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** : `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

___

### I. Web App Installer

Nearly all web apps require that you have a database, database username, and database password already set up

*Create our database and its login now...*

| **1** :> `CREATE DATABASE webapp_db;`

| **2** :> `GRANT ALL PRIVILEGES ON webapp_db.* TO webapp_db_user@localhost IDENTIFIED BY 'webappdbpassword';`

| **3** :> `FLUSH PRIVILEGES;`

**Now, we have these database credentials:** (Many web apps ask for this on install)
```
Database name: webapp_db
Database user: webapp_db_user
Database password: webappdbpassword
Database hose: localhost
```

*Get ready to work in our SQL terminal...*

| **4** :> `USE webapp_db`

*Use our install page...*

| **5** :
```
sudo cp core/04-install.php web/install.php && \
sudo cp core/04-config1.in.php web/in.config.php && \
sudo cp core/04-checks.in.php web/in.checks.php && \
sudo cp core/04-functions.in.php web/in.functions.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/install.php web/in.config.php web/in.checks.php web/in.functions.php && \
ls web
```

*In the config, note:*

  - *function escape_sql($data)* (we will start using this instead of mysqli_real_escape_string)

| **install.php** :

**Hash password one-way:**

```php
$password_hashed = password_hash($password, PASSWORD_BCRYPT);
```
This is much like we did in [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md), ***but...***

This can't be decrypted because it is different each time

**SQL escape for each queries value:**

```php
$entry_value_sqlesc = mysqli_real_escape_string($database, $entry_value);
```

**Long ReGex for many special characters:**

Order of these special characters matters in a RegEx!

```php
$db_pass = (preg_match('/[A-Za-z0-9 \'\/&\*=\]\|[<>;,\.:\^\?\+\$%-‘~!@#)(}{_ ]{6,32}$/', $_POST['db_pass']))
```

**Powerful SQL use:**

- We created our SQL config file with `file_put_contents()`
- We made `ALTER` and `CREATE TABLE` SQL queries inside our PHP

*Review the diagrams above along side the following few steps...*

*Look, but don't touch...*

| **B-5** :// `localhost/web/install.php`

*Use Ctrl + Shift + C in browser to see the developer view*

| **S5** :> `SHOW TABLES;`

| **SB-5** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's go back to our webform...*

| **B-5** :// `localhost/web/install.php`

```
Database name: webapp_db
Database user: webapp_db_user
Database password: webappdbpassword
Database hose: localhost

# Our login we will use:
Username: jonboy
Password: My#1Password

# Use whatever you want for all else
```

*Enter the information above into the webform, then continue*

| **S6** :> `SHOW TABLES;`

| **SB-6** ://phpMyAdmin **> webapp_db**

| **S7** :> `SELECT * FROM users;`

| **SB-7** ://phpMyAdmin **> users**

*Note the `pass` column is a long string; that is the one-way hashed password*

*Website ready, now login...*

### II. User Login

**Login requires two things:**

1. Session

```php
$_SESSION array from session_start(); // in our config file
```

2. Reverse-check hash the password

```php
password_verify($form_password, $hashed_password_from_database);
```

This is similar to a hash check from [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md), ***but...***

It only confirms with `true` or `false` because the hash is different each time

*Review the diagrams above along side the following few steps...*

| **8** :
```
sudo cp core/04-login1.php web/webapp.php && \
sudo cp core/04-config2.in.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/webapp.php && \
ls web
```

*gedit: Reload*

  - *in.config.php*

*In the config, note:*

  - *`session_start();`*

| **S8** :> `SELECT id, fullname, pass FROM users WHERE username='jonboy';`

| **SB-8** ://phpMyAdmin **> users**

| **B-8** :// `localhost/web/webapp.php`

*Login with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, refresh the page to see already logged in message...*

| **B-9** :// `localhost/web/webapp.php` (same)


### III. Logout

**Logout can be done 3 ways; use them all!**

"Session Destroy Team Three"

```php
$_SESSION = array(); // Reset the `_SESSION` array
session_destroy(); // Destroy the session itself
setcookie (session_name(), '', time()-300); // Set any cookies to expire in the past (no cookies yet, just be safe)
```

**Redirect in PHP:**

```php
header("Location: /go/to/this/page"); // Can be file or http URL
```

**Sleep:**

```php
sleep($Seconds);
usleep($MicroSseconds);
```

This is similar to `sleep` from [301-02](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-02.md#iv-sleep)

**Rule #1: PHP renders HTML after**

The `echo` message will not display, comment the `header()` line to see the message after waiting 5 seconds

*Review the diagrams above along side the following few steps...*

| **11** :
```
sudo cp core/04-logout1.php web/logout.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/logout.php && \
ls web
```

*After looking through logout.php, continue to be logged out immediately...*

| **B-11** :// `localhost/web/logout.php` (5 second logout and redirect to webapp.php!)

*Let's do that again, but with a logout message instead of waiting...*

| **B-12** :// `localhost/web/webapp.php`

*Login again with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

**Logout variable:**

```php
$just_logged_out = true;
```

*Review the diagram above along side the following two steps...*

| **13** :
```
sudo cp core/04-logout2.php web/logout.php && \
sudo cp core/04-login2.php web/webapp.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/logout.php && \
ls web
```

*gedit: Reload*

  - *logout.php*
 	- *webapp.php*

*After looking through logout.php and webapp.php, continue to be logged out immediately...*

| **B-13** :// `localhost/web/logout.php` (Instant logout and redirect to webapp.php with message!)

*Let's make a login using cookies...*

### IV. 'Remember Me' Login Cookies





// Move this section IV to lesson 7 and create a new database table


| **14** :
```
sudo cp core/04-login3.php web/webapp.php && \
sudo cp core/04-config3.in.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

 	- *webapp.php*
  - *in.config.php*


| **B-10** :// `localhost/web/webapp.php` (Same)










### V. Account Settings


| **12** :
```
sudo cp core/04-accountsettings.php web/webapp.php && \
sudo cp core/04-config2.in.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/webapp.php web/style.css web/in.config.php web/in.functions.php web/in.checks.php && \
ls web
```

*gedit: Reload*

 	- *webapp.php*
  - *in.config.php*

| **S12** :> `SHOW TABLES;`

| **SB-12** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's create them*

| **B-12** :// `localhost/web/webapp.php` (Same)

### VI. Forgot Password


___

# The Take

___

#### [Lesson 5: RewriteMod (Pretty Permalinks)](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-05.md)
