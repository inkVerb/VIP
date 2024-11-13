# Linux 501
## Lesson 4: App Install & User Login

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

### This lesson uses two terminals and two browser tabs!
Ready the secondary SQL terminal and secondary SQL browser

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mariadb -u admin -padminpassword
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **SB-0** :// Username: `admin` Password: `adminpassword`

```console
localhost/phpMyAdmin/
```

### Used later in this lesson
*SQL database: (after command 6)*

| **L0** :>

```sql
USE firstapp_db
```

*Webapp login: (after command 11)*

| **LB-0** ://

```console
localhost/web/webapp.php
```

*Login with our credentials...*

```
Username: jonboy
Password: My#1Password
```

___

### I. PHP Epoch & Time
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

| **1** :$

```console
sudo cp core/04-time.php web/time.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-time.php && \
ls web
```

| **B-1** ://

```console
localhost/web/time.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

### II. Password Hash Checks
**Hash password one-way:**

```php
$password_hashed = password_hash($password, PASSWORD_BCRYPT);
```

This is much like a hash made in [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201/Lesson-08.md), ***but...***

This hash can't be decrypted because it creates a different hash each time

**Check password hash:**

```php
password_verify($password, $password_hashed);
```

This is much like a hash check in [201-08: Hash – md5sum, sha1sum, sha256sum, sha512sum](https://github.com/inkVerb/vip/blob/master/201/Lesson-08.md), ***but...***

This only returns `true` or NULL because the hash is different each time

| **2** :$

```console
sudo cp core/04-passhash.php web/passhash.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-passhash.php && \
ls web
```

| **B-2** ://

```console
localhost/web/passhash.php
```

*Enter any password you want*

*Note:*
- *The same password is hashed 5 times*
- *Each hash is different, but from the same password*
- *Each different hash checks out because they came from the same password*
- *Check number 6 is an example of a `password_verify()` hash check fail*

Conclusion:

- You cannot use the password or hash to find a match for a use in the SQL table
- You must get the password hash from the SQL table first, then check it against the password submitted in the `<form>` using `password_verify()`
- Using the password or hash to find an SQL match for a user is an out-dated method of validating a user

### III. Web App Installer
Nearly all web apps require that you have a database, database username, and database password already set up

*Create our database and its login now...*

| **3** :>

```sql
CREATE DATABASE firstapp_db;
```

| **4** :>

```sql
GRANT ALL PRIVILEGES ON firstapp_db.* TO firstapp_db_user@localhost IDENTIFIED BY 'webappdbpassword';
```

| **5** :>

```sql
FLUSH PRIVILEGES;
```

**Now, we have these database credentials:** (Many web apps ask for this on install)
```
Database name: firstapp_db
Database user: firstapp_db_user
Database password: webappdbpassword
Database host: localhost
```

*Get ready to work in our SQL terminal...*

| **6** :>

```sql
USE firstapp_db
```

*Use our install page...*

| **7** :$

```console
mkdir preapp
mv web/* preapp/
sudo cp core/04-install1.php web/install.php && \
sudo cp core/04-in.config1.php web/in.config.php && \
sudo cp core/04-in.checks.php web/in.checks.php && \
sudo cp core/04-in.functions.php web/in.functions.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-install1.php core/04-in.config1.php core/04-in.checks.php core/04-in.functions.php && \
ls web
```

*Note `in.config.php` (`04-in.config1.php`):*

- *`function escape_sql($data)`* (we will start using this instead of mysqli_real_escape_string)
  - *The `is_null()` test makes sure we don't run `preg_replace()` against a null variable, which isn't allowed*

*Note `in.functions.php` (`04-in.functions.php`):*

- *Validation and sanitizing set a `$regex_` variable first, which is more neat and tidy*
- *This style isolates the RegEx to help any RegEx hunting in the future*

| **install.php** :

**Hash the password:**

```php
$password_hashed = password_hash($password, PASSWORD_BCRYPT);
```

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

**Powerful SQL-PHP workflow:**

- Create the SQL config file with `file_put_contents()`
- Make SQL settings via `ALTER` and `CREATE TABLE` SQL queries inside the PHP

*Review the diagrams above along side the following few steps...*

*Look, but don't touch...*

| **B-7** ://

```console
localhost/web/install.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

| **S7** :>

```sql
SHOW TABLES;
```

| **SB-7** ://phpMyAdmin **> firstapp_db**

*Note our database has no tables*

*Let's fill-in our webform...*

| **B-8** :// (same, start filling-in)

```console
localhost/web/install.php
```

```
Database name: firstapp_db
Database user: firstapp_db_user
Database password: webappdbpassword
Database host: localhost

# Our login we will use:
Username: jonboy
Password: My#1Password

# Use whatever you want for all else
```

*Enter the information above into the webform, then continue*

| **S8** :>

```sql
SHOW TABLES;
```

| **SB-8** ://phpMyAdmin **> firstapp_db**

| **S9** :>

```sql
SELECT * FROM users;
```

| **SB-9** ://phpMyAdmin **> users**

*Note the `pass` column is a long string; that is the one-way hashed password*

*Set defaults for our install page...*

| **10** :$

```console
sudo cp core/04-install2.php web/install.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-install2.php && \
ls web
```

| **B-10** ://

```console
localhost/web/install.php
```

*Note the new block of code checks for an existing `in.sql.php` file, for if it was already installed*
 - *`DEFINE ('DB_CONFIGURED', true);` sets if the installation is configured*
   - *Without this line, the installer will still work, but the fields in the form can be already filled-in, such as if we already created a database with credentials*
     - *We will do more with this in [601 Lesson 8: Packages](https://github.com/inkVerb/vip/blob/master/601/Lesson-08.md) and the [Package Architectures Cheat Sheet](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Package-Architectures.md) with the [**501webapp**](https://github.com/inkVerb/501webapp) package*
 - *If `(defined('DB_CONFIGURED')) && (DB_CONFIGURED == true)`, then `exit (header("Location: webapp.php"));` exits and redirects to the main blog*
 - *This allows for database credentials to be pre-configured, but not yet installed*

| **install.php** :

```php
// Redirect if already configured
if (file_exists('./in.sql.php'))  {

  // Include the file we know we have
  require_once ('./in.sql.php');

  // Configured?
  if ((defined('DB_CONFIGURED')) && (DB_CONFIGURED == true)) {
    exit (header("Location: webapp.php"));
  }
}

...

// POSTed form?
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

...

    // Heredoc:
    $sqlConfigFile = <<<EOF
<?php
DEFINE ('DB_NAME', '$db_name');
DEFINE ('DB_USER', '$db_user');
DEFINE ('DB_PASSWORD', '$db_pass');
DEFINE ('DB_HOST', '$db_host');

// This disables the installer
DEFINE ('DB_CONFIGURED', true);
EOF;

    // Write the file:
    file_put_contents('./in.sql.php', $sqlConfigFile);

...

// Installed already, so in.sql.php already exists, but not DB_CONFIGURED?
} elseif ( (file_exists('./in.sql.php'))
 && (defined('DB_NAME'))
 && (defined('DB_USER'))
 && (defined('DB_PASSWORD'))
 && (defined('DB_HOST')) )  {

  // Database variables
  $db_name = DB_NAME;
  $db_user = DB_USER;
  $db_pass = DB_PASSWORD;
  $db_host = DB_HOST;

// Don't let those variables be empty
} else {
  
  // Blank database variables
  $db_name = '';
  $db_user = '';
  $db_pass = '';
  $db_host = '';

} // Finish POST/installed if

// Our actual signup page

echo '<h1>Admin signup</h1>';
echo '
<form action="install.php" method="post">';

echo '<b>Database info</b><br><br>
Database name: <input type="text" name="db_name" value="'.$db_name.'"><br><br>
Database username: <input type="text" name="db_user" value="'.$db_user.'"><br><br>
Database password: <input type="text" name="db_pass" value="'.$db_pass.'"><br><br>
Database host: <input type="text" name="db_host"  value="'.$db_host.'"> (leave as <i>localhost</i> unless told otherwise)<br><br>
<br><br>
<b>Admin user</b><br><br>';
```

*Note on install pages:*
- *This `install.php` file should be deleted if we aren't using it, but we won't do that now because we are still testing*
- *On a production website, once installed, either this file must automatically redirect or be removed so we don't compromise the system*

*You may just move on or run the installer again, create a second web admin login, and see what changes; move on when you are ready*

*Website ready*

*Before logging in, let's talk about time...*

### IV. User Login

PHP has 3 main groups of variables:

```php
// Script-specific: (stop working after the PHP script finishes)
$Simple_variable or $Simple_Array[0] // Must be "global" to work inside and outside functions
CONSTANT_VARIABLE // Never changes, work everywhere, called only "constant"

// Method arrays: (work only from form submission or page load)
$_GET // set in URL
$_POST // not in URL

// Persistent arrays: (keep working in the browser even after the PHP script finishes)
$_SESSION // - Server-RAM  - Until browser closes or too much time passes
$_COOKIE  // - Client-disk - Even after browser closes, until certain time passes
```

Login uses `$_SESSION` and `$_COOKIE` variables

`$_COOKIE` variables use PHP time

**Login requires two things:**

1. Session

```php
session_start(); // Must start the SESSION in every PHP script (in our config file)
$_SESSION['some_key'] = "some value";
```

2. Reverse-check hash the password

```php
password_verify($form_password, $hashed_password_from_database);
```

*Review the diagrams above along side the following few steps...*

| **11** :$

```console
sudo cp core/04-login1.php web/webapp.php && \
sudo cp core/04-in.config2.php web/in.config.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-login1.php core/04-in.config2.php && \
ls web
```

*Note `in.config.php` (`04-in.config2.php`):*

- *`session_start();`*

| **S11** :>

```sql
SELECT id, fullname, pass FROM users WHERE username='jonboy';
```

| **SB-11** ://phpMyAdmin **> users**

| **B-11a** ://

```console
localhost/web/webapp.php
```

*Login with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, re-enter the page to see already logged in message...  (not reload)*

| **B-11b** :// (same)

```console
localhost/web/webapp.php
```

### V. Logout
**Logout can be done 3 ways; use them all!**

"Session Destroy Team Three"

```php
$_SESSION = array(); // Reset the `_SESSION` array
session_destroy(); // Destroy the session itself
setcookie(session_name(), '', 86401); // Set any _SESSION cookies to expire in Jan 1970
setcookie(session_name(), '', time()-300);  // Wrong! (depending on your timezone, this could be in the future!)
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

This is similar to `sleep` from [301-02](https://github.com/inkVerb/vip/blob/master/301/Lesson-02.md#iv-sleep)

**Rule #1: PHP renders HTML after**

The `echo` message will not display, comment the `header()` line to see the message after waiting 5 seconds

*Review the diagrams above along side the following few steps...*

| **12** :$

```console
sudo cp core/04-logout1.php web/logout.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-logout1.php && \
ls web
```

*After looking through `logout.php`, continue to be logged out immediately...*

| **B-12a** :// (5 second logout and redirect to `webapp.php`!)

```console
localhost/web/logout.php
```

*Let's do that again, but with a logout message instead of waiting...*

| **B-12b** ://

```console
localhost/web/webapp.php
```

*Login again with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

**Logout `$_SESSION` variable:**

```php
$_SESSION['just_logged_out'] = true;
```

*Review the diagram above along side the following two steps...*

| **13** :$

```console
sudo cp core/04-logout2.php web/logout.php && \
sudo cp core/04-login2.php web/webapp.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-logout2.php core/04-login2.php && \
ls web
```

*Note:*

- *`logout.php` (`04-logout2.php`)*
- *`webapp.php` (`04-login2.php`)*

*After looking through `logout.php` and `webapp.php`, continue to be logged out immediately...*

| **B-13** :// (Instant logout and redirect to `webapp.php` with message!)

```console
localhost/web/logout.php
```

*Let's make a login using cookies...*

### VI. 'Remember Me' Login Cookies
Cookies are much like the `$_SESSION` array, but

1. They have an expiration (in **PHP epoch**)
2. They are set with the `setcookie()` function

Create a cookie:

```php
setcookie("cookie_name", $cookie_value, $cookie_expires);
```

Now, this will exist at that domain/host:

```php
$_COOKIE['cookie_name']
```

Unset the cookie:

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

| **14** :$ (You can use a `*` wildcard with `cd` if there is only one file possible)

```console
cd ~/.mozilla/firefox/*.default
```

| **15** :$

```console
ls
```

*Chromium, if you have it installed...*

| **16** :$

```console
cd ~/.config/chromium/Default
```

| **17** :$

```console
ls
```

***This is how cookies work...*** **the wrong way:** `user_id`

For teaching, we will put the **user_id** as the cookie's value, but this is not secure!

| **18** :$

```console
sudo cp core/04-logout3.php web/logout.php && \
sudo cp core/04-login3.php web/webapp.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-logout3.php core/04-login3.php && \
ls web
```

*Note:*

- *`webapp.php` (`04-login3.php`)*
- *`logout.php` (`04-logout3.php`)*

*Review cookie logic in `webapp.php` by searching "$_COOKIE"*

| **B-18a** :// (previous)

```console
localhost/web/webapp.php
```

*Check "Remember me, then login again with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Load the page again to see the cookies remember your login...*

| **B-18b** :// (same)

```console
localhost/web/webapp.php
```

#### Never put username, password, email, name, or other user info in a cookie!
- This is a matter or proper security habits
- Cookies should only store information that only your app can interpret
- Cookies store otherwise useless information which you then use to look up the user's specific information in your SQL database
- This was only an example of how a cookie behaves
- Later we will put a secret key into the cookie for proper security

#### Variable Review
4 types of PHP variables:

1. Simple (ends with PHP script)
```php
$Variable = "Some value";
global $Variable; // Make it global
```

2. Constant (ends with PHP script)
```php
DEFINE ('CONSTANT_NAME', 'some value');
```
... Now you can use this as a variable:
```php
CONSTANT_NAME
```

3. SESSION (continues after PHP script and page reload)
```php
 // Start SESSION in each PHP file using it
session_start();

// Use SESSION array variables
$_SESSION['some_key'] = "some value";

// End the SESSION with "Destroy Team Three"
$_SESSION = array(); // Reset
session_destroy(); // Destroy
setcookie(session_name(), '', 86401); // 86401 = sometime in Jan 1970
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

### VII. Account Settings

| **19** :$

```console
sudo cp core/04-account.php web/account.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-account.php && \
ls web
```

*Try an alternate way for no-login by searching "`webapp.php`" and uncommenting the line*

| **B-19** ://

```console
localhost/web/account.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

| **S19** :>

```sql
SELECT fullname, username, email, favnumber FROM users;
```

| **SB-19** ://phpMyAdmin **> users**

*Also try logging out and logging in with these pages from before:*

| **Logout** ://

```console
localhost/web/logout.php
```

| **Login** ://

```console
localhost/web/webapp.php
```

```
Username: jonboy
Password: My#1Password
```

*Try making changes or saving without changes, or enter invalid values*

*When finished, make sure the username and password are the same for future reference*

### VIII. Forgot Password
*Make sure you know your favorite number and email before continuing...*

| **S20** :>

```sql
SELECT id, fullname, email, favnumber FROM users;
```

| **SB-20** ://phpMyAdmin **> users**

*This simple "forgot password" page logs in via email and favorite number, rather than username and password...*

***This is a simple example, but it is not secure; we will use a secure way later in future lessons***

| **20** :$

```console
sudo cp core/04-forgot.php web/forgot.php && \
sudo chown -R www:www /srv/www/html && \
code core/04-forgot.php && \
ls web
```

| **B-20** ://

```console
localhost/web/forgot.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*...You must be logged out for it to work*

*These might come in handy...*

| **Logout** ://

```console
localhost/web/logout.php
```

| **Login** ://

```console
localhost/web/webapp.php
```

| **Login** ://

```console
localhost/web/account.php
```

*Success: You will get an SQL query to try*

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
  setcookie(session_name(), '', 86401); // Expire
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

#### [Lesson 5: RewriteMod (Pretty Permalinks)](https://github.com/inkVerb/vip/blob/master/501/Lesson-05.md)
