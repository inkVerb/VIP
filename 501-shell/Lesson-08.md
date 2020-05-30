# Shell 501
## Lesson 8: CMS Blog: Input, Display & TinyMCE

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

| **1** :
```
sudo cp core/08-edit1.php web/edit.php && \
sudo cp core/08-loginhead.in.php web/in.login_head.php && \
sudo cp core/08-logincheck.in.php web/in.login_check.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/in.login_head.php web/in.login_check.php web/edit.php && \
ls web
```

*Note:*

- *in.login_check.php simply checks for a SESSION or COOKIE login:*
  - *Redirect to webapp.php if no login*
  - *Message and admin links if logged in*
  - *Note we used the `$head_title` variable for the browser `<title>`*
- *in.login_head.php near the bottom has a link to edit.php*
- *edit.php is very simple now, but it contains our three prep files:*
  - *in.config.php*
  - *in.functions.php*
  - *in.login_check.php*
- *edit.php has no `<head>` because it is created by in.login_check.php*
  - *PHP redirects to a new page via `header()`, which uses `<head>`*
  - *If the `<head>` was already created in HTML, `header()` might break*
  - *So, when redirecting, such as in pages requiring login:*
    1. *Process the `if` tests to redirect via `header("Location: to_page.php")`*
    2. *Then create the `<head>` tag*

| **B-1** :// `localhost/web/edit.php` (It will redirect to webapp.php)

*Note it redirected because you are not logged in; Login:*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, enter the address directly because we didn't add a link to click...*

| **B-2** :// `localhost/web/edit.php` (Now you are logged in)

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Create the SQL table for a "Piece"...*

| **2** ://phpMyAdmin **> webapp_db**

| **3** :>
```sql
CREATE TABLE IF NOT EXISTS `pieces` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('post', 'page') NOT NULL,
  `status` ENUM('live', 'draft', 'dead') NOT NULL,
  `title` VARCHAR(90) NOT NULL,
  `slug` VARCHAR(90) NOT NULL,
  `content` LONGTEXT DEFAULT NULL,
  `after` TINYTEXT DEFAULT NULL,
  `date_live` TIMESTAMP NULL,
  `date_created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `date_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

*Note `TIMESTAMP NULL` works; `TIMESTAMP DEFAULT NULL` does not work*

*See what we just added...*

| **3** ://phpMyAdmin **> webapp_db > pieces**

*...Use that table by adding a "Piece" `<form>` to our "Editor" page...*

| **3** :
```
sudo cp core/08-edit2.php web/edit.php && \
sudo cp core/08-editpiece2.in.php web/in.editpiece.php && \
sudo cp core/08-piecefunctions.in.php web/in.piecefunctions.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/edit.php web/in.editpiece.php web/in.piecefunctions.php && \
ls web
```

*gedit: Reload*

- *edit.php*

| **B-3** :// `localhost/web/edit.php` (Same)

*Note our JavaScript in:*

- *edit.php: div id "goLiveOptions"*
- *in.piecefunctions.php: onClick "showGoLiveOptionsBox"*
- *This makes our "Schedule..." Date Live settings show/hide with the checkbox*

1. Fill-out the fields, simple with what you want
2. Click "Save draft"
3. Note the green message: Saved!

| **4** :> `SELECT * FROM pieces;`

| **4** ://phpMyAdmin **> pieces**

*...There is the piece we just created, in the database*

1. Don't change any fields
2. Click "Publish"
3. Note the green message: Saved!

| **5** :> `SELECT * FROM pieces;`

| **5** ://phpMyAdmin **> pieces**

*...There two pieces now in the database*

- *This is because we did not `UPDATE` the old entry*
- *Our PHP script will only `INSERT` new entries*

*Save one more for practice in the future...*

1. Don't change any fields
2. Click "Publish"
3. Note the green message: Saved!

| **6** :> `SELECT * FROM pieces;`

| **6** ://phpMyAdmin **> pieces**

**We must write the PHP script to:**
- **`UPDATE` existing pieces**
- **Retrieve the ID of the most recent `INSERT`**

This will get the new ID of the last database `INSERT`:

```sql
SELECT SCOPE_IDENTITY();
```

This is how to do it in MySQLi (SQL for PHP):

```php
$last_id = $database->insert_id;
```

| **7** :
```
sudo cp core/08-edit3.php web/edit.php && \
sudo cp core/08-editpiece3.in.php web/in.editpiece.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/edit.php web/in.editpiece.php web/in.piecefunctions.php && \
ls web
```

*gedit: Reload*

- *edit.php*
- *in.editpiece.php*

___

# The Take

___

#### [Lesson 9: Handling Uploads](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-09.md)
