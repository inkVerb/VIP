# Shell 501
## Lesson 9: Content Library

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser tabs!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** : `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :> `USE webapp_db;`

| **SB-1** ://phpMyAdmin **> webapp_db**

___

We want to review a list of our pieces

### Cleanup header/footer and prepare our "Pieces" page framework

| **1** :
```
sudo cp core/09-pieces1.php web/pieces.php && \
sudo cp core/09-logincheck.in.php web/in.login_check.php && \
sudo cp core/09-footer.in.php web/in.footer.php && \
sudo cp core/09-edit.php web/edit.php && \
sudo cp core/09-blog.php web/blog.php && \
sudo cp core/09-webapp.php web/webapp.php && \
sudo cp core/09-accountsettings.php web/account.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces1.php web/in.login_check.php web/in.footer.php web/edit.php web/blog.php web/webapp.php web/account.php && \
ls web
```

*Note basic changes:*

- *`$edit_page_yn` to see whether to add JS for TinyMCE:*
  - *in.login_check.php*
  - *pieces.php: `false`*
  - *edit.php: `true`*
- *`$nologin_allowed` to redirect if not logged in:*
  - *pieces.php: `false`*
  - *in.login_check.php*
  - *edit.php: `false`*
  - *blog.php: `true`*
  - *webapp.php: `true`*
- *in.login_check.php*
  - *HTML page starts at end of logic*
  - *`<h1>` page name is part*
- *in.footer.php*
  - *Finally here in all page files*
  - *Simple for now: `</body>` & `</html>`*
- *webapp.php*
  - *Only handles login/logout*
  - *Is a little more complicated because it processes the POST for the login `<form>`*
- *account.php*
  - *Ready for our new in.login_check and in.footer files*

***Note our new file:***

- *pieces.php*
  - *Lists all pieces in a `while` loop and `<table>`*
  - *We will add more later*

| **B-1** :// `localhost/web/pieces.php` (It will redirect to webapp.php)

*Note it redirected because you are not logged in; Login:*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, enter the address directly or just click "Pieces"...*

| **B-2** :// `localhost/web/pieces.php` (Now you stay because are logged in)

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Review pieces on our SQL table...*

| **2** ://phpMyAdmin **> pieces**

| **2** :> `SELECT id, type, status, title, date_created FROM pieces;`

That's quite simple, let's expand...

### More useful data, actions, and editable fields

| **3** :
```
sudo cp core/09-pieces2.php web/pieces.php && \
sudo cp core/09-delete2.php web/delete.php && \
sudo cp core/09-undelete2.php web/undelete.php && \
sudo cp core/09-empty_delete2.php web/empty_delete.php && \
sudo cp core/09-newpublish2.php web/newpublish.php && \
sudo cp core/09-unpublish2.php web/unpublish.php && \
sudo cp core/09-republish2.php web/republish.php && \
sudo cp core/09-pagify2.php web/pagify.php && \
sudo cp core/09-postify2.php web/postify.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces2.php core/09-delete2.php core/09-undelete2.php core/09-empty_delete2.php core/09-newpublish2.php core/09-unpublish2.php core/09-republish2.php core/09-pagify2.php core/09-pagify2.php core/09-postify2.php && \
ls web
```

*Note pieces.php:*

- *SQL evaluates a user-useful meaning of "status" and "date", not only the settings from the database*
- *Every `<tr>` row has options that depend on the status of the piece*

*Note simple SQL queries based on GET arguments:*

- *delete.php*
- *undelete.php*
- *empty_delete.php*
- *unpublish.php*
- *republish.php*
- *pagify.php*
- *postify.php*

*Note newpublish.php:*

- *This prepares, then auto-sends a normal piece `<form>` to POST*
- *When receiving a piece `<form>` POST, this behaves just like edit.php and processes the same full publishing process*

| **B-3** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Observe changes to pieces on our SQL table...*

| **3** ://phpMyAdmin **> pieces**

| **3** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

*Note which piece IDs are not listed in publications...*

| **4** ://phpMyAdmin **> publications**

| **4** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`

While this works, we don't want a GET URL to be this powerful, use POST instead...

### Require POST for our actions

| **5** :
```
sudo cp core/09-pieces3.php web/pieces.php && \
sudo cp core/09-postfunctions.in.php web/in.postfunctions.php && \
sudo cp core/09-style.css web/style.css && \
sudo cp core/09-delete3.php web/delete.php && \
sudo cp core/09-undelete3.php web/undelete.php && \
sudo cp core/09-empty_delete3.php web/empty_delete.php && \
sudo cp core/09-newpublish3.php web/newpublish.php && \
sudo cp core/09-unpublish3.php web/unpublish.php && \
sudo cp core/09-republish3.php web/republish.php && \
sudo cp core/09-pagify3.php web/pagify.php && \
sudo cp core/09-postify3.php web/postify.php && \
atom core/09-pieces3.php web/in.postfunctions.php web/style.css core/09-delete3.php core/09-undelete3.php core/09-empty_delete3.php core/09-newpublish3.php core/09-unpublish3.php core/09-republish3.php core/09-pagify3.php core/09-pagify3.php core/09-postify3.php && \
ls web
```

*Note pieces.php:*

- *We added an `include` for in.postfunctions.php*
- *We use a `postform()` function rather than links*

*Note in.postfunctions.php:*

- *We created the `postform()` function*
- *The `style=` attribute embedded inside the `<form>` tag is necessary for `float:` to work*

*Note style.css:*

- *We added `.postform` classes*

*Note these validate POST instead of GET, no other differences:*

- *delete.php*
- *undelete.php*
- *empty_delete.php*
- *unpublish.php*
- *republish.php*
- *pagify.php*
- *postify.php*
- *newpublish.php*


| **B-5** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Observe changes to pieces on our SQL table...*

| **5** ://phpMyAdmin **> pieces**

| **5** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

| **6** ://phpMyAdmin **> publications**

| **6** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`

### Trash page with restore and bulk empty

| **7** :
```
sudo cp core/09-pieces4.php web/pieces.php && \
sudo cp core/09-trash.php web/trash.php && \
sudo cp core/09-undelete_trash.php web/undelete_trash.php && \
sudo cp core/09-empty_delete_trash.php web/empty_delete_trash.php && \
sudo cp core/09-empty_all_trash.php web/empty_all_trash.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces4.php web/trash.php web/undelete_trash.php web/empty_delete_trash.php web/empty_all_trash.php && \
ls web
```

*Note pieces.php:*

- *Now, there is a link to "Trash"*

*Note trash.php:*

- *This is similar to pieces.php, but toned down*

*Note these redirect to trash.php, not pieces.php:*

- *undelete_trash.php*
- *empty_delete_trash.php*

*Note empty_all_trash.php:*

- *This has a `while` loop to delete each "dead" piece*


| **B-7** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Review "pieces" on our SQL table...*

| **7** ://phpMyAdmin **> pieces**

| **7** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

| **8** ://phpMyAdmin **> publications**

| **8** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`







Eventually use [htmldiff.js](https://github.com/tnwinc/htmldiff.js) to compare revision history
- [https://ourcodeworld.com/articles/read/653/how-to-diff-html-compare-and-highlight-differences-and-generate-output-in-html-with-javascript]
___

# The Take

___

#### [Lesson 10: Media Library & Uploads](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-10.md)
