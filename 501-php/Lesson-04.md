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

*Look through `in.functions.php` and `install.php` first and a few things...*

| **in.functions.php** :

**Truncate a possibly long value:**

Note preg_replace() is inside substr($Variable,0,10) to truncate after 90 characters

```php
//
substr(preg_replace("/[^a-zA-Z0-9-_:\/.]/","", $value),0,90) : '';
```

| **install.php** :

**Hash password one-way:** (This can't be decrypted and it is different each time)

```php
$password_hashed = password_hash($password, PASSWORD_BCRYPT);
```

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

| **S5** :> `SHOW TABLES;`

| **SB-5** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's create them by installing...*

| **B-5** :// `localhost/web/install.php`

*Enter the database information from above, along with your username, password, and other info, then continue*

| **S6** :> `SHOW TABLES;`

| **SB-6** ://phpMyAdmin **> webapp_db**

| **S7** :> `SELECT * FROM users;`

| **SB-7** ://phpMyAdmin **> users**

*Note the `pass` column is a long string; that is the one-way hashed password*






*Website should be ready, use our login files...*

| **8** :
```
sudo cp core/04-webapp1.php web/webapp.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/webapp.php && \
ls web
```

| **S8** :> `SHOW TABLES;`

| **SB-8** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's create them*

| **B-8** :// `localhost/web/webapp.php`

*Let's make a login using cookies...*

| **9** :
```
sudo cp core/04-webapp2.php web/webapp.php && \
sudo cp core/04-config2.in.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/webapp.php web/style.css web/in.config.php web/in.functions.php web/in.checks.php && \
ls web
```

*gedit: Reload*

 	- *website.php*
  - *in.config.php*

| **S9** :> `SHOW TABLES;`

| **SB-9** ://phpMyAdmin **> webapp_db**

*Note our database has no tables, let's create them*

| **B-9** :// `localhost/web/webapp.php` (Same)

___

# The Take

___

#### [Lesson 5: RewriteMod (Pretty Permalinks)](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-05.md)
