# Shell 501
## Lesson 9: Lists, Loops, Arrays & JSON

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

### Cleanup Header/Hooter and Prepare Our "Pieces" Page Framework

| **1** :
```
sudo cp core/09-pieces1.php web/pieces.php && \
sudo cp core/09-logincheck.in.php web/in.login_check.php && \
sudo cp core/09-footer.in.php web/in.footer.php && \
sudo cp core/09-edit1.php web/edit.php && \
sudo cp core/09-blog1.php web/blog.php && \
sudo cp core/09-webapp.php web/webapp.php && \
sudo cp core/09-accountsettings.php web/account.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces1.php core/09-logincheck.in.php core/09-footer.in.php core/09-edit1.php core/09-blog1.php core/09-webapp.php core/09-accountsettings.php && \
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

*Review pieces on our SQL table...*

| **2** ://phpMyAdmin **> pieces**

| **2** :> `SELECT id, type, status, title, date_created FROM pieces;`

That's quite simple, let's expand...

### More Useful Data, Actions, and Editable Fields

| **3** :
```
sudo cp core/09-pieces2.php web/pieces.php && \
sudo cp core/09-delete2.php web/delete.php && \
sudo cp core/09-undelete2.php web/undelete.php && \
sudo cp core/09-empty_delete2.php web/empty_delete.php && \
sudo cp core/09-unpublish2.php web/unpublish.php && \
sudo cp core/09-republish2.php web/republish.php && \
sudo cp core/09-pagify2.php web/pagify.php && \
sudo cp core/09-postify2.php web/postify.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces2.php core/09-delete2.php core/09-undelete2.php core/09-empty_delete2.php core/09-unpublish2.php core/09-republish2.php core/09-pagify2.php core/09-pagify2.php core/09-postify2.php && \
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

| **B-3** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

*Observe changes to pieces on our SQL table...*

| **3** ://phpMyAdmin **> pieces**

| **3** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

*Note which piece IDs are not listed in publications...*

| **4** ://phpMyAdmin **> publications**

| **4** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`

While this works, we don't want a GET URL to be this powerful, use POST instead...

### Require POST for Our Actions

| **5** :
```
sudo cp core/09-pieces3.php web/pieces.php && \
sudo cp core/09-piecesfunctions3.in.php web/in.piecesfunctions.php && \
sudo cp core/09-style3.css web/style.css && \
sudo cp core/09-delete3.php web/delete.php && \
sudo cp core/09-undelete3.php web/undelete.php && \
sudo cp core/09-empty_delete3.php web/empty_delete.php && \
sudo cp core/09-unpublish3.php web/unpublish.php && \
sudo cp core/09-republish3.php web/republish.php && \
sudo cp core/09-pagify3.php web/pagify.php && \
sudo cp core/09-postify3.php web/postify.php && \
atom core/09-pieces3.php core/09-piecesfunctions3.in.php core/09-style3.css core/09-delete3.php core/09-undelete3.php core/09-empty_delete3.php core/09-unpublish3.php core/09-republish3.php core/09-pagify3.php core/09-pagify3.php core/09-postify3.php && \
ls web
```

*Note pieces.php:*

- *We added an `include` for in.piecesfunctions.php*
- *We use a `postform()` function rather than links*

*Note in.piecesfunctions.php:*

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

| **B-5** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

*Observe changes to pieces on our SQL table...*

| **5** ://phpMyAdmin **> pieces**

| **5** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

| **6** ://phpMyAdmin **> publications**

| **6** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`

### Trash Page with Restore and Bulk Empty

| **7** :
```
sudo cp core/09-pieces4.php web/pieces.php && \
sudo cp core/09-trash4.php web/trash.php && \
sudo cp core/09-undelete_trash4.php web/undelete_trash.php && \
sudo cp core/09-empty_delete_trash4.php web/empty_delete_trash.php && \
sudo cp core/09-empty_all_trash.php web/empty_all_trash.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces4.php core/09-trash4.php core/09-undelete_trash.php core/09-empty_delete_trash.php core/09-empty_all_trash.php && \
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

*Review "pieces" on our SQL table...*

| **7** ://phpMyAdmin **> pieces**

| **7** :> `SELECT id, type, status, pub_yn, title, date_live, date_created FROM pieces;`

| **8** ://phpMyAdmin **> publications**

| **8** :> `SELECT piece_id, type, pubstatus, title, slug FROM publications;`

### Style & JavaScript to Hide some of Our Meta

| **9** :
```
sudo cp core/09-pieces5.php web/pieces.php && \
sudo cp core/09-trash5.php web/trash.php && \
sudo cp core/09-style5.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces5.php core/09-trash5.php core/09-style3.css && \
ls web
```

*Note pieces.php & trash.php:*

- *Added "contentlib" class to the table, matching the stylesheet to clean up clutter*
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

| **B-9** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

In Atom:

- Put style5.css and pieces5.php in spit view
- Double click `.classes` in the .css to see where they appear in the .php

### Revision History

| **10** :
```
sudo cp core/09-pieces6.php web/pieces.php && \
sudo cp core/09-piece1.php web/piece.php && \
sudo cp core/09-hist1.php web/hist.php && \
sudo cp core/09-htmldiff.js web/htmldiff.js && \
sudo cp core/09-editprocess1.in.php web/in.editprocess.php && \
sudo cp core/09-revert.php web/revert.php && \
sudo cp core/09-style6.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces6.php core/09-piece1.php core/09-hist1.php core/09-editprocess1.in.php core/09-revert.php core/09-style6.css && \
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

| **B-10** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

Hover over a "Status" section and click "history", it should take you somewhere like...

| **B-11** :// `localhost/web/hist.php?p=3` (ID `3` is only one example, it could be any number)

*Use Ctrl + Shift + C in browser to see the developer view*

*...This is using our htmldiff.js framework*

*(If you don't see any posts with changes, edit one, then "Update" for the differences)*

*Note: hist.php:*

- *It requires a GET argument*
- *It creates content using [heredocs](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-11.md#ii-heredoc-cat-eof), which we saw in 401-11*
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

| **11** ://phpMyAdmin **> publication_history** > "Sort by key: PRIMARY (DESC)"

*Next, `id=3` is just an example, you can change it to another ID, such as what works from `hist.php?p=` if this doesn't...*

| **12** :> `SELECT id, title, slug, date_updated FROM publication_history WHERE piece_id=3 ORDER BY id DESC LIMIT 1;`

*...Note the `id`...*

| **13** :> `SELECT id, title, slug, date_updated FROM publication_history WHERE piece_id=3 ORDER BY id DESC LIMIT 1,1;`

This "History" view is nice, but it could be much more functional...

### Revision History with More Options

| **14** :
```
sudo cp core/09-hist2.php web/hist.php && \
atom core/09-hist2.php
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

| **B-11** :// `localhost/web/hist.php?p=3` (or whatever ID, Ctrl + R to reload)

### Tags Field via JSON

We are starting to use JSON

JSON is an array that lives as a string, so you can view it with `echo` (arrays must be looped or dumped to view)

- JSON is meant to be parsed by JavaScript, but we won't look at that
- JSON can also be an SQL datatype
- JSON can be processed by PHP
- JSON can have arrays:
  - *as* JSON objects
  - *inside* JSON objects

**Array *as* JSON objects: (as-JSON)**

```json
[ "Apple", "Banana", "Ubuntu" ]

[ ["","",""] , ["","",""] ]
```

**Arrays *inside* JSON objects: (inside-JSON)**

```json
{
"count":3,
"use":"multiple",
"systems":[ "Apple", "Banana", "Ubuntu" ]
}

{ "0":{"0":"","1":"","2":""},"1":{"0":"","1":"","2":""} }
```

**PHP processes JSON a few ways, including:**

```php
$list_nojson = 'one, two, three'; // Comma-separated list
$string_json = json_encode(explode(', ', $list_nojson)); // To array as-JSON from comma-separated list
$string_json = json_encode(explode(', ', $list_nojson), JSON_FORCE_OBJECT); // To arrays inside-JSON from comma-separated list
$string_json = json_encode($some_array); // To array as-JSON
$string_json = json_encode($some_array, JSON_FORCE_OBJECT); // To arrays inside-JSON
$string_json = json_encode($some_array, JSON_PRETTY_PRINT); // To array as-JSON with line breaks
$string_json = json_encode($some_array, JSON_FORCE_OBJECT | JSON_PRETTY_PRINT); // To arrays inside-JSON with line breaks
$list_nojson = implode(', ', json_decode($string_json, true)); // From array as-JSON
$list_nojson = implode(', ', json_decode($string_json)); // From arrays inside-JSON
```

**SQL matches JSON differently:**

```sql
WHERE BINARY after='I am a sentence.' -- Exact, case-sensitive match (TEXT datatype)
WHERE BINARY tags='[ "Apple", "Banana", "Ubuntu" ]' -- WILL NOT MATCH! (JSON datatype)
WHERE tags='[ "Apple", "Banana", "Ubuntu" ]' -- WILL NOT MATCH! (JSON datatype)
WHERE tags=CAST('[ "Apple", "Banana", "Ubuntu" ]' AS JSON) -- Matches (JSON datatype)
```

...trying to match JSON without `CAST('$json' AS JSON)` will return "Empty" (0 rows)

*Try an example...*

#### JSON in PHP

| **12** :
```
sudo cp core/09-jsonarrays.php web/jsonarrays.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-jsonarrays.php && \
ls web
```

| **B-12** :// `localhost/web/jsonarrays.php`

*Let's try to hack some JSON into our SQL...*

#### JSON in SQL

*Review our SQL tables...*

| **13a** ://phpMyAdmin **> pieces**

| **13b** ://phpMyAdmin **> publications**

| **13c** ://phpMyAdmin **> publication_history**

*Add our `tags` JSON colums...*

| **14** :>

```sql
ALTER TABLE `pieces`
ADD `tags` JSON DEFAULT NULL;
ALTER TABLE `publications`
ADD `tags` JSON DEFAULT NULL;
ALTER TABLE `publication_history`
ADD `tags` JSON DEFAULT NULL;
```

*Note the new `tags` column...*

| **15a** ://phpMyAdmin **> pieces**

| **15b** ://phpMyAdmin **> publications**

| **15c** ://phpMyAdmin **> publication_history**

*Watch the SQL in action...*

| **16** :> `SELECT title, slug, tags FROM pieces WHERE id=3;` (ID `3` is only one example, it could be any number)

| **16** ://phpMyAdmin **> pieces** (Note id 3, or whatever ID you are using)

| **17a** :> `UPDATE pieces SET tags='["one tag","second tag","tertiary","quarternary","ternary","idunnory"]' WHERE id=3;`

| **17** ://phpMyAdmin **> pieces**

| **17b** :> `SELECT title, slug, tags FROM pieces WHERE id=3;`

*Now, select for a match in `tags`...*

| **18** :> `SELECT id, title, slug FROM pieces WHERE tags='["one tag","second tag","tertiary","quarternary","ternary","idunnory"]';`

*...No matches! Try this...*

| **19** :> `SELECT id, title, slug FROM pieces WHERE tags=CAST('["one tag","second tag","tertiary","quarternary","ternary","idunnory"]' AS JSON);`

*...That's how SQL handles JSON*

#### JSON in Our Blog

*Let's implement JSON in our blog...*

| **20** :
```
sudo cp core/09-edit2.php web/edit.php && \
sudo cp core/09-piecefunctions2.in.php web/in.piecefunctions.php && \
sudo cp core/09-editprocess2.in.php web/in.editprocess.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-edit2.php core/09-piecefunctions2.in.php core/09-editprocess2.in.php && \
ls web
```

*Note `p_tags` in:*

- *edit.php*
- *piecefunctions.php*
- *in.editprocess.php*

*Note how in.editprocess.php processes `JSON` in SQL queries and `json_decode()` in PHP*

*See the changes in our web browser...*

| **B-21** :// `localhost/web/edit.php?p=3` (ID `3` is only one example, it could be any number)

*Use Ctrl + Shift + C in browser to see the developer view*

*Note the new "Tags" field and the `="p_tags"` values in HTML*

1. Enter some tags (words) separated by comma
2. Click "Update"

| **21** :> `SELECT title, slug, tags FROM pieces WHERE id=3;`

**See the code from in.editprocess.php:**

1. Search for "uncomment" lines in in.editprocess.php
2. Uncomment those lines
3. Then run the file `sudo cp` command cluster again
4. Then retry edit.php the browser
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
5. The PHP array goes to and from JSON to save in the SQL database

| **22** :
```
sudo cp core/09-jsonlinksexplained.php web/jsonlinks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-jsonlinksexplained.php && \
ls web
```

*Look a little at the file, look mostly at what renders in the browser...*

| **B-22** :// `localhost/web/jsonlinksexplained.php`

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
  2. Into JSON for SQL entry
  3. From JSON after SQL retrieval back into a PHP array
  4. Iterated into `<a>` links

*Let's look at that code again, without all the explanation...*

| **23** :
```
sudo cp core/09-jsonlinks.php web/jsonlinks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-jsonlinks.php && \
ls web
```

*Look a little at the file, look mostly at what renders in the browser...*

| **B-23** :// `localhost/web/jsonlinks.php`

*Try the example, reverse item order some, and submit the form*

### Add Links to the Pieces

| **24** :
```
sudo cp core/09-edit3.php web/edit.php && \
sudo cp core/09-jsonlinks.in.php web/in.jsonlinks.php && \
sudo cp core/09-piecefunctions3.in.php web/in.piecefunctions.php && \
sudo cp core/09-editprocess3.in.php web/in.editprocess.php && \
sudo cp core/09-functions.in.php web/in.functions.php && \
sudo cp core/09-piece2.php web/piece.php && \
sudo cp core/09-blog2.php web/blog.php && \
sudo cp core/09-style7.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-edit3.php core/09-jsonlinks.in.php core/09-piecefunctions3.in.php core/09-editprocess3.in.php core/09-functions.in.php core/09-piece2.php core/09-style7.css && \
ls web
```

*Note in edit.php:*

- *Links to "View on blog" and "Preview draft"*
- *Content is closer to the top*
- *The `="submit"` buttons were moved to just after "Content"*
- *Links uses the new function `infoPop()` for a usage tip*

*Note in in.piecefunctions.php:*

- *`p_links` has been added to both functions:*
  - *`checkPiece()`*
  - *`pieceInput()`*
- *RegEx checks for em and en dashes with proper usage*
  - *`p_content`*
  - *`p_after`*
  - *`p_links`*

*Note in in.editprocess.php:*

- *`$p_links` appears*
  - *`checkPiece()`, alongside `$p_tags`*
  - *`json_decode()`, alongside `$p_tags`*
  - *SQL queries (with the `links` column)*
  - *Uses `CAST('$json' AS JSON)`, as with `tags`

*Note in.functions.php:*

- *New function for an "info" popup help*

*Note in piece.php:*

  - *Links and Tags show*
  - *There is a "View on blog" link at the top*
  - *Each iterated link's `<a>` and `<b>` tags have `class="link_item"`, smart to do, we may use later*

*Note in blog.php:*
  - *Tags show on hovering over a piece via JavaScript*
  - *Wordlength is truncated as a "preview" via the `preview_text()` function*

*Note in style.css:*

  - *New `section.links` class (for displaying Links)*
  - *New `section.tags` class (for displaying Tags)*
  - *New `textarea.meta` class (for editing After and Links)*
  - *New `input[type=text].piece` class (for editing text input)*
  - *New `.infopop`, etc classes (for `infoPop()` function)*

*We need another JSON column on our tables...*

| **24** :>

```sql
ALTER TABLE `pieces`
ADD `links` JSON DEFAULT NULL;
ALTER TABLE `publications`
ADD `links` JSON DEFAULT NULL;
ALTER TABLE `publication_history`
ADD `links` JSON DEFAULT NULL;
```

*Note the new `links` column...*

| **24a** ://phpMyAdmin **> pieces**

| **24b** ://phpMyAdmin **> publications**

| **24c** ://phpMyAdmin **> publication_history**

| **B-24** :// `localhost/web/edit.php?p=3`

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

| **B-25** :// `localhost/web/piece.php?p=3` (Click 'View on blog' in Edit, or enter whatever ID you are using if not 3)

*Let's add a "Series" option...*

### Piece Series Defined by SQL Table

#### AJAX a `<form>` to `INSERT` SQL

*First, a review...*

In Lesson 6 we learned to [AJAX a `<form>`](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-06.md#ajax-a-form)

| **25** :
```
sudo cp core/09-select.php web/select.php && \
sudo cp core/09-select.in.php web/in.select.php && \
sudo cp core/09-select.ajax.php web/ajax.select.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-select.php core/09-select.in.php core/09-select.ajax.php && \
ls web
```

| **B-25** :// `localhost/web/select.php`

*Use Ctrl + Shift + C in browser to see the developer view*

Try adding a Series with the "+ Series" form

*Note the result comes back in the dropdown list and it is selected*

*This example does not change the SQL tables, but the next example will*

*Put this AJAX `<form>` into our "Edit" page...*

| **26** :
```
sudo cp core/09-edit4.php web/edit.php && \
sudo cp core/09-piecefunctions4.in.php web/in.piecefunctions.php && \
sudo cp core/09-editprocess4.in.php web/in.editprocess.php && \
sudo cp core/09-series.in.php web/in.series.php && \
sudo cp core/09-series.ajax.php web/ajax.series.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-edit4.php core/09-piecefunctions4.in.php core/09-settings.php && \
ls web
```

*Note edit.php:*

- *`<form>` no longer wraps `<input>` items,*
- *Every `<input>` uses the `form=` attribute*

*Note in.piecefunctions.php:*

- *`form="edit_piece"` added to every `<input>` and `<textarea>`*
  - *This allows side-by-side forms, as with edit.php*

*Note in.editprocess.php:*

- *`p_series` validation runs an SQL query to see if the Series actually exists*

*Note in.series.php & ajax.series.php:*

- *These run an AJAX `<form>`, nearly identical to what we did in Lesson 6*
- *Both the `<select>` input and the new Series `<form>` are wrapped in a `<div>` for AJAX to reload*
  - *This is how we clear the input field in the new Series `<form>`*

*We need to create the `series` table and make our first entry so this can work...*

| **26** :>

```sql
CREATE TABLE IF NOT EXISTS `series` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NOT NULL,
  `slug` VARCHAR(90) NOT NULL,
  `template` INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
INSERT INTO series (name, slug) VALUES ('Blog', 'blog');
ALTER TABLE `pieces`
ADD `series` INT UNSIGNED DEFAULT 1;
ALTER TABLE `publications`
ADD `series` INT UNSIGNED DEFAULT 1;
ALTER TABLE `publication_history`
ADD `series` INT UNSIGNED DEFAULT 1;
```

| **27** :> `SELECT * FROM series;`

| **27** ://phpMyAdmin **> series**

*Note there is only a "Blog" series*

| **B-27** :// `localhost/web/edit.php?p=3`

Try adding a Series with the "+ Series" form

| **28** :> `SELECT * FROM series;`

| **28** ://phpMyAdmin **> series**

*Note your new Series has been added to the `series` table*

*We just used `form=` to put a `<form>` among other `<form>` items; let's do more...*

### Side-by-Side Forms

*First, a review...*

| **29** : `atom core/09-pieces6.php`

| **B-29** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

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

| **30** :
```
sudo cp core/09-postformarrays.php web/postformarrays.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/postformarrays.php && \
ls web
```

| **B-30** :// `localhost/web/postformarrays.php`

*Use Ctrl + Shift + C in browser to see the developer view*

Check different boxes, then submit with different buttons multiple times

*Now, we will apply that system so we can do more...*

### Bulk Actions in Pieces Table: `form=` Attribute & AJAX

| **31** :
```
sudo cp core/09-pieces7.php web/pieces.php && \
sudo cp core/09-bulkpieces.act.php web/act.bulkpieces.php && \
sudo cp core/09-piecesfunctions7.in.php web/in.piecesfunctions.php && \
sudo cp core/09-trash7.php web/trash.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-pieces7.php core/09-bulkpieces.act.php core/09-piecesfunctions7.in.php core/09-trash7.php && \
ls web
```

*Note pieces.php:*

- *View of deleted pieces is gone, but logic still allows for them*
  - *We will AJAX changes later and want to still see "just deleted" pieces*
- *Bulk actions section hides/shows via JavaScript*
  - *These call act.bulkpieces.php*

*Note act.bulkpieces.php:*

- *This simply accepts a `POST` action, then calls other actions*
- *The `POST` array only sends:*
  1. *Which button was pressed*
  2. *Bulk IDs*
- *The button array key (`['bluksubmit']`) is tested, then removed*
- *Only IDs remain in the `POST` array*
- *Remaining `POST` IDs are iterated through*

*Note in.piecesfunctions.php:*

- *The `piecesaction()` function was added*
  - *This does the actual that formerly used all those pieces-action files*
  - *These are used by act.bulkpieces.php without leaving that page*

*Note trash.php:*

- *This is similar to pieces.php*
- *Deleted pieces can be previewed and edited*
- *Classes for "live" pieces are allowed*
  - *We will AJAX changes later and want to still see "just restored" pieces*
- *Bulk actions section hides/shows via JavaScript*
  - *These call act.bulkpieces.php*


| **B-31** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

Click and try:

- Checkboxes
- "Bulk actions" (various buttons)
- Trash
- Pieces

*Let's AJAX these small "actions"...*

| **32** :
```
sudo cp core/09-pieces8.php web/pieces.php && \
sudo cp core/09-piecesfunctions8.in.php web/in.piecesfunctions.php && \
sudo cp core/09-piecesactions8.ajax.php web/ajax.piecesactions.php && \
sudo cp core/09-piecesactions.act.php web/act.piecesactions.php && \
sudo cp core/09-trash8.php web/trash.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/09-piecesfunctions8.in.php core/09-piecesactions.ajax.php && \
ls web
```

| **B-32** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

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

- *Added a JavaScript function `clearChanged[ID]`*
  - *Used in `<i class="renew" ...>changed</i>` in ajax.piecesactions.php*

*Note in.piecesfunctions.php:*

- *The `piecesform()` function was changed*
  - *It does not have all those calls to files anymore*
  - *Now, it generates AJAX calls with the `<forms>`*
  - *The AJAX JavaScript adds the `.renew` CSS class to the `<tr>`*
    - *`document.getElementById("prow_ID").classList.add("renew");`*
    - *This class `.renew` was part of CSS file from a few steps back*
      - *View with `atom core/09-style7.css`*

*Note AJAX is handled by:*

- *ajax.piecesactions.php*
  - *AJAX calls this by default*
  - *It re-creates the entire `<tr>` and sends it for AJAX to update*
  - *It adds a note `<i class="renew" ...>changed</i>`*
    - *This class `.renew` was part of CSS file from a few steps back*
      - *View with `atom core/09-style7.css`*
    - *We need this note because UX theory (User eXperience) demands that appearance changes both:*
    - *Clicking "changed" will activate JavaScript's `clearChanged[ID]` created in pieces.php*
      - *This will remove the "changed" text and the "renew" class*
      1. *Be explained to the user*
      2. *Be axiomatic to the user (self-explanatory)*

- *act.piecesactions.php*
  - *Handles the action and redirects if AJAX doesn't get triggered for some reason*
  - *The entire page will reload*

*Since we don't need those pieces action files anymore...*

| **33** :
```
sudo rm -f web/delete.php web/undelete.php web/empty_delete.php web/unpublish.php web/republish.php web/pagify.php web/postify.php web/undelete_trash.phpweb/empty_delete_trash.php
ls web
```

### Meta Edit in Pieces Table via JS Popup `<form>` & AJAX

| **12** :
```
sudo cp core/09-pieces9.php web/pieces.php && \
sudo cp core/09-piecesactions9.ajax.php web/ajax.piecesactions.php && \
atom core/09-pieces8.php && \
ls web
```

| **B-12** :// `localhost/web/pieces.php` (Ctrl + R to reload)

*Note:*

- *HTML entity symbols:*
  - *The pencil symbol next to each Piece Title*
  - *The hover "edit" text changed to "Editor ->"*


*Use Ctrl + Shift + C in browser to see the developer view*


### Published History to Display New Meta

| **12** :
```
sudo cp core/09-hist3.php web/hist.php && \
atom core/09-hist3.php && \
ls web
```



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

___

#### [Lesson 10: Media Library, Files & Uploads](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-10.md)
