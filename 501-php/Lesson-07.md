# PHP 501
## Lesson 7: Account & Settings

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

| **1** :> `CREATE DATABASE blog_db;`

| **2** :> `GRANT ALL PRIVILEGES ON blog_db.* TO blog_db_user@localhost IDENTIFIED BY 'blogdbpassword';`

| **3** :> `FLUSH PRIVILEGES;`

**Now, we have these database credentials:** (Many web apps ask for this on install)
```
Database name: blog_db
Database user: blog_db_user
Database password: blogdbpassword
Database hose: localhost
```

*Get ready to work in our SQL terminal...*

| **4** :> `USE blog_db`







| **1** : `mkdir web/css && cp core/01-style.css web/css/style.css && gedit web/css/style.css && ls web/css`

| **2** : `cp core/01-back-users.html web/back-users.html && gedit web/back-users.html && ls web`

| **B-2** :// `localhost/web/back-users.html`

| **3** : `cp core/01-front-home.html web/front-home.html && gedit web/front-home.html && ls web`

| **B-2** :// `localhost/web/front-home.html`

| **4** : `cp core/01-front-page.html web/front-page.html && gedit web/front-page.html && ls web`

| **B-2** :// `localhost/web/front-page.html`

| **5** : `cp core/01-front-post.html web/front-post.html && gedit web/front-post.html && ls web`

| **B-2** :// `localhost/web/front-post.html`

| **6** : `cp core/01-back-pieces.html web/back-pieces.html && gedit web/back-pieces.html && ls web`

| **B-2** :// `localhost/web/back-pieces.html`

| **7** : `cp core/01-back-settings.html web/back-settings.html && gedit web/back-settings.html && ls web`

| **B-2** :// `localhost/web/back-settings.html`
___

# The Take

___

#### [Lesson 8: CMS Blog: Input, Display & TinyMCE](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-08.md)
