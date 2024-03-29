# Linux 401
## Lesson 4: MySQL & `systemctl`

Ready the CLI

```console
cd ~/School/VIP/401
```

- [Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)
- [LAMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LAMP-Desktop.md)

___

SQL language is generally the same across database platforms.

This does not teach SQL language.

This teaches basic SQL control operations in MySQL from Shell, without having to login to MySQL.

***This lesson uses and modifies essential settings in MySQL, so any MySQL installation on your machine should not be used for production or other purposes without this consideration***

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
___

*MySQL can be installed with:*

> | **Q1** :$*

```console
sudo apt install mysql-server
```

*If you install MySQL for this lesson, then you **MAY** completely remove*

*it after with this:*

```sh
sudo apt remove mysql-server mysql-common
sudo apt purge mysql-server mysql-common
sudo apt autoremove mysql-server mysql-common
sudo apt update
```

*Use `systemctl` to start, stop, restart, and check the status of services, such as MySQL*

| **1** :$

```console
sudo systemctl status mysql
```

*Note MySQL is running*

*Stop MySQL:*

| **2** :$

```console
sudo systemctl stop mysql
```

*Check the status*

| **3** :$

```console
sudo systemctl status mysql
```

*Start MySQL*

| **4** :$

```console
sudo systemctl start mysql
```

*Check the status*

| **5** :$

```console
sudo systemctl status mysql
```

### Make MySQL secure
*This is not necessary, but most MySQL instructions will assume this was done, including this tutorial.*

> | **Q1** `sudo mysql_secure_installation`

*If already installed, it may ask you for a password.*

*Answer with the following in this tutorial, usually "YES" on a production server.*

1. "NO" - VALIDATE PASSWORD PLUGIN
2. "YES" Change the password for root? *(if you have this quesiton)*
3. Enter a simple password and remember, maybe: mypassword
4. "NO" - Remove anonymous users?
5. "YES" - Disallow root login remotely?
6. "NO" - Remove test database and access to it?
7. "YES" - Reload privilege tables now?

### Login to MySQL
#### Choose one of two ways:
##### 1. First time ever

| **6** :$ *(If you need, type `exit` to leave)*

```console
sudo mysql
```

##### 2. Password already set (but we will set it again)

| **7** :$ *Enter this tutorial's password ( newpassword )*

```console
mysql -u root -p
```

### The MySQL command prompt: `mysql>_`
*Note most coders put SQL commands in ALL CAPS, but lowercase also works.*

#### Change MySQL root password
___

*Enter the following:*

| **8** :>

```console
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'newpassword';
```

| **9** :>

```console
FLUSH PRIVILEGES;
```

| **10** :>

```console
QUIT
```

*Note you exited MySQL*

*Go back into MySQL `-u [user]` is the user `-p` means to prompt for a password*

*Note, because MySQL's root password is now setup, we no longer need `sudo` with `mysql`*

___

| **11** :$ *And enter the password: ( `newpassword` )*

```console
mysql -u root -p
```

*You are in MySQL*

#### Basic MySQL commands (users & databases)
___

*List databases:*

| **12** :>

```console
SHOW DATABASES;
```

*Create a database:*

| **13** :>

```console
CREATE DATABASE vipdatabase;
```

| **14** :>

```console
SHOW DATABASES;
```

*Now we made the database "`vipdatabase`"! Yeah!*

*List users:*

| **15** :>

```console
SELECT user FROM mysql.user;
```

*Create user (simply by assigning one to a database):*

| **16** :>

```console
GRANT ALL PRIVILEGES ON vipdatabase.* TO 'vipuser'@'localhost' IDENTIFIED BY 'vippassword';
```

| **17** :>

```console
SELECT user FROM mysql.user;
```

*That user can't use the database until we "flush" privileges...*

| **18** :>

```console
FLUSH PRIVILEGES;
```

*Now we made the user "`vipuser`", and it can access "`vipdatabase`"! Yeah!*

*Let's have another look at the databases...*

| **19** :>

```console
SHOW DATABASES;
```

*Delete the database "`vipdatabase`"*

| **20** :>

```console
DROP DATABASE vipdatabase;
```

| **21** :>

```console
SHOW DATABASES;
```

*...all gone!*

| **22** :>

```console
SELECT user FROM mysql.user;
```

*...but but the user is still there!*

*Delete the user "`vipuser`"*

| **23** :>

```console
DROP USER vipuser@localhost;
```

| **24** :>

```console
SELECT user FROM mysql.user;
```

*...all gone!*

| **25** :>

```console
QUIT
```
___

### MySQL via Shell
*Look at this carefully:*

- `mysql -u root -pnewpassword -e "MYSQL COMMAND GOES HERE;"`
- `mysql -u root -pPASSWORD_HERE` *This starts the MySQL command.*
- `-pPASSWORD_HERE` *No space between `-p` and the password! **This is normally bad!***
- `-e` *We need this for it to work in Shell.*
- `"MYSQL COMMAND GOES HERE;"` *The normal MySQL command can go in the quotes.*

| **26** :$

```console
mysql -u root -pnewpassword -e "SHOW DATABASES;"
```

*Note putting the password in the command at the terminal prompt is usually bad.*

*This is the normal way:*

| **27** :$ *Enter the password ( `newpassword` )*

```console
mysql -u root -p -e "SHOW DATABASES;"
```

*But, we're being lazy and this is a tutorial, so we don't care...*

| **28** :$

```console
mysql -u root -pnewpassword -e "SHOW DATABASES;"
```

| **29** :$

```console
mysql -u root -pnewpassword -e "CREATE DATABASE vipdatabase;"
```

| **30** :$

```console
mysql -u root -pnewpassword -e "SHOW DATABASES;"
```

| **31** :$

```console
mysql -u root -pnewpassword -e "SELECT user FROM mysql.user;"
```

| **32** :$

```console
mysql -u root -pnewpassword -e "GRANT ALL PRIVILEGES ON vipdatabase.* TO 'vipuser'@'localhost' IDENTIFIED BY 'vippassword'; FLUSH PRIVILEGES;"
```

*Note we put "`FLUSH PRIVILEGES;`" in the same command because ";" separates commands.*

| **33** :$

```console
mysql -u root -pnewpassword -e "SELECT user FROM mysql.user;"
```

| **34** :$

```console
mysql -u root -pnewpassword -e "SHOW DATABASES;"
```

| **35** :$

```console
mysql -u root -pnewpassword -e "DROP DATABASE vipdatabase;"
```

| **36** :$

```console
mysql -u root -pnewpassword -e "SHOW DATABASES;"
```

| **37** :$

```console
mysql -u root -pnewpassword -e "SELECT user FROM mysql.user;"
```

| **38** :$

```console
mysql -u root -pnewpassword -e "DROP USER vipuser@localhost;"
```

| **39** :$

```console
mysql -u root -pnewpassword -e "SELECT user FROM mysql.user;"
```

*Conclusion: The commands in MySQL can be run from a Shell prompt.*

### MySQL password file for secure Shell scripts
*But, the password should never go on the command line. Do this instead:*

1. Put special MySQL admin user & password info in a file: /path/to/userinfo/file

*Create a new admin user in MySQL* ***only*** *for your Shell scripts...*

| **40** :$ *Enter your password ( newpassword ); annoying, but this is the "secure" way.*

```console
sudo mysql -u root -p
```

| **41** :$

```console
GRANT ALL PRIVILEGES ON *.* TO 'newadminuser'@'localhost' IDENTIFIED BY 'newpassword' WITH GRANT OPTION;
```

| **42** :$ *(If you really, badly want to see that the user is there.)*

```console
SELECT user FROM mysql.user;
```

| **43** :$

```console
FLUSH PRIVILEGES;
```

| **44** :$

```console
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

*Put the same username & info into a file:*

| **45** :
```shell
echo "[client]
user = newadminuser
password = newpassword
host = localhost
" > mysqlinfofile
```

___
> Optional: Login again as a "sudoer" if needed
>
> | **S3** :$

```console
su Username
```
___

| **46** :$

```console
ls
```

| **47** :$

```console
cat mysqlinfofile
```

*There it is, there's your file.*

2. Run your MySQL command like this: `mysql --defaults-extra-file=/path/to/userinfo/file -e "MYSQL COMMAND;"`

*For example (this can also go in your Shell script):*

| **48** :$

```console
mysql --defaults-extra-file=~/School/VIP/401/mysqlinfofile -e "SHOW DATABASES;"
```

*...and that's how to put MySQL commands in a Shell script.*

*(This was for a MySQL admin user, which is useful in Shell scripts, but you could do it for a normal MySQL user with the appropriate SQL commands.)*

***Disclaimer**: On a production server, this method has some security problems of having an admin MySQL user's password in a readable file. But, you need to find your own way to deal with that securely, probably by keeping it in a secure location and not readable by the public.*

#### Now remove that tutorial admin user so it doesn't cause the codepocalypse...

| **49** :$

```console
mysql --defaults-extra-file=~/School/VIP/401/mysqlinfofile -e "DROP USER newadminuser@localhost;"
```

___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S4** :$

```console
exit
```
___

# The Take
## `systemctl`
- `systemctl` manages background server "services", such as an SQL or web server
- Syntax: `systemctl COMMAND SERVICE`
- See usage and examples here: [Resources & Things That Run: systemctl vs service](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

## MySQL in Shell
- A MySQL server is managed from the terminal
- AFter install, production MySQL servers should be made secure with `sudo mysql_secure_installation`
- MySQL can be "queried" two ways:
  1. By entering MySQL to use the prompt, normally using `sudo mysql -u USER -p`
  2. By entering the full query command from the Linux terminal via:
  - `mysql -u USER -pUSERPASSWORD -e "MYSQL COMMAND GOES HERE;"`
- For writing Shell scripts that query MySQL, ***the password should NOT be in the Shell script***, but in a separate file with user information
  - This uses a special flag, eg:
    `mysql --defaults-extra-file=/path/to/user/file -e "MYSQL COMMAND;"`
  - Example file:

  ```shell
  [client]
  user = MYSQLUSERNAME
  password = MYSQLUSERPASSWORD
  host = localhost
  ```

## Develop PHP & MySQL on your Ubuntu desktop
- For your own Ubuntu desktop developer setup for PHP & MySQL, follow the instructions here: [LAMP Desktop](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/LAMP-Desktop.md)

___

#### [Lesson 5: More with Variables](https://github.com/inkVerb/vip/blob/master/401/Lesson-05.md)
