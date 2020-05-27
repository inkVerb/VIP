# Shell 501
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
Database host: localhost
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

*In the in.functions.php, note:*

- *Validation and sanitizing set a `$regex_` variable first, which is more neat and tidy*
- *This style isolates the RegEx to help any RegEx hunting in the future*

| **install.php** :

**Hash password one-way:**

```php
$password_hashed = password_hash($password, PASSWORD_BCRYPT);
```
This is much like we did in [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md), ***but...***

This can't be decrypted because it is different each time

**SQL escape for each query's value:**

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

| **B-5a** :// `localhost/web/install.php`

*Use Ctrl + Shift + C in browser to see the developer view*

| **S5** :> `SHOW TABLES;`

| **SB-5** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's go back to our webform...*

| **B-5b** :// `localhost/web/install.php` (same, start filling-in)

```
Database name: webapp_db
Database user: webapp_db_user
Database password: webappdbpassword
Database host: localhost

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

*Website ready*

*Before logging in, let's talk about time...*

### II. PHP Epoch & Time

**The PHP epoch:** *seconds from midnight Jan 1, 1970*

The PHP epoch is an integer, so you can add time with simple arithmetic

Many coders add time with human-readable multiplication:

```php
60 // 1 minute
60 * 60 // 1 hour
24 * 60 * 60 // 1 day
365 * 24 * 60 * 60 // 1 year
500 * 365 * 24 * 60 * 60 // 500 years
```

Nifty tools for PHP epoch, time, and length

```php
$date_now = date("Y-m-d H:i:s"); // SQL date format
$epoch_date_now = strtotime($date_now); // SQL date -> PHP epoch
$epoch_time_now = time(); // PHP epoch
$thirty_days = (30 * 24 * 60 * 60); // (30 days * hours * minutes * seconds)
$epoch_later = $epoch_time_now + $thirty_days; // epoch 30 days from now
$epoch_simple_later = time() + (30 * 24 * 60 * 60); // epoch 30 days from now
$date_later = date("Y-m-d H:i:s", substr($epoch_later, 0, 10)); // epoch -> SQL date (for whatever date $epoch_later is)
```

Just the PHP epoch later

```php
$epoch_simple_later = time() + (30 * 24 * 60 * 60);
```

**Time demo**

*Review the diagrams above along side the following few steps...*

| **8** :
```
sudo cp core/04-time.php web/time.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/time.php && \
ls web
```

| **B-8** :// `localhost/web/time.php`

*Use Ctrl + Shift + C in browser to see the developer view*

### III. User Login

PHP has 4 types of variables:

```php
// File specific: (stop working after the file finishes)
$Simple_variables // May be "global" to work with functions
CONSTANT_VARIABLES // Never change, work everywhere

// Universal: (work even after the file finishes)
$_SESSION // Until browser closes or too much time passes
$_COOKIE // Even after browser closes, until certain time passes
```

Login uses `$_SESSION` and `$_COOKIE` variables

`$_COOKIE` variables use PHP time

**Login requires two things:**

1. Session

```php
session_start(); // Must start the SESSION in every file (in our config file)
$_SESSION['some_key'] = "some value";
```

2. Reverse-check hash the password

```php
password_verify($form_password, $hashed_password_from_database);
```

This is similar to a hash check from [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-08.md), ***but...***

It only confirms with `true` or `false` because the hash is different each time

*Review the diagrams above along side the following few steps...*

| **9** :
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

| **S9** :> `SELECT id, fullname, pass FROM users WHERE username='jonboy';`

| **SB-9** ://phpMyAdmin **> users**

| **B-9a** :// `localhost/web/webapp.php`

*Login with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, refresh the page to see already logged in message...*

| **B-9b** :// `localhost/web/webapp.php` (same)


### IV. Logout

**Logout can be done 3 ways; use them all!**

"Session Destroy Team Three"

```php
$_SESSION = array(); // Reset the `_SESSION` array
session_destroy(); // Destroy the session itself
setcookie(session_name(), null, 86401); // Set any _SESSION cookies to expire in Jan 1970
setcookie(session_name(), null, time()-1);  // Wrong! (depending on your timezone, this could be in the future!)
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

| **10** :
```
sudo cp core/04-logout1.php web/logout.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/logout.php && \
ls web
```

*After looking through logout.php, continue to be logged out immediately...*

| **B-10a** :// `localhost/web/logout.php` (5 second logout and redirect to webapp.php!)

*Let's do that again, but with a logout message instead of waiting...*

| **B-10b** :// `localhost/web/webapp.php`

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

| **11** :
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

| **B-11** :// `localhost/web/logout.php` (Instant logout and redirect to webapp.php with message!)

*Let's make a login using cookies...*

### V. 'Remember Me' Login Cookies

Cookies are much like the `$_SESSION` array, but

1. They have an expiration (in **PHP epoch**)
2. They are set with the `setcookir()` function

Create a cookie:

```php
setcookie("cookie_name", $cookie_value, $cookie_expires);
```

Now, this will exist at that domain/host:

```php
$_COOKIE['cookie_name']
```

Unset the cookie

```php
unset($_COOKIE['cookie_name']); // Unset the cookie so if tests don't find it later
setcookie('cookie_name', null, 86401); // Set our cookie value to "null" (nothing) and expire in Jan 1970
setcookie('cookie_name', null, time()-1);  // Wrong! (depending on your timezone, this could be in the future!)
```

Cookies are stored in files on the "Client" (user's local machine)

- These are encrypted files that you can't open:
  - Chrome: `~/.config/google-chrome/Default/Cookies`
  - Chromium: `~/.config/chromium/Default/Cookies`
  - Firefox: `~/.mozilla/firefox/????????.default/` (It has a random name)

*Have a look at Firefox cache data, where cookies are kept...*

| **12** : `cd ~/.mozilla/firefox/*.default` (You can use a `*` wildcard if there is only one file possible)

| **13** : `ls`

*Chromium, if you have it installed...*

| **14** : `cd ~/.config/chromium/Default`

| **15** : `ls`

***This is how cookies work...*** **the wrong way:** user_id

For teaching, we will put the **user_id** as the cookie's value, but this is not secure!

| **16** :
```
sudo cp core/04-login3.php web/webapp.php && \
sudo cp core/04-logout3.php web/logout.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

- *webapp.php*
- *logout.php*

*Review cookie logic in webapp.php by searching "$_COOKIE"*

| **B-16a** :// `localhost/web/webapp.php` (previous)

*Check "Remember me, then login again with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Load the page again to see the cookies remember your login...*

| **B-16b** :// `localhost/web/webapp.php` (same)

#### Never put username or password in a cookie!

This was only an example of how a cookie behaves

Later we will put a secret key into the cookie for proper security

### Variable Review

4 types of PHP variables:

1. Simple (ends with file)
```php
$Variable = "Some value";
global $variable; // Make it global
```

2. Constant (ends with file)
```php
DEFINE ('CONSTANT_NAME', 'some value');
```
... Now you can use this as a variable:
```php
CONSTANT_NAME
```

3. SESSION (continues after file and page reload)
```php
 // Start SESSION in each file using it
session_start();

// Use SESSION array variables
$_SESSION['some_key'] = "some value";

// End the SESSION with "Destroy Team Three"
$_SESSION = array(); // Reset
session_destroy(); // Destroy
setcookie(session_name(), null, 86401); // 86401 = sometime in Jan 1970
```

4. COOKIE (continues after browser closes)
```php
// Create a cookie
setcookie("cookie_name", $cookie_value, $cookie_expires);
// ... Now we have ...
$_COOKIE['cookie_name'];

// Unset then expire the COOKIE
unset($_COOKIE['cookie_name']); // Unset
setcookie('cookie_name', null, 86401); // 86401 = sometime in Jan 1970
```

### VI. Account Settings

| **17** :
```
sudo cp core/04-accountsettings.php web/account.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/account.php && \
ls web
```

*Try an alternate way for no-login by searching "webapp.php" and uncommenting the line*

| **B-17** :// `localhost/web/account.php`

*Use Ctrl + Shift + C in browser to see the developer view*

| **S17** :> `SELECT fullname, username, email, favnumber FROM users;`

| **SB-17** ://phpMyAdmin **> users**

*Also try logging out and logging in with these pages from before:*

| **Logout** :// `localhost/web/logout.php`

| **Login** :// `localhost/web/webapp.php`

*Try making changes or saving without changes, or enter invalid values*

*When finished, make sure the username and password are the same for future reference*

```
Username: jonboy
Password: My#1Password
```

### VII. Forgot Password

*Make sure you remember your favorite number and email before continuing...*

| **18** :
```
sudo cp core/04-forgot.php web/forgot.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/forgot.php && \
ls web
```

| **B-18** :// `localhost/web/forgot.php`

*Use Ctrl + Shift + C in browser to see the developer view*

*...You must be logged out for it to work*

*These might come in handy...*

| **Logout** :// `localhost/web/logout.php`

| **Login** :// `localhost/web/webapp.php`

| **Login** :// `localhost/web/account.php`

*Success: You will get an SQL query to try, also review these:*

| **S18** :> `SELECT id, fullname, email, favnumber FROM users;`

| **SB-18** ://phpMyAdmin **> users**

___

# The Take

## Web App Installer
- Web apps use SQL
  - database name
  - database user
  - database password
  - database host (`localhost` or `https://...`)

## Escape Queries Before Sending to SQL
- Escape function: `mysqli_real_escape_string()`
- We did this in our own function: `escape_sql()`

## Hash & Unhash Passwords
- Hash a password for database `password_hash()`
- Check passwords with reverse hash: `password_verify()`

## PHP Epoch & Time
- Time functions
  - PHP epoch: `time()`
  - SQL date: `date("Y-m-d H:i:s")`
  - SQL date -> PHP epoch: `strtotime($sql_date)`
  - epoch -> SQL date: `date("Y-m-d H:i:s", substr($epoch, 0, 10))`

- **Epoch:** *seconds from midnight Jan 1, 1970*
  - `86401` = sometime in Jan 1970, any timezone
  - Use human-readable multiplication to add to time:
    - One day: `24 * 60 * 60`
    - One week: `7 * 24 * 60 * 60`

## User Login Variables
- SESSION
  ```php
  session_start();
  $_SESSION['some_key'] = "some value";
  ```
- COOKIE
  ```php
  setcookie("cookie_name", $cookie_value, $cookie_expires);
  $_COOKIE['cookie_name'];
  ```
  - Cookie location:
    - Chrome: `~/.config/google-chrome/Default/Cookies`
    - Chromium: `~/.config/chromium/Default/Cookies`
    - Firefox: `~/.mozilla/firefox/????????.default`

### Never put username or password in a cookie!

## Logout Destroys & Expires *all* Login variables
- Set expire times to `86401`
- SESSION destroy: (Team Three)
  ```php
  $_SESSION = array(); // Reset
  session_destroy(); // Destroy
  setcookie(session_name(), null, 86401); // Expire
  ```
- COOKIE destroy:
  ```php
  unset($_COOKIE['cookie_name']); // Unset
  setcookie('cookie_name', null, 86401); // Expire
  ```

## Account Settings
- Like a signup form, already filled in from the database

## Forgot Password
- Check the database for other information from the database

___

#### [Lesson 5: RewriteMod (Pretty Permalinks)](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-05.md)
