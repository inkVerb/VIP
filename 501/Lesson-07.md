# Shell 501
## Lesson 7: Security Keys

Ready the CLI

```console
cd ~/School/VIP/501
```

Ready services

Arch/Manjaro & CentOS/Fedora
```console
sudo systemctl start httpd mariadb
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mysql
```

### This lesson uses two terminals and two browser tabs!

Ready the secondary SQL terminal and secondary SQL browser

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u admin -padminpassword
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :>

```console
USE webapp_db;
```

| **S1** ://phpMyAdmin **> webapp_db**

___

### Random String

| **1** :$
```
sudo cp core/07-recover1.php web/recover.php && \
sudo cp core/07-in.string_functions.php web/in.string_functions.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-recover1.php core/07-in.string_functions.php && \
ls web
```

*Note that we are including in.string_functions.php, give it a good look over*

| **B-1** ://

```console
localhost/web/recover.php
```

*Refresh the page a few times to see new strings*

*Let's use our random string in an SQL table...*

### Login Recovery (via Security Key)

| **2** :$
```
sudo cp core/07-recover2.php web/recover.php && \
sudo cp core/07-ajaxstring.php web/ajax_string.php && \
sudo cp core/07-recover_login.php web/recover_login.php && \
sudo cp core/07-webapp.php web/webapp.php && \
sudo cp core/07-in.loginhead1.php web/in.login_head.php && \
sudo cp core/07-account.php web/account.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-recover2.php core/07-ajaxstring.php core/07-recover_login.php core/07-webapp.php core/07-in.loginhead1.php core/07-account.php && \
ls web
```

*Note:*

- *recover.php uses a recovery form and AJAX script*
  - The AJAX POST sends the user ID
- *ajax_string.php processes the AJAX action*
  - This creates a string and enters it into the "strings" table with a 20 second expiration date
  - The AJAXed file also requires the config file for the `session` and database connection
- *recover_login.php processes the random string as a GET value*
  - The string is tested in the database for a match and expiration date
  - If matched, the page redirects to webapp.php using `header`
- *account.php has links for logout and the main webapp*
- *webapp.php replaced the login workflow an `include` for in.login_head.php*
- *in.login_head.php:*
  - contains the login workflow that webapp used to
  - has links for Account Settings and logout

*Look through those files carefully*

*Note the duplicate check in ajax_string.php:*

```php
// Create our string
$random_string = alnumString(32);

// Check to see if the string already exists in the database
$query = "SELECT random_string FROM strings WHERE BINARY random_string='$random_string'";
$call = mysqli_query($database, $query);

// Dup fix loop
while (mysqli_num_rows($call) != 0) {
  $random_string = alnumString(32);
  // Check again
  $query = "SELECT random_string FROM strings WHERE BINARY random_string='$random_string'";
  $call = mysqli_query($database, $query);
  if (mysqli_num_rows($call) == 0) {
    break; // end the loop
  }
}
```

*...Note how we run the same query both inside and outside the loop,*

*then `break` when we get what we want*

<!-- DEV NOTE: Why is this SQL statement here? It seems redundant from Lesson 4 install.php if using webapp_db -->

| **2** :>

```sql
CREATE TABLE IF NOT EXISTS `strings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` INT UNSIGNED NOT NULL,
  `random_string` VARCHAR(255) DEFAULT NULL,
  `usable` ENUM('live', 'dead') NOT NULL,
  `date_expires` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
GRANT ALL PRIVILEGES ON webapp_db.* TO webapp_db_user@localhost IDENTIFIED BY 'webappdbpassword';
FLUSH PRIVILEGES;
```

<!-- DEV NOTE end -->

| **SB-2** ://phpMyAdmin **> strings**

| **B-2** :// (It will require credentials)

```console
localhost/web/recover.php
```

```
Username: jonboy
Favorite Number: (same as before)
```

*If you forgot your favorite number, get it here:*

| **2-opt** :>

```console
SELECT * FROM users;
```

**Follow along...**

*From steps 2-4 you have 20 seconds!*

1. *Enter the Username and Favorite number*
2. *Click "Get your recover string link..."*
3. *Look at the string in the table:*

| **3** :>

```console
SELECT * FROM strings;
```

4. *Click your login link in the browser*
5. *Check to see that your key is "dead":*

| **4** :>

```console
SELECT * FROM strings;
```

### Cleanup

*Review our strings...*

| **5** :>

```console
SELECT * FROM strings;
```

| **SB-5** ://phpMyAdmin **> strings**

1. Click the button: **Get your recovery string link...**
  - Each time, check new entries in the database:
    - :> `SELECT * FROM strings;`
    - ://phpMyAdmin **> strings**
2. Try the three SQL queries under **...Teaching tip...**
3. Click the link to login, but note it should have expired
4. Click around and explore
  - Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> to see the developer view of pages
  - Compare the pages with the .php files

*When finished, delete all expired strings...*

| **6** :>

```console
SELECT * FROM strings;
```

| **SB-6** ://phpMyAdmin **> strings**

| **7** :>

```console
DELETE FROM strings WHERE date_expires < NOW();
```

| **8** :>

```console
SELECT * FROM strings;
```

| **SB-8** ://phpMyAdmin **> strings**

*Create a .php file to do the same thing...*

### Cleanup PHP Job Script

*Create our routine .php file...*

| **9** :$
```
sudo cp core/07-cleanup1.php web/cleanup.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-cleanup1.php && \
ls web
```

*Note our same DELETE query in SQL*

*Prep some keys, so we can delete them...*

| **B-9** :// (It may require credentials)

```console
localhost/web/recover.php
```

```
Username: jonboy
Favorite Number: (same as before)
```

*...Click "Get your recovery string link..." a few times to create some keys*

| **9** :>

```console
SELECT * FROM strings;
```

| **SB-9** ://phpMyAdmin **> strings**

***Remember: Our keys expire after 20 seconds!***

*Add new keys, delete old keys before new keys expire...*

***Do these next four steps WITHIN 20 SECONDS...***

| **B-10** :// (Same, use 'Back' if repeating steps)

```console
localhost/web/recover.php
```

*(If repeating steps, you may need to confirm, ie: 'Try Again' or 'Resend')*

*...Click "Get your recovery string link..."*

*See our new keys...*

| **10** :>

```console
SELECT * FROM strings;
```

| **SB-10** ://phpMyAdmin **> strings**

*Run the cleanup...*

| **B-11** ://

```console
localhost/web/cleanup.php
```

*Notice only old keys were deleted...*

| **11** :>

```console
SELECT * FROM strings;
```

| **SB-11** ://phpMyAdmin **> strings**

*You may repeat all commands 8–9 to see this again*

### Cleanup via `cron` Task

We learned about `cron` tasks in [Shell 401 Lesson 3](https://github.com/inkVerb/vip/blob/master/401/Lesson-03.md)

We can use `cron` to run a php file

*First, create some keys to delete, again...*

| **B-12** :// (Use credentials or 'Back')

```console
localhost/web/recover.php
```

```
Username: jonboy
Favorite Number: (same as before)
```

*...Click "Get your recovery string link..." a few times to create some keys*

*See the keys...*

| **12** :>

```console
SELECT * FROM strings;
```

| **SB-12** ://phpMyAdmin **> strings**

#### Anything Run from the Terminal Can Be Run by `cron`

Make sure you test your `cron` tasks by running them from the terminal

We use this syntax here: `php /same/path/as/cron/task/to/script.php`

*A .php script run by `cron` needs an absolute path...*

| **13** :$
```
sudo cp core/07-cleanup2.php web/cleanup.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-cleanup2.php && \
ls web
```

*Run it from the terminal...*

| **14** :$

```console
php /srv/www/html/web/cleanup.php
```

*See that the expired keys were deleted...*

| **14** :>

```console
SELECT * FROM strings;
```

| **SB-14** ://phpMyAdmin **> strings**

#### Creating a `cron` Task File

*Create a few more keys to delete after 20 seconds...*

| **B-15** :// (Use credentials or 'Back')

```console
localhost/web/recover.php
```

*See the keys...*

| **15** :>

```console
SELECT * FROM strings;
```

| **SB-15** ://phpMyAdmin **> strings**

*Create the `cron` task file...*

| **16** :$

```console
cd /etc/cron.d
```

| **17** :$

```console
ls
```

**Handle `cron` task files correctly...**

Files for `cron` jobs are finicky; follow all instructions carefully:

- *Being in the `/etc/` directory, we need `sudo`*
- *Use `root /usr/bin/php` as the user because we need PHP to run this*
  - *We got `/usr/bin/php` by running: `which php`*
- *[VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md)*

*We will edit with `vim` from [Shell 201 Lesson 11](https://github.com/inkVerb/vip/blob/master/201/Lesson-11.md#vim-is-for-awesome-people)*

| **18** :$

```console
sudo vim /etc/cron.d/webappcleanup
```

| **vim-16a** :] `i`

*Copy and paste this as the content, press Enter so there is a new line after:*

```shell
* * * * * root /usr/bin/php /srv/www/html/web/cleanup.php
```

| **vim-16b** :] Esc

| **vim-16c** :] `:wq` (Write and quit)

*Set file permissions for the `cron` task...*

| **19** :$

```console
sudo chmod 644 /etc/cron.d/webappcleanup
```

*Note:*

- *This `cron` task runs at 00 seconds every minute*
- *Every minute, keys older than 20 seconds should be deleted*

**Repeat 18 to watch `cron` delete expired keys:**

| **B-20** :// (Same)

```console
localhost/web/recover.php
```

*...Click "Get your recovery string link..." a few times to create some keys*

| **20** :>

```console
SELECT * FROM strings;
```

| **SB-20** ://phpMyAdmin **> strings**

*Wait 1 minute and run again*

*When finished, let's use a key for our login cookie...*

### Keys for Cookie Login

Remember from [Lesson 4](https://github.com/inkVerb/vip/blob/master/501/Lesson-04.md#v-remember-me-login-cookies) that storing user info in a cookie is not secure

Instead, one good option is to store a key, like the keys we just set up

**Workflow:**
```
$_COOKIE['user_key'] --> key finds user_id --> user_id logs in
```

We need to:

1. Create a key at "Remember me" login
2. Check the key when returning
3. Delete the key at logout

*Start by logging out...*

- *We used our old cookie method to login*
- *So, we should use our old cookie method to logout before making changes*

| **B-21** ://

```console
localhost/web/logout.php
```

*Update the `usable` column in the `strings` table to include a 'cookie_login' option...*

| **21** :>
```sql
ALTER TABLE `strings`
CHANGE  `usable`  `usable` ENUM('live', 'cookie_login', 'dead') NOT NULL;
```

| **22** :$
```
sudo cp core/07-in.loginhead2.php web/in.login_head.php && \
sudo cp core/07-logout.php web/logout.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-in.loginhead2.php core/07-logout.php && \
ls web
```

*Note:*

  - *in.login_head.php*
  - *logout.php*

- *Cookie login refers to the key, no longer the user's ID*
- *We escape the key from the cookie before searching for the key in the database*
  - *This makes sure some hacker doesn't hack the cookie to inject some SQL command*
- *When we logout, we set any cookie to "dead" in the SQL table*

| **B-22** ://

```console
localhost/web/webapp.php
```

*Check "Remember me...", login again with our credentials from before...*

```
Username: jonboy
Password: My#1Password
```

*Note the string in the message is your cookie, same as the database...*

| **22** :>

```console
SELECT * FROM strings;
```

| **SB-22** ://phpMyAdmin **> strings**

*Refresh the webapp.php page to see it again...*

| **B-23** :// (Refresh)

```console
localhost/web/webapp.php
```

*We don't want those cookie keys on our page in the future, so update to new files that don't use them...*

| **24** :$
```
sudo cp core/07-in.loginhead3.php web/in.login_head.php && \
sudo chown -R www:www /srv/www/html && \
atom core/07-in.loginhead3.php && \
ls web
```

| **B-24** :// (Refresh)

```console
localhost/web/webapp.php
```

1. Click "Log out"
2. See that the cookie key was set to "dead" from the `strings` table...

| **24** :>

```console
SELECT * FROM strings;
```

| **SB-24** ://phpMyAdmin **> strings**

**When finished:**

*Delete that `cron` task so it isn't constantly running on your machine...*

| **25** :$

```console
sudo rm /etc/cron.d/webappcleanup
```

___

# The Take

## Random String
- A PHP function can create a random string of characters
- Functions of all sorts can be handy to `include` in a PHP script
- Long, random strings like this may be called "keys" or "security keys"

## Login Recovery via Security Key
- Logins can be recovered using security keys
- A "login link" processes a long string via GET, then checks it against the database
- Links with security keys like these can also be used to:
  - "Confirm" an email address
  - "Unsubscribe" from emails
  - Click in an email to confirm a change or do some action in your account
  - Many other purposes
- SQL must use "BINARY" to match letter case
- When adding any such recovery or security "key", check to see if it is already in the database
- Expiration dates can be set using SQL or PHP time

## Cleanup
- SQL can query entries based on arguments like: `WHERE date_column < NOW()`
  - This can be handy to `DELETE` expired rows in your database

## PHP via `cron`
- `cron` can run PHP scripts
- Test the PHP script from the terminal first:
  - Syntax: `php /same/path/as/cron/task/to/script.php`
- Find out where the `php` command is on your machine:
  - `which php` (could be: `/usr/bin/php`)
- Use `/usr/bin/php` in your `cron` statement (or other path from `which`)
  - Syntax: `* * * * * root /usr/bin/php /srv/www/html/script.php`
    - This is a task that runs every minute
- Use absolute paths for any `include` or `require` statements in PHP
  - This: `require_once ('/srv/www/html/inc/config.php');`
  - NOT!: `require_once ('./inc/config.php');`
- Files for `cron` jobs are finicky
  - [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md)

## Login Cookies via Security Key
- Cookies should never contain direct user information, including SQL table ID or username
- A long, random string (key) works well as a cookie, indicating the user in a table used only for keys
- Make sure to escape everything from a user before sending it to SQL, even from a cookie
  - This prevents hacker attacks known as "SQL injection"
- When we log out, delete the cookie, but also set the key to "dead" in our SQL key table

## NOT for Production
- These are examples for:
  - Security keys
  - Expiration times & dates
  - `cron` tasks
- These examples were small and brief for teaching
- Use longer keys and retain keys for longer times before deleting them, if ever
- `cron` tasks running every minute can add load to your server
  - Once per day or week should be enough, depending on your needs
- You need more and professional training before you are ready to program a server for production
- Our purpose is to understand these things:
  - When you use security features on websites and apps
  - If you do more in-depth study of these topics
___

#### [Lesson 8: CMS Blog: Edit, Display & TinyMCE](https://github.com/inkVerb/vip/blob/master/501/Lesson-08.md)
