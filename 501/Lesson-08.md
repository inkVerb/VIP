# Linux 501
## Lesson 8: CMS Blog: Edit, Display & TinyMCE

Ready the CLI

```console
cd ~/School/VIP/501
```

Ready services

Arch/Manjaro, OpenSUSE, RedHat/CentOS
```console
sudo systemctl start httpd mariadb
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mariadb
```

If teaching multiple students

Prep directory
```console
cd ~/School/VIP
```

Webapp database ***dump***
```console
mariadb-dump -u admin -padminpassword webapp_db > STUDENT_1/webapp_db.sql
```

Webapp database ***restore***
```console
mariadb -u admin -padminpassword webapp_db < STUDENT_2/webapp_db.sql
```

Backup Student 1 schoolwork directory
```console
rm 501/web
sudo mv /srv/www/html/web 501/
```

```console
mv 501 STUDENT_1/
```

Restore Student 2 schoolwork directory
```console
mv STUDENT_2/501 .
```

```console
sudo mv 501/web /srv/www/html/
sudo chown -R www:www /srv/www/html/web
sudo ln -sfn /srv/www/html/web 501/
sudo chown -R www:www 501/web
```

Re-ready the CLI

```console
cd ~/School/VIP/501
```

### This lesson uses two terminals and three browser tabs!
Ready the secondary SQL terminal and secondary SQL browser

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mariadb -u admin -padminpassword
```

| **SO** :> *(If returning after **SR1**)*

```sql
USE webapp_db;
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`**

### CSS for Reload:

| **C-0** :// (Reload this every time `style.css` is updated)

```console
localhost/web/style.css
```

### Rebuild our web app from the beginning
*Create the database with user, then use the database in the SQL terminal*

| **SR1** :>

```sql
CREATE DATABASE webapp_db;
GRANT ALL PRIVILEGES ON webapp_db.* TO webapp_db_user@localhost IDENTIFIED BY 'webappdbpassword';
FLUSH PRIVILEGES;
USE webapp_db;
```

| **SR2** ://phpMyAdmin **> webapp_db**

*Rebuild our webapp files, make sure we begin fresh*

| **R3** :$

```console
sudo cp core/08-webapp.php web/webapp.php && \
sudo cp core/08-account.php web/account.php && \
sudo cp core/08-forgot.php web/forgot.php && \
sudo cp core/08-logout.php web/logout.php && \
sudo cp core/08-in.config.php web/in.config.php && \
sudo cp core/08-cleanup.php web/cleanup.php && \
sudo cp core/08-ajaxstring.php web/ajax_string.php && \
sudo cp core/08-recover.php web/recover.php && \
sudo cp core/08-recover_login.php web/recover_login.php && \
sudo cp core/08-in.login_head_old.php web/in.login_head.php && \
sudo cp core/08-in.string_functions.php web/in.string_functions.php && \
sudo cp core/08-in.functions.php web/in.functions.php && \
sudo cp core/08-in.checks.php web/in.checks.php && \
sudo cp core/08-install.php web/install.php && \
sudo cp core/08-style_old.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/08-webapp.php core/08-account.php core/08-forgot.php core/08-logout.php core/08-in.config.php core/08-cleanup.php core/08-ajaxstring.php core/08-recover.php core/08-recover_login.php core/08-in.login_head_old.php core/08-in.string_functions.php core/08-in.functions.php core/08-in.checks.php core/08-install.php core/08-style_old.css && \
ls web
```

*On a production server we need this*

| **`/etc/cron.d/webappcleanup`** :

```
* * * * * root /usr/bin/php /srv/www/html/web/cleanup.php
```

*Install the app, same as in [Lesson 4](https://github.com/inkVerb/vip/blob/master/501/Lesson-04.md)*

| **B-R3** ://

```console
localhost/web/install.php
```

**Database credentials:**

```
Database name: webapp_db
Database user: webapp_db_user
Database password: webappdbpassword
Database host: localhost
```

**User creation credentials:**

```
Username: jonboy
Password: My#1Password
```

*Use whatever you want for all else*

### Review
*Examine the files now open in the text exitor; this is what we basically have running so far*

*Also, feel free to explore the tables in SQL*

| **RS3** :>

```sql
SHOW TABLES;
```

___

### Set up Editor Framework

| **1** :$

```console
sudo cp core/08-edit1.php web/edit.php && \
sudo cp core/08-in.login_head.php web/in.login_head.php && \
sudo cp core/08-in.logincheck1.php web/in.logincheck.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-edit1.php core/08-in.login_head.php core/08-in.logincheck1.php && \
ls web
```

*Note:*

- *in.logincheck.php simply checks for a SESSION or COOKIE login:*
  - *Redirect to webapp.php if no login*
  - *Message and admin links if logged in*
  - *Note we used the `$head_title` variable for the browser `<title>`*
- *in.login_head.php has two changes:*
  - *Line 38 redirects to `blog.php`*
  - *Line 188 has a link to `edit.php`*
  - *near the bottom has a link to `edit.php`*
- *edit.php is very simple now, but it contains our three prep files:*
  - *`in.config.php`*
  - *`in.functions.php`*
  - *`in.logincheck.php`*
- *edit.php has no `<head>` because it is created by `in.logincheck.php`*
  - *PHP redirects to a new page via `header()`, which uses `<head>`*
  - *If the `<head>` was already created in HTML, `header()` might break*
  - *So, when redirecting, such as in pages requiring login:*
    1. *Process the `if` tests to redirect via `header("Location: to_page.php")`*
    2. *Then create the `<head>` tag*

| **B-1** :// (This should redirect to webapp.php)

```console
localhost/web/edit.php
```

*Note it redirected if you are not logged in; Login:*

```
Username: jonboy
Password: My#1Password
```

*Once logged in, you can click the new "Editor" link or enter the address directly...*

| **B-2** :// (Now it will load because you are logged in)

```console
localhost/web/edit.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Create the SQL table for a "Piece"...*

| **2** ://phpMyAdmin **> webapp_db**

| **3** :>

```sql
CREATE TABLE IF NOT EXISTS `pieces` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('post', 'page') NOT NULL,
  `status` ENUM('live', 'dead') NOT NULL,
  `pub_yn` BOOLEAN NOT NULL DEFAULT false,
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

### Add our `<form>` to the Editor

| **3** :$

```console
sudo cp core/08-edit2.php web/edit.php && \
sudo cp core/08-in.editprocess2.php web/in.editprocess.php && \
sudo cp core/08-in.piecefunctions2.php web/in.piecefunctions.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-edit2.php core/08-in.editprocess2.php core/08-in.piecefunctions2.php && \
ls web
```

| **B-3** :// *(<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/edit.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note our JavaScript in:*

- *edit.php: div id "goLiveOptions"*
- *in.piecefunctions.php: onClick "showGoLiveOptionsBox"*
- *This makes our "Schedule..." Date Live settings show/hide with the checkbox*

*Note in.piecefunctions.php:*

- *`strip_tags($value);` removes HTML tags*
- *`htmlspecialchars($value);` converts all HTML characters to their HTML enity code*

1. Fill-out the fields, being simple with what you want
2. Click "Save" (only once!)
3. Note the green message: Saved!

| **B-4** :// (Save)

```console
localhost/web/edit.php
```

| **4** :>

```sql
SELECT * FROM pieces;
```

| **4** ://phpMyAdmin **> pieces**

*...There is the piece we just created, in the database*

1. Don't change any fields
2. Click "Save"
3. Note the green message: Saved!
4. Note the changes in the database...

| **B-5** :// (Save)

```console
localhost/web/edit.php
```

| **5** :>

```sql
SELECT * FROM pieces;
```

| **5** ://phpMyAdmin **> pieces**

*...There are two pieces now in the database*

- *This is because we did not `UPDATE` the old entry*
- *Our PHP script will only `INSERT` new entries*

*Save one more for practice in the future...*

1. Don't change any fields
2. Click "Save"
3. Note the green message: Saved!
4. Note the changes in the database...

| **B-6** :// (Save)

```console
localhost/web/edit.php
```

| **6** :>

```sql
SELECT * FROM pieces;
```

| **6** ://phpMyAdmin **> pieces**

*We can only create new pieces, not update*

### Add an `UPDATE` Ability to Our Form Processor
**We must write the PHP script to:**

- `UPDATE` existing pieces
- Retrieve the ID of the most recent `INSERT`

This will get the ID of the last database `INSERT`:

```sql
SELECT SCOPE_IDENTITY();
```

This is how to do the same in MySQLi (SQL for PHP):

```php
$last_id = $database->insert_id;
```

| **7** :$

```console
sudo cp core/08-edit3.php web/edit.php && \
sudo cp core/08-in.editprocess3.php web/in.editprocess.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-edit3.php core/08-in.editprocess3.php && \
ls web
```

| **B-7** :// *(**Must use** <kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/edit.php
```

*Note the Slug was updated because this is technically a new piece*

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note:*

- *edit.php has a "New or update" if statement*
  - *This adds a `hidden` `<input>` tag with the piece ID if there is one*
  - *This will be included in the POST array if it is there*
- *in.editprocess.php adds*
  - *An "update" SQL query option*
  - *An entire section dedicated to GET methods so the piece ID is in the URL*
  - *The page refreshes if a new piece is saved the first time*
    - *This readies the just-saved piece for edit/UPDATE actions*
    - *This just-saved new ID comes from `$database->insert_id;`*
  - *Check for "duplicate" to avoid unneeded `UPDATE` queries (search 'duplicate' in the file)*
- *With all this, a new piece or an edited piece will use the same .php file*
  - *An edited piece will have the `?p=ID` GET argument in the URL*
  - *A new piece will have no GET argument in the URL*

1. Delete the entire Slug field
2. Make a few other changes, including the Title
3. Click "Save"
4. Note the various and sundry save messages
5. Note the changes in the database...

| **B-8** :// (Save, multiple times, changing and not)

```console
localhost/web/edit.php
```

| **8** :>

```sql
SELECT * FROM pieces;
```

| **8** ://phpMyAdmin **> pieces**

### Add `publications` Table with Revision History

**Workflow:**

- Pieces are prepared and saved in `pieces` table
- Once published, they are added to the `publications` table
- All versions of published pieces are added to the `publication_history` table
- "Save draft" changes are not published, only saved to the `pieces` table

| **9** :$

```console
sudo cp core/08-edit4.php web/edit.php && \
sudo cp core/08-in.editprocess4.php web/in.editprocess.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-edit4.php core/08-in.editprocess4.php && \
ls web
```

*Create the SQL tables for publication and history...*

| **9** :>

```sql
CREATE TABLE IF NOT EXISTS `publications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `piece_id` INT UNSIGNED NOT NULL,
  `type` ENUM('page', 'post') NOT NULL,
  `status` ENUM('live', 'dead') NOT NULL,
  `pubstatus` ENUM('published', 'redrafting') NOT NULL,
  `title` VARCHAR(90) NOT NULL,
  `slug` VARCHAR(90) NOT NULL,
  `content` LONGTEXT DEFAULT NULL,
  `after` TINYTEXT DEFAULT NULL,
  `date_live` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `date_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `publication_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `piece_id` INT UNSIGNED NOT NULL,
  `type` ENUM('page', 'post') NOT NULL,
  `title` VARCHAR(90) NOT NULL,
  `slug` VARCHAR(90) NOT NULL,
  `content` LONGTEXT DEFAULT NULL,
  `after` TINYTEXT DEFAULT NULL,
  `date_live` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `date_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

| **B-9** :// *('Enter' in the browser address bar to properly load; **do not** simply reload)*

```console
localhost/web/edit.php?=...
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note:*

- *in.editprocess.php adds*
  - *Several calls for a `publications` table were added*
  - *`$p_status` variable*
  - *`$editing_published_piece` variable*
  - *`$editing_existing_piece` variable*
- *edit.php has a "New or update" if statement*
  - *"Save draft" and "Publish" `<submit>` inputs for the `<form>`*
  - *`$editing_published_piece` changes "Publish" to "Update"*

| **9a** ://phpMyAdmin **> webapp_db** *(Refresh)*

| **9b** ://phpMyAdmin **> webapp_db > publications**

1. Make a few slight changes, or not (in the web app, not in phpMyAdmin)
2. Click "Save draft", "Publish", or "Update"
3. Note the various and sundry save messages
4. Note the changes in the database  (SQL terminal or phpMyAdmin)

| **10a** :>

```sql
SELECT * FROM pieces;
```

| **10a** ://phpMyAdmin **> pieces**

| **10b** :>

```sql
SELECT * FROM publications;
```

| **10b** ://phpMyAdmin **> publications**

*Try the above four steps a few times to watch it work*

**SQL Tip**

*We have many entries on our `publication_history` table, even for the same piece...*

| **11** :>

```sql
SELECT id, piece_id, title, content, after FROM publication_history;
```

*This is a handy SQL query to get only the most recent version of each published piece:*

| **11** :>

```sql
SELECT p1.id, p1.piece_id, p1.title, p1.content, p1.after, p1.date_live, p1.date_updated
FROM publication_history p1 LEFT JOIN publication_history p2
ON (p1.piece_id = p2.piece_id AND p1.id < p2.id)
WHERE p2.id IS NULL;
```

*That complexity is why we put our publications and history in different tables*

*Note how the buttons change if we use a new piece...*

| **B-11** :// (Save draft / Publish / Update)

```console
localhost/web/edit.php
```

### View Our Pieces on Our Site

| **12** :$

```console
sudo cp core/08-htaccess web/.htaccess && \
sudo cp core/08-blog.php web/blog.php && \
sudo cp core/08-piece.php web/piece.php && \
sudo cp core/08-in.logincheck2.php web/in.logincheck.php && \
sudo cp core/08-in.head.php web/in.head.php && \
sudo cp core/08-edit5.php web/edit.php && \
sudo cp core/08-style.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/08-blog.php core/08-piece.php core/08-in.logincheck2.php core/08-in.head.php core/08-edit5.php core/08-style.css && \
ls web
```

*Note:*

- *.htaccess*
  - *Forwards basic slug to: `piece.php?s=$1`*
- *`blog.php`*
  - *We reverse our SQL sanitation with `htmlspecialchars_decode()`*
  - *Each piece link simply points to its slug*
- *`piece.php`*
  - *Like a single-piece viewer of `blog.php`*
  - *Logic accepts both `s=SLUG` and `p=piece_ID` GET arguments*
  - *Not restricted to SQL `type='post'`; this can also show pages*
- *`in.logincheck.php`*
  - *Removed redirect if not logged in*
  - *"Should not be here" scenarios now redirect to our new blog.php page*
  - *Remove HTML headerfor `in.head.php`*
- *`in.head.php`*
  - *Contains our previous HTML head*
  - *Includes our user header links only if logged in*
- *in.piecefunctions.php (remember)*
  - *`htmlspecialchars($value);` converts all HTML characters to their HTML enity code*
- *`edit.php`*
  - *Added `include ('./in.head.php');`*
- *`style.css`*
  - *Added a `.piece-content` class for piece content*

| **B-12** ://

```console
localhost/web/blog.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note how each piece entry is iterated from the loop*

### HTML Styling

| **B-13** ://

```console
localhost/web/edit.php
```

1. Paste-in the following code (along with HTML markup):

```html
<p>This is HTML style: <strong>bold</strong> <em>italics <strong>bold italics</strong></em></p>
<p style="text-align: center;">Paragraph center</p>
<p style="text-align: right;">Paragraph right</p>
<p>Symbols: &deg;&para;&trade;&copy;&reg;&cent;&pound;&euro;&yen;&sect;&spades;&clubs;&hearts;&diams;</p>
<p>en dash: &ndash; em dash: &mdash;</p>
```
2. Click "Update" or "Publish"
3. See the changes on the blog and in the database...

| **B-14** ://

```console
localhost/web/blog.php
```

| **14** :>

```sql
SELECT * FROM pieces;
```

| **14** ://phpMyAdmin **> pieces**

### WYSIWYG Editor
**What You See Is What You Get**

This type of editor gives you buttons to add HTML style

Usually, these use JavaScript to change the `<textarea>` you want as your editor

#### TinyMCE
- [GitHub repo](https://github.com/tinymce/tinymce-dist) (original, maintained)
- [GitHub fork](https://github.com/inkVerb/tinymce-dist) (legacy version used in this lesson)

TinyMCE is a basic WISYWIG many people are familiar with

On your own, learn more about implementation at [tiny.cloud](https://www.tiny.cloud/docs/general-configuration-guide/basic-setup/)

Let's just watch it work...

##### Core Example: CDN (Online JS)

*This may be locked since we don't have an API key, but you can see it is there...*

| **15** :$

```console
sudo cp core/08-tiny-cdn.html web/tiny.html && \
sudo chown -R www:www /srv/www/html && \
code core/08-tiny-cdn.html && \
ls web
```

| **B-15** ://

```console
localhost/web/tiny.html
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*This form won't do anything, just give it a good look*

*Note:*

- *There are two `<script>` entries in the `<head>`, both make TinyMCE work*
- *The `selector: '#myTextarea'` JavaScript statement*
- *The `<textarea id="myTextarea">` to connect it to the JavaScript*
- *The JavaScript tinymce.min.js is included from a "Contend Delivery Network" (CDN), not locally:*
```html
src="https://cdn.tiny.cloud/1/no-api-key/tinymce/5/tinymce.min.js"
```

We can download TinyMCE JavaScript and host it locally...

*(Note, we will use a `git clone` from the inkVerb fork, not from tinymce, so this Lesson will continue to work after the repo is updated; for a live server, we would `git clone` from the original developer)*

##### Core Example: Local (JS on our server)

| **16** :$

```console
sudo cp core/08-tiny-man.html web/tiny.html && \
git clone https://github.com/inkverb/tinymce-dist.git
sudo mv tinymce-dist web/tinymce
sudo chown -R www:www /srv/www/html && \
code core/08-tiny-man.html && \
ls web
```

*Note:*

- *This example uses many common settings*
- *tiny.html includes the JavaScript locally, not from a CDN:*
```html
src='tinymce/tinymce.min.js'
```
- *TinyMCE requires the entire `tinymce` folder to work*
  - *located here:*
```bash
/srv/www/html/web/tinymce
```
  - *Downloaded from here:*
```
https://github.com/tinymce/tinymce-dist
```

| **B-16** :// *(<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/tiny.html
```

*Note there is no message about domains*

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

##### Customize TinyMCE
We can customize the TinyMCE toolbar layout

| **17** :$

```console
sudo cp core/08-tiny-cust.html web/tiny.html && \
sudo chown -R www:www /srv/www/html && \
code core/08-tiny-cust.html && \
ls web
```

*Note settings:*

*- `block_formats`: defines items in the dropdown with "Paragraph, Heading 1, etc" (adds "inline code")*
*- `toolbar`: lists tool buttons, including buttons defined in `toolbar_groups` (popup button groups)*
*- `toolbar_groups`: defines our buttons in the toolbar: `formatgroup paragraphgroup toolgroup`*
*- `toolbar_location`: put the tools at the bottom*
*- `menubar`: `= false` removed "My Favorites, File, Edit, View, etc"*
*- `paste_as_text`: "Paste" removes formatting (see it already "on" by clicking the "T" formatting button)*
*- `content_css`: should be our style.css file so "Preview" uses our styling*

| **B-17** :// *(<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/tiny.html
```

##### TinyMCE in Our 501 Blog

| **18** :$

```console
sudo cp core/08-in.head3-tinymce.php web/in.head.php && \
sudo cp core/08-in.piecefunctions3.php web/in.piecefunctions.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-in.head3-tinymce.php core/08-in.piecefunctions3.php && \
ls web
```

*Note:*

- *`in.head.php`*
  - *Note the two `<script>` sections between the comments `<!-- TinyMCE -->`*
  - *These include the JavaScript* ***in the header*** *so TinyMCE works*
  - *It calls the* ***class*** *of our "Content" `<textarea>` HTML element by `class="tinymce_editor"`*
    - *This is from the setting: `selector: '.tinymce_editor'`*
    - *This could be an ID with: `selector: '#tinymce_editor'`*
- *`in.piecefunctions.php`*
  - *Adds `class="tinymce_editor"` to `<textarea id="p_content"`*

| **B-18** :// *(Same as previously, empty form)*

```console
localhost/web/edit.php
```

1. Type new content
2. Apply or note some HTML styling with the WYSYWIG buttons
3. Click "Update" or "Publish"
4. See the changes on the blog and in the database...

| **B-18** ://

```console
localhost/web/blog.php
```

| **18** :>

```sql
SELECT * FROM pieces;
```

| **18** ://phpMyAdmin **> pieces**

#### Medium Editor
- [GitHub repo](https://github.com/yabwe/medium-editor/releases)
- [GitHub fork](https://github.com/inkVerb/medium-editor/releases) (in case it doesn't work)

The Medium editor is a simplified WISYWIG alternative to TinyMCE

Let's just watch it work for now...

##### Core Example

| **19** :$

```console
sudo cp core/08-medium-cdn.html web/medium.html && \
sudo chown -R www:www /srv/www/html && \
code core/08-medium-cdn.html && \
ls web
```

| **B-19** ://

```console
localhost/web/medium.html
```

1. Type something, it is a very blank text editor
2. Highlight some text to see the styling options menu

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*This form won't do anything, just give it a good look and try*

*Note:*

- *There are two `<script>` entries in the `<head>`, both make Medium work*
- *The `selector: '#myTextarea'` JavaScript statement*
- *The `<textarea id="myTextarea">` to connect it to the JavaScript*
- *The JavaScript tinymce.min.js is included from a "Contend Delivery Network" (CDN), not locally:*
```html
src="//cdn.jsdelivr.net/npm/medium-editor@5.23.2/dist/js/medium-editor.min.js"
```

We can download the Medium editor JavaScript and host it locally...

*(Note, we will use a `git clone` from the inkVerb fork, not from yabwe, so this Lesson will continue to work after the repo is updated; for a live server, we would `git clone` from the original)*

| **20** :$

```console
sudo cp core/08-medium-man.html web/medium.html && \
git clone https://github.com/inkverb/medium-editor.git && \
sudo mkdir web/medium && \
sudo mv medium-editor/dist/css web/medium && \
sudo mv medium-editor/dist/js web/medium && \
rm -rf medium-editor && \
sudo chown -R www:www /srv/www/html && \
code core/08-medium-man.html && \
ls web
```

*Note medium.html includes the JavaScript locally, not from a CDN:*

```html
src="medium/js/medium-editor.js"
```

- *The Medium editor requires the entire `medium` folder to work*
  - *located here:*

```bash
/srv/www/html/web/medium
```

  - *Downloaded from here:*

```
https://github.com/inkverb/medium-editor
```

| **B-20** :// *(<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/medium.html
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

##### Medium Editor Plugin Example: Tables
- [GitHub repo](https://github.com/yabwe/medium-editor-tables) (original, may no longer be abailable)
- [GitHub fork](https://github.com/inkVerb/medium-editor-tables) (in case it went missing as it did)

Medium has an effective way to add plugins

This plugin adds the ability to insert an HTML `<table>`

| **21** :$

```console
sudo cp core/08-medium-tables.html web/medium.html && \
git clone https://github.com/inkverb/medium-editor-tables.git && \
sudo cp medium-editor-tables/dist/css/*.css web/medium/css && \
sudo cp medium-editor-tables/dist/js/*.js web/medium/js && \
sudo chown -R www:www /srv/www/html && \
code core/08-medium-tables.html && \
ls web web
```

| **B-21** :// *(Same)*

```console
localhost/web/medium.html
```

*Notice the "Table" button in the styling options menu (when highlighting text)*

##### Medium's Editor in Our 501 Blog

| **22** :$

```console
sudo cp core/08-in.head4-medium.php web/in.head.php && \
sudo cp core/08-in.piecefunctions-medium.php web/in.piecefunctions.php && \
sudo chown -R www:www /srv/www/html && \
code core/08-in.head4-medium.php core/08-in.piecefunctions-medium.php && \
ls web
```

*Note:*

- *`in.head.php`*
  - *Note the two `<script>` sections between the comments `<!-- Medium editor -->`*
  - *These include the CSS so Medium works*
- *`in.piecefunctions.php`*
  - *This puts the JavaScript* ***after*** *our "Content" `<textarea>` HTML element*
  - *This implements the* ***class*** *`medium_editor` for the Medium editor JavaScript to act on*

| **B-22** :// *(<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)*

```console
localhost/web/edit.php
```

**Notice the text in the "Content" field has no border**

- It can still be edited
- Highlight text to see styling options

*You may be interested in the following optional steps or not...*

___
> Optional: You may toy with the Medium editor
>
> 1. Apply or note some HTML styling with the WYSYWIG buttons
> 2. Click "Update" or "Publish"
> 3. See the changes on the blog and in the database...
>
> | **B-M1** ://

```console
localhost/web/blog.php
```
>
> | **M1** :>

```sql
SELECT * FROM pieces;
```
>
> | **M1** ://phpMyAdmin **> pieces**
>
___

##### Restore the Editor to TinyMCE
The Medium Editor is powerful, but lacks some of the tools we need for this project

*Restore TinyMCE as our main WYSIWYG editor*

| **23** :$

```console
sudo cp core/08-in.head3-tinymce.php web/in.head.php && \
sudo cp core/08-in.piecefunctions3.php web/in.piecefunctions.php && \
sudo chown -R www:www /srv/www/html
```

___

# The Take
## Login Checks
- Checking for user login can be done with a separate `include` file
- Login can affect the header and should be checked early
- Part of the `<head>` can be determined by variables

## Web Page Files
- The actual file for a website page might contain only a few `include` statements
- A blog post editor is probably a `<form>`
- JavaScript can control parts of a page or `<form>`
  - Disable or hide "sub-options" when the parent option is turned off
  - JavaScript `onClick` & `getElementById` can connect two HTML elements

## Handling Blog Entries
- Creating a new piece will use `INSERT` for the SQL database
- Editing an old piece will use `UPDATE` for the SQL database
- Your PHP script must know if you are editing an old or new piece
  - A `$_GET[]` argument is a wonderful way to set which piece you are editing
  - Syntax: `yourwebsite.tld?g=123`
    - (`$_GET[g]` will be your piece number `123` inside your script)
- Drafts, published pieces, and revision history can be complex
  - Make sure you have some way to keep it sorted out
  - Using different database tables is only one way, but it works
- Some blog fields must be unique
  - Use a `while` loop to check the database
  - Use `breeak` to end the loop

## Viewing Blog Entries
- Viewing a blog piece can also use a `$_GET[]` argument
- Viewing is mostly about what HTML you want to organize and display your blog pieces
- Use a `while` loop to show each blog entry on the web page

## WYSIWYG Editors
- TinyMCE and Medium are two common WYSIWYG editors
- These use simple JavaScript
- The ID in the JavaScript should match the ID of the `<textarea>`
- You can download and source the .js file or use an embedded onlin/cdn link

## JavaScript Tools: CDN vs Local
- Many JavaScript tools are included off-site with a "Content Delivery Network" (CDN)
- You can download and install those JavaScript tools, but you must:
  - Follow instructions closely
  - Possibly include the entire folder the JavaScript file comes in
- Via CDN is usually faster and stays up to date
  - But, this may require registration and could break when updated
- Via local hosting give you more control and is likely more stable
  - But, this can be a hassle and can make your website heavier and slower

___

#### [Lesson 9: Content List: Loops, Arrays, JSON & AJAX](https://github.com/inkVerb/vip/blob/master/501/Lesson-09.md)
