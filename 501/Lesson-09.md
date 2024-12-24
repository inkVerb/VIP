# Linux 501
## Lesson 9: Content List: Loops, Arrays, JSON & AJAX

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

### This lesson uses two terminals and two browser tabs!
Ready the secondary SQL terminal and secondary SQL browser

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mariadb -u admin -padminpassword
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`**

| **S1** :>

```sql
USE webapp_db;
```

| **S1** ://phpMyAdmin **> webapp_db**

### Webapp Dashboard Login:

| **B-0** :// (Check that you're logged in)

```console
localhost/web/webapp.php
```

```
Username: jonboy
Password: My#1Password
```
___

We want to review a list of our pieces

### Cleanup Header/Hooter and Prepare Our "Pieces" Page Framework

| **1** :$

```console
sudo cp core/09-pieces1.php web/pieces.php && \
sudo cp core/09-in.head1.php web/in.head.php && \
sudo cp core/09-in.logincheck.php web/in.logincheck.php && \
sudo cp core/09-in.footer.php web/in.footer.php && \
sudo cp core/09-edit1.php web/edit.php && \
sudo cp core/09-blog1.php web/blog.php && \
sudo cp core/09-webapp.php web/webapp.php && \
sudo cp core/09-account.php web/account.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces1.php core/09-in.head1.php core/09-in.logincheck.php core/09-in.footer.php core/09-edit1.php core/09-blog1.php core/09-webapp.php core/09-account.php && \
ls web
```

*Note basic changes:*

- *`$edit_page_yn` to see whether to add JS for TinyMCE:*
  - *`in.head.php`*
  - *pieces.php: `false`*
  - *edit.php: `true`*
- *`$nologin_allowed` to redirect if not logged in:*
  - *pieces.php: `false`*
  - *`in.head.php`*
  - *edit.php: `false`*
  - *blog.php: `true`*
  - *webapp.php: `true`*
- *`in.head.php`*
  - *HTML page starts at end of logic*
  - *`<h1>` page name is part*
  - *TinyMCE uses class `#p_content` for the selector*
- *`in.logincheck.php`*
  - *Added some logic near the end to keep things clean*
- *`in.footer.php`*
  - *Finally here in all page files*
  - *Simple for now: `</body>` & `</html>`*
- *`webapp.php`*
  - *Only handles login/logout*
  - *Is a little more complicated because it processes the POST for the login `<form>`*
- *`account.php`*
  - *Ready for our new in.head and in.footer files*

***Note our new file:***

- *`pieces.php`*
  - *Lists all pieces in a `while` loop and `<table>`*
  - *We will add more later*

| **B-1** ://

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Review pieces on our SQL table...*

| **1** ://phpMyAdmin **> pieces**

| **1** :>

```sql
SELECT id, type, status, title, date_created FROM pieces;
```

That's quite simple, let's expand...

### More Useful Data, Actions, and Editable Fields

| **2** :$

```console
sudo cp core/09-pieces2.php web/pieces.php && \
sudo cp core/09-delete2.php web/delete.php && \
sudo cp core/09-undelete2.php web/undelete.php && \
sudo cp core/09-purge_delete2.php web/purge_delete.php && \
sudo cp core/09-unpublish2.php web/unpublish.php && \
sudo cp core/09-republish2.php web/republish.php && \
sudo cp core/09-pagify2.php web/pagify.php && \
sudo cp core/09-postify2.php web/postify.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces2.php core/09-delete2.php core/09-undelete2.php core/09-purge_delete2.php core/09-unpublish2.php core/09-republish2.php core/09-pagify2.php core/09-pagify2.php core/09-postify2.php && \
ls web
```

*Note pieces.php:*

- *SQL evaluates a user-useful meaning of "status" and "date", not only the settings from the database*
- *Every `<tr>` row has options that depend on the status of the piece*

*Note simple SQL queries based on GET arguments:*

- *`delete.php`*
- *`undelete.php`*
- *`purge_delete.php`*
- *`unpublish.php`*
- *`republish.php`*
- *`pagify.php`*
- *`postify.php`*

| **B-2** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Observe changes to pieces on our SQL table...*

| **2** ://phpMyAdmin **> pieces**

| **2** :>

```sql
SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;
```

*Note which piece IDs are not listed in publications...*

| **3** ://phpMyAdmin **> publications**

| **3** :>

```sql
SELECT piece_id, type, pubstatus, title, slug FROM publications;
```

While this works, we don't want a GET URL to be this powerful, use POST instead...

### Require POST for Our Actions

| **4** :$

```console
sudo cp core/09-pieces3.php web/pieces.php && \
sudo cp core/09-in.metaeditfunctions3.php web/in.metaeditfunctions.php && \
sudo cp core/09-style3.css web/style.css && \
sudo cp core/09-delete3.php web/delete.php && \
sudo cp core/09-undelete3.php web/undelete.php && \
sudo cp core/09-purge_delete3.php web/purge_delete.php && \
sudo cp core/09-unpublish3.php web/unpublish.php && \
sudo cp core/09-republish3.php web/republish.php && \
sudo cp core/09-pagify3.php web/pagify.php && \
sudo cp core/09-postify3.php web/postify.php && \
code core/09-pieces3.php core/09-in.metaeditfunctions3.php core/09-style3.css core/09-delete3.php core/09-undelete3.php core/09-purge_delete3.php core/09-unpublish3.php core/09-republish3.php core/09-pagify3.php core/09-pagify3.php core/09-postify3.php && \
ls web
```

*Note pieces.php:*

- *We added an `include` for `in.metaeditfunctions.php`*
- *We use our new `metaeditform()` function rather than links*

*Note in.metaeditfunctions.php:*

- *We created the `metaeditform()` function*
- *The `style=` attribute embedded inside the `<form>` tag is necessary for `float:` to work*
- *We check using `switch`-`case` because there are so many options for a very simple variable value test*

*Note style.css:*

- *We added `.postform` classes*

*Note these validate POST instead of GET, no other differences:*

- *`delete.php`*
- *`undelete.php`*
- *`purge_delete.php`*
- *`unpublish.php`*
- *`republish.php`*
- *`pagify.php`*
- *`postify.php`*

| **B-4** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Observe changes to pieces on our SQL table...*

| **4** ://phpMyAdmin **> pieces**

| **4** :>

```sql
SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;
```

| **5** ://phpMyAdmin **> publications**

| **5** :>

```sql
SELECT piece_id, type, pubstatus, title, slug FROM publications;
```

### Trash Page with Restore and Bulk Empty

| **6** :$

```console
sudo cp core/09-pieces4.php web/pieces.php && \
sudo cp core/09-trash4.php web/trash.php && \
sudo cp core/09-undelete_trash4.php web/undelete_trash.php && \
sudo cp core/09-purge_delete_trash4.php web/purge_delete_trash.php && \
sudo cp core/09-purge_all_trash.php web/purge_all_trash.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces4.php core/09-trash4.php core/09-undelete_trash.php core/09-purge_delete_trash.php core/09-empty_all_trash.php && \
ls web
```

*Note pieces.php:*

- *Now, there is a link to "Trash"*

*Note trash.php:*

- *This is similar to pieces.php, but toned down*

*Note these redirect to trash.php, not pieces.php:*

- *`undelete_trash.php`*
- *`purge_delete_trash.php`*

*Note empty_all_trash.php:*

- *This has a `while` loop to delete each "dead" piece*


| **B-6** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Review "pieces" on our SQL table...*

| **6** ://phpMyAdmin **> pieces**

| **6** :>

```sql
SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;
```

| **7** ://phpMyAdmin **> publications**

| **7** :>

```sql
SELECT piece_id, type, pubstatus, title, slug FROM publications;
```

### Style & JavaScript to Hide some of Our Meta

| **8** :$

```console
sudo cp core/09-pieces5.php web/pieces.php && \
sudo cp core/09-trash5.php web/trash.php && \
sudo cp core/09-style5.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces5.php core/09-trash5.php core/09-style3.css && \
ls web
```

*Note pieces.php & trash.php:*

- *Added "contentlib" class to the table, matching the stylesheet to clean up clutter*
  - *This is used for cascading hierarchy*
  - *The `<table>` itself only uses `id="pieces-table"`*
- *Added `$table_row_color` and a ternary statement to toggle between 'blues' and 'shady'*
- *Added `$show_div_count` counter to create unique ID and JavaScript function names to match*
- *Added "view" option for published pieces*
- *Added unique JavaScript per row; this hides/shows action links*
- *trash.php made a double-opt-in via JavaScript to "Empty all trash"*
  - *Not about convenience, but "nuke buttons" left uncovered*

*Note style.css under "Content library":*

- *Made some parts of our `<table>` absolute so showing/hiding won't change the size of the table*
  - *Try deleting any `table` elements in style.css to see what happens without it*
- *Added several statements to control link colors (`<a>` elements)*
- *Cleaned up clutter via: alignments, colors, and font styles*
  - *Colors for the alternating `<tr>` row classes of 'blues' and 'shady'*
  - *Removed borders*
  - *Font styles to make information unique and/or out of the spotlight*
- *This isn't about beauty as much as it is about being more readable*
  - *This is called "UX theory" (User eXperience theory)*

| **B-8** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

In Atom:

- Put style5.css and pieces5.php in spit view
- Double click `.classes` in the .css to see where they appear in the .php

### Revision History
#### htmldiff.js
- [GitHub repo](https://github.com/poetryiscode/htmldiff)
- [GitHub fork](https://github.com/inkverb/htmldiff) (in case it doesn't work)

We will use this JavaScript package to find differences in two blocks of text and highlight their differences

This is similar to the Linux tool `diff`, which we learned about in [201-11](https://github.com/inkVerb/vip/blob/master/201/Lesson-11.md#diff)

On your own, learn more about implementation at [github.com/poetryisCODE/htmldiff](https://github.com/poetryiscode/htmldiff/blob/master/README.md)

| **9** :$

```console
sudo cp core/09-pieces6.php web/pieces.php && \
sudo cp core/09-piece1.php web/piece.php && \
sudo cp core/09-hist6.php web/hist.php && \
git clone https://github.com/poetryiscode/htmldiff.git && \
sudo cp htmldiff/htmldiff.min.js web/ && \
sudo cp core/09-in.editprocess1.php web/in.editprocess.php && \
sudo cp core/09-revert.php web/revert.php && \
sudo cp core/09-style6.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces6.php core/09-piece1.php core/09-hist6.php core/09-in.editprocess1.php core/09-revert.php core/09-style6.css && \
ls web
```

*Note pieces.php:*

- *Adds a `<a class="purple"` links in the `'published'` and `'redrafting'` `if` options*
- *Adds "preview" option*

*Note piece.php:*

- *Adds a feature that logged-in users can "preview" an unpublished piece*

*Note in.editprocess.php:*

- *It accepts both `&_GET['p']` and `$_GET['h']` for opening a piece*
  - *The `$_GET['h']` method would open values from the `publication_history` SQL table*

*Note style.css:*

- *Added a `.purple` class*
- *Added a section for "htmldiff.js"*

| **B-9** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

Hover over a "Status" section and click "history", it should take you somewhere like...

| **B-10** :// (ID `3` is only one example, it could be any number)

```console
localhost/web/hist.php?p=3
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*...This is using our htmldiff.js framework*

*(If you don't see any posts with changes, edit one, then "Update" for the differences)*

*Note: hist.php:*

- *It requires a GET argument*
- *It creates content using [heredocs](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md#ii-heredoc-cat-eof), which we saw in 401-11*
  - *Our delimeter is "EOP"*
  - *There are neither spaces before nor comments after the closing delimeter `EOP;`!!*
  - *Syntax for variable: `$Variable = <<<EOP`*
- *It implements htmldiff ([see the repo](https://github.com/JesseSteele/htmldiff))*
- *We use a "Non-Breaking SPace" in "`<h2>Changes<br>&amp;nbsp;...`"*
  - *This prevents misalignment below since the other `<h2>` headings have two lines*
- *It fetches the two most recent pieces from the `publication_history` table*
  - SQL tip:
  - Most recent: `... ORDER BY id DESC LIMIT 1`
  - Second-most recent: `... ORDER BY id DESC LIMIT 1,1`

| **10** ://phpMyAdmin **> publication_history** > "Sort by key: PRIMARY (DESC)"

*Next, `id=3` is just an example, you can change it to another ID, such as what works from `hist.php?p=` if this doesn't...*

| **10** :>

```sql
SELECT id, title, slug, date_updated FROM publication_history WHERE piece_id=3 ORDER BY id DESC LIMIT 1;
```

*...Note the `id`...*

| **11** :>

```sql
SELECT id, title, slug, date_updated FROM publication_history WHERE piece_id=3 ORDER BY id DESC LIMIT 1,1;
```

This "History" view is nice, but it could be much more functional...

### Revision History with More Options

| **12** :$

```console
sudo cp core/09-hist9.php web/hist.php && \
code core/09-hist9.php
```

*Note hist.php:*

- *Our logic accepts an argument for:*
  - *The current draft (`p=ID`)*
  - *The most recent publication (`r=ID`)*
  - *Past publications  (`h=ID3&c=ID2`)*
  - *Each set of logic sets the same values different ways as needed*
- *A revision history list appears at the bottom*
  - *Note how the `while` loop preserves the previous value:*
```php
$old_id = $new_id;
$new_id = $row[0];
```
  - *Think creatively like this and you can solve many problems simply*
- *We changed our header hierarchy since adding an `<h2>` statement*
  - *This bumped our old htmldiff DOM `<h2>` tags to `<h3>`*
  - *It is VERY important to preserve header hierarchy, starting with `<h1>` and going down*

| **B-12** :// (or whatever ID, <kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/hist.php?p=3
```

### Tags Field via JSON
We are starting to use JSON

JSON is an array that lives as a string, so you can view it with `echo` (arrays must be looped or dumped to view)

- JSON is meant to be parsed by JavaScript, but we won't look at that
- JSON can also be an SQL datatype
- JSON can be processed by PHP
- JSON can have arrays:
  - *as* JSON objects
  - *inside* JSON objects

**Array *as* JSON objects: (as-JSON, auto-indexed array AI)**

```json
[ "Apple", "Banana", "Manjaro" ]

[ ["","",""] , ["","",""] ]
```

**Arrays *inside* JSON objects: (inside-JSON, associative array AS)**

```json
{
"count":3,
"use":"multiple",
"systems":[ "Apple", "Banana", "Manjaro" ]
}

{ "0":{"0":"","1":"","2":""},"1":{"0":"","1":"","2":""} }
```

**PHP processes JSON & arrays a few ways, including:**

```php
$list_nojson = 'one, two, three'; // Comma-separated list to PHP array
$php_arrayAI = explode(', ', $list_nojson); // Comma-separated list to PHP array (AI)
$list_nojson = implode(', ', $php_arrayAI); // PHP array (AI) to comma-separated list
$string_json = json_encode(explode(', ', $list_nojson)); // To array as-JSON from comma-separated list
$string_json = json_encode(explode(', ', $list_nojson), JSON_FORCE_OBJECT); // To arrays inside-JSON from comma-separated list
$string_json = json_encode($some_array); // To array as-JSON (AI) from PHP array
$string_json = json_encode($some_array, JSON_FORCE_OBJECT); // To arrays inside-JSON (AS) from PHP array
$string_json = json_encode($some_array, JSON_PRETTY_PRINT); // To array as-JSON (AI) with line breaks from PHP array
$string_json = json_encode($some_array, JSON_FORCE_OBJECT | JSON_PRETTY_PRINT); // To arrays inside-JSON (AS) with line breaks
$list_nojson = implode(', ', json_decode($string_json, true)); // From array as-JSON (AI) to comma-separated list
$list_nojson = implode(', ', json_decode($string_json)); // From arrays inside-JSON (AS) to comma-separated list
$php_arrayAS = json_decode($string_json, true); // From array as-JSON (AI) to PHP array (AI)
$php_arrayAI = json_decode($string_json); // From arrays inside-JSON (AS) to PHP array (AS)
```

**MySQL vs MariaDB & standard SQL:**

According to [this article](https://stackoverflow.com/a/51775308/10343144) and [MariaDB docs](https://mariadb.com/kb/en/library/json-data-type/), SQL standards do not allow JSON datatypes

- MySQL allows a `JSON` datatype, accessed with `CAST('$json' AS JSON)`
- MariaDB and standard SQL engines use `JSON` as an alias for `LONGTEXT`, accessed as normal text in a string

```sql
-- Standard SQL & MariaDB
-- Creat a LONGTEXT column with this:
`pieces` ADD `tags` LONGTEXT DEFAULT NULL;
-- Match the column with this:
WHERE tags='[ "Apple", "Banana", "Manjaro" ]'

-- MySQL for JSON datatype
-- Creat a JSON column with this:
`pieces` ADD `tags` JSON DEFAULT NULL;
-- Match the column with this:
WHERE tags=CAST('[ "Apple", "Banana", "Manjaro" ]' AS JSON)
```

We will ***not*** use the `JSON` datatype, but `LONGTEXT` for standard SQL cross-platform compatability

*Try an example...*

#### JSON in PHP

| **13** :$

```console
sudo cp core/09-jsonarrays.php web/jsonarrays.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-jsonarrays.php && \
ls web
```

| **B-13** ://

```console
localhost/web/jsonarrays.php
```

*Let's try to some JSON in our SQL...*

#### JSON in SQL
*Review our SQL tables...*

| **13a** ://phpMyAdmin **> pieces**

| **13b** ://phpMyAdmin **> publications**

| **13c** ://phpMyAdmin **> publication_history**

*Add our `tags` JSON columns as the `LONGTEXT` datatype...*

| **13** :>

```sql
ALTER TABLE `pieces` ADD `tags` LONGTEXT DEFAULT NULL;
ALTER TABLE `publications` ADD `tags` LONGTEXT DEFAULT NULL;
ALTER TABLE `publication_history` ADD `tags` LONGTEXT DEFAULT NULL;
```

*Note the new `tags` column...*

| **14a** ://phpMyAdmin **> pieces**

| **14b** ://phpMyAdmin **> publications**

| **14c** ://phpMyAdmin **> publication_history**

*Watch the SQL in action...*

| **15** :> (ID `3` is only one example, it could be any number)

```console
SELECT title, slug, tags FROM pieces WHERE id=3;
```

| **15** ://phpMyAdmin **> pieces** (Note id 3, or whatever ID you are using)

| **16** :>

```sql
UPDATE pieces SET tags='["one tag","second tag","tertiary","quarternary","ternary","idunnory"]' WHERE id=3;
```

| **16** ://phpMyAdmin **> pieces**

| **17** :>

```sql
SELECT title, slug, tags FROM pieces WHERE id=3;
```

*Now, select for a match in `tags`...*

| **18** :> (Standard SQL & MariaDB for `TEXT` or `LONGTEXT` datatype)

```sql
SELECT id, title, slug FROM pieces WHERE tags='["one tag","second tag","tertiary","quarternary","ternary","idunnory"]';
```

*Remember, MySQL allows a `JSON` datatype, but MariaDB (what we used) simply uses `JSON` as `LONGTEXT`*

*On a MySQL server (not MariaDB) we could have made the colum with this:*

```sql
`pieces` ADD `tags` LONGTEXT DEFAULT NULL;
```

*Which would use this instead:*

```sql
SELECT id, title, slug FROM pieces WHERE tags=CAST('["one tag","second tag","tertiary","quarternary","ternary","idunnory"]' AS JSON);
```

*Note MariaDB won't return results for `CAST($json) AS JSON` because MariaDB treats JSON simply as text in a string (`LONGTEXT`, `TEXT`, etc) which follows SQL standards and keeps our SQL queries quite simple*

#### JSON in Our Blog
*Let's implement JSON in our blog...*

| **19** :$

```console
sudo cp core/09-edit2.php web/edit.php && \
sudo cp core/09-in.piecefunctions2.php web/in.piecefunctions.php && \
sudo cp core/09-in.editprocess2.php web/in.editprocess.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-edit2.php core/09-in.piecefunctions2.php core/09-in.editprocess2.php && \
ls web
```

*Note `p_tags` in:*

- *`edit.php`*
- *`piecefunctions.php`*
- *`in.editprocess.php`*

*Note how in.editprocess.php processes JSON in SQL queries and `json_decode()` in PHP*

*See the changes in our web browser...*

| **B-19** :// (ID `3` is only one example, it could be any number)

```console
localhost/web/edit.php?p=3
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Note the new "Tags" field and the `="p_tags"` values in HTML*

1. Enter some tags (words) separated by comma
2. Click "Update"

| **19** :>

```sql
SELECT title, slug, tags FROM pieces WHERE id=3;
```

**See the code from in.editprocess.php:**

1. Search for "uncomment" lines in in.editprocess.php
2. Uncomment those lines
3. Then run the file `sudo cp` command cluster again
4. Then Save or Update a post with tags in edit.php in the browser
5. Note the `$Variables` with JSON values
6. Note the SQL query and try it in the SQL terminal

### Links JSON RegEx Process
#### We start by processing PHP arrays

**Process a PHP array:**

```php
foreach ($rarray as $item) {
    echo $item[0];
    echo $item[1];
    echo $item[2];
}
```

**Display human-readable 3-D PHP array:**

```php
foreach ($links_array as $line_item) {
  echo "<pre><b>$line_item</b></pre>";
  foreach ($line_item as $key => $avalue) {
    echo "<pre>[$key] = $avalue</pre>";
  }
}
```

#### We also include RegEx and careful logic
Don't pick apart the PHP in this next file too carefully

Just note:

1. PHP logic uses an order to accept many scenarios
2. We use RegEx to pull what we want
3. We uses RegEx to cut what we don't want
4. Everything goes into a PHP array whenever we process it  
5. The PHP array goes to and from JSON to easily save an array as text in the SQL database

| **20** :$

```console
sudo cp core/09-jsonlinksexplained.php web/jsonlinksexplained.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-jsonlinksexplained.php && \
ls web
```

*Look a little at the file, look mostly at what renders in the browser...*

| **B-20** ://

```console
localhost/web/jsonlinksexplained.php
```

*Try the example, reverse item order some, and submit the form*

- This parses a URL, Title, and Credit
- They must all be on the same line and separated by double semicolon `;;`
- A Credit can be pulled from a Title with anything after `|` Pipe
- All of these will work:
  - `Noun Case;; PinkWrite;; https://write.pink` (Credit last, URL in any order)
  - `https://write.pink;; Noun Case | PinkWrite` (Credit pulled after `|` Pipe )
  - `<a href="http://verb.ink">Get inking. // inkVerb</a>`
  - `<a href="http://verb.ink">Get inking. | inkVerb</a>` (Credit pulled after `|` Pipe )
  - `https://write.pink;; Noun Case` (Credit pulled from URL host)
  - `<a href="http://verb.ink">Get inking.</a>`
- If there are only two arguments, the non-URL host will be presumed as the Credit
  - But, if the Title has a pipe `|` , what is after the last pipe will be the Credit
  - In an HTML `<a>` tag, anything after doubleslash `//` will be the Credit
  - If a doubleslash `//` is absent, Credit can be pulled from after last `|` Pipe
- If only the URL is argued, that will become the link with "link" as the credit
- This truncates everything after `|` Pipe in Titles, but pulls for an absent Credit first
- Items are then processed:
  1. Starting in a PHP array
  2. Into JSON-as-text for SQL entry
  3. From JSON-as-text after SQL retrieval back into a PHP array
  4. Iterated into `<a>` links

*Let's look at that code again, without all the explanation...*

| **21** :$

```console
sudo cp core/09-jsonlinks.php web/jsonlinks.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-jsonlinks.php && \
ls web
```

*Look a little at the file, look mostly at what renders in the browser...*

| **B-21** ://

```console
localhost/web/jsonlinks.php
```

*Try the example, reverse item order some, and submit the form*

### Add Links to the Pieces

| **22** :$

```console
sudo cp core/09-edit3.php web/edit.php && \
sudo cp core/09-in.jsonlinks.php web/in.jsonlinks.php && \
sudo cp core/09-in.piecefunctions3.php web/in.piecefunctions.php && \
sudo cp core/09-in.editprocess3.php web/in.editprocess.php && \
sudo cp core/09-piece3.php web/piece.php && \
sudo cp core/09-blog3.php web/blog.php && \
sudo cp core/09-style7.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-edit3.php core/09-in.jsonlinks.php core/09-in.piecefunctions3.php core/09-in.editprocess3.php core/09-piece3.php core/09-blog3.php core/09-style7.css && \
ls web
```

*Note:*

- *`edit.php`*
  - *Links to "View on blog" and "Preview draft"*
  - *Content is closer to the top*
  - *The `="submit"` buttons were moved to just after "Content"*
  - *Links uses the new function `infoPop()` for a usage tip*
- *`in.piecefunctions.php`*
  - *`p_links` has been added to both functions:*
    - *`checkPiece()`*
    - *`pieceInput()`*
  - *RegEx checks for em and en dashes with proper usage*
    - *`p_content`*
    - *`p_after`*
    - *`p_links`*
  - *New function for an "info" popup help*
- *`in.editprocess.php`*
  - *`$p_links` appears*
    - *`checkPiece()`, alongside `$p_tags`*
    - *`json_decode()`, alongside `$p_tags`*
    - *SQL queries (with the `links` column)*
    - *MariaDB uses a simple text match*
      - *MySQL would use `CAST('$json' AS JSON)`, as with `tags`*
- *in `piece.php`*
  - *`$nologin_allowed` variable set by ternary statement, requireing login for previews*
  - *Links and Tags show*
  - *There is a "View on blog" link at the top*
  - *Each iterated link's `<a>` and `<b>` tags have `class="link_item"`, smart to do, we may use later*
- *in `blog.php`*
  - *Tags show on hovering over a piece via JavaScript*
  - *Wordlength is truncated as a "preview" via the `preview_text()` function*
- *in `style.css`*
  - *New `section.links` class (for displaying Links)*
  - *New `section.tags` class (for displaying Tags)*
  - *New `textarea.meta` class (for editing After and Links)*
  - *New `input[type=text].piece` class (for editing text input)*
  - *New `.infopop`, etc classes (for `infoPop()` function)*

*We need another LONGTEXT column to hold a JSON string...*

| **22** :>

```sql
ALTER TABLE `pieces` ADD `links` LONGTEXT DEFAULT NULL;
ALTER TABLE `publications` ADD `links` LONGTEXT DEFAULT NULL;
ALTER TABLE `publication_history` ADD `links` LONGTEXT DEFAULT NULL;
```

*Note the new `links` column...*

| **22a** ://phpMyAdmin **> pieces**

| **22b** ://phpMyAdmin **> publications**

| **22c** ://phpMyAdmin **> publication_history**

| **B-22** ://

```console
localhost/web/edit.php?p=3
```

1. Paste in these values to the "Links" field...

```
https://verb.one
https://verb.red ;;Get inking.
https://verb.ink;; Ink is a verb.;;inkVerb
https://verb.blue;; Inky | Blue Ink
<a href="https://inkisaverb.com">Ink is a verb.</a>
<a href="https://verb.vip">Get inking. // VIP Linux</a>
<a href="http://poetryiscode.com">Poetry is code. | piC</a>
```

2. Click "Update"
3. Note how all links were re-sorted in the "Links field"
4. View the piece...

| **B-23** :// (Click 'View on blog' in Edit, or enter whatever ID you are using if not 3)

```console
localhost/web/piece.php?p=3
```

*Let's add a "Series" option...*

### Piece Series Defined by SQL Table
#### AJAX a `<form>` to `INSERT` SQL
*First, a review...*

In Lesson 6 we learned to [AJAX a `<form>`](https://github.com/inkVerb/vip/blob/master/501/Lesson-06.md#ajax-a-form)

| **24** :$

```console
sudo cp core/09-select.php web/select.php && \
sudo cp core/09-in.select.php web/in.select.php && \
sudo cp core/09-ajax.select.php web/ajax.select.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-select.php core/09-in.select.php core/09-ajax.select.php && \
ls web
```

*We need to create the `series` table and make our first entry so this can work...*

| **24** :>

```sql
CREATE TABLE IF NOT EXISTS `series` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `slug` VARCHAR(90) NOT NULL,
  `template` INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
INSERT INTO series (name, slug) VALUES ('Blog', 'blog');
ALTER TABLE `pieces` ADD `series` INT UNSIGNED DEFAULT 1;
ALTER TABLE `publications` ADD `series` INT UNSIGNED DEFAULT 1;
ALTER TABLE `publication_history` ADD `series` INT UNSIGNED DEFAULT 1;
```

| **B-24** ://

```console
localhost/web/select.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

Try adding a Series with the "+ Series" form

*Note the result comes back in the dropdown list and it is selected*

*This example does not change the SQL tables, but the next example will*

*Put this AJAX `<form>` into our "Edit" page...*

| **25** :$

```console
sudo cp core/09-edit4.php web/edit.php && \
sudo cp core/09-in.piecefunctions4.php web/in.piecefunctions.php && \
sudo cp core/09-in.editprocess4.php web/in.editprocess.php && \
sudo cp core/09-in.series4.php web/in.series.php && \
sudo cp core/09-ajax.series4.php web/ajax.series.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-edit4.php core/09-in.piecefunctions4.php core/09-in.editprocess4.php core/09-in.series4.php core/09-ajax.series4.php && \
ls web
```

*Note:*

- *edit.php:*
  - *`<form>` no longer wraps `<input>` items,*
  - *Every `<input>` uses the `form=` attribute*
- *`in.piecefunctions.php`*
  - *`form="edit_piece"` added to every `<input>` and `<textarea>`*
    - *This allows side-by-side forms, as with `edit.php`*
- *`in.editprocess.php`*
  - *`p_series` validation runs an SQL query to see if the Series actually exists*
  - *`$p_series` also appears in SQL queries and dup checks*
- *in.series.php & `ajax.series.php`*
  - *These run an AJAX `<form>`, nearly identical to what we did in Lesson 6*
    - *This uses a `<button>` that activates the AJAX, not an `<input type="submit">` with an AJAX `<form>` capture `window.addEventListener`*
  - *Both the `<select>` input and the new Series `<form>` are wrapped in a `<div>` for AJAX to reload*
  - *We must `include ('./in.logincheck.php')` in the AJAX source for anything related to logged-in activity*
    - *It is not enough just to check `$_SESSION`, which usually expires after 15 minutes*
    - *We want to check for `$_COOKIE` login, which is part of `in.logincheck.php`*

| **26** :>

```sql
SELECT * FROM series;
```

| **26** ://phpMyAdmin **> series**

*Note there is only a "Blog" series*

| **B-26** ://

```console
localhost/web/edit.php?p=3
```

1. Try adding a Series with the "+ Series" form (click, don't press 'Enter')
2. Press "Enter" to add a Series, which could make the page reload because of a bug we will fix later
3. If your page reloads, click "Back" to return to the piece you were editing

| **27** :>

```sql
SELECT * FROM series;
```

| **27** ://phpMyAdmin **> series**

*Note your new Series has been added to the `series` table*

*We just used `form=` to put a `<form>` among other `<form>` items; let's do more...*

### Side-by-Side Forms
*First, a review...*

| **28** :$

```console
code core/09-pieces6.php
```

| **B-28** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

We already have a `<form>` inside many of these `<table>` cells (the links that appear on hover)

We can put a `<table>` inside a `<form>`, but we can't put a `<form>` inside another `<form>`

Still, we need a `="checkbox"` in each `<table>` row for a bulk process

We can relate a `="checkbox"` outside a `<form>` using the `form=` attribute

Consider `form=` & `="apply2all"` in this code...

```html
<form method="post" action="apply2all.php" id="apply2all">
  <input type="submit" value="Blue all">
  <input type="submit" value="Red all">
</form>
<table>
  <tr>
    <td>
      <input type="checkbox" name="item_1" value="1" form="apply2all">
    </td>
  </tr>
  <tr>
    <td>
      <input type="checkbox" name="item_2" value="2" form="apply2all">
    </td>
  </tr>
</table>
```

| **29** :$

```console
sudo cp core/09-postformarrays.php web/postformarrays.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-postformarrays.php && \
ls web
```

| **B-29** ://

```console
localhost/web/postformarrays.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

Check different boxes, then submit with different buttons multiple times

*Now, we will apply that system so we can do more...*

### Bulk Actions in Pieces Table: `form=` Attribute & AJAX

| **30** :$

```console
sudo cp core/09-pieces7.php web/pieces.php && \
sudo cp core/09-act.bulkpieces.php web/act.bulkpieces.php && \
sudo cp core/09-in.metaeditfunctions7.php web/in.metaeditfunctions.php && \
sudo cp core/09-trash7.php web/trash.php && \
sudo cp core/09-unpublish7.php web/unpublish.php && \
sudo cp core/09-republish7.php web/republish.php && \
sudo cp core/09-pagify7.php web/pagify.php && \
sudo cp core/09-postify7.php web/postify.php && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces7.php core/09-act.bulkpieces.php core/09-in.metaeditfunctions7.php core/09-trash7.php core/09-unpublish7.php core/09-republish7.php core/09-pagify7.php core/09-postify7.php && \
ls web
```

*Note pieces.php:*

- *View of deleted pieces is gone, but logic still allows for them*
  - *We will AJAX changes later and want to still see "just deleted" pieces*
- *Bulk actions section hides/shows via JavaScript*
  - *These call `act.bulkpieces.php`*

*Note act.bulkpieces.php:*

- *This simply accepts a `POST` action, then calls other actions*
- *The `POST` array only sends:*
  1. *Which button was pressed*
  2. *Bulk IDs*
- *The button array key (`['bluksubmit']`) is tested, then removed*
- *Only IDs remain in the `POST` array*
- *Remaining `POST` IDs are iterated through*

*Note in.metaeditfunctions.php:*

- *The `piecesaction()` function was added*
  - *This does the actual that formerly used all those pieces-action files*
  - *These are used by act.bulkpieces.php without leaving that page*
  - *This only changes `status`, `pubstatus`, and `type` of a piece, not `date_updated` because that is about deeper content of a piece and should trigger a history difference*

*Note trash.php:*

- *This is similar to `pieces.php`*
- *Deleted pieces can be previewed and edited*
- *Classes for "live" pieces are allowed*
  - *We will AJAX changes later and want to still see "just restored" pieces*
- *Bulk actions section hides/shows via JavaScript*
  - *These call `act.bulkpieces.php`*


| **B-30** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

Click and try:

- Checkboxes
- "Bulk actions" (various buttons)
- Trash
- Pieces

*Let's AJAX these small "actions"...*

| **31** :$

```console
sudo cp core/09-pieces8.php web/pieces.php && \
sudo cp core/09-in.metaeditfunctions8.php web/in.metaeditfunctions.php && \
sudo cp core/09-ajax.piecesactions8.php web/ajax.piecesactions.php && \
sudo cp core/09-act.piecesactions.php web/act.piecesactions.php && \
sudo cp core/09-trash8.php web/trash.php && \
sudo cp core/09-style8.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces8.php core/09-in.metaeditfunctions8.php core/09-ajax.piecesactions8.php core/09-act.piecesactions.php core/09-trash8.php core/09-style8.css && \
ls web
```

| **B-31** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Notice the AJAX functions with every piece*

In Pieces and Trash:

- Delete
- Restore
- Refresh the page

*Note how "just deleted" or "just restored" pieces stay listed on the pages that don't show them after refresh*

*With AJAX, the entire page does not reload*

*This conveniently allows quick delete/undelete of pieces just changed*

*AJAX calls are made to one, single file, not all those action files as before*

*Note pieces.php:*

- *Added a JavaScript function `clearChanged`*
  - *Used in `<code class="renew" ...>changed</code>` in `ajax.piecesactions.php`*

*Note in style.css:*

- *New class `.renew`*

*Note in.metaeditfunctions.php:*

- *The `metaeditform()` function was changed*
  - *It does not have all those calls to files anymore*
  - *Now, it generates AJAX calls with the `<forms>`*
  - *The AJAX JavaScript adds the `.renew` CSS class to the `<tr>`*
    - *`document.getElementById("prow_ID").classList.add("renew");`*
    - *This class `.renew` is in our new `style.css`*

*Note AJAX is handled by:*

- *`ajax.piecesactions.php`*
  - *AJAX calls this by default*
  - *It re-creates the entire `<tr>` and sends it for AJAX to update*
  - *It adds a note `<code class="renew" ...>changed</code>`*
    - *This class `.renew` is in our new `style.css`*
    - *We need this note because UX theory (User eXperience) demands that appearance changes both:*
    - *Clicking "changed" will activate JavaScript's `clearChanged` created in `pieces.php`*
      - *This will remove the "changed" text and the "renew" class*
      1. *Be explained to the user*
      2. *Be axiomatic to the user (self-explanatory)*

- *`act.piecesactions.php`*
  - *Handles the action and redirects if AJAX doesn't get triggered for some reason*
  - *The entire page will reload*

*Since we don't need those pieces action files anymore...*

| **32** :$

```console
sudo rm -f web/delete.php web/undelete.php web/purge_delete.php web/unpublish.php web/republish.php web/pagify.php web/postify.php web/undelete_trash.phpweb/purge_delete_trash.php
ls web
```

**This AJAX setup is buggy, but it is a good, simple example**

- This current setup AJAX-updates the entire `<tr>` row with any AJAX call in that row
- Clicking different AJAX options will cause AJAX to break and reload the page instead
- It is best for each AJAX call to update as little as possible, not a full `<tr>` row
- The solution is more complex AJAX, with JavaScript changing many individual elements

*Let's cleanup this AJAX...*

| **33** :$

```console
sudo cp core/09-pieces9.php web/pieces.php && \
sudo cp core/09-trash9.php web/trash.php && \
sudo cp core/09-in.metaeditfunctions9.php web/in.metaeditfunctions.php && \
sudo cp core/09-ajax.piecesactions9.php web/ajax.piecesactions.php && \
sudo cp core/09-style9.css web/style.css && \
code core/09-pieces9.php core/09-trash9.php core/09-in.metaeditfunctions9.php core/09-ajax.piecesactions9.php core/09-style9.css && \
ls web
```

*Note in style.css:*

- *New classes `.deleting` & `.undeleting`*
- *Classes `.deleting`, `.undeleting` & `.renew` so the messge looks like a button*
  - *This is part of good US theory, intuitive and axiomatic*
- *The changes to this class affect "changed" indicator, from:*
  - *`pieces.php`*
  - *`trash.php`*
  - *`in.metaeditfunctions.php`*

*Note in in.metaeditfunctions.php:*

- *There is* ***much more JavaScript*** *which:*
  - *Changes the page more directly with AJAX calls*
  - *Changes the text of the "changed" button, while we're at it*

| **B-33** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

Try different Piece actions and see how the page never needs to reload

**This AJAX setup works and demonstrates many uses of JavaScript**

- AJAX is a JavaScript subject; we won't dive too deep into JavaScript in this PHP course
- Part of code philosophy involves "using the least load time"
  - Is it less to download if we use AJAX?
  - Is it less to download if we just reload the page?
  - Is it too confusing to reload the page?
- For your own study, consider AJAX's use of JavaScript, IDs, and classes in:
  - pieces.php
  - trash.php
  - in.metaeditfunctions.php
  - ajax.piecesactions.php

### Meta Edit in Pieces Table via JS Popup `<form>` & AJAX

| **34** :$

```console
sudo cp core/09-pieces10.php web/pieces.php && \
sudo cp core/09-trash10.php web/trash.php && \
sudo cp core/09-in.piecefunctions10.php web/in.piecefunctions.php && \
sudo cp core/09-in.metaeditfunctions10.php web/in.metaeditfunctions.php && \
sudo cp core/09-ajax.metaedit.php web/ajax.metaedit.php && \
sudo cp core/09-style10.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-pieces10.php web/pieces.php core/09-trash10.php web/trash.php core/09-in.piecefunctions10.php core/09-in.metaeditfunctions10.php core/09-ajax.metaedit.php core/09-style10.css && \
ls web
```

**Upgrade side note:**

1. `id=` uses the Piece ID number almost everywhere
- *Where used, this declares:*
  - `$edit_piece_id`
  - `$form_id`
- *Every `<form>` element now uses a unique ID with the Piece ID as part of the name*
- *Peruse this in our `pieceInput()` function (in.metaeditfunctions.php)*
- *...We will need this since we are going to AJAX forms for different pieces on the same page...*
2. Every Piece `<form>` is side-by-side
- We learned about this with `postformarrays.php`
- Piece ID `3` example:

```html
<form id="my_name_3"></form>
<!-- Form ended, but you can still add inputs anywhere on the page -->
<input form="my_name_3" type="hidden" name="something" value="important">
<input form="my_name_3" type="text" name="something">
<input form="my_name_3" type="text" name="something">
<input form="my_name_3" type="submit" name="something">
```

**Those are the upgrades, let's see the part with our working AJAX:**

| **35** :$

```console
code core/09-pieces10.php core/09-trash10.php core/09-in.metaeditfunctions10.php core/09-ajax.metaedit.php core/09-style10.css
```

*Note pieces.php:*

- *Our `metaEdit...` JavaScript function*
  - *This replaces the Piece Title with a form*
  - *This was heavily adopted from the first and final AJAX examples in Lesson 6*
  - *It is accompanies by several other JavaScript that you can search by double-clicking*
- *Nearly all JavaScript loads from pieces.php and in.metaeditfunctions.php, not sent from AJAX (ajax.metaedit.php)*
- *Some JavaScript was migrated from `edit.php`*
- *Basic layout:*
```html
<tr>

<!-- Per-Piece <table> row stuff we already know here -->

<script>
// JavaScript to click-show the Meta Edit <form>
function metaEdit() {}

// JavaScript to AJAX-load and process the Meta Edit <form>
function sendEditMetaData() {}

// JavaScript to mess other things, maybe from edit.php
function metaEditClose() {}
function showGoLiveOptionsLabel() {}
function showGoLiveOptionsBox() {}

// Other JavaScript we saw before
function showActions() {}
function clearChanged() {}
</script>
</tr>
```

*Note pieces.php & ajax.metaedit.php: fancy use of `<table><tr>` rows...*

- *Each Piece `<tr>` row actually has two rows*
- *One shows the normal information and actions*
- *One is hidden, but replaced by our AJAX*
- *When AJAX shows and loads the `<form>` into the hidden `<tr>` row, the normal row hides*
- *When we submit or cancel the AJAX `<form>`, the normal `<tr>` row shows again*
- *Hiding most HTML elements uses `x.style.display = "none";` (JavaScript) or `style="display: none;"` (HTML)*
- *JS-showing most HTML elements uses `x.style.display = "";` or `x.style.display = "";`*
- *JS-showing a `<tr>` element that was hidden uses `x.style.display = "";`*

*Note ajax.metaedit.php:*

- *This both renders and processes the `<form>`*
- *It is a toned-down edit.php, some from `in.editprocess.php`*
- *After submitting the `<form>`, the output updates the "changed" indicator in the `<table>` row*
- *Our `pieceInput()` function has the `_me` appendage for some fields*
  - *These options were added to in.piecefunctions.php so the fields would be shorter in our Meta Edit*

*Note `style.css`*

- *`.metaupdate` class for the `<table>` row after Meta Edit AJAX finishes*
- *`.metaedit` class for our new `pieceInput()` function*
  - *From `in.piecefunctions.php`*
  - *Used by `ajax.metaedit.php`*
- *The `font-size` is smaller, just to make sure everything fits*
  - *`tr.pieces`, the normal table `small`*
  - *`tr.metaedit` and several `<form>` elements `x-small`*

*Note our use of JSON:*

- *ajax.metaedit.php prepares a JSON response:*

```php
$ajax_response = array();
$ajax_response['title'] = $p_title;
$ajax_response['message'] = 'logic dictates';
$json_response = json_encode($ajax_response, JSON_FORCE_OBJECT);
echo $json_response;
```

- *pieces.php parses it for JavaScript:*
  - *Note `+` is "concatenate" in JavaScript, which is `.` in PHP*

```js
var jsonMetaEditResponse = JSON.parse(event.target.responseText);
document.getElementById("title_"+p_id).innerHTML = '<b>'+jsonMetaEditResponse["title"]+' &#9998;</b>';
document.getElementById("changed_"+p_id).innerHTML = '&nbsp;'+jsonMetaEditResponse["message"]+'&nbsp;';
```

| **B-35** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

*Clicking on any Piece Title will bring up our JavaScript "Meta Edit" box*

*Note on HTML entity symbols: pieces.php, trash.php, `in.metaeditfunctions.php`*

- *The pencil symbol next to each Piece Title*
  - *This often means "edit", so we should change that text...*
- *The hover "edit" text changed to "Edit ->"*
  - *The user can easily distinguish this from the pencil symbol*
- *Other symbols: deleting, restoring, drafting, pages, and posts*
  - *These are meant to be distinct, intuitive, and memorable*
  - *We avoid pictures and clutter*
  - *We want standard HTML characters quickly recognized*
  - *Pilcrows (adopted meanings)*
    - *Curly pilcrow for "Pages": won't be confused, but has some basis in ancient documents*
    - *Reverse pilcrow for "Posts": no writer's use outside of some software coding*


*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

### Published History to Display New Meta

| **36** :$

```console
sudo cp core/09-hist10.php web/hist.php && \
code core/09-hist10.php && \
ls web
```

| **B-36** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

Click on "history" for any Piece

### AJAX our Editor
*Let's cleanup `edit.php`*

- Better HTML viewing, outside `<?php` tags
- AJAX for:
  - Save draft
  - Slug  

| **37** :$

```console
sudo cp core/09-edit11.php web/edit.php && \
sudo cp core/09-ajax.edit11.php web/ajax.edit.php && \
sudo cp core/09-in.piecefunctions11.php web/in.piecefunctions.php && \
sudo cp core/09-in.editprocess11.php web/in.editprocess.php && \
sudo cp core/09-in.series11.php web/in.series.php && \
sudo cp core/09-ajax.series11.php web/ajax.series.php && \
sudo cp core/09-in.head11.php web/in.head.php && \
sudo cp core/09-style11.css web/style.css && \
sudo chown -R www:www /srv/www/html && \
code core/09-edit11.php core/09-ajax.edit11.php core/09-in.piecefunctions11.php core/09-in.editprocess11.php core/09-in.series11.php core/09-ajax.series11.php core/09-in.head11.php core/09-style11.css && \
ls web
```

*Note:*

- *`edit.php`*
  - *Uses new JavaScript*
    - *`onNavWarn()` & `offNavWarn()` to warn users navigating away after potential unsave changes*
    - *`Disable "Enter" key on forms`*
    - *`ajaxSaveDraft()` to AJAX our "Save draft" button*
      - *Clicking "Save draft" will not reload the entire page, but it still saves*
    - *For new pieces with no ID*
      - *The Javascript <kbd>Ctrl</kbd> + <kbd>S</kbd> listener will trigger the "Save draft" button*
      - *TinyMCE's <kbd>Ctrl</kbd> + <kbd>S</kbd> hotkey will trigger a false ajaxSaveDraft() that simply clicks the "Save draft" button just the same*
      - *Search: `// AJAX false triggers in new piece`*
    - *`addEventListener` to capture "<kbd>Ctrl</kbd> + <kbd>S</kbd>" for the "Save draft" button*
      - *When editing an existing Piece, it will send the `ajaxSaveDraft()` AJAX call directly*
      - *When editing a new Piece with no ID yet, it will use JavaScript to "click" the "Save draft" `<input type="submit"`*
    - *AJAX response appears inside `<div id="ajax_save_draft_response"`*
    - *AJAX will update the of the slug `<input value=""`*
    - *JavaScript for `showSlugEdit()`, `showGoLiveOptionsBox()`, `showGoLiveOptionsLabel()`, etc closes `<?php` tags so as to use HTML syntax highlighting*
- *`ajax.edit.php`*
  - *Only purpose is to include in.editprocess.php for AJAX calls from `edit.php`*
- *`in.piecefunctions.php`*
  - *Added two warnings JavaScript functions to every `<form>` `<input>`:*
    - *`onchange="onNavWarn();"`*
    - *`onkeyup="onNavWarn();"`*
    - *Not added to `<textarea`...`name="p_content"` because we don't want to run a JS function on every letter typed*
      - *We will build a solution for the `p_content` with our autosave feature in the next step*
  - *Changed `<input id="p_slug"` to `class="slug"` to match our new CSS*
- *`in.editprocess.php`*
  - *Uses AJAX for "Save draft"*
    - *`$response`*
    - *`$r_class`*
    - *`$ajax_response`*
    - *`$json_response`*
- *in.series.php & `ajax.series.php`*
  - *Added two warnings JavaScript functions to every `<form>` `<input>`:*
    - *`onchange="onNavWarn();"`*
    - *`onkeyup="onNavWarn();"`*
- *`in.head.php`*
  - *For AJAX and other JavaScript to read TinyMCE content, we need this in the config:*
```javascript
setup: function (editor) {
  editor.on('change', function () {
    tinymce.triggerSave();
  });
},
```
  - *For TinyMCE to allos the "<kbd>Ctrl</kbd> + <kbd>S</kbd>" AJAX hotkey, we need this in the config:*
```javascript
init_instance_callback: function (editor) {
  editor.addShortcut("ctrl+s", "Save draft", "custom_ctrl_s");
  editor.addCommand("custom_ctrl_s", function() {
      ajaxSaveDraft('ajax.edit.php')
  });
},
```
- *`style.css`*
  - *`Notice hides` section, making class `.notehide` disappear after 8 seconds*
  - *Added `input[type=text].slug` so the slug `<input type="text"` isn't ridiculously long like before*

| **B-37** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

1. Click "Edit" for any piece
2. Click "Save draft" and watch for the message
3. Press "<kbd>Ctrl</kbd> + <kbd>S</kbd>" to watch the same message
4. Click "Update" or "Publish" and the page will reload instead of AJAX

### JavaScript Auto-Save

Let's add a JavaScript function for autosaves

| **38** :$

```console
sudo cp core/09-edit12.php web/edit.php && \
sudo cp core/09-hist12.php web/hist.php && \
code core/09-edit12.php core/09-hist12.php && \
ls web
```

This autosave function serves many purposes, including nav warnings when changes were made in TinyMCE

*Note:*

- *`edit.php`*
  - *In JavaScript, we added our `pieceAutoSave()` function to our AJAX `ajaxSaveDraft()` function*
    - *This keeps everything up to date*
  - *`autoSaveTimer()` is created by `function Timer` to loop our autosave every 30 seconds*
    - *Creates functions to be used as:*
      - *`autoSaveTimer.stop();`*
      - *`autoSaveTimer.start();`*
      - *`autoSaveTimer.reset(30000);` (including `30000` to redeclare our miliseconds)*
  - *`// Run this when the page loads` section looks for old autosaves on page load and warns about differences*
    - *If there is an unsaved autosave found, the 30 second autosave loop will not start*
      - *We run `autoSaveTimer.stop();`right after we create `autoSaveTimer()` to make sure it isn't running, such as in this situation where an unsaved autosave was found*
    - *`See diff...` `<button>` will send JSON with an unsaved autosave to `hist.php`*
  - *30-second autosave differences will trigger the nav warning `onNavWarn();`*
    - *We don't want to trigger `onNavWarn();` from our TinyMCE/content editor because that runs the function every time the user types, which is too much CPU expense*
    - *Times it won't work are few and acceptable in most recovery-autosave efforts in current software*
    - *`ajaxSaveDraft()` will resets autosave*
      - *`pieceAutoSave();` to update any autosaves before processing AJAX saves*
      - *`offNavWarn();` to remove any current nav warnings*
  - *`dismissASdiff()` to dismiss any autosave differences*
  - *"Update"/"Publish" `<input type="submit"` was replaced by a `<button>`*
    - *Calls the JavaScript function `buttonFormSubmit`*
      - *Sets the `<input type="hidden" value=` of the former `<input type="submit"` the `<button>` replaced*
      - *Stops our `autoSaveTimer()`*
      - *Turns off our navigation warning with `offNavWarn()`*
      - *Sends the `<form name="edit_piece"` via JavaScript rather than `<input type="submit"`*
  - *`htmlchars(string)` function because we will pass JS variable `recover_as` through an HTML form*
- *`hist.php`*
  - *Added `include ('./in.piecefunctions.php');` because we will use this to process an autosave recovery*
  - *Added `if (isset($_POST['as_json']))` scenario for processing an autosave recovery*
  - *Added `// Recovered autosave` scenario loading an autosave review*
    - *Includes tests for:*
      - *`$_GET['o']`*
      - *`$_GET['a']`*
      - *`$_POST['old_as']`*
  - *`htmlspecialchars($_POST['old_as'])` to decode our `recover_as = htmlchars(old_as)` from `edit.php`*

| **B-38** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pieces.php
```

1. Click "Edit" for any piece
2. Type some changes in the "Content" (TinyMCE) field
3. Wait 30 seconds and **DO NOT** press "<kbd>Ctrl</kbd> + <kbd>S</kbd>"
4. Press "<kbd>Ctrl</kbd> + <kbd>R</kbd>" to reload the page
  - Agree to a warning to navigate away and leave the page
  - If there is no navigate away warning, you didn't wait long enough after changes
5. When the page reloads, you will see the message about unsaved changes
  - These changes were saved by JavaScript in your browser and are not in the database
6. Click "See diff..." or "Dismiss forever", trying this a few different times
7. "See diff..." will take you to hist.php, where you can choose to "restore this autosave"

We need to do one more thing so we can do things right...

### Unpublished Changes: Simple Diff via SQL
We need a proper way to decide if there are changes to a draft in the `pieces` that have not been published to the `publications` table

Interestingly, SQL has very simple ways to find differences, so we don't need complicated PHP `if` statements for this

Remember our workflow:

  - Our Meta Editor in "Pieces" (pieces.php) will `UPDATE` both the `pieces` and `publications` tables without creating a new revision history in `publications`
  - "Update" in our Editor (edit.php) will create a new revision in the `publications` table if there are any changes at all
  - We can view the diff between the latest draft and latest publication in History (hist.php) already

#### a. We need such a way in:
1. Both pieces.php and edit.php
2. To identify whether there are publishable changes to our latest draft
3. Which can do using a simple `LEFT JOIN` SQL query

```sql
-- table_a has the "id" column, corresponding to the "a_id" column in table_b
-- common columns: apple, banana, watermelon
SELECT A.apple, A.banana
     FROM table_a AS A
LEFT JOIN table_b AS B
 ON A.id=B.a_id
AND A.watermelon=B.watermelon
WHERE B.a_id=5 -- The table_b match is more important, which could matter later
ORDER BY B.id DESC LIMIT 1; -- Only the very last table_b entry, previous entries may match which we don't want
```

#### b. In identifying differences between two tables:

1. It will be more efficient to more deeply connect our queries between those two tables
2. We can do this with SQL using `INSERT` & `SELECT` in the same query

```sql
-- New entry
INSERT INTO destination_table (clone_id, etc_2) SELECT id, etc_2 FROM origin_table WHERE some_row="some value";
-- Update existing entry
UPDATE destination_table AS DEST, origin_table AS ORIG
SET DEST.etc_2=ORIG.etc_2,
    DEST.etc_3=ORIG.etc_3
WHERE DEST.original_id=5
  AND ORIG.id=5;
```

#### Apply this SQL-driven diff to both edit.php and pieces.php

| **39** :$

```console
sudo cp core/09-edit13.php web/edit.php && \
sudo cp core/09-pieces13.php web/pieces.php && \
sudo cp core/09-in.editprocess13.php web/in.editprocess.php && \
code core/09-edit13.php core/09-pieces13.php core/09-in.editprocess13.php && \
ls web
```

*Note:*

- *edit.php & `pieces.php`*
  - *Checks if a Piece draft and publication is different*
    - *This uses our SQL `LEFT JOIN` query*
  - *Search: `// Unpublished changes to draft`*
  - *Search: `$draft_diff`*
- *`in.editprocess.php`*
  - *Will `UPDATE` or `INSERT INTO` the `publications` and `publication_history` tables by cloning `FROM` the `pieces` table*
    - *This will clone `date_updated` from `pieces` to `publications`, used by our `LEFT JOIN` difference check*
    - *Search: `INSERT INTO publication_history`*
    - *Search: `UPDATE publications PUB`*
  - *Made some changes under `// Prepare the query to update the old piece`*
    - *Previously, all non-published draft saves were set as unscheduled to identify pending changes in Pieces*
    - *With our proper check for unpublished changes, we can...*
      - *change this workflow to allow for "to-be-rescheduled" drafts*
      - *display more accuracy in Pices*

| **B-39** :// (if it works, we will use `1` for this step)

```console
localhost/web/edit.php?p=1
```

*Only if `edit.php?p=1` doesn't edit any existing piece, find a different `id` from "Pieces"...*
___
> | **B-39-fix** ://

```console
localhost/web/pieces.php
```
>
> 1. Click "Edit" for any piece
> 2. Use the number in `edit.php?p=NUM` to replace `1` in `U.piece_id=1` for our SQL queries below
>
___

1. Make sure the piece is published
2. Make some changes anywhere
3. Click "Save draft" or press "<kbd>Ctrl</kbd> + <kbd>S</kbd>", **NOT** "Update publication"
5. Look for a message near the top that reads "**view diff for unpublished changes**"
  - You may need to load from the address bar again to see that "view diff..." message
6. Run our SQL query for this piece (change `U.piece_id=1` to another number if `edit.php?p=1` didn't work in the previous step)

| **39** :>

```sql
SELECT P.date_updated FROM pieces AS P LEFT JOIN publications AS U ON P.id=U.piece_id AND P.date_updated=U.date_updated WHERE U.piece_id=1 ORDER BY U.id DESC LIMIT 1;
```

7. That SQL query should return nothing
  - This is because the latest "draft" in `pieces` does not have the identical `date_updated` to the most recent entry by that `piece_id` in `publications`

| **39a** ://phpMyAdmin **> pieces**

...`date_updated` for that piece is different from the corresponding row on...

| **39b** ://phpMyAdmin **> publications**

*Let's update the publication and see what changes*

1. Click "Update publication" in the Editor
2. We no longer see the "**view diff for unpublished changes**" message
3. Run the same SQL query again

| **40** :>

```sql
SELECT P.date_updated FROM pieces AS P LEFT JOIN publications AS U ON P.id=U.piece_id AND P.date_updated=U.date_updated WHERE U.piece_id=1 ORDER BY U.id DESC LIMIT 1;
```

4. Note it finds one match
  - This is because the latest "draft" in `pieces` now has one the identical `date_updated` with the most recent entry by that `piece_id` in `publications`

| **40a** ://phpMyAdmin **> pieces**

...`date_updated` for that piece is the same on...

| **40b** ://phpMyAdmin **> publications**

*FYI, we could have updated only the dates to match from different tables, even if there are other changes to the piece, with this `UPDATE` SQL query:*

```sql
UPDATE pieces AS P, publications AS U SET U.date_updated=P.date_updated WHERE U.piece_id=1 AND P.id=1;
```

*Browse Pieces and look for a "**(pending changes)**" message by posts with the same "unpublished changes" status*

| **B-41** ://

```console
localhost/web/pieces.php
```

*If you don't see any "**(pending changes)**" message, exit a piece and "Save draft" for some changes, then try Pieces again*

### Prevent Multiple `<form>` `<input>` Submissions
*Create a new post...*

| **B-42** :// (No "p" _GET argument in the URL, this is a new piece)

```console
localhost/web/edit.php
```

1. Enter a boring title you will recognize
2. Many times as fast as you can: click "Save draft" or press "<kbd>Ctrl</kbd> + <kbd>S</kbd>"

*Have a look...*

| **B-43** ://

```console
localhost/web/pieces.php
```

| **43a** ://phpMyAdmin **> pieces**

- *Over the Internet, you would probably be able to save multiple duplicates before the `<form>` finishes and the page reloads*
- *Since this sends to your local machine, you may not be able to save multiple duplicates*
- *Regardless, we do not want the ability to keep saving a new draft, which creates a new database entry each time*

**Disable the `<form>` after the first submission**

*Disable an `<input>` after sending with this handy JavaScript snippet in the `onclick="..."` attribute:*

```JavaScript
var f=this; setTimeout(function(){f.disabled=true;}, 0); return true;
```

*Like so:*

```html
<input type="submit" onclick="var f=this; setTimeout(function(){f.disabled=true;}, 0); return true;">
```

| **44** :$

```console
sudo cp core/09-edit14.php web/edit.php && \
code core/09-edit14.php && \
ls web
```

*Note the JavaScript smippet added to `<input ... onclick=` right under `// First Save for new Piece`*

*Create another new post...*

| **B-44** :// (No "p" _GET argument in the URL, this is another new piece)

```console
localhost/web/edit.php
```

*Have a look...*

| **B-45** ://

```console
localhost/web/pieces.php
```

*...No duplicates*
___

# The Take
## PHP Arrays
- Arrays can be 2-D
  - A big group
- Arrays can be 3-D
  - Many groups, each with a leader
- We can't actually see PHP arrays
  - Iterate arrays with a `foreach` loop
    - Syntax: `foreach( $array as $item )`
- Arrays are useful when processing many items to organize

## JSON
- ...can have arrays *as* JSON objects
  - `[ ["","",""] , ["","",""] ]`
- ...can have arrays *inside* JSON objects
  - `{ "0":{"0":"","1":"","2":""},"1":{"0":"","1":"","2":""} }`
- ...is a string and can be seen, unlike a PHP array
- ...is an SQL datatype
- ...can be read by JavaScript, but we didn't do that here
- ...can change back and forth between a PHP array
  - Syntax:
    - `$json = json_encode($array)`
    - `$array = json_decode($json)`

## AJAX
- ...needs complex calls to work intuitively
- ...needs lots of JavaScript to change other things after AJAX changes things
- ...should not send anymore than needed, JavaScript and HTML should load separately wherever possible

## JSON & AJAX
- AJAX responses in JSON can be understood by JavaScript
- Sending and receiving only JSON with AJAX is efficient, more and more developers do this
- Syntax:
  - **PHP sending AJAX response** :
```php
$ajax_array = array();
$ajax_array['foo'] = $bar.' or something';
$json_thing = json_encode($ajax_array, JSON_FORCE_OBJECT);
echo $json_thing;
```
  - **JavaScript recieving AJAX response** :
```js
var ourJSONresponse = JSON.parse(event.target.responseText);
document.getElementById("bar_id").innerHTML = ourJSONresponse["title"]+' and something';
```

## HTML `<form>` IDs
- Use an `id=` named after the SQL ID for whatever it is editing, if possible
  - Use this in the `<form>` and in every `<input>`, etc
- Side-by-Side forms allow more things to work; this is based on `id=`
  - Place each `<input>` outside the `<form>` tags
  - This avoids "forms inside forms", which HTML does not allow
  - Match `<form id=` with `<input form=`
  - Format:
```html
<form id="my_form_25"></form>
<!-- Form ended, but you can still add inputs anywhere on the page -->
<input form="my_form_25" type="text" name="something">
<input form="my_form_25" type="hidden" name="secret">
<input form="my_form_25" type="checkbox" name="check">
<input form="my_form_25" type="submit" name="submit">
```

## Content Libaries
- Content libraries show well by combining:
  - PHP `while` loop
  - HTML `<table>`
- Making things usefully clickable needs AJAX
- The code gets exponentially more complex with each simple ability you add
  - Editing things while in a list is complex
  - Editing things one at a time is simple

## JavaScript `localStorage`
- This is useful for making content available offline, including:
  - Browser website settings
  - Backups of unsaved work
- `localStorage` may contain:
  - A simple string
  - JSON turned into a string
- Turn JSON into a string: (JavaScript)
  - Syntax: `JSON.stringify(some_json_object)`
- Turn a JSON-ready string into readable JSON: (JavaScript)
  - Syntax: `JSON.parse(some_json_string)`
- To make the JSON string readable by PHP:
  - PHP Syntax: `$json_array = json_decode($json_string, true);`
    - Now, use: `$json_array['some_key']`
  - PHP-OOP Syntax: `$json_array = json_decode($json_string);`
    - Now, use: `$json_array->'some_key'`
- Note we will address PHP-OOP syntax in [Lesson 11](https://github.com/inkVerb/vip/blob/master/501/Lesson-11.md)

## SQL Table/Row Cloning & Diffing
- Create or insert a new SQL row from an existing row
  - This uses `INSERT` & `SELECT` in the same query
```sql
-- New entry
INSERT INTO new_table (etc_1, etc_2) SELECT etc1, etc2 FROM old_table WHERE some_row='something';
-- Update existing entry
UPDATE next_table NEXT, old_table OLD
SET NEXT.etc_1=OLD.etc1,
    NEXT.etc_2=OLD.etc2
WHERE NEXT.old_some_row='something'
  AND OLD.some_row='something';
```
- Clone an entire table, FYI
```sql
-- Create the new table with the same rows and datatypes as the old table
CREATE TABLE new_table LIKE old_table;
-- Clone the content from the old table into the new table
INSERT INTO old_table SELECT * FROM new_table;

-- Or do it all in one command
CREATE TABLE new_table SELECT * FROM old_table;
```
- Check for two identical rows from separate tables
```sql
SELECT A.col_one, A.col_two
     FROM table_a A
LEFT JOIN table_b B
 ON A.id=B.a_id
AND A.col_three=B.col_three
WHERE B.a_id=5; -- The table_b match is more important, which could matter later
```
- The main takeaway is:
  - ***Deeper knowledge of SQL will improve your PHP work***
  
___

#### [Lesson 10: Media Library, Files & Uploads](https://github.com/inkVerb/vip/blob/master/501/Lesson-10.md)
