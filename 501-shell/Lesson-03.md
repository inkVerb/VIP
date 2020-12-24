# Shell 501
## Lesson 3: MySQL & PHP MySQLi

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser tabs!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** :$ `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S1** :> `USE food_db;`

| **SB-1** ://phpMyAdmin **> food_db**

___

SQL inside PHP makes a website come to life

We want to make our database calls *before* we render any HTML

1. Make database calls
2. Set variables accordingly (strings, boolean, etc)
3. Render HTML based on our database-set variables

*You don't want half of your page waiting to load while you make another database call*

### I. Website via many `include` files

**Include file tree:**
```
website.php
	- style.css
	- in.functions.php
	? in.checks.php (if POST)
```

| **1** :$
```
sudo cp core/03-website1.php web/website.php && \
sudo cp core/03-style1.css web/style.css && \
sudo cp core/03-in.functions1.php web/in.functions.php && \
sudo cp core/03-in.checks1.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website1.php core/03-style1.css core/03-in.functions1.php core/03-in.checks1.php && \
ls web
```

| **B-1** :// `localhost/web/website.php`

*Use Ctrl + Shift + C in browser to see the developer view*

*You should recognize this from before, restructured via `include` files*

*Using `include` this way is normal, get used to it*

*Now, let's put our SQL into this mix...*

### II. MySQL Config

**MySQLi:** *MySQL the "safe way" in PHP*

#### Example of a MySQLi Config:

```php
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_USER', 'databaseuser');
DEFINE ('DB_PASSWORD', 'databasepassword');
DEFINE ('DB_NAME', 'databasename');

// Database connection
$database = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

// Character seting
mysqli_set_charset($database, 'utf8');

// Function to escape for SQL
function escape_sql($data) {

  // Database connection variable is needed here
	global $database;

	// Remove whitespace
	$trimmed_data = trim(preg_replace('/\s+/', ' ', $data));

	// Apply mysqli_real_escape_string()
	return mysqli_real_escape_string($database, $trimmed_data);

}
```

#### Example of a MySQLi Query:

**Query:**

```php
$query = "SELECT column_name, other_column FROM table_name WHERE column_name='some_value'";
$call = mysqli_query($database, $query);
if ($call) { //// Test the query //// see more below ////
	$row = mysqli_fetch_array($call, MYSQLI_NUM);
		$variable_column_name = "$row[0]";
		$variable_other_column = "$row[1]";
	...
} // End query test //
```

**Query tests:**

```php
if ($call) // (all queries) If the query worked, no errors
if (mysqli_num_rows($call) == 1) // (SELECT) If the query returned exactly 1 row
if (mysqli_affected_rows($database) == 1) // (UPDATE and DELETE) If the query changed exactly 1 row
while ( $row = mysqli_fetch_array($call, MYSQLI_NUM) ) // (SELECT) Loop multiple rows (used later)
```

*Review the diagrams above along side the following few steps...*

| **2** :$
```
sudo cp core/03-website2.php web/website.php && \
sudo cp core/03-in.config2.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website2.php core/03-in.config.php && \
ls web
```

*Note website.php:*

- *The same SQL query for the `$query` variable in our PHP*

*Tip: for troubleshooting, it can help to `echo` your `$query`, then test what renders in the SQL terminal*

```php
echo "<pre>$query</pre>";
```

| **S2** :> `SELECT name, type, have, count, prepared FROM fruit WHERE name='bananas';`

| **SB-2** ://phpMyAdmin **> fruit**

| **B-2** :// `localhost/web/website.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

### III. SQL > PHP > HTML

*Let's do the same thing, but put it in an HTML `<table>`...*

| **3** :$
```
sudo cp core/03-website3.php web/website.php && \
sudo cp core/03-style3.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website3.php core/03-style3.css && \
ls web
```

*Note the `<table>` in HTML and border lines in CSS:*

- *website.php*
- *style.css*

| **B-3** :// `localhost/web/website.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

#### SQL PHP Summary
1. An SQL query becomes a PHP `$Variable` (with any variable name)
	- Syntax: `$query = "SELECT col_1, col_2 FROM table...";`
2. That query `$Variable` then goes through two PHP functions
	- **`mysqli_query()`**
		- Syntax: `$call = mysqli_query($database, $query);`
	- **`mysqli_fetch_array()`**
		- Syntax: `$row = mysqli_fetch_array($call, MYSQLI_NUM);`
3. The SQL response is an array assigned to `$New_variables`
	- Syntax: `$Item_variable = "$row[0]";` (for each column in the `SELECT` query)

### IV. SQL Multiple Rows > PHP > HTML

Process many SQL entry rows via `while` loop...

**Query could return multiple rows:**

```php
$query = "SELECT column_name, other_column FROM table_name WHERE column_name='some_value'";
$call = mysqli_query($database, $query);
while ( $row = mysqli_fetch_array($call, MYSQLI_NUM) ) { // test and array as one line
	$variable_column_name = "$row[0]";
	$variable_other_column = "$row[1]";
	...
} // End query test //
```

| **4** :$
```
sudo cp core/03-website4.php web/website.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website4.php && \
ls web
```
*Note website.php: the same SQL query for the `$query` variable in our PHP*

| **S4** :> `SELECT name, type, have, count, prepared FROM fruit;` *Removed `WHERE name='bananas'` so we get multiple rows*

| **SB-4** ://phpMyAdmin **> fruit** (Same)

| **B-4** :// `localhost/web/website.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

#### SQL Rows Loop Summary
1. Each SQL row is an item that can be looped through
2. Just put the same thing in a `while` loop
	- Syntax: `while ( $rows = mysqli_fetch_array(...) )`

*Another `while` loop, different things...*

| **5** :$
```
sudo cp core/03-website5.php web/website.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website5.php && \
ls web
```
*Note the same SQL query for the `$query` variable in our PHP*

| **S5** :> `SELECT name, type, date_created FROM fruit;`

| **SB-5** ://phpMyAdmin **> fruit** (Same)

| **B-5** :// `localhost/web/website.php` (Ctrl + R to reload)

*Use Ctrl + Shift + C in browser to see the developer view*

### V. SQL `INSERT` New Entry < HTML
- See if a query succeeded without error
	- Syntax: `if ($row)`
- Bonus tip: Get the ID of whatever new row you just inserted:
	- Code: `$query = "SELECT SCOPE_IDENTITY()";` (SQL, not MySQL)
	- MySQLi: `$last_id = $database->insert_id;`

| **6** :$
```
sudo cp core/03-website6.php web/website.php && \
sudo cp core/03-style6.css web/style.css && \
sudo cp core/03-in.functions6.php web/in.functions.php && \
sudo cp core/03-in.checks6.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website6.php core/03-style6.css core/03-in.functions6.php core/03-in.checks6.php && \
ls web
```

*Note we have several new form functions & POST checks:*

- *website.php*
- *style.css*
- *in.functions.php*
- *in.checks.php*

| **B-6** :// `localhost/web/website.php` (Same)

*In the webform, input:*

- Name: mangos
- Type: oversize
- Prepared: Fresh

*Try to input numbers or leave a field empty to see how the form responds*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, see the new entries in the database...*

| **SB-6** ://phpMyAdmin **> fruit** (Same)

| **S6** :> `SELECT name, type, have, count, prepared FROM fruit;`

### VI. Always Escape SQL Created by a User Action

MySQLi escape function:

```php
$something_sql_safe = mysqli_real_escape_string($database, $something);
```

| **7** :$
```
sudo cp core/03-website7.php web/website.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website7.php && \
ls web
```

*Note website.php:*

- *We use `mysqli_real_escape_string()` on every item in an SQL query*
	- *This only applies to user input*

| **B-7** :// `localhost/web/website.php` (Same)

*In the webform, input: (include spaces before and after)*

- Name: " peaches "
- Type: " Presidential "
- Prepared: Fresh

*See it added just the same...*

| **SB-7** ://phpMyAdmin **> fruit** (Same)

*...Note no spaces in phpMyAdmin*

| **S7** :> `SELECT name, type, have, count, prepared FROM fruit;`

*...Note you can see the spaces in the database*

Use a function to do a little more:

- `trim()` & `replace()` to remove extra spaces on user input
- `mysqli_real_escape_string()` just the same

```php
function escape_sql($data) {
	global $database;

  $trimmed_data = trim(preg_replace('/\s+/', ' ', $data));
	return mysqli_real_escape_string($database, $trimmed_data);
}

$something_sql_safe = escape_sql($something);
```

| **8** :$
```
sudo cp core/03-website8.php web/website.php && \
sudo cp core/03-in.config8.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website8.php core/03-in.config8.php && \
ls web
```

*Note website.php:*

- *We use our custom `escape_sql()` function in place of `mysqli_real_escape_string()`*

| **B-8** :// `localhost/web/website.php` (Same)

*In the webform, input:*

- Name: " kiwi "
- Type: " Golden "
- Prepared: Fresh

*See it added just the same...*

| **SB-8** ://phpMyAdmin **> fruit** (Same)

*See it removed the spaces...*

| **S8** :> `SELECT name, type, have, count, prepared FROM fruit;`

### VII. SQL `UPDATE` Existing Entry < HTML
- See if an update made a change
	- Syntax: `if (mysqli_affected_rows($database) == 1)`

| **9** :$
```
sudo cp core/03-website9.php web/website.php && \
sudo cp core/03-style9.css web/style.css && \
sudo cp core/03-in.functions9.php web/in.functions.php && \
sudo cp core/03-in.checks9.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website9.php core/03-style9.css core/03-in.functions9.php core/03-in.checks9.php && \
ls web
```

*Note we have several new form functions & POST checks:*

- *website.php*
- *style.css*
- *in.functions.php*
- *in.checks.php*

| **B-9** :// `localhost/web/website.php` (Same)

*Make changes, input numbers, or empty a field to see how the form responds*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, see the updated entries in the database...*

| **SB-9** ://phpMyAdmin **> fruit** (Same)

| **S9** :> `SELECT name, type, have, count, prepared FROM fruit;`

### VIII. SQL `DELETE` Entry < HTML
- See if the row was deleted, same as an update
	- Syntax: `if (mysqli_affected_rows($database) == 1)`

| **10** :$
```
sudo cp core/03-website10.php web/website.php && \
sudo cp core/03-in.checks10.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/03-website10.php core/03-in.checks10.php && \
ls web
```

*Note we have several new form functions & POST checks:*

- *website.php*
- *in.checks.php*

| **B-10** :// `localhost/web/website.php` (Same)

*Use a checkbox to delete an entry*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, note the entries deleted from the database...*

| **SB-10** ://phpMyAdmin **> fruit** (Same)

| **S10** :> `SELECT name, type, have, count, prepared FROM fruit;`

___

# The Take

## Be organized with `include` files
- Organize them how you want
- We usually include two types of files:
	- functions
	- config

## MySQLi Combines MySQL with PHP
- The settings usually go in an included config file
- Conventional syntax in the config file:
```php
DEFINE ('DB_USER', 'databaseuser');
DEFINE ('DB_PASSWORD', 'databasepassword');
DEFINE ('DB_NAME', 'databasename');
DEFINE ('DB_HOST', 'localhost');
$database = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
mysqli_set_charset($database, 'utf8');
```

## SQL Queries Use `$Variables`
- Query anything: `SELECT`, `UPDATE`, `INSERT`, `DROP`, `DELETE`, `CREATE`, etc
- Conventional syntax of an MySQLi query in PHP:
```php
$query = "SELECT column_name, other_column FROM table_name WHERE column_name='some_value'";
$call = mysqli_query($database, $query);
```
- Find trouble with your code: `echo` your SQL `$query`
```php
echo "<pre>$query</pre>";
```
	- Then, run the rendered query in your SQL terminal to see the response

## Work with MySQLi Queries
- Assign columns of a row as variables:
```php
$row = mysqli_fetch_array($call, MYSQLI_NUM);
$variable_column_name = "$row[0]";
$variable_other_column = "$row[1]";
```
- Loop through multiple rows wtih `while`
```php
while ($row = mysqli_fetch_array($call, MYSQLI_NUM)) {...}
```
- See if a query was successful
```php
if ($row) {...}
if ($call) {...}
```
- See if a query made a change
```php
if (mysqli_affected_rows($database) == 1)
```
- SQL tip: Get the last ID of the most recent `INSERT` statement
	- This does ***not*** work wtih MySQL!
```sql
SELECT SCOPE_IDENTITY();
```
- MySQLi: Get the last ID of the most recent `INSERT` statement
```php
$last_id = $database->insert_id;
```
___

#### [Lesson 4: App Install & User Login](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-04.md)
