# Shell 501
## Lesson 7: Security Keys

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser windows!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** : `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :> `USE webapp_db;`

| **SB-1** ://phpMyAdmin **> webapp_db**

___

### Random String

| **1** :
```
sudo cp core/07-recover1.php web/recover.php && \
sudo cp core/07-string_functions.in.php web/in.string_functions.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/recover.php web/in.string_functions.php && \
ls web
```

*Note that we are including in.string_functions.php, give it a good look over*

| **B-1** :// `localhost/web/recover.php`

*Refresh the page a few times to see new strings*

*Let's use our random string in an SQL table...*

### Login Recovery (via Security Key)

| **2** :
```
sudo cp core/07-recover2.php web/recover.php && \
sudo cp core/07-ajaxstring.php web/ajax_string.php && \
sudo cp core/07-recover_login.php web/recover_login.php && \
sudo cp core/07-webapp.php web/webapp.php && \
sudo cp core/07-loginhead.in.php web/in.login_head.php && \
sudo cp core/07-accountsettings.php web/account.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/ajax_string.php web/recover_login.php web/webapp.php web/in.login_head.php web/in.login_head.php web/account.php && \
ls web
```

*gedit: Reload recover.php*

*Note:*
  - *recover.php uses a recovery form and AJAX script*
    - The AJAX POST sends the user ID
  - *ajax_string.php processes the AJAX action*
    - This creates a string and enters it into the "strings" table with a 20 second expiration date
    - The AJAXed file also requires the config file for the `session` and database connection
  - *recover_login.php processes the random string as a GET value*
    - The string is tested in the database for a match and expiration date
    - If matched, the page redirects to webapp.php using `header`
  - *accountsettings.php has links for logout and the main webapp*
  - *webapp.php replaced the login workflow an `include` for in.login_head.php*
  - *in.login_head.php:*
    - contains the login workflow that webapp used to
    - has links for Account Settings and logout

*Look through these files carefully*

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

| **SB-2** ://phpMyAdmin **> strings**

| **B-2** :// `localhost/web/recover.php` (It will require credentials)

```
Username: jonboy
Favorite Number: (same as before)
```

*If you forgot your favorite number, get it here:*

| **2-opt** :> `SELECT * FROM users;`

*Once you succeeded with your username and favorite number...*

### Cleanup

| **3** :> `SELECT * FROM strings;`

| **SB-3** ://phpMyAdmin **> strings**

1. Click the button: **Get your recovery string link...**
  - Each time, check new entries in the database:
    - :> `SELECT * FROM strings;`
    - ://phpMyAdmin **> strings**
2. Try the three SQL queries under **...Teaching tip...**
3. Click the link to login, but note it should have expired
4. Click around and explore
  - Use Ctrl + Shift + C to see the developer view of pages
  - Compare the pages with the .php files

*When finished, delete all expired strings...*

| **4** :> `SELECT * FROM strings;`

| **SB-4** ://phpMyAdmin **> strings**

| **5** :> `DELETE FROM strings WHERE date_expires < NOW();`

| **6** :> `SELECT * FROM strings;`

| **SB-6** ://phpMyAdmin **> strings**

*Create a .php file to do the same thing...*

### Cleanup PHP Job Script

*Create our routine .php file...*

| **7** :
```
sudo cp core/07-cleanup1.php web/cleanup.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/cleanup.php \
ls web
```

*Note our same DELETE query in SQL*

*Prep some keys, so we can delete them...*

| **B-7** :// `localhost/web/recover.php` (It may require credentials)

```
Username: jonboy
Favorite Number: (same as before)
```

*...Click "Get your recovery string link..." a few times to create some keys*

| **7** :> `SELECT * FROM strings;`

| **SB-7** ://phpMyAdmin **> strings**

***Remember: Our keys expire after 20 seconds!***

*Add new keys, delete old keys before new keys expire...*

***Do these next four steps WITHIN 20 SECONDS...***

| **B-8** :// `localhost/web/recover.php` (Same, use 'Back' if repeating steps)

*(If repeating steps, you may need to confirm, ie: 'Try Again' or 'Resend')*

*...Click "Get your recovery string link..."*

*See our new keys...*

| **8** :> `SELECT * FROM strings;`

| **SB-8** ://phpMyAdmin **> strings**

*Run the cleanup...*

| **B-9** :// `localhost/web/cleanup.php`

*Notice only old keys were deleted...*

| **9** :> `SELECT * FROM strings;`

| **SB-9** ://phpMyAdmin **> strings**

*You may repeat all commands 8–9 to see this again*

### Cleanup via `cron` Task

We learned about `cron` tasks in [Shell 401 Lesson 3](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-03.md)

We can use `cron` to run a php file

*First, create some keys to delete, again...*

| **B-10** :// `localhost/web/recover.php` (Use credentials or 'Back')

```
Username: jonboy
Favorite Number: (same as before)
```

*...Click "Get your recovery string link..." a few times to create some keys*

*See the keys...*

| **10** :> `SELECT * FROM strings;`

| **SB-10** ://phpMyAdmin **> strings**

#### Anything run from the terminal can be run by `cron`

Make sure you test your `cron` tasks by running them from the terminal

We use this syntax here: `php /same/path/as/cron/task/to/script.php`

*A .php script run by `cron` needs an absolute path...*

| **11** :
```
sudo cp core/07-cleanup2.php web/cleanup.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: reload cleanup.php*

*Run it from the terminal...*

| **12** : `php /var/www/html/web/cleanup.php`

*See that the expired keys were deleted...*

| **12** :> `SELECT * FROM strings;`

| **SB-12** ://phpMyAdmin **> strings**

#### Creating a `cron` Task File

*Create a few more keys to delete after 20 seconds...*

| **B-13** :// `localhost/web/recover.php` (Use credentials or 'Back')

*See the keys...*

| **13** :> `SELECT * FROM strings;`

| **SB-13** ://phpMyAdmin **> strings**

*Create the `cron` task file...*

| **14** : `cd /etc/cron.d`

| **15** : `ls`

**Handle `cron` task files correctly...**

Files for `cron` jobs are finicky; follow all instructions carefully:

  - *Being in the `/etc/` directory, we need `sudo`*
  - *Use `root /usr/bin/php` as the user because we need PHP to run this*
    - *We got `/usr/bin/php` by running: `which php`*
  - *[VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md)*

*We will edit with `vim` from [Shell 201 Lesson 12](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-12.md#vim-is-for-awesome-people)*

| **16** : `sudo vim /etc/cron.d/webappcleanup`

| **vim-16a** :] `i`

*Copy and paste this as the content, press Enter so there is a new line after:*

```shell
* * * * * root /usr/bin/php /var/www/html/web/cleanup.php
```

| **vim-16b** :] Esc

| **vim-16c** :] `:wq` (Write and quit)

*Set file permissions for the `cron` task...*

| **17** : `sudo chmod 644 /etc/cron.d/webappcleanup`

*Note:*
  - *This `cron` task runs at 00 seconds every minute*
  - *Every minute, keys older than 20 seconds should be deleted*

*Repeat these steps as often as you want to watch `cron` delete expired keys...*

| **B-18** :// `localhost/web/recover.php` (Same)

*...Click "Get your recovery string link..." a few times to create some keys*

| **18** :> `SELECT * FROM strings;`

| **SB-18** ://phpMyAdmin **> strings**

___

# The Take

## Random String
- A random string of characterscan be created by a PHP function
- Functions of all sorts can be handy to `include` in a PHP script
- Long, random strings like this may be called "keys" or "security keys"

## Login Recovery (via Security Key)
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
  - Syntax: `* * * * * root /usr/bin/php /var/www/html/script.php`
    - This is a task that runs every minute
- Use absolute paths for any `include` or `require` statements in PHP
  - This: `require_once ('/var/www/html/inc/config.php');`
  - NOT!: `require_once ('./inc/config.php');`
- Files for `cron` jobs are finicky
  - [VIP/Cheat-Sheets: Cron Schedule Tasks](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Cron.md)

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

#### [Lesson 8: CMS Blog: Input, Display & TinyMCE](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-08.md)
