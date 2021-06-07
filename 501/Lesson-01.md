# Shell 501
## Lesson 1: PHP Core

Ready the CLI

`cd ~/School/VIP/501`

- [Tests: Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)
- [Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

___

### PHP Background
- PHP was made in 1994 by a man to manage his online resume
- PHP was written in C language
- PHP originally stood for "Personal Home Page"
- PHP uses logic (like Shell) to be interactive
- PHP works on the server
- PHP and SQL are called "server languages"
- PHP can `echo` "client languages" (browser languages)
  - HTML
  - CSS
  - JavaScript

### PHP Rules:

1. PHP renders HTML ***after*** the entire PHP script finishes
2. HTML and PHP work wherever they are
  - HTML can exist outside `<?php ?>` in a .php file
  - `<?php ?>` can be used ***inside*** an .html file
  - `<?php ?>` can be used ***inline*** with HTML

| **.html** or **.php** :
```html
<html>
<head>
  <title> <?php echo $title; ?> </title>
</head>
<body>

<?php

echo "<h1>$title</h1>";
echo '<p>Poetry is code!</p>';

?>

</body>
</html>
```

3. Variables begin with `$`, *even when declaring the value (unlike Shell)*
4. Variables work inside `"double quotes"` *not `'single quotes'`*
5. Variable names allow the same characters as Shell:
  - letters, numbers, underscore
  - case-sensitive
  - can't start with a number
6. Concatenate strings and variables with `.`
  - JavaScript uses `+` to concatenate
  - Shell & BASH don't concatenate

**Concatenation**
```php
echo $variable.' single quote $no_var'." double quote working $variables";

echo 'string '.$variable.' string continues '.$variable." etc...";
```

7. Always test success and plan for failure, even the impossible

**Failure plan**
```php
if ($certain_success == true) {
  echo "Only now can we do our normal thing.";
} else { // Yes, we need this
  echo "Something impossible happened.";
}
```

You will see many tests with `} else {` options for reporting errors, this is why

#### `if` ? 'is for PHP' : 'WHEN is for reality';

#### Everything breaks. It's not `if`. It's WHEN!

### I. PHP Method Handling

#### `$_GET` Method

**_GET**
```
http://webaddress.com?this_name=something-here
```
...becomes...

```php
$_GET['this_name'] // = "something-here"
```

| **1** :$
```
sudo cp core/01-phpget1.php web/phpget.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phpget1.php && \
ls -l web
```

*Note the file owner of phpget.php changed from `root` to `www-data` after the `chown` command*

| **B-1** ://

```console
localhost/web/phpget.php?go=I am an apple pie
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

*Try the form a few times to see how it works*

*Note we don't need to `chown` file owner when copying over a file...*

| **2** :$
```
sudo cp core/01-phpget2.php web/phpget.php && \
atom core/01-phpget2.php && \
ls -l web
```

*Note phpget.php has the same file owner as before, though we copied over it without `chown`*

| **B-2** ://

```console
localhost/web/phpget.php?go=over there&h=6-hour&time=8:22
```

*Try the form a few times to see how it works*

#### `$_POST` Method

**_POST**
```html
<form method="post" action="some_page.php">
<input name="this_name">
```

...after `<submit>`, becomes in some_page.php...

```php
$_POST['this_name'] // = whatever was entered into the <input>
```

| **3** :$
```
sudo cp core/01-phppost1.php web/phppost.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phppost1.php && \
ls web
```

| **B-3** ://

```console
localhost/web/phppost.php
```

*Try the form a few times to see how it works*

#### PHP Arrays

`$_POST` and `$_GET` are arrays

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
echo $autoArray[1];
echo $autoArray[2];
echo $autoArray[3];

// Assign array values directly
list($a_one, $a_two, $a_three, $a_four) = $autoArray;
// Same as...
$a_one = $autoArray[0];
$a_two = $autoArray[1];
$a_three = $autoArray[2];
$a_four = $autoArray[3];

// Associative array
// Define an empty array so it can take associative keys
$assocArray = array();

// Associative values
$assocArray['key_one'] = "Donuts";
$assocArray['twokeys'] = "Coffee";
$assocArray['badBoys'] = "Whatcha gonna do";

echo $assocArray['key_one'];

// Not allowed in "quotes"!!!!!
echo "$assocArray['key_one']";

// Do like this
$someVariable = $assocArray['key_one'];
echo "$someVariable";

// Get all values of any array
print_r($assocArray);
print_r($autoArray);

// Match an item in an array
$found = (in_array("find me", $array)) ? true : false;
if (in_array("find me", $array)) {echo $do_something;}
// Example
$fruit = array('apples','bananas','berries');
if (in_array('apples', $fruit)) {echo 'found';}
if (in_array('kiwi', $fruit)) {echo 'should not be found';}
```

*Review the diagram above along side the following two steps...*

| **4** :$
```
sudo cp core/01-phparrays.php web/phparrays.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phparrays.php && \
ls web
```

| **B-4** ://

```console
localhost/web/phparrays.php
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

| **5** :$
```
sudo cp core/01-phpforeach.php web/phppost.php && \
atom core/01-phpforeach.php && \
ls web
```

| **B-5** :// (Same)

```console
localhost/web/phppost.php
```

#### PHP `if` Syntax

**`if` test:**

`if ( Test Here ) { Do This... ;}`

**`if` test with `else` and `elseif`:**

`if ( Test Here ) { Do This... ;} elseif ( Another Test ) { Do This... ;} else { Do This... ;}`

**multiple lines and normal style:**

```php
if ( Test Here ) {
  Do This;
  Do This;
} elseif ( Another Test ) {
  Do This;
} else {
  Do This;
}
```

*Review the diagrams above along side the following few steps...*

| **6** :$
```
sudo cp core/01-phppost2.php web/phppost.php && \
atom core/01-phppost2.php && \
ls web
```

| **B-6** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form a few times to see how it works*

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

| **7** :$
```
sudo cp core/01-phppost3.php web/phppost.php && \
atom core/01-phppost3.php && \
ls web
```

| **B-7** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **8** :$
```
sudo cp core/01-phppost4.php web/phppost.php && \
atom core/01-phppost4.php && \
ls web
```

| **B-8** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **9** :$
```
sudo cp core/01-phppost5.php web/phppost.php && \
atom core/01-phppost5.php && \
ls web
```

| **B-9** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **10** :$
```
sudo cp core/01-phppost6.php web/phppost.php && \
atom core/01-phppost6.php && \
ls web
```

| **B-10** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

#### [Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)

```php
$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';

// example:

$Variable = ( $Some_Variable == 5 ) ? 'it is five' : 'not five';

// inline with greater string
$Variable = 'start ' . (( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false') . ' end'; // this
$Variable = 'start ' . ( THIS IS THE TEST  ? 'value_if_true' : 'value_if_false') . ' end'; // or this

// example:

$Variable = 'The number is ' . (( $Some_Variable == 5 ) ? 'five' : 'not five') . 'today'; // this
$Variable = 'The number is ' . ( $Some_Variable == 5 ? 'five' : 'not five') . 'today'; // or this

// Ternary statements don't only work with variables

// echo example:
echo ( $Some_Variable == 5 ) ? 'it is five' : 'not five';
echo ( $Some_Variable == 5 ) ? 'it is five' : false; // It will do nothing if the test fails
```

*Review the diagram above along side the following two steps...*

| **11** :$
```
sudo cp core/01-phppost7.php web/phppost.php && \
atom core/01-phppost7.php && \
ls web
```

| **B-11** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view with <kbd>Ctrl</kbd> + <kbd>C</kbd>*

#### `switch`-`case` Statements

This is comparable to a Shell [case Statement](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#vii-case-esac)

```php
switch ($variable_to_test) {
  case "red":
    echo 'Do something red';
    break;
  case "green":
    echo 'Do something green';
    break;
  case "blue":
    echo 'Do something blue';
    break;
  default:
    echo 'Do something completely other than RGB';
}
```

*Review the diagram above along side the following two steps...*

| **12** :$
```
sudo cp core/01-phppost8.php web/phppost.php && \
atom core/01-phppost8.php && \
ls web
```

| **B-12** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view with <kbd>Ctrl</kbd> + <kbd>C</kbd>*

*Try any color, also try selecting no color at all to see the `switch`-`default`*

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

date("Y-m-d H:i:s", time() + 30) // Returns an SQL-standard date string, add 30 seconds

strtotime($time_string) // Changes most common date strings into a PHP epoch time, (seconds from 1970/01/01 midnight)

date("Y-m-d H:i:s", substr($time_epoch, 0, 10)) // Change PHP epoch time back to SQL date string

// Handy code for PHP debugging, place in each script, don't use in production
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Exit and redirect correctly
exit(header("Location: to_page.php"));

```

*...In PHP, you will see functions like these and many, many more*

### III. PHP RegEx & Validation

#### Security rules:
1. Validate first & always
2. Sanitize second
3. Escape before using

#### Know the datatype!

A "string" is a "datatype", which we looked at in [Shell 401 Lesson 6](https://github.com/inkVerb/vip/blob/master/401/Lesson-06.md)

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
preg_match('/[0-9]{6,32}$/i', $Variable)

// Test for letters wtih RegEx, (any case, 6-32 characters)
preg_match('/[a-zA-Z]{6,32}$/i', $Variable)

// Test for alphanumeric characters or underscore wtih RegEx, (any case, any length)
preg_match('/[a-zA-Z0-9_]$/i', $Variable)

// Test for password (6-32 characters, 1 uppercase, 1 lowercase, 1 number, and allow special characters: ! @ & # $ %)
preg_match('/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@&#$%]{6,32}$/', $Variable)
```

*Review the diagram above along side the following two steps...*

| **13** :$
```
sudo cp core/01-phpregex1.php web/phppost.php && \
atom core/01-phpregex1.php && \
ls web
```

| **B-13** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

#### Basic PHP Sanitizing Filters

"Sanitizing" is basically doing a search and replace of all characters we don't want

This often uses a RegEx to define those characters

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

*Review the diagram above along side the following two steps and elaboration...*

##### RegEx Replacement & Arguments (Useful for Sanitizing and More)

We looked at RegEx briefly in [Shell 401 Lesson 1](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md)

**RegEx arguments come from `(parentheses)`:**
```regex
([something_one])...([something_two]), '$1...$2'
```

**PHP replacement examples**
```php
// Syntax
$result = str_replace('foo','bar',$string); // 'foo' to 'bar', RegEx not allowed
$result = preg_replace($RegEx_foo,$RegEx_bar,$string); // Same, but allows RegEx

// Simple RegEx
$alphbt = preg_replace("/[a-z]/",'z',$alphbt); // lowercase to 'z'
$alphbt = preg_replace("/[A-Z]/",'Z',$alphbt); // uppercase to 'Z'
$number = preg_replace('/[0-9]/','#',$number); // numbers to '#'

// 1st alphanumeric set becomes $1; 2nd becomes $2
// '_dogfish_' to '_GoldFish_', preserving what is before and after
$argmnt = preg_replace('/([a-zA-Z0-9]+)_dogfish_([a-zA-Z0-9]+)/','$1_GoldFish_$2',$argmnt);
// The $ in the first part makes sure the whole word is preserved
```

*Look at this example...*

| **14** :$
```
sudo cp core/01-phpreplace.php web/phpreplace.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phpreplace.php && \
ls web
```

**Note this converts dashes from common misuse to proper:**
```php
/*
** em-dash: (long)
** en-dash: (mid)
** hyphen: (short)
** These can be difficult to type and choose, so we will fix them for our users on the back end
*/
$dash = preg_replace('/([A-Z].[a-z]+)-([A-Z].[a-z]+)/','$1–$2',$dash); // Proper noun range to en-dash (days, months, etc)
$dash = preg_replace('/([0-9]+)-([0-9]+)/','$1–$2',$dash); // digit range to en-dash
$dash = str_replace(' -- ',' – ',$dash); // to en-dash if couched in spaces
$dash = str_replace(' --','—',$dash); // to em-dash, no space before
$dash = str_replace('-- ','—',$dash); // to em-dash, no space after
$dash = str_replace('---','—',$dash); // to em-dash, someone made certain
$dash = str_replace('--','—',$dash); // to em-dash
```

| **B-14** ://

```console
localhost/web/phpreplace.php
```

*Try matching characters and watch them get replaced*

#### Basic PHP Escaping

We looked at "escaping" certain characters in [Shell 101 Lesson 1](https://github.com/inkVerb/vip/blob/master/101/Lesson-11.md)

In any code language, certain characters "mean something", they must be "escaped" (AKA 'quoted' or 'cancelled') so the characters mean only themselves and are not "working" in the code

```php
// Convert every single thing into an HTML entity that you can:
$Variable = htmlentities($Variable);

// Convert HTML-specific characters to HTML entities:
$Variable = htmlspecialchars($Variable);

// Convert back from htmlentities():
$Variable = html_entity_decode($Variable);

// Convert back from htmlspecialchars():
$Variable = htmlspecialchars_decode($Variable);

// Convert to SQL (MySQLi)
$Variable = mysqli_real_escape_string($Database_Connection, $Variable);
  // From: $Database_Connection = mysqli_connect(...);

```

*Note how `preg_replace()` and `strtolower()` are used to sanitize the values...*

| **15** :$
```
sudo cp core/01-phpregex2.php web/phppost.php && \
atom core/01-phpregex2.php && \
ls web
```

| **B-15** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **16** :$
```
sudo cp core/01-phpregex3.php web/phppost.php && \
atom core/01-phpregex3.php && \
ls web
```

| **B-16** :// (Same)

```console
localhost/web/phppost.php
```

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

| **17** :$
```
sudo cp core/01-phpfunction1.php web/phppost.php && \
atom core/01-phpfunction1.php && \
ls web
```

| **B-17** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **18** :$
```
sudo cp core/01-phpfunction2.php web/phppost.php && \
atom core/01-phpfunction2.php && \
ls web
```

| **B-18** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **19** :$
```
sudo cp core/01-phpfunction3.php web/phppost.php && \
atom core/01-phpfunction3.php && \
ls web
```

| **B-19** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **20** :$
```
sudo cp core/01-phpfunction4.php web/phppost.php && \
atom core/01-phpfunction4.php && \
ls web
```

| **B-20** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

| **21** :$
```
sudo cp core/01-phpfunction5.php web/phppost.php && \
atom core/01-phpfunction5.php && \
ls web
```

| **B-21** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

***We need a little more cleanup:***

  - "empty" error message if empty POST
  - Double-check password

| **22** :$
```
sudo cp core/01-phpfunction6.php web/phppost.php && \
atom core/01-phpfunction6.php && \
ls web
```

| **B-22** :// (Same)

```console
localhost/web/phppost.php
```

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

| **23** :$
```
sudo cp core/01-in.phpinclude.php web/in.phppost.php && \
sudo cp core/01-phpinclude.php web/phppost.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-in.phpinclude.php core/01-phpinclude.php && \
ls web
```

| **B-23** :// (Same)

```console
localhost/web/phppost.php
```

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

| **24** :$
```
sudo cp core/01-phpconstant1.php web/phppost.php && \
atom core/01-phpconstant1.php && \
ls web
```

| **B-24** :// (Same)

```console
localhost/web/phppost.php
```

*Try the form and developer view*

*...organize all this in an `include` config file...*

| **25** :$
```
sudo cp core/01-in.config.php web/in.config.php && \
sudo cp core/01-phpconstant2.php web/phppost.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-in.config.php core/01-phpconstant2.php && \
ls web
```

| **B-25** :// (Same)

```console
localhost/web/phppost.php
```

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

| **26** :$
```
sudo cp core/01-in.phpheader.php web/in.header.php && \
sudo cp core/01-in.phpfooter.php web/in.footer.php && \
sudo cp core/01-phphfconventions.php web/phppost.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-in.phpheader.php core/01-in.phpfooter.php core/01-phphfconventions.php && \
ls web
```

| **B-26** :// (Same)

```console
localhost/web/phppost.php
```

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

| **27** :$
```
sudo cp core/01-phpfileput1.php web/phpfileput.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phpfileput1.php && \
ls web
```

*Look over the PHP file in atom before using the browser*

| **B-27** ://

```console
localhost/web/phpfileput.php
```

*See the file changes...*

| **28** :$

```console
ls web && cat web/fileput.1
```

**Variables:**

| **29** :$
```
sudo cp core/01-phpfileput2.php web/phpfileput.php && \
atom core/01-phpfileput2.php && \
ls web
```

| **B-29** :// (Same)

```console
localhost/web/phpfileput.php
```

*See the file changes...*

| **30** :$

```console
ls web && cat web/fileput.2
```

**Heredoc:**

```php
$file_text = <<<EOF
... $Variable
EOF;
```

| **31** :$
```
sudo cp core/01-phpfileput3.php web/phpfileput.php && \
atom core/01-phpfileput3.php && \
ls web
```

*Note how the heredoc was made for later reference:*

| **B-31** :// (Same)

```console
localhost/web/phpfileput.php
```

*See the file changes...*

| **32** :$

```console
ls web && cat web/fileput.3
```

**Heredoc with `'single quotes'`:**

```php
$file_text = <<<'EOF'
... $Variable
EOF;
```

| **33** :$
```
sudo cp core/01-phpfileput4.php web/phpfileput.php && \
atom core/01-phpfileput4.php && \
ls web
```

*Note the use of `'single quotes'` affect the `$Variable` in the heredoc:*

| **B-33** :// (Same)

```console
localhost/web/phpfileput.php
```

*See the file changes...*

| **34** :$

```console
ls web && cat web/fileput.4
```


### VII. Handling Arrays: `$_POST` Array, `print_r()` & `var_dump()`

| **35** :$
```
sudo cp core/01-phpprintr.php web/phpprintr.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phpprintr.php && \
ls web
```

| **B-35** ://

```console
localhost/web/phpprintr.php
```

Fill-out the fields and click "Hit me"

*Note this is the entire `$_POST` array, only what was in the `<form>`*

*Note phpprintr.php: both file and browser*

  - *The `$_POST` keys match the `<input>` names*
  - *The `name=` of the `="submit"` `<input>` matches the `value=` attribute*

*Try the same thing with `var_dump()`...*

| **36** :$
```
sudo cp core/01-phpvardump.php web/phpvardump.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phpvardump.php && \
ls web
```

| **B-36** ://

```console
localhost/web/phpvardump.php
```

Fill-out the fields and click "Hit me"

*Same basic information, different format*

**The `$_POST` array will only have what is in the `<form>`!**

### VIII. PHP Errors

| **37** :$
```
sudo cp core/01-phperrors1.php web/phperrors.php && \
sudo chown -R www:www /var/www/html && \
atom core/01-phperrors1.php && \
ls web
```

| **B-37** ://

```console
localhost/web/phperrors.php
```

*Right away, the PHP message complains about the variable `$nothere` because it is not set*

**PHP Error Handler Rules:**

1. We only saw this erro message because we used `echo` to show it in the error handler
2. Many errors still happen we don't see because the error handler doesn't `echo` them
3. You don't want any unseen errors in your PHP, it slows down your site and other things
4. Develop with an error handler, turn it off once you have no errors and you go live

*Let's try the `$live` option...*

| **38** :$
```
sudo cp core/01-phperrors2.php web/phperrors.php && \
atom core/01-phperrors2.php && \
ls web
```

*Note we added the `$site_live` variable, which easily turned-off our error `echo`...*

| **B-38** :// (Same)

```console
localhost/web/phperrors.php
```

___

# The Take

## PHP Background
- Made in 1994
- Written in C language
- "Personal Home Page"
- "Server language"

## PHP rules:
1. PHP renders HTML ***after*** the entire PHP script finishes
2. HTML and PHP work wherever they are
  - HTML can exist outside `<?php ?>` in a .php file
  - `<?php ?>` can be used inside an .html file
3. Variables begin with `$`, *even when declaring the value (unlike Shell)*
4. Variables work inside `"double quotes"` *not `'single quotes'`*
5. Variable names allow the same characters as Shell:
  - letters, numbers, underscore
  - case-sensitive
  - can't start with a number
6. Concatenate strings and variables with `.`
7. Always test success and plan for failure, even the impossible

## PHP Form & Method Handling
- `$_GET` takes values from the web URL
  - `http://longurl?one=value&two=value` has two `$_GET` values useable as...
  - `$_GET['one']` and `$_GET['two']`
- `$_POST` takes values from a submitted `<form>`
  - `<form method="post" action="http://address"><input name="one"...><input name="two"...` has two `$_POST` values usable as...
  - `$_POST['one']` and `$_POST['two']`
- Handy test to match an item in an array:
  - `in_array("find me", $array)`

## PHP Basic Syntax
1. PHP must start with `<?php` and can end with `?>`
2. Every PHP line must end with `;`
3. *`do` ... `done`* and *`then` ... `fi`* are replaced with *`{` ... `}`*
4. Tests are wrapped in `(`parentheses`)`, you can use `(tests (inside tests))`

## PHP Logic
- Loops use arrays
- 4 types of loops `do` `while` `for` `foreach`
  - `foreach` syntax: `foreach ($array as $item) { Do This... ;}`
- PHP uses `if` tests
  - Syntax: `if ( Test Here ) { Do This... ;}`
- PHP `if` tests can use `else` and `elseif` *(not `elif`)*

## Ternary Statements
- Syntax: `$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';`

## `switch`-`case` Statements
- Syntax:
```php
switch ($variable) {
  case "one":
    echo 'Do something for one';
    break;
  case "two":
    echo 'Do something for two';
    break;
  default:
    echo 'Do something else';
}
```

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

## Handling Arrays: `$_POST` Array, `print_r()` & `var_dump()`
- Arrays can be auto-indexed or associative
  - `$_POST` & `$_GET` are associative arrays with keys like so...
    - `$_POST['key']`
    - `$_GET['key']`
- The `$_POST` array only has what is in the `<form>`
- `print_r()` & `var_dump()` both show everything in an array
  - Syntax: `print_r($_POST);`

## Error Handler
- The function that deals with errors is called an "error handler"
- Customize your own way to see errors
- Syntax:
```php
function my_error_handler($e_number, $e_message, $e_file, $e_line, $e_vars) {
  // Function settings here
  $message = "Error in '$e_file' on line $e_line:\n$e_message\n";
  $message .= "<pre>" .print_r(debug_backtrace(), 1) . "</pre>\n";
  echo nl2br($message);
}
set_error_handler ('my_error_handler');
```
- Use some variable like `$live` to change what the error handler does
- Syntax:
```php
$live = false;
function my_error_handler($e_number, $e_message, $e_file, $e_line, $e_vars) {

  global $live;

  $message = "Error in '$e_file' on line $e_line:\n$e_message\n";
  $message .= "<pre>" .print_r(debug_backtrace(), 1) . "</pre>\n";

  if ($live == true) {
      echo nl2br($message);
  } else {
    // Script to send an email or something else
  }

}
set_error_handler ('my_error_handler');
```
___

#### [Lesson 2: MySQL & phpMyAdmin](https://github.com/inkVerb/vip/blob/master/501/Lesson-02.md)
