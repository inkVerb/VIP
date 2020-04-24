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

| **B-1** :// `localhost/web/phpget.php?go=I am an apple pie`

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

#### PHP Form Summary

**_GET**
```php
'http://webaddress.com?this_name=...'  >>>>  $_GET['this_name']
```

**_POST**
```php
<input name="this_name">  >>>>  $_POST['this_name']
```

### II. PHP Logic

#### Basic Syntax
##### 1. PHP must start with `<?php` and can end with `?>`
##### 2. Every PHP line must end with `;`
##### 3. *`do` ... `done`* and *`then` ... `fi`* are replaced with *`{` ... `}`*
##### 4. Tests are wrapped in `(`parentheses`)`, you can use `(tests (inside tests))`

*Many other things are the same between PHP and Shell*

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

| **4** : `cp core/01-phppost2.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-4** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

| **5** : `cp core/01-phppost3.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-5** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

| **6** : `cp core/01-phppost4.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-6** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

| **7** : `cp core/01-phppost5.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-7** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

| **8** : `cp core/01-phppost6.php web/phppost.php`

*gedit: Reload phpget.php*

| **B-8** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

#### Ternary Statements

*Now, use a [Ternary Statement](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)*

```php
$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';

// example:

$Variable = ( $Some_Variable == 5 ) ? 'it is five' : 'not five';

```

| **9** : `cp core/01-phppost7.php web/phppost.php`

| **B-9** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

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

*Compare those charts with these files...*

| **10** : `cp core/01-phpregex1.php web/phppost.php && gedit core/01-phpregex1.php`

| **B-10** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

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

| **11** : `cp core/01-phpregex2.php web/phppost.php && gedit core/01-phpregex2.php`

| **B-11** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

| **12** : `cp core/01-phpregex3.php web/phppost.php && gedit core/01-phpregex3.php`

| **B-12** :// `localhost/web/phppost.php` *(Ctrl + R to reload)*

*Try the form a few times to see how it works*

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
- PHP uses `if` tests
  - syntax: `if ( TEST HERE ) { DO THIS... ;}`
- PHP `if` tests can use `else` and `elseif` *(not `elif`)*

## Ternary syntax
- Syntax: `$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';`

## PHP RegEx & Validation
- Use RegEx with `preg_match()` to check strings
-

## PHP Functions in Forms

## Constants & Config Files

___

#### [Lesson 2: MySQL & phpMyAdmin](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-02.md)
