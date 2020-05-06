# PHP 501
## Lesson 1: PHP Core

Ready the CLI

`cd ~/School/VIP/501`

- [Tests: Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)
- [Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

___

### PHP rules:

1. PHP renders HTML ***after*** the entire PHP script runs
2. HTML can exist outside `<?php ?>` tags in a .php file
3. PHP can be inserted inside an .html file
4. Variables begin with `$`, *even when declaring the value (unlike Shell)*
5. Variables can work inside `"double quotes"` *not `'single quotes'`*
6. Variable names allow the same characters as Shell:
  - letters, numbers, underscore
  - case-sensitive
  - can't start with a number
7. Concatenate strings and variables with `.`

**Concatenation**
```php
echo $variable.' single quote $no_var'." double quote working $variables";

echo 'string '.$variable.' string continues '.$variable." etc...";
```

### I. PHP Form & Method Handling

#### `_GET`

| **1** :
```
sudo cp core/01-phpget1.php web/phpget.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/phpget.php && \
ls web
```

| **B-1** :// `localhost/web/phpget.php?go=I am an apple pie` *(Ctrl + Shift + C in browser to see the developer HTML view)*

*Try the form a few times to see how it works*

| **2** : `sudo cp core/01-phpget2.php web/phpget.php && ls web`

*gedit: Reload phpget.php*

| **B-2** :// `localhost/web/phpget.php?go=over there&h=6-hour&time=5:22`

*Try the form a few times to see how it works*

#### `_POST`

| **3** : `sudo cp core/01-phppost1.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-3** :// `localhost/web/phppost.php`

*Try the form a few times to see how it works*

#### PHP Arrays

`_POST` and `_GET` are arrays

You may define your own arrays

```php
// Auto-indexed array
$autoArray = array(
  'value_1',
  "second value",
  "triplets",
  'fourthly'
);

echo $autoArray[0];
echo "<br>"; // Add a break so it is easy to read
echo $autoArray[1];
echo "<br>";
echo $autoArray[2];
echo "<br>";
echo $autoArray[3];


// Associative array
// Define an empty array so it can take associative keys
$assocArray = array();

// Associative values
$assocArray['key_one'] = "Donuts";
$assocArray['twokeys'] = "Coffee";
$assocArray['badBoys'] = "Whatcha gonna do";

echo "<br>"; // Add a break so it is easy to read

echo $assocArray['key_one'];

echo "<br>"; // Add a break so it is easy to read

// Not allowed in "quotes"!!!!!
echo "$assocArray['key_one']";

// Do like this
$someVariable = $assocArray['key_one'];
echo "$someVariable";


// Get all values of any array
echo "<br>print_r \$assocArray:<br>";
print_r($assocArray);
echo "<br>print_r \$autoArray:<br>";
print_r($autoArray);

```

*Review the diagram above along side the following two steps...*

| **4** :
```
sudo cp core/01-phparrays.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phparrays.php && \
ls web
```

| **B-4** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

#### PHP Form Method Summary

**_GET**
```php
'http://webaddress.com?this_name=...'  >>>>  $_GET['this_name']
```

**_POST**
```php
<input name="this_name">  >>>>  $_POST['this_name']
```

**`$_POST` and `$_GET` are arrays that use keys**
```php
$_POST['key']
$_GET['key']
```

### II. PHP Logic

#### Basic Syntax
##### 1. PHP must start with `<?php` and *may* end with `?>`
##### 2. Every PHP line must end with `;`
##### 3. `do ... done` and `then ... fi` are replaced with `{ ... }`
##### 4. Tests are wrapped in `(`parentheses`)`, you can use `(tests (inside tests))`

*Many other things are the same between PHP and Shell*

#### Loops

Loops usually work with arrays

PHP has 4 types of loops:
- `do`
- `while`
- `for`
- `foreach`

**Loop syntax: `foreach` example**
```php

foreach ($array as $item) {

  echo $item.'<br>';

}

```

*Review the diagram above along side the following two steps...*

| **5** :
```
sudo cp core/01-phpforeach.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpforeach.php && \
ls web
```

| **B-5** :// `localhost/web/phppost.php` (Same)

#### PHP `if` Syntax

**`if` test:**

`if ( TEST HERE ) { DO THIS... ;}`

**`if` test with `else` and `elseif`:**

`if ( TEST HERE ) { DO THIS... ;} elseif ( ANOTHER TEST ) { DO THIS... ;} else { DO THIS... ;}`

**multiple lines and normal style:**

```php
if ( TEST HERE ) {
  DO THIS;
  DO THIS;
} elseif ( ANOTHER TEST ) {
  DO THIS;
} else {
  DO THIS;
}
```

*Review the diagrams above along side the following few steps...*

| **6** : `sudo cp core/01-phppost2.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-6** :// `localhost/web/phppost.php` (Same)

*Try the form a few times to see how it works*

*Use Ctrl + Shift + C in browser to see the developer view*

| **7** : `sudo cp core/01-phppost3.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-7** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **8** : `sudo cp core/01-phppost4.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-8** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **9** : `sudo cp core/01-phppost5.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-9** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **10** : `sudo cp core/01-phppost6.php web/phppost.php && ls web`

*gedit: Reload phpget.php*

| **B-10** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### Ternary Statements

**[Ternary Statement](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)**
```php
$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';

// example:

$Variable = ( $Some_Variable == 5 ) ? 'it is five' : 'not five';

```

*Review the diagram above along side the following two steps...*

| **11** : `sudo cp core/01-phppost7.php web/phppost.php && ls web`

| **B-11** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### FYI Reference: Useful PHP Tests & Functions

```php

// Simple tests

empty($testme)

isset($testme)

array_key_exists($key, $array_name)

file_exists($file_name) // For file on server OR with http address (use with care)

// Note:
!empty($testme) // flips the true/false return for the if test for any of these

// Below are not tests, but they return true if successful, just like a test

unset($remove_me) // Removes (unsets) the value of the variable

file_get_contents($file_name) // For file on server OR remote file with http address (use with care)

header("Location: $new_http_web_address") // Redirect to this address, often used in easy PHP forward files

date("Y-m-d H:i:s") // Returns an SQL-standard date string (2020-01-01 23:59:59 format)

strtotime($time_string) // Changes most common date strings into a PHP epoch time, (seconds from 1970/01/01 midnight)

date("Y-m-d H:i:s", substr($time_epoch, 0, 10)) // Change PHP epoch time back to SQL date string

```

*...In PHP, you will see functions like these and many, many more*

### III. PHP RegEx & Validation

#### Security rules:
1. Validate first & always
2. Sanitize second
3. Escape before using

#### Know the Datatype!
*A "string" is a "datatype", which we looked at in [VIP/Shell 401 – Lesson 6](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-06.md)*

##### Four Important Datatypes in PHP:
- string *- any kind of raw text: name, email, web address (URL), blog post, mailing address, passwords, etc*
- integer (int) *- whole numbers, positive or negative*
- array *- a complex variable; a "mini database variable"; a list (array) of multiple values, each with a number/key for reference*
- boolean *- only `true` or `false`*

##### PHP Validation:
- *Use PHP RegEx `preg_match()` and some `filter_var()` validation checks on **strings***
- *Use non-RegEx PHP `filter_var()` validation checks on **integers, true/false, arrays, etc***

#### Basic PHP RegEx & Validation Tests:
```php
// Test a URL
filter_var($Variable, FILTER_VALIDATE_URL)

// Test an email address
filter_var($Variable,FILTER_VALIDATE_EMAIL)

// Test an integer
filter_var($Variable, FILTER_VALIDATE_INT)

// Test for string length (eg. up to 128)
( strlen($value) <= 128 )

// Test a number with RegEx (6-32 characters)
preg_match('/^[0-9]{6,32}$/i', $Variable)

// Test for letters wtih RegEx, (any case, 6-32 characters)
preg_match('/^[a-zA-Z]{6,32}$/i', $Variable)

// Test for alphanumeric characters or underscore wtih RegEx, (any case, any length)
preg_match('/[a-zA-Z0-9_]$/i', $Variable)

// Test for password (6-32 characters, 1 uppercase, 1 lowercase, 1 number, and allow special characters: ! @ & # $ %)
preg_match('/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@&#$%]{6,32}$/', $Variable)
```

*Review the diagram above along side the following two steps...*

| **12** :
```
sudo cp core/01-phpregex1.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpregex1.php && \
ls web
```

| **B-12** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### Basic PHP Sanitizing Filters
```php
// Remove any non-alphanumeric character
$Variable = preg_replace("/[^a-zA-Z0-9]/","", $Variable);

// Replace any non-alphanumeric character with a space
$Variable = preg_replace("/[^a-zA-Z0-9]/"," ", $Variable);

// Replace any non-alphanumeric character with a hyphen (-)
$Variable = preg_replace("/[^a-zA-Z0-9]/","-", $Variable);

// Remove whitespace at start and end
$Variable = trim($Variable);

// Remove all whitespace: trim(preg_replace())
$Variable = trim(preg_replace('/\s+/', ' ', $Variable));

// Truncate before/after certain characters (eg. returns first 10 characters)
$Variable = substr($Variable,0,10);

// Change any letters to lower case
$Variable = strtolower($Variable);

// Change any letters to upper case
$Variable = strtoupper($Variable);

// Change the first character of entire string to lowercase
$Variable = lcfirst($Variable);

// Change the first character of entire string to uppercase
$Variable = ucfirst($Variable);

// Change the first character of each word to uppercase
$Variable = ucwords($Variable);

```

#### Basic PHP Escaping
```php
// Convert every single thing into an HTML entity that you can:
$Variable = htmlentities($Variable);

// Convert HTML-specific characters to HTML entities:
$Variable = htmlspecialchars($Variable);

// Convert to SQL (MySQLi)
$Variable = mysqli_real_escape_string($Database_Connection, $Variable);
  // From: $Database_Connection = mysqli_connect(...);

```

*Note how `preg_replace()` and `strtolower()` are used to sanitize the values...*

| **13** :
```
sudo cp core/01-phpregex2.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpregex2.php && \
ls web
```

| **B-13** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **14** :
```
sudo cp core/01-phpregex3.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpregex3.php && \
ls web
```

| **B-14** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

*Try entering a website or email longer than 128 characters*

#### Validation Summary

**Validate:** `01-phpregex1.php`
```php
filter_var()
preg_match()
```

**Sanitize:** `01-phpregex3.php`
```php
preg_replace()
strtolower()
```

**String length:** `01-phpregex3.php`
```php
(strlen($String) <= 128) // Validate
 substr($String, 0, 128) // Truncate

// Nested functions also work
substr(preg_replace($String), 0, 128)
```

### IV. PHP Functions in Forms

This is a PHP function: `preg_replace()`, which you have already been using

You may define your own custom functions

#### Custom PHP Functions

**Define the function:**
```php

function myFunctionName($arg1, $arg2, $arg3) {

  echo '$arg1: '.$arg1.'<br>$arg2: '.$arg2.'<br>$arg3: '.$arg3;
}

```

**Call the function:**
```php

myFunctionName('John', "Jim", 'Sam');

// Will display:
'$arg1: John'
'$arg2: Jim'
'$arg3: Sam'

```

**Variables with functions:**
```php

$Variable = "I am outside the function";

function anotherFunctHere($someArg, $anotherArg) {

  // This will not work:
  echo $Variable;

  // ...because we must do this first:
  global $Variable;

  // Now, this will work:
  echo $Variable;

  // This works inside this function:
  echo $someArg.' and '.$anotherArg;

  // Compact the function variables so they work outside the function:
  return compact(
    'someArg',
    'anotherArg'
  );
}

// Call the function inside extract() to use the variables from inside the function
extract(anotherFunctHere("first arg", "second arg"));

// These two variables from inside the function only work after the function because they were compacted, then extracted
echo $someArg.' and '.$anotherArg;

```

**Function to `return` a value:**
```php

function iHaveValue($oneArg) {

  return "Arg: $oneArg";
}

echo iHaveValue("John");

// OR

$someVariable = iHaveValue("John");
echo $someVariable;

```

*Review the diagrams above along side the following few steps...*

| **15** :
```
sudo cp core/01-phpfunction1.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction1.php && \
ls web
```

| **B-15** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **16** :
```
sudo cp core/01-phpfunction2.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction2.php && \
ls web
```

| **B-16** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **17** :
```
sudo cp core/01-phpfunction3.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction3.php && \
ls web
```

| **B-17** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **18** :
```
sudo cp core/01-phpfunction4.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction4.php && \
ls web
```

| **B-18** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **19** :
```
sudo cp core/01-phpfunction5.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction5.php && \
ls web
```

| **B-19** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

***We need a little more cleanup:***

  - "empty" error message if empty POST
  - Double-check password

| **20** :
```
sudo cp core/01-phpfunction6.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpfunction6.php && \
ls web
```

| **B-20** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

### V. Includes & Constants

Config files usually use **includes** and **constants**

#### Includes

There are two ways to include a file, each way has two options

- `include` inserts the text of a file if it exists
- `require` is like `include`, but breaks if the file does not exist
- `..._once` will not include the file more than one time
- *included .php files should start with a `<?php` tag, but not end with the closing tag `?>`*

```php
include ('path/to/file');

include_once ('path/to/file');

require ('path/to/file');

require_once ('path/to/file');
```

*Note the included file uses a Linux path*

**Purpose** of including files:

- Avoid redundant code, especially: headers, footers, functions, and settings
- Cleaner code, without having to look at all the functions, validations, etc

**Conventions** with included files:

- Use `.inc.php` at the end of included file names
- Put included files in a subdirectory called `inc`

Then we get this:

```php
include ('./inc/file.inc.php');
```

...But it's not core, so we did: `in.filename.php`

Then we get this:

```php
include ('./in.file.php');
```

*Review the diagrams above along side the following two steps...*

| **21** :
```
sudo cp core/01-phpinclude.in.php web/in.phppost.php && \
sudo cp core/01-phpinclude.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/in.phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpinclude.php && \
ls web
```

| **B-21** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### Constants

**Constant rules:**

1. Constants are variables that do not ever change
2. Constants work inside and outside functions
3. While PHP variables being with `$`, constants do not
4. Constants can't work inside `"double quotes"` nor `'single quotes'`

**Define & call a constant:**
```php
// Define
define ('CONSTANT_NAME', 'Constant value');

// Call
echo CONSTANT_NAME;
```

*Review the diagrams above along side the following few steps...*

| **22** :
```
sudo cp core/01-phpconstant1.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpconstant1.php && \
ls web
```

| **B-22** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

*...organize all this in an `include` config file...*

| **23** :
```
sudo cp core/01-phpconstant2.in.php web/in.config.php && \
sudo cp core/01-phpconstant2.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/in.config.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit core/01-phpconstant2.php && \
ls web
```

| **B-23** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### Header/Footer Conventions

Use `require_once`, not `include` for important files like these...

```php

require_once ('config.php');

require_once ('header.php');

... Whatever makes this particular page special goes here ...

require_once ('footer.php');

```

Normally, the top and bottom of a webpage are some kind of `include` of `header.php` and `footer.php` respectively

| **24** :
```
sudo cp core/01-phpheader.in.php web/in.header.php && \
sudo cp core/01-phpfooter.in.php web/in.footer.php && \
sudo cp core/01-phphfconventions.php web/phppost.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/in.header.php web/in.footer.php core/01-phphfconventions.php && \
ls web
```

| **B-24** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

### VI. Writing a File

We can write a file from a:

- Simple string
- Variable
- Heredoc

```php
file_put_contents('./file/location', 'File content string');
```

**Simple string:**

| **25** :
```
sudo cp core/01-phpfileput1.php web/phpfileput.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/phpfileput.php && \
ls web
```

*Look over the PHP file in gedit before using the browser*

| **B-25** :// `localhost/web/phpfileput.php`

*See the file changes...*

| **26** : `ls web && cat web/fileput.1`

**Variables:**

| **27** :
```
sudo cp core/01-phpfileput2.php web/phpfileput.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload phpfileput.php*

| **B-27** :// `localhost/web/phpfileput.php` (Same)

*See the file changes...*

| **28** : `ls web && cat web/fileput.2`

**Heredoc:**

```php
$file_text = <<<EOF
... $Variable
EOF;
```

| **29** :
```
sudo cp core/01-phpfileput3.php web/phpfileput.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload phpfileput.php*

*Note how the heredoc was made for later reference:*

| **B-29** :// `localhost/web/phpfileput.php` (Same)

*See the file changes...*

| **30** : `ls web && cat web/fileput.3`

**Heredoc with `'single quotes'`:**

```php
$file_text = <<<'EOF'
... $Variable
EOF;
```

| **31** :
```
sudo cp core/01-phpfileput4.php web/phpfileput.php && \
sudo chown -R www-data:www-data /var/www/html && \
ls web
```

*gedit: Reload phpfileput.php*

*Note the use of `'single quotes'` affect the `$Variable` in the heredoc:*

| **B-31** :// `localhost/web/phpfileput.php` (Same)

*See the file changes...*

| **32** : `ls web && cat web/fileput.4`

___

# The Take

## PHP rules:
1. PHP renders HTML ***after*** the entire PHP script runs
2. HTML can exist outside `<?php ?>` tags in a .php file
3. PHP can be inserted inside an .html file
4. Variables begin with `$`, *even when declaring the value (unlike Shell)*
5. Variables can work inside `"double quotes"` *not `'single quotes'`*
6. Variable names allow the same characters as Shell:
  - letters, numbers, underscore
  - case-sensitive
  - can't start with a number
7. Concatenate strings and variables with `.`

## PHP Form & Method Handling
- `_GET` takes values from the web URL
  - `http://longurl?one=value&two=value` has two `_GET` values useable as...
  - `$_GET['one']` and `$_GET['two']`
- `_POST` takes values from a submitted `<form>`
  - `<form method="post" action="http://address"><input name="one"...><input name="two"...` has two `_POST` values usable as...
  - `$_POST['one']` and `$_POST['two']`
- Technically, `$_POST` and `$_GET` are "arrays" with "keys", like so...
  - `$_POST['key']`
  - `$_GET['key']`

## PHP Basic Syntax
1. PHP must start with `<?php` and can end with `?>`
2. Every PHP line must end with `;`
3. *`do` ... `done`* and *`then` ... `fi`* are replaced with *`{` ... `}`*
4. Tests are wrapped in `(`parentheses`)`, you can use `(tests (inside tests))`

## PHP Logic
- Loops use arrays
- 4 types of loops `do` `while` `for` `foreach`
  - `foreach` syntax: `foreach ($array as $item) { DO THIS... ;}`
- PHP uses `if` tests
  - Syntax: `if ( TEST HERE ) { DO THIS... ;}`
- PHP `if` tests can use `else` and `elseif` *(not `elif`)*

## Ternary Statements
- Syntax: `$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';`

## PHP RegEx & Validation
- **Security rules:**
  1. Validate first & always
  2. Sanitize second
  3. Escape before using
- Use `preg_match()` wtih RegEx to check most strings
- Use `filter_var()` to check
  - Non-strings like integers
  - Common strings like email and web addresses

## PHP Functions in Forms
- Functions can be useful for:
  - RegEx validation checks
  - Sanitizing
  - Creating HTML items (`<input>`, etc)
- HTML `<form>` errors fit nicely in an array
  - Syntax: `$error_array['input_name']`
- Arrays and functions can work together

## Includes & Constants
- Includes:
  - Save redundant code
  - Are good organizing
  - Usual syntax & naming: `include ('./inc/file.inc.php');`
  - Also use: `require`, `require_once`, `include_once`
- Constants:
  - **Constant rules:**
    1. Constants are variables that do not ever change
    2. Constants work inside and outside functions
    3. While PHP variables being with `$`, constants do not
    4. Constants can't work inside `"double quotes"` nor `'single quotes'`
  - Syntax: `define ('CONSTANT_NAME', 'Constant value');`
- Header/Footer Conventions:
  - The top and bottom of most web pages are the same, thus `include` in this order:
    - `config.php` (or similar name)
    - `header.php` (or similar name)
    - `footer.php` (or similar name)
  - But, we use `require_once`, not `include`, because these are important

## Create Files
- Create a file with: `file_put_contents('./file/location', 'File content string');`
- Heredocs with `'single quotes'` around the delimeter will cancel variables
  - Syntax: `$Variable = <<<'EOF'`
___

#### [Lesson 2: MySQL & phpMyAdmin](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-02.md)
