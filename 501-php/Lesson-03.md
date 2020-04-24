# PHP 501
## Lesson 3: MySQL & PHP MySQLi

Ready the CLI

`cd ~/School/VIP/501`

___

### MySQL Config

**MySQLi:** *MySQL the "safe way" in PHP*

#### Example of a MySQLi Config:
```php
DEFINE ('DB_USER', 'databaseuser');
DEFINE ('DB_PASSWORD', 'databasepassword');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'databasename');

// Database connection
$database = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

// Character seting
mysqli_set_charset($database, 'utf8');

// Function to escape for SQL
function escape_sql($data) {

  // Database connection variable is needed here
	global $database;

	// Strip the slashes if Magic Quotes is on (older servers)
	if (get_magic_quotes_gpc()) $data = stripslashes($data);

	// Apply mysqli_real_escape_string() and trim()
	return mysqli_real_escape_string ($database, trim($data));

}
```

___

# The Take

___

#### [Lesson 4: HTML via PHP](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-04.md)
