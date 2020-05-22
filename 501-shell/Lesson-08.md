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
sudo cp core/08-logincheck.in.php web/in.login_check.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/edit.php web/in.login_check.php \
ls web
```

*Note:*

  - *in.login_check.php simply checks for a SESSION or COOKIE login:*
    - *Redirect to webapp.php if no login*
    - *Message and admin links if logged in*
    - *Note we used the `$head_title` variable for the browser `<title>`*
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
  `date_live` TIMESTAMP DEFAULT NULL,
  `date_created` TIMESTAMP NOT NULL,
  `date_updated` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

*...Use that table by adding a "Piece" `<form>` to our "Editor" page...*

| **3** :
```
sudo cp core/08-edit2.php web/edit.php && \
sudo cp core/08-functions.in.php web/in.functions.php && \
sudo cp core/08-editpiece.in.php web/in.editpiece.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/functions.php web/in.editpiece.php \
ls web
```

*gedit: Reload edit.php*

| **B-3** :// `localhost/web/edit.php` (Same)

___

# The Take

___

#### [Lesson 9: Handling Uploads](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-09.md)
