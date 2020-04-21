# PHP 501
## Lesson 2: HTML via PHP

Ready the CLI

`cd ~/School/VIP/501`

- [Tests: Ternary Statements](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)

___

### I. PHP Form & Method Handling

#### `_GET`

| **1** : `cp core/02-phpget1.php web/phpget.php && gedit web/phpget.php`

| **b-1** :// `localhost/web/phpget.php?go=I am an apple pie`

| **2** : `cp core/02-phpget2.php web/phpget.php`

*gedit: Reload phpget.php*

| **b-2** :// `localhost/web/phpget.php?go=over there&h=6-hour&time=5:22`

#### `_POST`

| **3** : `cp core/02-phppost1.php web/phppost.php`

| **b-3** :// `localhost/web/phppost.php`

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

| **4** : `cp core/02-phppost2.php web/phppost.php`

| **b-4** :// `localhost/web/phppost.php`

| **5** : `cp core/02-phppost3.php web/phppost.php`

| **b-5** :// `localhost/web/phppost.php`

| **6** : `cp core/02-phppost4.php web/phppost.php`

| **b-6** :// `localhost/web/phppost.php`

| **7** : `cp core/02-phppost5.php web/phppost.php`

| **b-7** :// `localhost/web/phppost.php`

| **8** : `cp core/02-phppost6.php web/phppost.php`

| **b-8** :// `localhost/web/phppost.php`

#### Ternary Statements

*Now, use a [Ternary Statement](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md#xi-ternary-statements-)*

```php
$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';

// example:

$Variable = ( $Some_Variable == 5 ) ? 'it is five' : 'not five';

```

| **9** : `cp core/02-phppost7.php web/phppost.php`

| **b-9** :// `localhost/web/phppost.php`

### III. PHP RegEx Checks


### IV. Render HTML via PHP


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

## Ternary syntax: `$Variable = ( THIS IS THE TEST ) ? 'value_if_true' : 'value_if_false';`

## Render HTML on a webpage using PHP

___

#### [Lesson 3: MySQL & phpMyAdmin](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-03.md)
