# Shell 501
## Lesson 3: MySQL & PHP MySQLi

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser windows!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** : `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

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

### Website via many `include` files

**Include file tree:**
```
website.php
	- style.css
	- in.functions.php
	? in.checks.php (if POST)
```

| **1** :
```
sudo cp core/03-website1.php web/website.php && \
sudo cp core/03-style1.css web/style.css && \
sudo cp core/03-functions1.in.php web/in.functions.php && \
sudo cp core/03-checks1.in.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/website.php web/style.css web/in.functions.php web/in.checks.php && \
ls web
```

| **B-1** :// `localhost/web/website.php` *(Ctrl + Shift + C in browser to see the developer HTML view)*

*You should recognize this from before, restructured via `include` files*

*Using `include` this way is normal, get used to it*

*Now, let's put our SQL into this mix...*

### MySQL Config

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
	return mysqli_real_escape_string ($database, $trimmed_data);

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

| **2** :
```
sudo cp core/03-website2.php web/website.php && \
sudo cp core/03-config.in.php web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/in.config.php && \
ls web
```

*gedit: Reload website.php*

*Note the same SQL query for the `$query` variable in our PHP*

| **S2** :> `SELECT name, type, have, count, prepared FROM fruit WHERE name='bananas';`

| **SB-2** ://phpMyAdmin **> fruit**

| **B-2** :// `localhost/web/website.php` (Same)

*Use Ctrl + Shift + C in browser to see the developer view*

### SQL > PHP > HTML

*Let's do the same thing, but put it in an HTML `<table>`...*

| **3** :
```
sudo cp core/03-website3.php web/website.php && \
sudo cp core/03-style3.css web/style.css && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

- *website.php*
- *style.css*

*Note the <table> in HTML and border lines in CSS*

*gedit: Reload website.php*

| **B-3** :// `localhost/web/website.php` (Same)

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

### SQL Multiple Rows > PHP > HTML

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

| **4** :
```
sudo cp core/03-website4.php web/website.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload website.php*

*Note the same SQL query for the `$query` variable in our PHP*

| **S4** :> `SELECT name, type, have, count, prepared FROM fruit;` *Removed `WHERE name='bananas'` so we get multiple rows*

| **SB-4** ://phpMyAdmin **> fruit** (Same)

| **B-4** :// `localhost/web/website.php` (Same)

*Use Ctrl + Shift + C in browser to see the developer view*

#### SQL Rows Loop Summary
1. Each SQL row is an item that can be looped through
2. Just put the same thing in a `while` loop
	- Syntax: `while ( $rows = mysqli_fetch_array(...) )`

*Another `while` loop, different things...*

| **5** :
```
sudo cp core/03-website5.php web/website.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload website.php*

*Note the same SQL query for the `$query` variable in our PHP*

| **S5** :> `SELECT name, type, date_created FROM fruit;`

| **SB-5** ://phpMyAdmin **> fruit** (Same)

| **B-5** :// `localhost/web/website.php` (Same)

*Use Ctrl + Shift + C in browser to see the developer view*

### SQL `INSERT` New Entry < HTML
- See if a query succeeded without error
	- Syntax: `if ($row)`
- Bonus tip: Get the ID of whatever new row you just inserted:
	- Code: `$query = "SELECT SCOPE_IDENTITY()";`

| **6** :
```
sudo cp core/03-website6.php web/website.php && \
sudo cp core/03-style6.css web/style.css && \
sudo cp core/03-functions6.in.php web/in.functions.php && \
sudo cp core/03-checks6.in.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

- *website.php*
- *style.css*
- *in.functions.php*
- *in.checks.php*

*Note we have several new form functions & POST checks*

| **SB-6** ://phpMyAdmin **> fruit** (Same)

| **B-6** :// `localhost/web/website.php` (Same)

*In the webform, input:*

- Name: mangos
- Type: oversize
- Prepared: Fresh

*Try to input numbers or leave a field empty to see how the form responds*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, see the new entries in the database...*

| **S6** :> `SELECT name, type, have, count, prepared FROM fruit;`

### SQL `UPDATE` Existing Entry < HTML
- See if an update made a change
	- Syntax: `if (mysqli_affected_rows($database) == 1)`

| **7** :
```
sudo cp core/03-website7.php web/website.php && \
sudo cp core/03-style7.css web/style.css && \
sudo cp core/03-functions7.in.php web/in.functions.php && \
sudo cp core/03-checks7.in.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

- *website.php*
- *style.css*
- *in.functions.php*
- *in.checks.php*

*Note we have several new form functions & POST checks*

| **SB-7** ://phpMyAdmin **> fruit** (Same)

| **B-7** :// `localhost/web/website.php` (Same)

*Make changes, input numbers, or empty a field to see how the form responds*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, see the updated entries in the database...*

| **S7** :> `SELECT name, type, have, count, prepared FROM fruit;`

### SQL `DELETE` Entry < HTML
- See if the row was deleted, same as an update
	- Syntax: `if (mysqli_affected_rows($database) == 1)`

| **8** :
```
sudo cp core/03-website8.php web/website.php && \
sudo cp core/03-checks8.in.php web/in.checks.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload*

- *website.php*
- *in.checks.php*

*Note we have several new form functions & POST checks*

| **SB-8** ://phpMyAdmin **> fruit** (Same)

| **B-8** :// `localhost/web/website.php` (Same)

*Use a checkbox to delete an entry*

*Use Ctrl + Shift + C in browser to see the developer view*

*Once finished, note the entries deleted from the database...*

| **S8** :> `SELECT name, type, have, count, prepared FROM fruit;`

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
```
- See if a query made a change
```php
if (mysqli_affected_rows($database) == 1)
```
- Bonus tip: Get the last ID of the most recent `INSERT` statement
```php
$query = "SELECT SCOPE_IDENTITY()";
```
___

#### [Lesson 4: App Install & User Login](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-04.md)
