# Shell 501
## Lesson 2: MySQL & phpMyAdmin

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

Ready SQL *if continuing after not finishing this lesson last time*

```console
mysql -u admin -padminpassword
```

Browser: // Username: `admin` Password: `adminpassword`

```console
localhost/phpMyAdmin/
```

___

### SQL Language

Created in 1979

SQL is a database language used by many

MySQL is one such database software

Other SQL database software includes:

- SQLite
- PostgreSQL
- MariaDB (forked from MySQL by the original developers after MySQL was acquired by Oracle in 2009)

SQL is a more secure, interactive alternative to XML, another way to store information data

## Optional Fix: If you have trouble logging in to MySQL
### This optional section requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
___

| **X1** :$

```console
sudo mysql
```

*Below, `admin` and `adminpassword` can be anything, but for these lessons you should not need to change them*

| **X2** :>

```sql
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;
```

| **X3** :>

```sql
FLUSH PRIVILEGES;
```

| **X4** :>

```sql
QUIT
```

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
___
___


### I. Basics: User and Database

*Note this format will prompt you for a password:*

- `mysql -u USERNAME -p`

*But, this won't: (normally not "secure", but allowable for these lessons)*

- `mysql -u USERNAME -pPASSWORD`

*Login to MySQL as our `admin`...*

| **1** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u admin -padminpassword
```

| **B-1** :// Username: `admin` Password: `adminpassword`

```console
localhost/phpMyAdmin/
```

**SQL Query**

An SQL command is called a "query"

SQL queries often use ALL CAPS for SQL terms to better see the SQL language part, but ALL CAPS isn't necessary

*List users...*

| **2** :>

```sql
SELECT user FROM mysql.user;
```

| **B-2** ://phpMyAdmin **> User accounts**

*Create a user `new_user`...*

| **3** :>

```sql
CREATE USER new_user@localhost;
```

*Note the user was created...*

| **4** :>

```sql
SELECT user FROM mysql.user;
```

| **B-4** ://phpMyAdmin **> User accounts**

*Delete that user `new_user`...*

| **5** :>

```sql
DROP USER new_user@localhost;
```

*Note the user was deleted...*

| **6** :>

```sql
SELECT user FROM mysql.user;
```

| **B-6** ://phpMyAdmin **> User accounts**

*List databases...*

| **7** :>

```sql
SHOW DATABASES;
```

| **B-7** ://phpMyAdmin **> Databases**

*Create a database `new_db`...*

| **8** :>

```sql
CREATE DATABASE new_db;
```

*Note the database was created...*

| **9** :>

```sql
SHOW DATABASES;
```

| **B-9** ://phpMyAdmin **> Databases**

*Delete that database `new_db`...*

| **10** :>

```sql
DROP DATABASE new_db;
```

*Note the database was deleted...*

| **11** :>

```sql
SHOW DATABASES;
```

| **B-11** ://phpMyAdmin **> Databases**

### II. Privileges: User and Database

*Create a database and user on one, combined line...*

| **12** :>

```sql
CREATE USER new_user@localhost; CREATE DATABASE new_db;
```

*Note they were both created...*

| **13** :>

```sql
SHOW DATABASES;
```

| **B-13** ://phpMyAdmin **> Databases**

| **14** :>

```sql
SELECT user FROM mysql.user;
```

| **B-14** ://phpMyAdmin **> User accounts**

*...Note `new_user` has no password; assign one (`newpassword`)...*

| **15** :>

```sql
SET PASSWORD FOR new_user@localhost=PASSWORD("newpassword");
```

*Note `new_user` now has a password...*

| **B-15** ://phpMyAdmin **> User accounts**

*Always flush privileges after altering users!*

| **16** :>

```sql
FLUSH PRIVILEGES;
```

*Exit MySQL, then login as the new user...*

| **17** :>

```sql
QUIT
```

| **B-17** ://phpMyAdmin **> Log out** *(icon top left, under phpMyAdmin logo)*

*Login to MySQL with `new_user`...*

| **18** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u new_user -pnewpassword
```

| **B-18** :// Username: `new_user` Password: `newpassword`

```console
localhost/phpMyAdmin/
```

*Have a look at databases again...*

| **19** :>

```sql
SHOW DATABASES;
```

| **B-19** ://phpMyAdmin **> Databases**

*Note `new_db` isn't listed! You don't have any databases! (`information_schema` doesn't count)*

*...Let's fix that...*

**Run in a new terminal window:**
>
> Open a new terminal window: <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> (not <kbd>F12</kbd>)
>
> | **T1** :$

```console
mysql -u admin -padminpassword
```
>
> | **T2** :>

```sql
GRANT ALL PRIVILEGES ON new_db.* TO new_user@localhost IDENTIFIED BY 'newpassword';
```
>
> | **T3** :>

```sql
FLUSH PRIVILEGES;
```
>
> | **T4** :>

```sql
QUIT
```
>
> | **T5** :$

```console
exit
```

*Now you can see the database `new_db` because you have "privileges" on it...*

| **20** :>

```sql
SHOW DATABASES;
```

| **B-20** ://phpMyAdmin **> Databases**

*Exit MySQL...*

| **21** :>

```sql
QUIT
```

| **B-21** ://phpMyAdmin **> Log out** *(icon top left, under phpMyAdmin logo)*

### III. Privileges Automatically Create a User

#### SQL Privileges Rules:
1. A user must have "privileges" on a database to use that database
2. A so-called "admin" user simply has "privileges" for everything on every database

*Login to MySQL as our `admin`...*

| **22** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u admin -padminpassword
```

| **B-22** :// Username: `admin` Password: `adminpassword`

```console
localhost/phpMyAdmin/
```

*Create a database and user on one, combined line...*

| **23** :>

```sql
DROP USER new_user@localhost; DROP DATABASE new_db;
```

*Note they were both deleted...*

| **24** :>

```sql
SHOW DATABASES;
```

| **B-24** ://phpMyAdmin **> Databases**

| **25** :>

```sql
SELECT user FROM mysql.user;
```

| **B-25** ://phpMyAdmin **> User accounts**

**Create a database, then auto-create a user**

This is the conventional way, using fewer commands...

1. Create the new database

| **26** :>

```sql
CREATE DATABASE new_db;
```

2. Assign privileges to a non-existent user; then the user is automatically created

| **27** :>

```sql
GRANT ALL PRIVILEGES ON new_db.* TO new_user@localhost IDENTIFIED BY 'newpassword';
```

*Always flush privileges after altering users!*

| **28** :>

```sql
FLUSH PRIVILEGES;
```

*Note both the database were created...*

| **29** :>

```sql
SHOW DATABASES;
```

| **B-29** ://phpMyAdmin **> Databases**

| **30** :>

```sql
SELECT user FROM mysql.user;
```

*Note `new_user` exists and has a password...*

| **B-30** ://phpMyAdmin **> User accounts**

*Exit MySQL...*

| **31** :>

```sql
QUIT
```

| **B-31** ://phpMyAdmin **> Log out** *(icon top left, under phpMyAdmin logo)*

### IV. Tables

*Login to MySQL as the user of the database, not as the `admin` user...*

| **32** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u new_user -pnewpassword
```

| **B-32** :// Username: `new_user` Password: `newpassword`

```console
localhost/phpMyAdmin/
```

**"Use" the database**

| **33** :>

```sql
USE new_db
```

| **B-33** ://phpMyAdmin **> new_db**

**...Now we can work with "tables" in that database...**

*Look at our tables...*

| **34** :>

```sql
SHOW TABLES;
```

| **B-34** ://phpMyAdmin **> new_db**

*Note no tables, create one...*

| **35** :>
```sql
CREATE TABLE `fruit` (
  `name` VARCHAR(90) NOT NULL,
  `type` TINYTEXT DEFAULT NULL,
  `count` INT DEFAULT 0
);
```
*Look at our tables...*

| **36** :>

```sql
SHOW TABLES;
```

| **B-36** ://phpMyAdmin **> new_db**

*See what's in our `fruit` table...*

| **37** :>

```sql
SELECT * FROM fruit;
```

| **B-37** ://phpMyAdmin **> fruit**

**Add to a table...**

| **38** :>

```sql
INSERT INTO fruit (name) VALUES ('bananas');
```

*See our entry...*

| **39** :>

```sql
SELECT * FROM fruit;
```

| **B-39a** ://phpMyAdmin **> Browse**

OR

| **B-39b** ://phpMyAdmin **> Table: fruit** *(top bredcrumb)*

*Note the `type` column is `NULL`*

*Make another entry...*

| **40** :>

```sql
INSERT INTO fruit (name, type) VALUES ('apples', 'McIntosh');
```

*See our entry...*

| **41** :>

```sql
SELECT * FROM fruit;
```

| **B-41** ://phpMyAdmin **> Browse**

*Note the `type` column is not `NULL`*

**Change an entry...**

| **42** :>

```sql
UPDATE fruit SET count='5' WHERE name='apples';
```

*See our changes...*

| **43** :>

```sql
SELECT * FROM fruit;
```

| **B-43** ://phpMyAdmin **> Browse**

*Make more changes...*

| **44** :>

```sql
UPDATE fruit SET type='nino', count='7' WHERE name='bananas';
```

*See our changes...*

| **45** :>

```sql
SELECT * FROM fruit;
```

| **B-45** ://phpMyAdmin **> Browse**

*Delete an entry...*

| **46** :>

```sql
DELETE FROM fruit WHERE name='apples';
```

*See our changes...*

| **47** :>

```sql
SELECT * FROM fruit;
```

| **B-47** ://phpMyAdmin **> Browse**

*Delete the entire table...*

| **48** :>

```sql
DROP TABLE fruit;
```

*Try to look at the table now...*

| **49** :>

```sql
SELECT * FROM fruit;
```

| **B-49** ://phpMyAdmin **> Browse**

*Delete the database too...*

| **50** :>

```sql
DROP DATABASE new_db;
```

*The database no longer exists...*

| **51** :>

```sql
SHOW DATABASES;
```

| **B-51** ://phpMyAdmin **> Databases**

*Exit MySQL...*

| **52** :>

```sql
QUIT
```

| **B-52** ://phpMyAdmin **> Log out** *(icon top left, under phpMyAdmin logo)*

#### SQL Table Rules:
1. Tables are often created with code in a multi-line array
2. Most developers don't understand all SQL code, it just does what you need
  - *It is always good to learn...*
  - *...but don't let SQL curiosity stop your PHP work*
  - Just make sure you know the right SQL code to do what you need
3. SQL "tables" are organized into "columns" and "rows"
  - **Column:** a field or piece of information part of an item entry
  - **Row:** an item entry in a table
4. SQL "columns" have datatypes
  - Whole Numbers
    - `TINYINT` 0-255
    - `SMALLINT` 0-32,767
    - `INT` 0-2,147,483,647
  - Decimals
    - `FLOAT` 7 digits after point
    - `DOUBLE` 15 digits after point
    - `DECIMAL` 28 digits after point
  - `BOOLEAN` true/false
  - `ENUM` multiple choice
  - `VARCHAR` standard characters, useful up to 255 characters
    - Good for passwords, usernames, names, emails, websites, titles, etc
  - Text
    - `TINYTEXT` up to 255 characters
    - `TEXT` up to 65,535 characters
    - `MEDIUMTEXT` up to 16,777,215 characters
    - `LONGTEXT` up to 4,294,967,295 characters
    - `TIMESTAMP` date and time
5. SQL "columns" usually need an `id` column
  - Syntax: `` `id` INT UNSIGNED NOT NULL AUTO_INCREMENT, ... PRIMARY KEY (`id`) ``
6. When creating an SQL "table", include:
  - Each column
  - The datatype of each column
  - The default of each column
7. Bigger datatypes use more resources, use the smallest ones you can

**Example of columns with datatypes:**
```sql
  `id` INT UNSIGNED NOT NULL,
  `live` BOOLEAN NOT NULL DEFAULT true,
  `type` ENUM('big', 'short', 'red', 'normal') NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TINYTEXT DEFAULT NULL,
  `date_created` TIMESTAMP NOT NULL,
```

### V. SQL Done Right

#### Create the Right Way: *with details*
##### 1. Database:
```sql
CREATE DATABASE new_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
##### 2. Table:
```sql
CREATE TABLE IF NOT EXISTS `new_table` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ...
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```
##### 3. Comment:
```sql
-- This is an SQL comment
-- Use comments to label your code, like in any other code
-- Comments can also cancel a code do you can keep it for reference without using it
```

*Login to MySQL as our `admin`...*

| **53** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u admin -padminpassword
```

| **B-53** :// Username: `admin` Password: `adminpassword`

```console
localhost/phpMyAdmin/
```

*Cleanup and delete user `new_user`..*

| **54** :>

```sql
DROP USER new_user@localhost;
```

*Create a database and user...*

| **55** :>
```sql
CREATE DATABASE food_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON food_db.* TO food_usr@localhost IDENTIFIED BY 'foodpassword';
FLUSH PRIVILEGES;
```

| **B-55** ://phpMyAdmin **> Reload navigation panel** *(icon top left, under phpMyAdmin logo)*

*Note the new `food_db` database appeared on the left*

| **56** :>

```sql
SHOW DATABASES;
```

| **B-56** ://phpMyAdmin **> Databases**

| **57** :>

```sql
SELECT user FROM mysql.user;
```

| **B-57** ://phpMyAdmin **> User accounts**

*Note the user is for PHP (later), we can use the database as the `admin` user for now*

*Specify the database to use...*

| **58** :>

```sql
USE food_db;
```

| **B-58** ://phpMyAdmin **> Databases > food_db**

*Create a table...*

| **59** :>

```sql
CREATE TABLE IF NOT EXISTS `fruit` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NOT NULL,
  `type` TINYTEXT DEFAULT NULL,
  `have` BOOLEAN NOT NULL DEFAULT false,
  `count` INT DEFAULT 0,
  `prepared` ENUM('fresh', 'dry', 'cooked', 'NA') NOT NULL,
  `date_created` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

| **60** :>

```sql
SHOW TABLES;
```

| **61** :>

```sql
SELECT * FROM fruit;
```

| **B-61** ://phpMyAdmin **> food_db > fruit**

*Make an entry...*

| **62** :>

```sql
INSERT INTO fruit (name, type) VALUES ('apples', 'McIntosh');
```

| **63** :>

```sql
SELECT * FROM fruit;
```

| **B-63** ://phpMyAdmin **> fruit**

*And another...*

| **64** :>

```sql
INSERT INTO fruit (name, type) VALUES ('apples', 'Golden Delicious');
```

| **65** :>

```sql
SELECT * FROM fruit;
```

| **B-65** ://phpMyAdmin **> fruit**

*Add more details to entry 1...*

| **66** :>

```sql
UPDATE fruit SET have=true, count='37', prepared='dry' WHERE id=1;
```

| **67** :>

```sql
SELECT * FROM fruit;
```

| **B-67** ://phpMyAdmin **> Browse**

*Make a "complete" entry...*

| **68** :>

```sql
INSERT INTO fruit (name, type, have, count, prepared) VALUES ('bananas', 'nino', true, 58, 'fresh');
```

*Look at only `id` and `name`...*

| **69** :>

```sql
SELECT id, name FROM fruit;
```

| **70** :>

```sql
SELECT * FROM fruit;
```

| **B-70** ://phpMyAdmin **> Browse**

*Let's say our nino bananas go out of stock...*

| **71** :>

```sql
UPDATE fruit SET have=false, count='0' WHERE id=3;
```

*Look at only important columns from our "bananas" entry..*

| **72** :>

```sql
SELECT name, type, have, count, prepared FROM fruit WHERE name='bananas';
```

| **73** :>

```sql
SELECT * FROM fruit;
```

| **B-73** ://phpMyAdmin **> Browse**

___

# The Take

## SQL Basics
- SQL is a database language used by many, not only MySQL
- SQL has databases and users for them
- Assigning a user to a database will create that user if it doesn't already exist
- SQL databases have tables
- SQL tables have columns for different types of information
- SQL entries are called "rows"
- Deleting or changing a "row" will delete or change an "entry"
- Code to talk to SQL is called a "query"
- SQL queries use ALL CAPS to see code better, but ALL CAPS isn't necessary
- When creating, specify datatypes and defaults, even if you don't need to
- Use the smallest, most simple datatype
  - Bigger datatypes use more resources

## Input & change SQL in the MySQL Terminal
- Databases and users
  - `CREATE DATABASE`: make a new database
  - `GRANT ALL PRIVILEGES ON`: add a user to a database
  - `USE`: start using a specific database
  - `CREATE TABLE`: make a new table
  - `SHOW`: `USERS` or `DATABASES` or `TABLES` (list)
  - `DROP`: `USER` or `DATABASE` or `TABLE` (delete)
- Tables
  - `INSERT INTO`: make a new row entry
  - `SELECT`: retrieve row entries
  - `UPDATE`: change a row entry
  - `DELETE FROM`: delete a row entry

## Watch the Changes in phpMyAdmin
- Login using the same user and password as in the terminal
- Databases are listed on the left
- Logout and refresh the database list with icons under the phpMyAdmin logo
- See databases and users with the row of tabs at the top
- Clicking on tabs and breadcrumbs can refresh what you see
- ***Do not manage databases with phpMyAdmin***
  - You can delete and add entries and use an SQL terminal in phpMyAdmin if needed for learning or reference

## SQL for an App
- SQL belongs inside a "logic code" like PHP (or Node, Python, etc)
  - In the next lesson, we will put SQL inside PHP to make a website come to life
  - This is how most software applications are made
  - SQL has alternatives (MongoDB, ScalaQL, PostgreSQL) just how PHP has alternatives (Node.js, Python, Go)
- In app development:
  1. Learn the SQL you need to do what you need done *correctly*
    - *(don't be a 'sript kiddy', who just copies from others without understanding)*
  2. Maintain a "cheat sheet of SQL recipes to hack" for building your PHP code
  3. Prepare your SQL queries in a text editor *to each specific need*
  4. Copy-paste your SQL queries into the terminal *to test them*
  5. Finally, put your tested SQL queries into your PHP code (or Node, Python, Go, etc)

## How Much SQL Should I Learn?
- In any work, most of your SQL queries are the same, again and again, with few differences
- Many people who work with data all day as a job know SQL language very well and use the terminal
- Working with SQL directly (phpMyAdmin or terminal) is another type of work to itself
- If you make a serious app: remember it goes two ways: *understand*, then *copy*
- Don't learn all SQL, you will never learn all
- Learn a little beyond what you will use, but make sure you understand it
  - Study SQL in more depth than you will use, just to make sure you aren't doing things wrong
  - Copy-paste SQL queries from a "**cheat sheet you understand**" so you aren't making mistakes
  - Don't waste all your time studying SQL forever when you won't use it
- Start as a beginner in SQL with [SoloLearn: SQL Fundamentals](https://www.sololearn.com/Course/SQL/)

___

#### [Lesson 3: MySQL & PHP MySQLi](https://github.com/inkVerb/vip/blob/master/501/Lesson-03.md)
