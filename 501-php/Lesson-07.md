# PHP 501
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

___

#### [Lesson 8: CMS Blog: Input, Display & TinyMCE](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-08.md)
