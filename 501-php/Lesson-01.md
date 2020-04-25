# PHP 501
## Lesson 1: PHP

Ready the CLI

`cd ~/School/VIP/501`

- [Tests: Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)
- [Characters](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/Characters.md)

___

### I. PHP Form & Method Handling

#### `_GET`

| **1** : `cp core/01-phpget1.php web/phpget.php && gedit web/phpget.php && ls web`

| **B-1** :// `localhost/web/phpget.php?go=I am an apple pie` *(Ctrl + Shift + C in browser to see the developer HTML view)*

*Try the form a few times to see how it works*

| **2** : `cp core/01-phpget2.php web/phpget.php && ls web`

*gedit: Reload phpget.php*

| **B-2** :// `localhost/web/phpget.php?go=over there&h=6-hour&time=5:22`

*Try the form a few times to see how it works*

#### `_POST`

| **3** : `cp core/01-phppost1.php web/phppost.php`

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

| **4** : `cp core/01-phparrays.php web/phppost.php && gedit core/01-phparrays.php`

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
##### 1. PHP must start with `<?php` and can end with `?>`
##### 2. Every PHP line must end with `;`
##### 3. *`do` ... `done`* and *`then` ... `fi`* are replaced with *`{` ... `}`*
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

| **5** : `cp core/01-phpforeach.php web/phppost.php && gedit core/01-phpforeach.php`

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

| **6** : `cp core/01-phppost2.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-6** :// `localhost/web/phppost.php` (Same)

*Try the form a few times to see how it works*

*Use Ctrl + Shift + C in browser to see the developer view*

| **7** : `cp core/01-phppost3.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-7** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **8** : `cp core/01-phppost4.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-8** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **9** : `cp core/01-phppost5.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-9** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **10** : `cp core/01-phppost6.php web/phppost.php`

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

| **11** : `cp core/01-phppost7.php web/phppost.php`

| **B-11** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

#### FYI Reference: Useful PHP Tests & Functions

```php

// Simple tests

empty($testme)

isset($testme)

array_key_exists($key, $array_name)

file_exists($file_name) // For file on server (or with http address, use with care)

// Note:
!empty($testme) // flips the true/false return for the if test for any of these

// Below are not tests, but they return true if successful, just like a test

unset($remove_me) // Removes (unsets) the value of the variable

file_get_contents($file_name) // For file on server (or with http address, use with care)

header("Location: $new_http_web_address") // Redirect to this address, often used in easy PHP forward files

date("Y-m-d H:i:s") // Returns an SQL-standard date string (2020-01-01 23:59:59 format)

strtotime($time_string) // Changes most common date strings into a PHP epoch time, (seconds from 1970/01/01 midnight)

date("Y-m-d H:i:s", substr($time_epoch, 0, 10)) // Change PHP epoch time back to SQL date string

```

*...In PHP, you will see functions like these and many, many more*

### III. PHP RegEx & Validation

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

##### This Prevents Hackers and Serious User Error
For basic security:
1. Validate first & always
2. Sanitize second
3. Escape before using

#### Basic PHP RegEx & Validation Tests:
```php
// Test a URL
filter_var($Variable, FILTER_VALIDATE_URL)

// Test an email address
filter_var($Variable,FILTER_VALIDATE_EMAIL)

// Test an integer
filter_var($Variable, FILTER_VALIDATE_INT)

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

| **12** : `cp core/01-phpregex1.php web/phppost.php && gedit core/01-phpregex1.php`

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

| **13** : `cp core/01-phpregex2.php web/phppost.php && gedit core/01-phpregex2.php`

| **B-13** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **14** : `cp core/01-phpregex3.php web/phppost.php && gedit core/01-phpregex3.php`

| **B-14** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

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

| **15** : `cp core/01-phpfunction1.php web/phppost.php && gedit core/01-phpfunction1.php`

| **B-15** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **16** : `cp core/01-phpfunction2.php web/phppost.php && gedit core/01-phpfunction2.php`

| **B-16** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **17** : `cp core/01-phpfunction3.php web/phppost.php && gedit core/01-phpfunction3.php`

| **B-17** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **18** : `cp core/01-phpfunction4.php web/phppost.php && gedit core/01-phpfunction4.php`

| **B-18** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

| **19** : `cp core/01-phpfunction5.php web/phppost.php && gedit core/01-phpfunction5.php`

| **B-19** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

***We need a little more cleanup:***
- **"empty" error message if empty POST**
- **Double-check password**

| **20** : `cp core/01-phpfunction6.php web/phppost.php && gedit core/01-phpfunction6.php`

| **B-20** :// `localhost/web/phppost.php` (Same)

*Try the form and developer view*

### V. Constants & Config Files



___

# The Take

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
  - syntax: `if ( TEST HERE ) { DO THIS... ;}`
- PHP `if` tests can use `else` and `elseif` *(not `elif`)*

## Ternary syntax
- Syntax: `$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';`

## PHP RegEx & Validation
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
  - syntax: `$error_array['input_name']`
- Arrays and functions can work together

## Constants, Includes & Configs



___

#### [Lesson 2: MySQL & phpMyAdmin](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-02.md)
