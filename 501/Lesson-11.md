# Shell 501
## Lesson 11: Objects: OOP & PDO

Ready the CLI

```console
cd ~/School/VIP/501
```

___

Up until now, we have been using "procedural" PHP

Now, we start using "objects"

Objects are used in many languages, including Javascript, C, and countless others

By understanding objects in PHP, you will understand them elsewhere

### I. OOP (Object Oriented Programming)

A simple way to organize many functions and variables

- **Class**: the framework of properties & methods, mostly undefined
- **Property**: variable in a class
- **Method**: function in a class
- **Object**: a complex variable built from a class, having methods & properties from that class, mostly-defined

| **Normal PHP** :

```php
aFunction(); // Use a function
$aProperty; // Use a variable
```

| **Objects in PHP** :

```php
$anObject = new aClass; // Instantiate $anObject from the aClass
$anObject->aMethod(); // Use a method (class function)
$anObject->aProperty; // Use a property (class variable)
```

| **Objects in Javascript** :
```js
const anObject = new Object(); // Create an object named "anObject"
anObject.aMethod(); // Use a method (object function)
anObject.aProperty; // Use a property (object variable)
```

With many functions and variables, OOP can help organize code

This also explains the basic thinking inside Javascript

#### A. Classes, Objects, Properties & Methods

- **Class** - a framework or blueprint
- **Object** - a class that we start using
- **Property** - a variable in a class
- **Method** - a function in a class

Remember, properties and methods are bound to their object and class

| **Normal PHP** : (Won't work in OOP)

```php
return someFunction();
return $someVariable;
```

| **OOP PHP** : (Class syntax, inside the class statement)

```php
return $this->someMethod();
return $this->someProperty;
```

| **OOP PHP** : (Object syntax, outside the class statement)

```php
return $someObject->someMethod();
return $someObject->someProperty;
```

*See how it works...*

| **Create a Class** :

```php
class aClass {

  // Declare a property, not yet defined
  var $aProperty;

  // Define a method to set the property's value
  function aMethod($anArgument) {
    $this->aProperty = $anArgument;
  }

  // Define a method to return the property
  function bMethod() {
    return $this->aProperty;
  }

}
```

*Note `$this` is a native part of OOP, not a property you can define*

| **Instantiate an Object** :

We use a class by creating an object based on the framework of that class

This is called "**instantiating**" an object

We can instantiate as many objects as we want

```php
// Instantiate the object
$anObject = new aClass;

// Use the method to set the parameters of the object
$anObject->aMethod('some thing');

// Use the method to return the parameters of the object
$anObject->bMethod();
```

**Examples...**

| **1** :$
```console
sudo cp core/11-oop1.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop1.php && \
ls web
```

- `Topic` class with three methods:
  - `course`
  - `website`
  - `slogan`
- Use the `Topic` class as the framework to instantiate the object `$topicObject`

| **B-1** ://

```console
localhost/web/oop.php
```

*Another example...*

| **2** :$
```console
sudo cp core/11-oop2.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop2.php && \
ls web
```

- `Topic` class
- Three properties for:
  - `course`
  - `website`
  - `slogan`
- Six methods
  - Three methods set the properties
  - Three methods `return` the properties values
- Property `$this` refers to the current object of the class
  - `$this` works like a wildcard for whatever object may have been created from that class
  - Use `$this` inside a class when working with with properties that are part of that class

*Note the methods don't take many arguments*

| **B-2** ://

```console
localhost/web/oop.php
```

#### B. Polymorphism

A complex method

| **3** :$
```console
sudo cp core/11-oop3.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop3.php && \
ls web
```

- `immaClass` class
- Two properties
- The set method takes two arguments to set both properties
- The `return` method also takes an argument for which property to return
  - A multi-purpose method like this is called a "polymorphism"

*The methods take more arguments, so the methods are more complex, but there are fewer methods because they can do more*

- Method `MethodSet()` requires two arguments and only does one thing
  - It is a normal method
- Method `MethodReturn()` does different things based on arguments
  - It is a polymorphism
  - A polymorphism can become much more complicated if you want

| **B-3** ://

```console
localhost/web/oop.php
```

#### D. Instantiation: Constructor & Destructor

**What happens at instantiation?**

The contents of the class are not run as a script, but **only declaration & definition of properties and methods**

To run a script at instantiation of an object, use these "magic methods" (native PHP methods)

**Magic methods** are methods built into PHP

- `__construct()` (runs at start of instantiation)
- `__destruct()` (runs at end of instantiation)
- Magic methods start with double underscore `__someMagicMethod()`
- These two are most common magic methods, there are many others
- Other magic methods are basically used to hack into the class by using the underlying code PHP uses to handle classes and objects
  - Examples:
    - `__call()`
    - `__get()`
    - `__set()`
    - `__invoke()`
    - `__clone()`
  - ***You won't use other magic methods in normal PHP*** unless you are building contingency plans for possible faulty PHP objects, such as from another developer or an unusual scenario in the user experience

##### 1. `__construct()` start of instantiation

| **Workflow** : (How to run a statement at instantiation)

```php
// Creation
class Topic {

  function slogan() {
    return "Anyone can learn!";
  }

  // Broken:
  echo "Anyone can learn!";

  // Broken:
  $this->slogan();

  // Broken:
  echo $this->slogan();

  // Success: Auto-runs at instantiation
  function __construct() {
    echo $this->slogan();
    echo "<br> That's VIP Linux!";
  }

}

// Instantiation
$topicObject = new Topic;
```

*Basic `__construct()` example...*

| **4** :$
```console
sudo cp core/11-oop4.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop4.php && \
ls web
```

*Note lines 16-19 (same as the example) would break the script, try uncommenting any of them to watch*

| **B-4** ://

```console
localhost/web/oop.php
```

*Let's expand...*

| **5** :$
```console
sudo cp core/11-oop5.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop5.php && \
ls web
```

*Note lines 16-19 (same as the example) would break the script, try uncommenting any of them to watch*

| **B-5** ://

```console
localhost/web/oop.php
```

##### 2. `__destruct()` end of instantiation

| **6** :$
```console
sudo cp core/11-oop6.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop6.php && \
ls web
```

| **B-6** ://

```console
localhost/web/oop.php
```

Order doesn't matter...

| **7** :$
```console
sudo cp core/11-oop7.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop7.php && \
ls web
```

*Note this has the same contents, but in a random order, but it still executes in order*

| **B-7** ://

```console
localhost/web/oop.php
```

You can destroy an object by using `unset($object)`

| **8** :$
```console
sudo cp core/11-oop8.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop8.php && \
ls web
```

*Note the object can't be used after it is `unset()`*

| **B-8** ://

```console
localhost/web/oop.php
```

**Do not confuse** `__destruct()` with `unset()`

- `__destruct` runs at the end of instantiation
- `unset()` destroys the object and doesn't run anything else

Also, for security:

- `unset()` does not entirely destroy an object or variable, but pushes it to the end of memory. More work is needed if you need extreme security in your script!

#### D. Inheritance

| **Inherited Class** : (Properties)

```php
// Create the parent
class ParentClass {

  var $parentProperty;

}

// Create the child
class ChildClass extends ParentClass {

  var $childProperty;

}

// Instantiate
$ObjectParent = new ParentClass;
$ObjectChild = new ChildClass;

// These work:
echo $ObjectParent->parentProperty;
echo $ObjectChild->parentProperty;
echo $ObjectChild->childProperty;

// This fails:
echo $ObjectParent->childProperty;

```

| **9** :$
```console
sudo cp core/11-oop9.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop9.php && \
ls web
```

*Note line 25 would break the script because the parent object tries to call a child property*

| **B-9** ://

```console
localhost/web/oop.php
```

*Let's expand...*

| **Inherited Class** : (Properties & Methods)

```php
// Create the parent
class ParentClass {

  var $parentProperty;

  function parentMethodSet($arg) {
    $this->$parentProperty = $arg;
  }

  function parentMethodRet() {
    return $this->$parentProperty;
  }

}

// Create the child
class ChildClass extends ParentClass {

  var $childProperty;

  function childMethodSet($arg) {
    $this->$childProperty = $arg;
  }

  function childMethodRet() {
    return $this->$childProperty;
  }

}

// Instantiate
$ObjectParent = new ParentClass;
$ObjectChild = new ChildClass;

// These work:
$ObjectParent->parentMethodSet("something");
$ObjectParent->parentMethodRet();

$ObjectChild->parentMethodSet("something");
$ObjectChild->parentMethodRet();
$ObjectChild->childMethodSet("something");
$ObjectChild->childMethodRet();

// These fail:
$ObjectParent->childMethodSet("something");
$ObjectParent->childMethodRet();

```

| **10** :$
```console
sudo cp core/11-oop10.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop10.php && \
ls web
```

*Note lines 44 & 52 would break the script because the parent object tries to call child methods*

| **B-10** ://

```console
localhost/web/oop.php
```

*For fun, uncomment line 44 and/or 52 and watch the page fail*

#### E. Visibility

**Visibility** is a method or property's ability to be directly accessed from outside its class, such as in statements like this:

| **Fail** :

```php
echo $object->access_property;
echo $object->access_method();
```

| **Success** :

```php
echo $object->method_using_access_property();
```

If `$access_property` or `access_method()` are not visible, they will break

Properties and methods have three types of "visibility":

- `public` (default)
- `protected`
- `private`

...and one extra visibility option:
- `static`

| **Static usage** : (Using a `static` property or method)

```php
echo someClass::$staticProp;
echo someClass::staticMethod();
```

**Visibility key:**

- **`public`**: anywhere

- **`protected`**: class and inheritance

- **`private`**: class, not inheritance

- **`static`**: anywhere directly via class, bypass instantiated object

##### 1. Property Visibility

| **11** :$
```console
sudo cp core/11-oop11.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop11.php && \
ls web
```

| **Set Property Visibility** :

```php
public $publicProp;
protected $protectedProp;
private $privateProp;
```

*Note non-`public` properties can only be used within visibility by other methods of the class, not outside the class statement*

*Note lines 52, 54, 59, 61, 70, 75 & 77 would either fail or break because they act outside of visibility scope*

| **B-11** ://

```console
localhost/web/oop.php
```

##### 2. `static` Properties

| **12** :$
```console
sudo cp core/11-oop12.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop12.php && \
ls web
```

| **Set `static` Property** :

```php
static $staticProp;
```

| **Success** :

```php
echo classA::$staticA;
echo classB::$staticB;
```

| **Fail** :

```php
echo classA::$publicA;
echo classB::$publicB;
$this->staticA;
```

*Note calling a property through its class works only if it is `static`*

*Note lines 9, 10, 37 & 38 show correct and incorrect usage of `static` properties*

*Note lines 69, 71, 81, 83, 92 & 94 break the script because they call non-`static` property as if they were static*

*Tip: comment lines 60-61 to see how calling static properties by class doesn't require any instantiated objects*

| **B-12** ://

```console
localhost/web/oop.php
```

##### 3. `static` Methods

| **13** :$
```console
sudo cp core/11-oop13.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop13.php && \
ls web
```

| **Set `static` Property** :

```php
static function staticMethod() { echo "foo"; };
```

| **Success** :

```php
echo classA::staticA();
echo classB::staticB();
```

| **Fail** :

```php
echo classA::publicA();
echo classB::publicB();
```

*Note calling a method through its class works only if it is `static`*

*Note lines 37 & 39 break the script because they call non-`static` methods as if they were static*

*Tip: comment lines 28-29 to see how calling static methods by class doesn't require any instantiated objects*

| **B-13** ://

```console
localhost/web/oop.php
```

##### 4. Method Visibility

| **14** :$
```console
sudo cp core/11-oop14.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop14.php && \
ls web
```

| **Set Method Visibility** :

```php
public function publicMethod() { echo "foo"; };
protected function protectedMethod() { echo "foo"; };
private function privateMethod() { echo "foo"; };
```

*Note non-`public` methods can only be used within visibility by other methods of the class, not outside the class statement*

*Note lines 59, 61, 69, 71 & 77 break the script because they call functions outside of visibility scope*

| **B-14** ://

```console
localhost/web/oop.php
```

##### 5. Constants

| **15** :$
```console
sudo cp core/11-oop15.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop15.php && \
ls web
```

| **Set Constants with Visibility** :

```php
public const PUBLIC_CONST;
protected const PROTECTED_CONST;
private const PRIVATE_CONST;
```

| **Call Constants from within Class** :

```php
echo self::PUBLIC_CONST;
echo self::PROTECTED_CONST;
echo self::PRIVATE_CONST;
```

| **Call Constants from Uninstantiated Class** :

```php
echo classA::PUBLIC_CONST; // Success
echo classA::PROTECTED_CONST; // Fail
echo classA::PRIVATE_CONST; // Fail
```

Constants don't change, so call them from the class (above), not from an object (below)

| **Empty** : (Calling a constant from an object won't work)

```php
echo $object->PUBLIC_CONST;
// PHP will think you are looking for a property, not a constant:
var $PUBLIC_CONST = "something" ;
```

*Note lines 52, 54, 62, 64, 73, 80 & 82 break the script because they call functions outside of visibility scope*

*Note lines 58 & 76 return empty because they try to call a constant in the manner of calling a property*

- *Lines 58 & 76 are corrected in lines 60 & 78 respectively*

| **B-15** ://

```console
localhost/web/oop.php
```

#### F. Reflection

**Reflection** is the only way to directly access `protected` & `private` methods & properties from outside the class definition, *(see this [Stackoverflow answer](https://stackoverflow.com/a/21902271/10343144))*

##### 1. Loop through Object Properties

| **Normal Instantiation** :

```php
$loop_object = new LoopClass;
```

| **16** :$
```console
sudo cp core/11-oop16.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop16.php && \
ls web
```

*Note a `foreach` loop iterates `$properties`, but not `methods()` nor non-`public` `$properties`*

| **B-16** ://

```console
localhost/web/oop.php
```

We can use `foreach` to loop through non-`public` properties, if we set up the object through ***reflection***

##### 2. Reflection Loop

This requires the built-in `ReflectionClass()` function and `getDefaultProperties()` method

| **Reflection Instantiation** :

```php
$loop_object = new ReflectionClass('LoopClass');
$loop_obj_props = $loop_object->getDefaultProperties();
```

| **17** :$
```console
sudo cp core/11-oop17.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-oop17.php && \
ls web
```

*Note a `foreach` loop iterates all `$properties`, even non-`public` `$properties`, but still not `methods()`*

| **B-17** ://

```console
localhost/web/oop.php
```


### II. PDO (PHP Data Objects)

A simple way to organize SQL database calls

PDO uses objects to talk to SQL, rather than `mysqli()`

MySQLi interacts only with MySQL/MariaDB

PDO has drivers for many database platforms:

- MySQL/MariaDB
- SQLite
- PostgreSQL
- Firebird
- CUBRID
- Informix
- IBM
- Oracle
- MS SQL Server
- ODBC & DB2
- 4D

#### PDO MySQL Extension Required

Ensure that the `pdo_mysql` extension is enabled in your php.ini file

We did this when we set up our [LAMP Desktop](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/LAMP-Desktop.md), but if you have trouble:

| **P0** :$ (Only if you have trouble)
```console
sudo vim /etc/php/php.ini
```

- Uncomment: `extension=pdo_mysql`

#### Database Connection

| **Database Constants** :

```php
$db_name = 'some_database';
$db_user = 'some_user';
$db_pass = 'some_password';
$db_host = 'localhost';
```

| **MySQLi Config** :

```php
$database = mysqli_connect($db_host, $db_user, $db_pass, $db_name);
mysqli_set_charset($database, 'utf8');
```

| **PDO Config** : (Simple)

```php
$database = new PDO("mysql:host=$db_host; dbname=$db_name; charset=utf8", $db_user, $db_pass);
```

| **PDO Config** : (Readable with Options)

```php
$nameHostChar = "mysql:host=$db_host; dbname=$db_name; charset=utf8";
$opt = [
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH, // Row array is auto-indexed and associated by column name (default)
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Row array is associated by column name only
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_NUM, // Row array is auto-indexed only
];
$database = new PDO($nameHostChar, $db_user, $db_pass, $opt);
```

#### Escape & Quote

| **MySQLi Escape & Quote** :

```php
function escape_sql($data) {
  global $database;
  $trimmed_data = trim(preg_replace('/\s+/', ' ', $data));
	return mysqli_real_escape_string($database, $trimmed_data); // Escapes, no quote
}
$name = escape_sql($_POST['name']);
$query = "SELECT * FROM fruit WHERE name = '$name'"; // $name needs `quotes`
```

| **PDO Escape & Quote** :

```php
function escape_sql($data) {
  global $database;
  $trimmed_data = trim(preg_replace('/\s+/', ' ', $data));
	return PDO::quote($trimmed_data); // Escapes AND quotes
}
$name = escape_sql($_POST['name']);
$database->query("SELECT * FROM fruit WHERE name = $name"); // $name without 'quotes'
```

#### Query

| **MySQLi Query** :

```php
$query = "SELECT * FROM fruit WHERE name = '$name'";
$call = mysqli_query($database, $query);

// Process the row
$row = mysqli_fetch_array($call, MYSQLI_NUM);
$f_color = "$row[0]";
$f_locale = "$row[1]";
$f_market = "$row[2]";
```

| **PDO Query** :

```php
// Single statement
$statement = $database->query("SELECT * FROM fruit WHERE name = $name");

// Separate $query for easy error processing
$query = "SELECT * FROM fruit WHERE name = $name";
$statement = $database->query($query);

// Process the row
$row = $statement->fetch(PDO::FETCH_NUM);
$f_color = "$row[0]";
$f_locale = "$row[1]";
$f_market = "$row[2]";
```

#### Rows

| **MySQLi Rows** :

```php
$query = "SELECT * FROM fruit";
$call = mysqli_query($database, $query);
$row = mysqli_fetch_array($call, MYSQLI_NUM);
while ($row) {
  $f_name = "$row[0]";
  $f_color = "$row[1]";
  $f_locale = "$row[2]";
  $f_market = "$row[3]";
  echo "Name: $f_name Color: $f_color Farm: $f_locale Sold in: $f_market<br>";
}
```

| **PDO Rows** :

```php
$statement = $database->query("SELECT * FROM fruit");
$row = $statement->fetch(PDO::FETCH_NUM);
while ($row) {
  $f_name = "$row[0]";
  $f_color = "$row[1]";
  $f_locale = "$row[2]";
  $f_market = "$row[3]";
  echo "Name: $f_name Color: $f_color Farm: $f_locale Sold in: $f_market<br>";
}
```

#### Multiple Queries

| **MySQLi Config** : `multi_query()`

```php
$database = new mysqli($db_host, $db_user, $db_pass, $db_name); // Use OOP for your MySQLi connection
$query  = "
START TRANSACTION;
INSERT INTO fruit (name) VALUES ('apple');
INSERT INTO fruit (name) VALUES ('kiwi');
COMMIT;
";
$database->multi_query($query);
```

| **PDO Config** : `exec()`

```php
$database->setAttribute(PDO::ATTR_EMULATE_PREPARES, false); // Must have this option, same as example above
$query  = "
START TRANSACTION;
INSERT INTO fruit (name) VALUES ('apple');
INSERT INTO fruit (name) VALUES ('kiwi');
COMMIT;
";
$database->exec($query);
```

#### Checks

| **MySQLi Checks** :

```php
if ($call) // (all queries) Query had no errors
if (mysqli_num_rows($call) == 1) // (SELECT) Returned exactly 1 row
if (mysqli_affected_rows($database) == 1) // (UPDATE and DELETE) Changed exactly 1 row
$last_id = $database->insert_id; // Row ID of most recent `INSERT` statement
```

| **PDO Checks** :

```php
if ($statement) // (all queries) Query had no errors
if ($statement->rowCount() == 1) // (SELECT, UPDATE, and DELETE) Returned or changed exactly 1 row
$last_id = $database->lastInsertId(); // Row ID of most recent `INSERT` statement
```

#### Errors

| **Error Handler** : (FYI, for any PHP)

```php
// PHP Error handler
function show_error($e_number, $e_message, $e_file, $e_line) {
	$message = "Error in '$e_file' on line $e_line: $e_message\n";
	$message .= "<pre>" .print_r(debug_backtrace(), 1) . "</pre>\n"; // The ugly truth
	echo nl2br($message); // Line breaks for HTML
	return true; // So that PHP doesn't try to handle the error again
}
set_error_handler('show_error');
```

| **MySQLi Errors** :

```php
// MySQLi error handler function
function mysqli_error($query) {
	echo "SQL error from <pre>$query</pre>";
}

// Run the query
if (mysqli_affected_rows($database) == 1) {
  success();
} else {
  mysqli_error($query);
}
```

| **PDO Errors** :

```php
$database->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Must have this option, same as example above

// PDO error handler function
function pdo_error($query, $error_message) {
    echo "SQL error from <pre>$query</pre><br>$error_message";
}

// Wrap the query statement in a try statement
try {
  $query = "INSERT INTO fruit (name) VALUES ('apple')";
  $statement = $database->query($query);
} catch (PDOException $error) {
  pdo_error($query, $error->getMessage());
}
```

#### Follow along in phpMyAdmin & the MySQL terminal

Ready the secondary SQL terminal and secondary SQL browser

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mysql -u admin -padminpassword
```

| **S1** :>

```console
CREATE DATABASE test_pdo;
GRANT ALL PRIVILEGES ON test_pdo.* TO pdo_user@localhost IDENTIFIED BY 'pdopassword';
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S2** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

| **S3** ://phpMyAdmin **> webapp_db > test_pdo**

*From now on, you may optionally follow along at the SQL prompt and/or phpMyAdmin, but no instructions will be given*

#### Examples

| **18** :$
```console
sudo cp core/11-pdo18.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
atom core/11-pdo18.php && \
ls web
```

- Database: `test_pdo`
- User: `pdo_user`
- Password: `pdopassword`


| **B-18** ://

```console
localhost/web/pdo.php
```

### III. Rebuild Webapp for PDO



### IV. Rebuild Webapp for OOP



___

# The Take

## I. OOP (Object Oriented Programming)

- Vocabulary
  - **class**: a framework of functions (methods) and variables (properties)
  - **object**: a complex variable "instantiated" based on a class
  - **property**: a variable in a class
  - **method**: a function in a class
  - **instantiation**: creating an object (AKA an 'instance' of a class)
  - **magic method**: a method built into PHP, starts with double underscore `__someMagicMethod`
  - **constructor**: the `__construct()` magic method that runs at the start of instantiation
  - **destructor**: the `__destruct()` magic method that runs at the end of instantiation
  - **inheritance**: creating a child class of another class
    - Usage: `class Child extends Parent {}`
  - **visibility**: setting properties and methods ability to be used in a child class or from an object
    - `public` access everywhere, child classes and objects (default)
    - `protected` access only within class and children
    - `private` access only within class, not children
    - `static` directly access in uninstantiated class
      - Property usage: `SomeClass::$staticProperty`
      - Method usage: `SomeClass::staticMethod()`

- Create a class:

```php
class SomeClass {

  // Constructor (optional)
  function __construct() {
    echo "I run a script first";
  }

  // Destructor (optional)
  function __destruct() {
    echo "I run a script last";
  }

  // Declare & define properties
  var $someProperty = "I am a property";
  static $staticProperty = "I am a property";

  // Define functions
  function someMethod() { return $this->someProperty; }
  static function staticMethod() { return $this->staticProperty; }

  // Declare and define a constant
  const SOME_CONSTANT = "I am a constant";

}
```

- Call inside a class statement:

```php
return $this->someProperty;
return $this->someMethod();
return self::SOME_CONSTANT;
```

- Call from an uninstantiated class:

```php
echo SomeClass::$staticProperty;
echo SomeClass::staticMethod();
echo SomeClass::SOME_CONSTANT;
```

- Instantiate an object from a class:

```php
$SomeObject = new SomeClass;
```

- Call from object:

```php
echo $SomeObject->someProperty;
echo $SomeObject->someMethod();
echo $SomeObject->SOME_CONSTANT; // Fail empty
```

- Create parent & child classes:

```php
class ParentClass {
  var $childCanProp = "from parent";
  function childCanMethod() { return $this->childCanProp; }
}

class ChildClass extends ParentClass {
  var $parentCantProp = "from child";
  function parentCantMethod() { return $this->parentCantProp; }
}
```

- Visibility

```php
class ParentClass {

  public $publicProp = "public from parent"; // Outside access
  protected $protectedProp = "protected from parent"; // Child can access
  private $privateProp = "private from parent"; // Child CAN'T access

  public function publicMethod() { return "Public Method"; } // Outside access
  protected function protectedMethod() { return "Protected Method"; } // Child can access
  private function privateMethod() { return "Private Method"; } // Child CAN'T access

  function callParentMethods() {
    return $this->publicMethod()     // Outside access
         . $this->protectedMethod()  // Child can access
         . $this->privateMethod();   // Child CAN'T access
  }

  function callParentProperties() {
    return $this->publicProp     // Outside access
         . $this->protectedProp  // Child can access
         . $this->privateProp;   // Child CAN'T access
  }

}

class ChildClass extends ParentClass {

  function successFromParent() {
     return $this->publicMethod()
          . $this->protectedMethod()
          . $this->publicProp
          . $this->protectedProp;
  }

  function failsFromParent() {
     return $this->privateMethod()
          . $this->privateProp;
  }

}

// Instantiate
$parentObject = new ParentClass;
$childObject = new ChildClass;

// Success
echo $parentObject->publicProp;
echo $childObject->publicProp;
echo $parentObject->publicMethod();
echo $parentObject->callParentMethods();
echo $parentObject->callParentProperties();
echo $childObject->publicMethod();
echo $childObject->successFromParent();

// Fails
echo $parentObject->protectedProp;
echo $parentObject->privateProp;
echo $childObject->protectedProp;
echo $childObject->privateProp;
echo $parentObject->protectedMethod();
echo $parentObject->privateMethod();
echo $childObject->protectedMethod();
echo $childObject->privateMethod();
echo $childObject->callParentMethods();
echo $childObject->callParentProperties();
```

- Object properties can loop via `foreach`
  - This will not loop non-`public` properties or methods

```php
$loop_object = new LoopMe;
foreach($loop_object as $key=>$value) {echo "$key = $value<br>";}
// Only shows public properties & values
```

- Reflection can loop through non-`public` properties
  - This will not loop methods

```php
$loop_object = new ReflectionClass('LoopClass');
$loop_obj_props = $loop_object->getDefaultProperties();
foreach($loop_obj_props as $key=>$value) {echo "$key = $value<br>";}
// Shows all properties & values, even non-public
```

## II. PDO (PHP Data Objects)
___

#### [Lesson 12: Production & XML](https://github.com/inkVerb/vip/blob/master/501/Lesson-12.md)
