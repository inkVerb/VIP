# Shell 501
## Lesson 8: CMS Blog: Edit, Display & TinyMCE

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

### Set up our editor framework

| **1** :
```
sudo cp core/08-edit1.php web/edit.php && \
sudo cp core/08-loginhead.in.php web/in.login_head.php && \
sudo cp core/08-logincheck1.in.php web/in.login_check.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/in.login_head.php web/in.login_check.php web/edit.php && \
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

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the title of the web browser is "Editor" because we set the `<title>` tag*

*Create the SQL table for a "Piece"...*

| **2** ://phpMyAdmin **> webapp_db**

| **3** :>
```sql
CREATE TABLE IF NOT EXISTS `pieces` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` ENUM('post', 'page') NOT NULL,
  `status` ENUM('live', 'dead') NOT NULL,
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

### Add our `<form>` to the editor

| **3** :
```
sudo cp core/08-edit2.php web/edit.php && \
sudo cp core/08-editprocess2.in.php web/in.editprocess.php && \
sudo cp core/08-piecefunctions.in.php web/in.piecefunctions.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/edit.php web/in.editprocess.php web/in.piecefunctions.php && \
ls web
```

*atom: Reload*

- *edit.php*

| **B-3** :// `localhost/web/edit.php` *(Ctrl + R to reload)*

*Use Ctrl + Shift + C in browser to see the developer view*

*Note our JavaScript in:*

- *edit.php: div id "goLiveOptions"*
- *in.piecefunctions.php: onClick "showGoLiveOptionsBox"*
- *This makes our "Schedule..." Date Live settings show/hide with the checkbox*

*Note in.piecefunctions.php:*

- *`filter_var($value, FILTER_SANITIZE_STRING);` removes HTML tags*
- *`htmlspecialchars($value);` converts all HTML characters to their HTML enity code*

1. Fill-out the fields, simple with what you want
2. Click "Save"
3. Note the green message: Saved!

| **B-4** :// `localhost/web/edit.php` (Save)

| **4** :> `SELECT * FROM pieces;`

| **4** ://phpMyAdmin **> pieces**

*...There is the piece we just created, in the database*

1. Don't change any fields
2. Click "Save"
3. Note the green message: Saved!
4. Note the changes in the database...

| **B-5** :// `localhost/web/edit.php` (Save)

| **5** :> `SELECT * FROM pieces;`

| **5** ://phpMyAdmin **> pieces**

*...There are two pieces now in the database*

- *This is because we did not `UPDATE` the old entry*
- *Our PHP script will only `INSERT` new entries*

*Save one more for practice in the future...*

1. Don't change any fields
2. Click "Save"
3. Note the green message: Saved!
4. Note the changes in the database...

| **B-6** :// `localhost/web/edit.php` (Save)

| **6** :> `SELECT * FROM pieces;`

| **6** ://phpMyAdmin **> pieces**

*We can only create new pieces, not update*

### Add an `UPDATE` ability to our form processor

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

| **7** :
```
sudo cp core/08-edit3.php web/edit.php && \
sudo cp core/08-editprocess3.in.php web/in.editprocess.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*atom: Reload*

- *edit.php*
- *in.editprocess.php*

| **B-7** :// `localhost/web/edit.php` *(Ctrl + R to reload)*

*Use Ctrl + Shift + C in browser to see the developer view*

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

1. Make a few slight changes
2. Click "Save"
3. Note the various and sundry save messages
4. Note the changes in the database...

| **B-8** :// `localhost/web/edit.php` (Save)

| **8** :> `SELECT * FROM pieces;`

| **8** ://phpMyAdmin **> pieces**

### Add `publications` table with revision history

**Workflow:**

- Pieces are prepared and saved in `pieces` table
- Once published, they are added to the `publications` table
- All versions of published pieces are added to the `publication_history` table
- "Save draft" changes are not published, only saved to the `pieces` table

| **9** :
```
sudo cp core/08-edit4.php web/edit.php && \
sudo cp core/08-editprocess4.in.php web/in.editprocess.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*atom: Reload*

- *edit.php*
- *in.editprocess.php*

| **B-9** :// `localhost/web/edit.php` *(Ctrl + R to reload)*

*Use Ctrl + Shift + C in browser to see the developer view*

*Note:*

- *in.editprocess.php adds*
  - *Several calls for a `publications` table were added*
  - *`$p_status` variable*
  - *`$editing_published_piece` variable*
  - *`$editing_existing_piece` variable*
- *edit.php has a "New or update" if statement*
  - *"Save draft" and "Publish" `<submit>` inputs for the `<form>`*
  - *`$editing_published_piece` changes "Publish" to "Update"*

*Create the SQL tables for publication and history...*

| **9** :>
```sql
CREATE TABLE IF NOT EXISTS `publications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `piece_id` INT UNSIGNED NOT NULL,
  `type` ENUM('page', 'post') NOT NULL,
  `pubstatus` ENUM('published', 'drafting') NOT NULL,
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

| **9a** ://phpMyAdmin **> webapp_db** *(Refresh)*

| **9b** ://phpMyAdmin **> webapp_db > publications**

1. Make a few slight changes, or not
2. Click "Save draft", "Publish", or "Update"
3. Note the various and sundry save messages
4. Note the changes in the database...

| **B-10** :// `localhost/web/edit.php` (Save draft / Publish / Update)

| **10a** :> `SELECT * FROM pieces;`

| **10a** ://phpMyAdmin **> pieces**

| **10b** :> `SELECT * FROM publications;`

| **10b** ://phpMyAdmin **> publications**

*Try the above four steps a few times to watch it work*

**SQL Tip**

*We have many entries on our `publication_history` table...*

| **11** :>
```sql
SELECT id, piece_id, title, content, after FROM publication_history;
```

*This is a handy SQL query to get only the most recent of each published piece:*

| **11** :>
```sql
SELECT p1.id, p1.piece_id, p1.title, p1.content, p1.after, p1.date_live, p1.date_updated
FROM publication_history p1 LEFT JOIN publication_history p2
ON (p1.piece_id = p2.piece_id AND p1.id < p2.id)
WHERE p2.id IS NULL;
```

*That complexity is why we put our publications and history in different tables*

### View our pieces on our site

| **12** :
```
sudo cp core/08-blog.php web/blog.php && \
sudo cp core/08-logincheck2.in.php web/in.login_check.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/blog.php && \
ls web
```

*atom: Reload*

- *in.login_check.php*

*Note:*

- *in.login_check.php*
  - *Removed redirect if not logged in*
  - *Place HTML header at top*
- *in.piecefunctions.php (remember)*
  - *`htmlspecialchars($value);` converts all HTML characters to their HTML enity code*
- *blog.php*
  - *We reverse our SQL sanitation with `htmlspecialchars_decode()`*

| **B-12** :// `localhost/web/blog.php`

*Use Ctrl + Shift + C in browser to see the developer view*

*Note how each piece entry is iterated from the loop*

### HTML styling

| **B-13** :// `localhost/web/edit.php`

1. Add the following code (with HTML markup):

```html
<p>This is HTML style: <strong>bold</strong> <em>italics <strong>bold italics</strong></em></p>
<p style="text-align: center;">Paragraph center</p>
<p style="text-align: right;">Paragraph right</p>
<p>Symbols: &deg;&para;&trade;&copy;&reg;&cent;&pound;&euro;&yen;&sect;&spades;&clubs;&hearts;&diams;</p>
<p>en dash: &ndash; em dash: &mdash;</p>
```
2. Click "Update" or "Publish"
3. See the changes on the blog and in the database...

| **B-14** :// `localhost/web/blog.php`

| **14** :> `SELECT * FROM pieces;`

| **14** ://phpMyAdmin **> pieces**

### WYSIWYG editor

**What You See Is What You Get**

This type of editor gives you buttons to add HTML style

Usually, these use JavaScript to change the `<textarea>` you want as your editor

#### TinyMCE
- [GitHub repo](https://github.com/tinymce/tinymce-dist)
- [GitHub fork](https://github.com/inkVerb/tinymce-dist) (in case it doesn't work)

TinyMCE is a basic WISYWIG many people know of

On your own, learn more about implementation at [tiny.cloud](https://www.tiny.cloud/docs/general-configuration-guide/basic-setup/)

Let's just watch it work for now...

##### Core example

| **15** :
```
sudo cp core/08-tiny.html web/tiny.html && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/tiny.html && \
ls web
```

| **B-15** :// `localhost/web/tiny.html`

*Use Ctrl + Shift + C in browser to see the developer view*

*This form won't do anything, just give it a good look*

*Note:*

- *There are two `<script>` entries in the `<head>`, both make TinyMCE work*
- *The `selector: '#myTextarea'` JavaScript statement*
- *The `<textarea id="myTextarea">` to connect it to the JavaScript*

##### In our 501 Blog

| **16** :
```
sudo cp core/08-logincheck3.in.php web/in.login_check.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*atom: Reload*

- *in.login_check.php*

*Note:*

- *in.login_check.php*
  - *Note the two `<script>` sections between the comments `<!-- TinyMCE -->`*
  - *These include the JavaScript to TinyMCE works*
  - *It calls the ID of our "Content" `<textarea>` by `id="p_content"`*
  - *That's it, just that simple*

| **B-16** :// `localhost/web/edit.php` *(Ctrl + R to reload)*

1. Close the message "This domain is not registered with Tiny Cloud"
2. Apply or note some HTML styling with the WYSYWIG buttons
3. Click "Update" or "Publish"
4. See the changes on the blog and in the database...

| **B-17** :// `localhost/web/blog.php`

| **17** :> `SELECT * FROM pieces;`

| **17** ://phpMyAdmin **> pieces**

### Medium Editor
- [GitHub repo](https://github.com/yabwe/medium-editor/releases)
- [GitHub fork](https://github.com/inkVerb/medium-editor/releases) (in case it doesn't work)

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

___

#### [Lesson 9: Content Library](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-09.md)
