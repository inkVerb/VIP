# Shell 401
## Lesson 4: MySQL & systemctl

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

SQL language is generally the same across database platforms.

This does not teach SQL language.

This teaches basic SQL control operations in MySQL from Shell, without having to login to MySQL.
___
> Optional: You may login as a "sudoer" if needed
>
> `su USERNAME`
>
___

*MySQL can be installed with:* `sudo apt install mysql-server`

*Use* `systemctl` *to start, stop, restart, and check the status of services, such as MySQL*

`sudo systemctl status mysql`

*Note MySQL is running*

*Stop MySQL:*

`sudo systemctl stop mysql`

*Check the status*

`sudo systemctl status mysql`

*Start MySQL*

`sudo systemctl start mysql`

*Check the status*

`sudo systemctl status mysql`

### Make MySQL secure

*This is not necessary, but most MySQL instructions will assume this was done, including this tutorial.*

`sudo mysql_secure_installation`

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

#### Two ways:

##### 1. First time ever

`sudo mysql`

##### 2. Password already set

`sudo mysql -u root -p`

### The MySQL command prompt: `mysql>_`

*Note most coders put SQL commands in ALL CAPS, but lowercase also works.*

#### Change MySQL root password
___

*Enter the following:*

`ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'newpassword';`

`FLUSH PRIVILEGES;`

`QUIT`
___

*Note you exited MySQL*

*Go back into MySQL* `-u [user]` *is the user* `-p` *means to prompt for a password*

*Note, because MySQL's root password is now setup, we no longer need* `sudo` *with* `mysql`

`mysql -u root -p` *And enter the password: newpassword*

*You are back in MySQL*

#### Basic MySQL commands (users & databases)
___

*List databases:*

`SHOW DATABASES;`

*Create a database:*

`CREATE DATABASE vipdatabase;`

`SHOW DATABASES;`

*Now we made the database "vipdatabase"! Yeah!*

*List users:*

`SELECT User FROM mysql.user;`

*Create user (simply by assigning one to a database):*

`GRANT ALL PRIVILEGES ON vipdatabase.* TO 'vipuser'@'localhost' IDENTIFIED BY 'vippassword';`

`SELECT User FROM mysql.user;`

*That user can't use the database until we "flush" privileges...*

`FLUSH PRIVILEGES;`

*Now we made the user "vipuser", and it can access "vipdatabase"! Yeah!*

*Let's have another look at the databases...*

`SHOW DATABASES;`

*Delete the database "vipdatabase"*

`DROP DATABASE vipdatabase;`

`SHOW DATABASES;`

*...all gone!*

`SELECT User FROM mysql.user;`

*...but but the user is still there!*

*Delete the user "vipuser"*

`DROP USER vipuser@localhost;`

`SELECT User FROM mysql.user;`

*...all gone!*

`QUIT`
___

### MySQL via Shell

*Look at this carefully:*

- `mysql -u root -pnewpassword -e "MYSQL COMMAND GOES HERE;"`
- `mysql -u root -pPASSWORD_HERE` *This starts the MySQL command.*
- `-pPASSWORD_HERE` *No space between* `-p` *and the password! **This is normally bad!***
- `-e` *We need this for it to work in Shell.*
- `"MYSQL COMMAND GOES HERE;"` *The normal MySQL command can go in the quotes.*

`mysql -u root -pnewpassword -e "SHOW DATABASES;"`

*Note putting the password in the command at the terminal prompt is usually bad.*

*This is the normal way:*

`mysql -u root -p -e "SHOW DATABASES;"` *Enter the password: newpassword*

*But, we're being lazy and this is a tutorial, so we don't care...*

`mysql -u root -pnewpassword -e "SHOW DATABASES;"`

`mysql -u root -pnewpassword -e "CREATE DATABASE vipdatabase;"`

`mysql -u root -pnewpassword -e "SHOW DATABASES;"`

`mysql -u root -pnewpassword -e "SELECT User FROM mysql.user;"`

`mysql -u root -pnewpassword -e "GRANT ALL PRIVILEGES ON vipdatabase.* TO 'vipuser'@'localhost' IDENTIFIED BY 'vippassword'; FLUSH PRIVILEGES;"`

*Note we put "FLUSH PRIVILEGES;" in the same command because ";" separates commands.*

`mysql -u root -pnewpassword -e "SELECT User FROM mysql.user;"`

`mysql -u root -pnewpassword -e "SHOW DATABASES;"`

`mysql -u root -pnewpassword -e "DROP DATABASE vipdatabase;"`

`mysql -u root -pnewpassword -e "SHOW DATABASES;"`

`mysql -u root -pnewpassword -e "SELECT User FROM mysql.user;"`

`mysql -u root -pnewpassword -e "DROP USER vipuser@localhost;"`

`mysql -u root -pnewpassword -e "SELECT User FROM mysql.user;"`

*Conclusion: The commands in MySQL can be run from a Shell prompt.*

### MySQL password file for secure Shell scripts

*But, the password should never go on the command line. Do this instead:*

1. Put special MySQL admin user & password info in a file: /path/to/userinfo/file

*Create a new admin user in MySQL* ***only*** *for your Shell scripts...*

`sudo mysql -u root -p` *Enter your password; annoying, but this is the "secure" way.*

`GRANT ALL PRIVILEGES ON *.* TO 'newadminuser'@'localhost' IDENTIFIED BY 'newpassword' WITH GRANT OPTION;`

`SELECT User FROM mysql.user;` *(If you really, badly want to see that the user is there.)*

`FLUSH PRIVILEGES;`

`QUIT`

*Put the same username & info into a file:*

```shell
echo "[client]
user = newadminuser
password = newpassword
host = localhost
" > mysqlinfofile
```

`ls`

`cat mysqlinfofile`

*There it is, there's your file.*

2. Run your MySQL command like this: `mysql --defaults-extra-file=/path/to/userinfo/file -e "MYSQL COMMAND;"`

*For example (this can also go in your Shell script):*

`mysql --defaults-extra-file=~/School/VIP/shell/401/mysqlinfofile -e "SHOW DATABASES;"`

*...and that's how to put MySQL commands in a Shell script.*

*(This was for a MySQL admin user, which is useful in Shell scripts, but you could do it for a normal MySQL user with the right SQL commands.)*

*DISCLAIMER: On a production server, this method has some security problems of having an admin MySQL user's password in a readable file. But, you need to find your own way to deal with that securely, probably by keeping it in a secure location and not readable by the public.*

#### Now remove that tutorial admin user because it can cause the codepocalypse...

`sudo mysql -u root -pnewpassword -e "DROP USER newadminuser@localhost;"`

*Refer to this cheat-sheet for more about systemctl and others:* [VIP/Cheet-Sheets: Resources & Things That Run](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Resources.md)

#### [Lesson 5: More with Variables](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-05.md)
