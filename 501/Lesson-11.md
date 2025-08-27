# Linux 501
## Lesson 11: Objects: OOP & PDO

Ready the CLI

```console
cd ~/School/VIP/501
```

Ready services

Arch/Manjaro, OpenSUSE, RedHat/CentOS
```console
sudo systemctl start httpd mariadb
```

Debian/Ubuntu
```console
sudo systemctl start apache2 mariadb
```

If teaching multiple students

Prep directory
```console
cd ~/School/VIP
```

Webapp database ***dump***
```console
mariadb-dump -u admin -padminpassword blog_db > STUDENT_1/blog_db.sql
```

Webapp database ***restore***
```console
mariadb -u admin -padminpassword blog_db < STUDENT_2/blog_db.sql
```

Backup Student 1 schoolwork directory
```console
rm 501/web
sudo mv /srv/www/html/web 501/
```

```console
mv 501 STUDENT_1/
```

Restore Student 2 schoolwork directory
```console
mv STUDENT_2/501 .
```

```console
sudo mv 501/web /srv/www/html/
sudo chown -R www:www /srv/www/html/web
sudo ln -sfn /srv/www/html/web 501/
sudo chown -R www:www 501/web
```

Re-ready the CLI

```console
cd ~/School/VIP/501
```

### This lesson uses two terminals and two browser tabs!
Ready the secondary SQL terminal and secondary SQL browser (start using at step 19)

*(<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd> for new terminal tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** :$ *(password in the terminal, not safe outside these lessons!)*

```console
mariadb -u admin -padminpassword
```

*(<kbd>Ctrl</kbd> + <kbd>T</kbd> for new browser tab; <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> to switch tabs)*

| **S0** ://phpMyAdmin **> `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`**

*From now on, you may optionally follow along at the SQL prompt and/or phpMyAdmin, but no instructions will be given*

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
$aVariable; // Use a variable
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

This also reflects the basic thinking inside Javascript

#### A. Classes, Objects, Properties & Methods

- **Class** - a framework or blueprint
- **Object** - a class that we start using, including its properties and methods
- **Property** - a variable in a class
- **Method** - a function in a class

Remember, properties and methods are bound to their object and class

| **Normal PHP** : (Not OOP)

```php
return someFunction();
return $someVariable;
```

| **OOP PHP** : (Class syntax, defining inside the class statement)

```php
return $this->someMethod(); // can change
return $this->someProperty; // can change
return self::staticMethod(); // unchanging constant
return self::staticProperty; // unchanging constant
```

| **OOP PHP** : (Object syntax, outside the class statement)

```php
return $someObject->someMethod(); // can change
return $someObject->someProperty; // can change
return someClass::staticMethod(); // unchanging constant
return someClass::staticProperty; // unchanging constant
```

*See how it works...*

| **Define a Class** :

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
code core/11-oop1.php && \
ls web
```

- `Topic` class with three methods:
  - `course`
  - `website`
  - `slogan`
- Use the `Topic` class as the framework to instantiate the object `$topicObject`
- Nothing happens until after line 22; uncomment line 23 to make the script stop

| **B-1** ://

```console
localhost/web/oop.php
```

*Another example...*

| **2** :$

```console
sudo cp core/11-oop2.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop2.php && \
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
  - Use `$this->` inside a class when working with with properties that are part of that class
- You can access both a method and property of an object
  - `$Object->method()`
  - `$Object->property`

*Note the methods don't take many arguments*

| **B-2** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/oop.php
```

#### B. Polymorphism

A complex method

| **3** :$

```console
sudo cp core/11-oop3.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop3.php && \
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

| **B-3** :// (Same)

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
code core/11-oop4.php && \
ls web
```

*Note lines 16-19 (same as the example) would break the script, try uncommenting any of them to watch*

| **B-4** :// (Same)

```console
localhost/web/oop.php
```

*Let's expand...*

| **5** :$

```console
sudo cp core/11-oop5.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop5.php && \
ls web
```

*Note lines 16-19 (same as the example) would break the script, try uncommenting any of them to watch*

| **B-5** :// (Same)

```console
localhost/web/oop.php
```

##### 2. `__destruct()` end of instantiation

| **6** :$

```console
sudo cp core/11-oop6.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop6.php && \
ls web
```

| **B-6** :// (Same)

```console
localhost/web/oop.php
```

Order doesn't matter...

| **7** :$

```console
sudo cp core/11-oop7.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop7.php && \
ls web
```

*Note this has the same contents, but in a random order, but it still executes in order*

| **B-7** :// (Same)

```console
localhost/web/oop.php
```

You can destroy an object by using `unset($object)`

| **8** :$

```console
sudo cp core/11-oop8.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop8.php && \
ls web
```

*Note the object can't be used after it is `unset()`*

| **B-8** :// (Same)

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
// Define the parent
class ParentClass {

  var $parentProperty;

}

// Define the child
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
code core/11-oop9.php && \
ls web
```

*Note line 25 would break the script because the parent object tries to call a child property*

| **B-9** :// (Same)

```console
localhost/web/oop.php
```

*Let's expand...*

| **Inherited Class** : (Properties & methods)

```php
// Define the parent
class ParentClass {

  var $parentProperty;

  function parentMethodSet($arg) {
    $this->$parentProperty = $arg;
  }

  function parentMethodRet() {
    return $this->$parentProperty;
  }

}

// Define the child
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
code core/11-oop10.php && \
ls web
```

*Note lines 44 & 52 would break the script because the parent object tries to call child methods*

| **B-10** :// (Same)

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
code core/11-oop11.php && \
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

| **B-11** :// (Same)

```console
localhost/web/oop.php
```

##### 2. `static` Properties

| **12** :$

```console
sudo cp core/11-oop12.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop12.php && \
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

  - *Lines 77, 79, 89, 91, 101 & 103 break the script because their methods call those non-`static` properties as if they were static*
  - *Reverse-comment lines 9, 10, 37 & 38, then lines 77, 79, 89, 91, 101 & 103 will work*

| **B-12** :// (Same)

```console
localhost/web/oop.php
```

##### 3. `static` Methods

| **13** :$

```console
sudo cp core/11-oop13.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop13.php && \
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

*Note lines 45 & 47 break the script because they call non-`static` methods as if they were static*

| **B-13** :// (Same)

```console
localhost/web/oop.php
```

##### 4. Method Visibility

| **14** :$

```console
sudo cp core/11-oop14.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop14.php && \
ls web
```

| **Set Method Visibility** :

```php
public function publicMethod() { echo "foo"; };
protected function protectedMethod() { echo "foo"; };
private function privateMethod() { echo "foo"; };
```

*Note non-`public` methods can only be used within visibility by other methods of the class, not outside the class statement*

*Note lines 59, 61, 69, 71 & 77 break the script because they call methods outside of visibility scope*

| **B-14** :// (Same)

```console
localhost/web/oop.php
```

##### 5. Constants

| **15** :$

```console
sudo cp core/11-oop15.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop15.php && \
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

| **B-15** :// (Same)

```console
localhost/web/oop.php
```

##### 6. Set `static` & non-`static` Object Properties

| **16** :$

```console
sudo cp core/11-oop16.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop16.php && \
ls web
```

| **Define `static` Object** :

```php
class staticDemo {

  // Returns
  static function say_something($string) {
    return $string;
  }

  // Sets the $answer property
  static $answer;
  static function set_answer($string) {
    self::$answer = $string; // Set $answer
  }

}
```

| **Use `static` Object** :

```php
// Returns
staticDemo::say_something("Hello there, some world!");

// Sets the $answer property
staticDemo::set_answer("Hello there, valued world!");
echo staticDemo::$answer;
```

| **Define `public` Object** :

```php
class nonStaticDemo {

  // Returns
  public function say_something($string) {
    return $string;
  }

  // Sets the $answer property
  public $answer;
  public function set_answer($string) {
    $this->$answer = $string; // Set $answer
  }

}
```

| **Use non-`static` Object** :

```php
// Instantiate
$NonStaticDemo = new nonStaticDemo;

// Returns
$NonStaticDemo->say_something("Hello there, some world!");

// Sets the $answer property
$NonStaticDemo->set_answer("Hello there, valued world!");
echo $NonStaticDemo->$answer;
```

*Note `class staticDemo` is never instantiated...*

| **B-16** :// (Same)

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

| **17** :$

```console
sudo cp core/11-oop17.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop17.php && \
ls web
```

*Note on `$object`, a `foreach` loop iterates `public` `$properties`, but not `methods()` nor non-`public` `$properties`*

| **Define a Class** :

```php
class LoopMe {

  // Properties will show
  var $property1 = "Prop one";
  var $property2 = "Prop two";
  var $property3 = "Prop three";

  // Public will show
  public     $publicProp = "Public Prop";
  
  // Protected and private will not show
  protected  $protectedProp = "Protected Prop";
  private    $privateProp = "Private Prop";

  // Methods will not show
  function cantSeeMe() {
    echo "nothere";
  }
}
```

| **Instantiate an Object and Loop** :

```php
$loop_object = new LoopMe;

foreach ( $loop_object as $property=>$value ) {
    echo "$property = $value<br>";
}
```

| **B-17** :// (Same)

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

| **18** :$

```console
sudo cp core/11-oop18.php web/oop.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-oop18.php && \
ls web
```

*Note on `$object->getDefaultProperties()`, a `foreach` loop iterates all `$properties`, even non-`public` `$properties`, but still not `methods()`*

```php
class LoopMe {

  // Public, protected & private will show
  public     $publicProp = "Public Prop";
  protected  $protectedProp = "Protected Prop";
  private    $privateProp = "Private Prop";

  // Methods will not show
  function cantSeeMe() {
    echo "nothere";
  }
}
```

| **Instantiate an Object and Loop** :

```php
$loop_object = new LoopMe;

// Declare $loop_obj_props
$loop_obj_props = $loop_object->getDefaultProperties();

// Loop through $loop_obj_props with any visibility
foreach ( $loop_obj_props as $property=>$value ) {
    echo "$property = $value<br>";
}
```

| **B-18** :// (Same)

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

#### PDO MySQL Extension

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
mysqli_set_charset($database, 'utf8mb4');
```

| **PDO Config** : (Simple)

```php
$database = new PDO("mysql:host=$db_host; dbname=$db_name; charset=utf8mb4", $db_user, $db_pass);
```

| **PDO Config** : (Readable with Options)

```php
$nameHostChar = "mysql:host=$db_host; dbname=$db_name; charset=utf8mb4";
$opt = [
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH, // Row array is auto-indexed and associated by column name (default)
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Row array is associated by column name only
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_NUM, // Row array is auto-indexed only
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ, // Object built on column names
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

#### Multiple Queries at Once

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

#### Prepare Database for PDO Demo

| **19** :>

```sql
CREATE DATABASE test_pdo;
GRANT ALL PRIVILEGES ON test_pdo.* TO pdo_user@localhost IDENTIFIED BY 'pdopassword';
FLUSH PRIVILEGES;
```

#### Demonstrate

Create a table

| **19** :$

```console
sudo cp core/11-pdo19.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo19.php && \
ls web
```

- Database: `test_pdo`
- User: `pdo_user`
- Password: `pdopassword`

*Note this is one statement:*

| **`$query`** = (Line 26)

```sql
CREATE TABLE IF NOT EXISTS `fruit` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NOT NULL,
  `color` VARCHAR(90) DEFAULT NULL,
  `locale` VARCHAR(128) DEFAULT NULL,
  `market` VARCHAR(128) DEFAULT NULL,
  `date_updated` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

| **Run Query** : (Line 37)

```php
$statement = $database->query($query);
```

| **Test Query** : (Line 46)

```php
if ($statement) // Value above returns boolean
```

| **B-19** ://

```console
localhost/web/pdo.php
```

*The webpage should display `$statement` & a "Created..." message including the query above*

*Note:*

- *`$statement` returned `true`, but if we `echo` it, PHP would break*

Run multiple queries

| **20** :$

```console
sudo cp core/11-pdo20.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo20.php && \
ls web
```

*Note we run a query for **multiple SQL statements** differently:*

| **Run Multiple Statements** : (processed via `$statement =` on line 32)

```php
$query = "
START TRANSACTION;
INSERT INTO fruit (name) VALUES ('apple');
INSERT INTO fruit (name) VALUES ('kiwi');
COMMIT;
";

// $statement returns affected rows, unpredictable in multiple statements
$statement = $database->exec($query);
```

*This will behave differently...*

```php
$query = "INSERT INTO fruit (name) VALUES ('apple')";

// $statement success returns true
$statement = $database->query($query);
```

*Remember `$database->exec($query)` is for executing multiple SQL statements, such as on a database update or app installation*

- *From [PHP docs](https://www.php.net/manual/en/pdo.exec.php) we learn `exec()` returns the number of affected rows*
- *The last statement is SQL query is `COMMIT;`, affecting 0 rows*
- *So, `exec()` can't be used to test success of multiple SQL statements*
  - `echo ($database->exec($multiquery)) ? 'success' : 'fail'` *will always fail*
  - *This is why the ternary statement on line 38 failed when everything else worked*
    - `($statement)` *(38)* `=` `->exec($query);` *(32)*
- *If we only want one SQL statement, use `query()` instead of `exec()`*
  - *That could be tested for success by the ternary statement on line 38*
- *To test the database success of multiple rows, test the actual database, which we do after line 38...*

| **Query Check** : (Check database for what you want)

```php
$query = "SELECT * FROM fruit WHERE name = 'kiwi'";
$statement = $database->query($query);
if ($statement->rowCount() > 0)
```

*Note lin 49 combines `if` with `try`*

```php
if ($success) try {}
```

| **B-20** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/pdo.php
```

*Note:*

- *`$statement` returns `0`*
- *`$success` was built on several ternary statements; any fail would return `false`*

Retrieve from the database

| **21** :$

```console
sudo cp core/11-pdo21.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo21.php && \
ls web
```

*See how we retrieve and handle numbered rows...*

```php
try {
  $query = "SELECT * FROM fruit";
  $statement = $database->query($query);
} catch (PDOException $error) {
  pdo_error($query, $error->getMessage());
}

while ($row = $statement->fetch(PDO::FETCH_NUM)) {
  $f_name = "$row[1]";
  $f_color = "$row[2]";
  $f_locale = "$row[3]";
  $f_market = "$row[4]";
  echo "Name: $f_name Color: $f_color Farm: $f_locale Sold in: $f_market<br>";
}
```

| **B-21** :// (Same)

```console
localhost/web/pdo.php
```

*Note only "name" returns, "color", "locale", and "marker" are empty*

Update tables

| **22** :$

```console
sudo cp core/11-pdo22.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo22.php && \
ls web
```

*A test will pass because we use `->query($query)`, not `->exec($query)`...*

```php
try {
  $query = "UPDATE fruit SET color='green', locale='Japan', market='global' WHERE name='apple'";
  $statement = $database->query($query);
} catch (PDOException $error) {
  pdo_error($multiquery, $error->getMessage());
}

// If you echo $statement on success, PHP will break because $statement is an object
echo ($statement) ? "\$statement 'apple' success" : "\$statement fail: $statement";

// Watch us access the ->rowCount() method in the $statement object
if ($statement) {
  echo "
  Affected rows: ".$statement->rowCount()."<br>
  ";
}
```

| **B-22** :// (Same)

```console
localhost/web/pdo.php
```

Fun with `SELECT`

*Previously (pdo21.php line 32), we defined the `fetch()` mode for numbers*

```php
fetch(PDO::FETCH_NUM)
```

*We could also define the mode for associative keys...*

```php
fetch(PDO::FETCH_ASSOC)
```

*Note the `fetch()` mode is already defined `FETCH_BOTH` on line 14*

```php
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH,
```

*So, simple `fetch()` returns both associative and numbered (auto-indexed) arrays*

```php
fetch()
```

| **`fetch()` modes** :

```php
// (Default) Both associative and numbered
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH, // Option
$statement->fetch(PDO::FETCH_BOTH); // Per use

// Associative array from column names
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Option
$statement->fetch(PDO::FETCH_ASSOC); // Per use

// Numbered (auto-indexed) array
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_NUM, // Option
$statement->fetch(PDO::FETCH_NUM); // Per use

// Object built on column names
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ, // Option
$statement->fetch(PDO::FETCH_OBJ); // Per use
```

*Note you can read all about more `fetch()` modes at [PHP.net PDOStatement:fetch](https://www.php.net/manual/en/pdostatement.fetch.php)*

| **23** :$

```console
sudo cp core/11-pdo23.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo23.php && \
ls web
```

*Note we `SELECT` rows many times, many ways*

- **1:** default is `FETCH_BOTH`, we use numbered
- **2:** default is `FETCH_BOTH`, we use associative
- **3:** default is `FETCH_BOTH`, we use both
- **4:** set mode is `FETCH_OBJ`, we use an object

| **B-23** :// (Same)

```console
localhost/web/pdo.php
```

*Compare the usage: Which is easier?*

| **Numbered Array** :

```php
  $f_name = "$row[1]";
  $f_color = "$row[2]";
  $f_locale = "$row[3]";
  $f_market = "$row[4]";
  echo "Name: $f_name Color: $f_color Farm: $f_locale Sold in: $f_market<br>";
```

| **Associative Array** :

```php
$f_name = "$row[name]";
$f_color = "$row[color]";
$f_locale = "$row[locale]";
$f_market = "$row[market]";
echo "Name: $f_name Color: $f_color Farm: $f_locale Sold in: $f_market<br>";
```

| **Object** :

```php
echo "Name: $row->name Color: $row->color Farm: $row->locale Sold in: $row->market<br>";
```

#### *PHP objects work well with PDO database queries*

From now on, we will use object queries:

```php
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ, // Option
$statement->fetch(); // Per use
```

### III. PDO wtih OOP

We will build classes and methods to handle database queries for clean code

| **Database Connection (Procedural)** : (pdo24.php)

```php
$db_name = 'test_pdo';
$db_user = 'pdo_user';
$db_pass = 'pdopassword';
$db_host = 'localhost';

$nameHostChar = "mysql:host=$db_host; dbname=$db_name; charset=utf8mb4";
$opt = [
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
];
$database = new PDO($nameHostChar, $db_user, $db_pass, $opt);

// Usage
$statement = $database->query($query);
```

| **Database Connection (OOP)** : (pdo24.php)

```php
class DB {
  private $db_name = 'test_pdo';
  private $db_user = 'pdo_user';
  private $db_pass = 'pdopassword';
  private $db_host = 'localhost';

  public function conn() {
    $nameHostChar = "mysql:host=$this->db_host; dbname=$this->db_name; charset=utf8mb4";
    $opt = [
      PDO::ATTR_EMULATE_PREPARES => false,
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
    ];
    $database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
    return $database;
  }
}
// Instantiate
$pdo = new DB;
// Usage
$statement = $pdo->conn()->query($query);
```

*Note the differences in the next two files, how procedural and OOP achieve the same thing...*

*Note the actual query building in our webpage will come before the `// Use //` line*

#### Procedural Config

We have been using procedural PHP for our database config

| **Procedural Database Config** :

```php
$db_name = 'test_pdo';
$db_user = 'pdo_user';
$db_pass = 'pdopassword';
$db_host = 'localhost';

$nameHostChar = "mysql:host=$db_host; dbname=$db_name; charset=utf8mb4";
$opt = [
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
];
$database = new PDO($nameHostChar, $db_user, $db_pass, $opt);
```

| **24** :$

```console
sudo cp core/11-pdo24.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo24.php && \
ls web
```

*Note our object setting `PDO::FETCH_OBJ` on line 12*

```php
PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
```

*Note 4 lines to handle the query below `// Use //`*

```php
$query = "SELECT * FROM fruit WHERE name='apple'";
$statement = $database->query($query);
$val = $statement->fetch();
echo $val->color;
```

*Note the `$statement` is built with a single method (`->$query()`)*

| **B-24** :// (Same)

```console
localhost/web/pdo.php
```

*That script only returns the color, one word*

#### OOP Config

We can use OOP for the database config

| **OOP Database Config** :

```php
class DB {
  private $db_name = 'test_pdo';
  private $db_user = 'pdo_user';
  private $db_pass = 'pdopassword';
  private $db_host = 'localhost';

  public function conn() {
    $nameHostChar = "mysql:host=$this->db_host; dbname=$this->db_name; charset=utf8mb4";
    $opt = [
      PDO::ATTR_EMULATE_PREPARES => false,
      PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
      PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
    ];
    $database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
    return $database;

  } // conn()
} // class DB

$pdo = new DB; // Instantiate
```

*An OOP database config more complex, but building on it makes query work easier*

| **25** :$

```console
sudo cp core/11-pdo25.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo25.php && \
ls web
```

*Note 4 lines to handle the query below `// Use //`*

```php
$query = "SELECT * FROM fruit WHERE name='apple'";
$statement = $pdo->conn()->query($query);
$val = $statement->fetch();
echo $val->color;
```

*Note the `$statement` is built differently with OOP (`->conn()->query()`)*

| **B-25** :// (Same)

```console
localhost/web/pdo.php
```

*Same as before, the OOP script only returns the color, one word*

#### Query Method: `SELECT`

| **`select()` method** :

```php
public function select($table, $wcol, $vcol, $cols='*') {
  $query = "SELECT $cols FROM $table WHERE $wcol='$vcol'";
  $statement = $this->conn()->query($query);
  return $statement->fetch();
}

// Instantiate
$pdo = new DB;

// Usage
$val = $pdo->select($table, $where_col, $where_value, $columns);
```

| **26** :$

```console
sudo cp core/11-pdo26.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo26.php && \
ls web
```

*Note 2 lines (not 4) to handle the query below `// Use //`*

```php
$val = $pdo->select('fruit', 'name', 'apple');
echo $val->color;
```

| **B-26** :// (Same)

```console
localhost/web/pdo.php
```

*This script displays both the SQL query and the one-word value for `->color`*

#### Query Method: `UPDATE`

*Note `preg_split()` can put a comma-delimited list into an array while also removing whitespace*

```php
$cols_array = preg_split('~,\s*~', $cols);
// ...same as...
$cols = preg_replace("/,([\s])+/",",",$cols); // Remove whitespace
$cols_array = explode(",", $cols); // $string to array()
```

| **`update()` method** :

```php
public function update($table, $cols, $vals, $wcol, $vcol) {

  // Handle $cols & $vals to match SQL syntax by mix-matching arrays
  $cols_arr = preg_split('~,\s*~', $cols);
  $vals_arr = preg_split('~,\s*~', $vals);
  $set_array = array_combine($cols_arr, $vals_arr);
  $set_statement = "";
  foreach ( $set_array as $k => $v ) {
    $set_statement .= "$k='$v',";
  }
  $set_statement = rtrim($set_statement, ',');

  $query = "UPDATE $table SET $set_statement WHERE $wcol='$vcol'";
  $statement = $this->conn()->query($query);

  return $statement->fetch();
}

// Instantiate
$pdo = new DB;

// Usage
$val = $pdo->update($table, $columns, $values, $where_col, $where_value);
```

*Note moving `'one, two', 'a, b'` to `one='a', two='b'` requires some mixing and matching through arrays*

- *We do this through:*
  - `preg_split()` string to array beautifully
  - `array_combine()` combine two arrays to one array with [$key]=$value
    - `'one, two'` & `'a, b'` --> `[one]=a, [two]=b`
  - `foreach($array as $key => $value)` handle matching keys & values for easy mixing in our new string
  - `rtrim()` remove the last `,` we got from the `foreach` loop

*This is a teachable moment for how arrays can be remarkably useful*

| **27** :$

```console
sudo cp core/11-pdo27.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo27.php && \
ls web
```

*Note we run a `SELECT` query, then `UPDATE`, then `SELECT` again to show the changes, then yet again, changing two columns*

*This is how simple our queries become using PDO with an OOP database config*

```php
// SELECT
$val = $pdo->select('fruit', 'name', 'apple');
echo "$val->name $val->color $val->locale $val->market";

// UPDATE
$val = $pdo->update('fruit', 'color', 'red', 'name', 'apple');
```

| **B-27** :// (Same)

```console
localhost/web/pdo.php
```

#### Query Methods: `INSERT` & `DELETE`

| **Global properties** :

```php
public $change;
public $lastid;
```

| **`insert()` method** :

```php
public function insert($table, $cols, $vals) {
  $query = "INSERT INTO $table ($cols) VALUES ($vals)";
  $statement = $this->conn()->query($query);
  $this->change = ($statement->rowCount() == 1) ? true : false;
}

// Instantiate
$pdo = new DB;

// Usage
$pdo->insert($table, $columns, $values);
echo ($pdo->change) ? "Stuff changed<br>" : "No change<br>";
```

| **`delete()` method** :

```php
public function delete($table, $col, $val) {
  $query = "DELETE FROM $table WHERE $col='$val'";
  $statement = $this->conn()->query($query);
  $this->change = ($statement->rowCount() > 0) ? true : false;
}

// Instantiate
$pdo = new DB;

// Usage
$pdo->delete($table, $column, $value);
echo ($pdo->change) ? "Stuff changed<br>" : "No change<br>";
```

| **28** :$

```console
sudo cp core/11-pdo28.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo28.php && \
ls web
```

*Note the simple `DELETE` function...*

```php
// DELETE
$pdo->delete('fruit', 'name', 'banana');
echo ($pdo->change) ? "Change" : "No change";
```

*Note the `$pdo->change` & `$pdo->lastid` global properties to test query success*

- *(`$pdo->lastid` will fail)*

| **B-28** :// (Same)

```console
localhost/web/pdo.php
```

*We don't see the entry in phpMyAdmin or the SQL terminal because the row was inserted then deleted in the same PHP script*

*Note `$pdo->change` works, but `$pdo->lastid` returns `0` and does not show the last new ID*

  - *This is because the database is within a method within an object*
  - *Will fail: `$this->lastid = $this->conn()->lastInsertId();`*
  - *Will work: `$this->lastid = $database->lastInsertId();`*

*The database connection is an object...*

| **Database instantiation** :

```php
$database = new PDO($nameHostChar, $db_user, $db_pass, $opt);
```

| **Fails** :

```php
// Database object within a method inside the object:
function conn() {
  ...
  $database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
  return $database;
}
$this->conn()->query($query); // Object from inside conn() is limited

// Failed test:
$this->lastid = $this->conn()->lastInsertId();
```

*Using an object within an object puts a limit on what can be accessed*

```php
// Access object within method within object:
$this->conn()->query($query); // What we did

// Access object directly:
$database->query($query); // What we need
```

*To access deeper information from the database object, we must remove the database statement from the class and make it an object unto itself*

| **Works** :

```php
// Database as object:
$database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
$database->query($query); // Stand alone object can be fully accessed

// Successful test:
$this->lastid = $database->lastInsertId();

// Put this inside every method that calls DBO:
global $database;
```

#### Full Checks

| **`esc()` & `pdo_error()` methods** :

```php
// Escape method
static function esc($data) {
  $trimmed_data = trim(preg_replace('/\s+/', ' ', $data));
  return PDO::quote($trimmed_data);
}

// PDO error handler
protected function pdo_error($query, $error_message) {
  echo "SQL error from <pre>$query</pre><br>$error_message";
  exit();
}
```

| **`try` statements** : (all queries)

```php
try {
  $statement = $this->conn()->query($query);
} catch (PDOException $error) {
  $this->pdo_error($query, $error->getMessage());
}
```

*With `try`-`catch` statements, our PHP won't need a test for whether an SQL query merely worked*

  - *We only need to test if rows has a `$change` and/or retrieve `$this->lastid`*
  - *If something didn't work, `pdo_error()` will throw an error message anyway*
  - *So, we won't do this: `if ($statement) {...}` as we did in procedural PHP*

| **29** :$

```console
sudo cp core/11-pdo29.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo29.php && \
ls web
```

Inside a `class`:

```php
public $lastid;
$this->lastid = ...;
```

...becomes outside the `class`:

```php
$lastid
```

Failed in pdo28.php:

```php
function conn() {
  ...
  $database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
  return $database;
}
$this->conn()->query($query);
$this->lastid = $this->conn()->lastInsertId();
```

Works in pdo29.php:

```php
$database = new PDO($nameHostChar, $this->db_user, $this->db_pass, $opt);
$database->query($query);
$this->lastid = $database->lastInsertId();
```

*Declaring the database connection variables outside the class allows us to put those settings inside a separate config file, and to access more in our `$database` object*

*Note every method now has `global $database;` because `conn()` is no longer in the class, which is what we were using before*

*For fun, change the arguments for `select()`, `insert()`, and `delete()` methods where HTML renders at the end of the file*

  - *Both in pdo29.php & `pdo28.php`*
  - *Observe how errors are handled differently with `pdo_error()`*

| **B-29** :// (Same)

```console
localhost/web/pdo.php
```

*Same results, except "Last new ID:" doesn't fail, but reports accurately*

*We still don't see the entry in phpMyAdmin or the SQL terminal because the row was inserted then deleted in the same PHP script, but the ID has incremented up*

#### `SELECT` Multiple Rows

To retrieve multiple rows, we need `fetchAll()`, which doesn't work with `query()`

| **`query()` & `fetch()`** :

```php
$statement = $database->query($query);
return $statement->fetch();
```

We need `prepare()` & `execute()`

| **`prepare()`, `execute()` & `fetchAll()`** :

```php
$statement = $database->prepare($query);
$statement->execute();
return $statement->fetchAll();
```

| **`selectmulti()` method** : (to return multiple rows)

```php
public function selectmulti($table, $cols = '*', $wcol = '*', $vcol = '*') {
  global $database;

  $query = "SELECT $cols FROM $table";
  $query .= (($wcol == '*') || ($vcol == '*')) ?
  "" :
  " WHERE $wcol='$vcol'";

  try {
    $statement = $database->prepare($query);
    $statement->execute();
  } catch (PDOException $error) {
    $this->pdo_error($query, $error->getMessage());
  }

  return $statement->fetchAll();
}

// Instantiate
$pdo = new DB;

// Usage
$val = $pdo->selectmulti($table, $columns, $where_col, $where_value);
foreach ($val as $one) { echo "Some Col: $one->some_col<br>"; }
```

| **30** :$

```console
sudo cp core/11-pdo30.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo30.php && \
ls web
```

*Note near the end, the simple `SELECT` function for returning multiple rows...*

```php
$val = $pdo->selectmulti('fruit');
foreach ($val as $one) {}
```

| **B-30** :// (Same)

```console
localhost/web/pdo.php
```

*phpMyAdmin and the SQL terminal still don't show entries inserted and deleted, but the "Last new ID:" keeps incrementing*

#### Multiple `AND` with `SELECT` Multiple Rows

*Note we mix and match arrays for multiple `AND` arguments, much how we did with `update()` in `pdo26.php`*

| **`selectcomplex()` method** :

```php
public function selectcomplex($table, $wcols, $vcols, $cols = '*') {
  global $database;

  $wcols_arr = preg_split('~,\s*~', $wcols);
  $vcols_arr = preg_split('~,\s*~', $vcols);
  $where_array = array_combine($wcols_arr, $vcols_arr);
  $where_statement = "";
  foreach ( $where_array as $k => $v ) {
    $where_statement .= "$k='$v' AND ";
  }
  $where_statement = rtrim($where_statement, ' AND '); // remove last AND

  $query = "SELECT $cols FROM $table WHERE $where_statement";
  try {
    $statement = $database->prepare($query);
    $statement->execute();
  } catch (PDOException $error) {
    $this->pdo_error($query, $error->getMessage());
  }

  return $statement->fetchAll();
}

// Instantiate
$pdo = new DB;

// Usage
$val = $pdo->selectmulti($table, $where_col_list, $where_value_list, $columns);
foreach ($val as $one) { echo "Some Col: $one->some_col<br>"; }
```

| **31** :$

```console
sudo cp core/11-pdo31.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo31.php && \
ls web
```

*Note use of the `SELECT` function with multiple criteria*

```php
$val = $pdo->selectcomplex('fruit', 'name', 'apple');
foreach ($val as $one) {}
```

*...that function can make several complex inquiries quite easy to code*

| **B-31** :// (Same)

```console
localhost/web/pdo.php
```

*phpMyAdmin and the SQL terminal still don't show entries inserted and deleted, but the "Last new ID:" keeps incrementing*

#### `execute()` Arguments

The `execute()` method can take arguments, making SQL less hackable

| **`execute()` Argument** :

```php
$query = "SELECT * FROM fruit WHERE name = ?"; // ? becomes $arg in execute([$arg])
$statement = $database->prepare($query);
$statement->execute([$arg]); // $arg replaces ? in $query
```

| **Multiple `execute()` Arguments** :

```php
$query = "SELECT * FROM fruit WHERE name = ? AND color = ?"; // 2 arguments
$statement = $database->prepare($query);
$statement->execute([$arg1, $arg2]); // $arg1, $arg2 (respectively)
```

| **Build `execute()` Arguments Array** :

```php
public $change;

public function update($table, $cols, $vals, $wcol, $vcol) {
    global $database;

    // Build $vals_arr through arrays and loops
    $cols_arr = preg_split('~,\s*~', $cols);
    $vals_arr = preg_split('~,\s*~', $vals);
    $set_array = array_combine($cols_arr, $vals_arr);
    $set_statement = "";
    foreach ( $set_array as $k => $v ) {
      $set_statement .= "$k=?,";
    }
    $set_statement = rtrim($set_statement, ',');

    $query = "UPDATE $table SET $set_statement WHERE $wcol='$vcol';";

    try {
      $statement = $database->prepare($query);
      $statement->execute($vals_arr);
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    $this->change = ($statement->rowCount() > 0) ? true : false;

    return $statement->fetch();
  }
```

Security:

- These arguments are used for user-input
- PDO will not allow these arguments to contain SQL language
- This is yet another measure making SQL injections nearly impossible

If there is no `?` argument placeholder, `execute()` must be empty

| **`selectmulti()`** : (Excerpt example)

```php
// When building a complex query
$query = "SELECT * FROM table";
$query .= ($arg == '*') ? "" : " WHERE some_column = ?";

// Fails if $arg = '*'
$statement->execute([$arg]);

// Ternary statement to decide which to execute
($arg == '*') ? $statement->execute() : $statement->execute([$arg]);
```

| **32** :$

```console
sudo cp core/11-pdo32.php web/pdo.php && \
sudo chown -R www:www /srv/www/html && \
code core/11-pdo32.php && \
ls web
```

*Note many `->query` uses are replaced with `->execute` for security*

*Note the `public function insert(...)` function uses `$statement->execute($vals_arr);` as an*

*These functions help build complete `->execute()` statements with simple functions...*

```php
$pdo->insert('fruit', 'name, color, locale, market', "banana, green, Thailad, Southeast Asia");
$val = $pdo->update('fruit', 'color, locale', 'blue, Florida', 'name', 'apple');
```

| **B-32** :// (Same)

```console
localhost/web/pdo.php
```

*phpMyAdmin and the SQL terminal still don't show entries inserted and deleted, but the "Last new ID:" keeps incrementing*

*In out live webapp, we will use `PDO::prepare()` & `PDO::execute()` methods*

- *This is the alternative to `mysqli_real_escape_string()`, with two benefits:*
  - *It is more secure*
  - *It is compatible across SQL drivers (not only MySQL, SQLite, etc)*

### IV. Rebuild Webapp for PDO

We will rebuild our blog CMS to access SQL with PDO rather than MySQLi

*Assuming we initiate with:* `$pdo = new DB;`...

- *in.db.php:*
  - $ `code pdo/in.db.php mysqli/in.db.php`
  - *Methods:*
    - `$pdo->delete()` *for simple conditions*
    - `$pdo->select()` *for simple conditions*
    - `$pdo->update()` *loops through lists with `bindParam()`*
    - `$pdo->key_` *prefix for `BINARY` calls*
    - `$pdo->exec_()` *complex queries that need `bindParam()`*

  - *Properties we will use often:*
    - `$pdo->change` *boolean check for SQL changes*
    - `$pdo->lastid` *integer for newest SQL id*
    - `$pdo->rows` *integer for number of rows*
    - `$pdo->ok` *boolean check for success*
  - *`static` method*
    - `DB::trimspace()` *removes white space, intended for `INSERT`/`UPDATE` calls*
  - *`protected` method we can't use*
    - `$this->pdo_error()`

- *Good examples to note changes in:*
  - *`in.metaeditfunctions.php`*
  - $ `code pdo/webapp.php mysqli/in.metaeditfunctions.php`
  - $ `diff pdo/webapp.php mysqli/in.metaeditfunctions.php`
  - *Note we added `global $pdo;` because the piecesaction() function will need to use the `DB` class's `$pdo` object for `$pdo->exec_()` calls*
  - *`webapp.php`*
    - $ `code pdo/webapp.php mysqli/webapp.php`
    - $ `diff pdo/webapp.php mysqli/webapp.php`
  - *`blog.php`*
    - $ `code pdo/blog.php mysqli/blog.php`
    - $ `diff pdo/blog.php mysqli/blog.php`
  - *in.editprocess.php (elaborate)*
    - $ `atom pdo/in.editprocess.php mysqli/in.editprocess.php`
    - $ `diff pdo/in.editprocess.php mysqli/in.editprocess.php`
  - *Any file, in both pdo/ and mysqli/*
  - *`grep` for PDO in use*
    - $ `grep -R 'DB::trimspace(' pdo/*`
    - $ `grep -R '$pdo->delete(' pdo/*`
    - $ `grep -R '$pdo->select(' pdo/*`
    - $ `grep -R '$pdo->update(' pdo/*`
    - $ `grep -R '$pdo->key_' pdo/*`
    - $ `grep -R '$pdo->change' pdo/*`
    - $ `grep -R '$pdo->lastid' pdo/*`
    - $ `grep -R '$pdo->rows' pdo/*`
    - $ `grep -R '$pdo->ok' pdo/*`

#### Prepared statements for security `prepare()`, `bind()`, `execute()`

##### Basic PDO Call

| **Single PDO Script** :

```php
// Prepare the query
$query = $database->prepare("SELECT * FROM table WHERE id=:id");
$query->bindParam(':id', $id_val);

try {
  $query->execute();
} catch (PDOException $error) {
  $query->pdo_error($query, $error->getMessage());
}

// Assign values
foreach ($query as $row) {
  $type = "$row->type";
  $status = "$row->status";
}

// Other properties
$query->rowCount(); // Number of rows returned or changed
$query->fetchAll(); // All rows in 3D array
($query) ? true : false; // Test of success
$database->lastInsertId(); // Last inserted ID
```

##### Method Implementation

| **PDO Class & Method**

```php
class DB {
  public $rowcount;
  public $change;
  public $lastid;
  public $ok;

  public function exec_($query) {

    try {
      $query->execute();
    } catch (PDOException $error) {
      $query->pdo_error($query, $error->getMessage());
    }

    // Useful properties
    $this->rowcount = $query->rowCount();
    $this->change = ($query->rowCount() > 0) ? true : false;
    $this->ok = ($query) ? true : false;
    $this->database; // We need this for the next statement to work
    $this->lastid = $database->lastInsertId();

    // Return
    return $query->fetchAll();

  } // exec_()
} // class DB
```

| **PDO Method Implementation**

```php
// Prepare
$query = $database->prepare("SELECT * FROM table WHERE id=:id");
$query->bindParam(':id', $id_val);

// Execute via static method
$rows = $pdo->exec_($query);

// Retrieve
if ($pdo->rowcount > 0) {
  foreach ($rows as $row) {
    $type = "$row->type";
    $status = "$row->status";
  } // foreach
} // if

// Useful under various circumstances
$piece_id = $pdo->lastid;
$num_rows = $pdo->rowcount;
$success = ($pdo->ok) ? true : false;
$updated = ($pdo->change) ? true : false;
```

*Let's see the changes in action...*

### V. Webapp via PDO

Start fresh and prepare the fuller blog webapp for this lesson and the next

| **33** :>

```sql
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON blog_db.* TO blog_db_user@localhost IDENTIFIED BY 'blogdbpassword';
FLUSH PRIVILEGES;
```

| **34** :$

```console
sudo rm -rf web/* && \
sudo cp -r pdo/* web/ && \
sudo mv web/htaccess web/.htaccess && \
git clone https://github.com/inkverb/tinymce-dist.git && \
sudo mv tinymce-dist web/tinymce && \
git clone https://github.com/inkverb/dropzone.git && \
sudo cp dropzone/dist/min/dropzone.min.css web/ && \
sudo cp dropzone/dist/min/dropzone.min.js web/ && \
rm -rf dropzone && \
git clone https://github.com/poetryisCODE/htmldiff.git && \
sudo cp htmldiff/htmldiff.min.js web/ && \
rm -rf htmldiff && \
sudo mkdir -p web/media/docs web/media/audio web/media/video web/media/images web/media/uploads web/media/original/images web/media/original/video web/media/original/audio web/media/original/docs web/media/pro && \
sudo chown -R www:www /srv/www/html && \
ls web
```

| **B-34a** :// (fill-in from below)

```console
localhost/web/install.php
```

*Fill in the form with...*

**Database info:** (We created in step 33)

```
Database name: blog_db
Database username: blog_db_user
Database password: blogdbpassword
Database host: localhost
```

**Admin user:** (So we can remember)

```
Name: Jon Boy
Username: jonboy
Email: jon@verb.vip
Favorite number: 12
Password: My#1Password
...Or, fill-out with anything you will remember
```

*You should be re-directed to login...*

*Log in and doodle around to see that everything works just as before*

| **B-34b** :// ("Login" link redirects here, login with above credentials)

```console
localhost/web/webapp.php
```

*If you get any kind of "SQL" error message on the first login try only, it is a ghost cookie from the previous webapp thinking it is still logged in and is automatically cleared by `in.logincheck.php`*

#### Webapp Upgrades
*Now that we have a PDO-based CMS, let's add a few enhancements...*

<!--
# DEV
Continue from here
-->

| **35** :$

```console
sudo cp -r pdo-upgrade/* web/ && \
sudo mv web/htaccess web/.htaccess && \
sudo chown -R www:www /srv/www/html && \
ls pdo-upgrade
```

*Note the many new files and sections referred to below...*

| **B-35** :// (Note no .php file in the URL)

```console
localhost/web/
```

#### AJAX Security

To this point, we have not implemented the [AJAX security](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/AJAX-security.md) discussed at the end of [Lesson 6](https://github.com/inkVerb/vip/blob/master/501/Lesson-06.md)

Now, we will implement security tokens in our AJAX forms

*Create a universal token, but only once for all*

| **in.db.php** :

```php
// Create the AJAX token, only if it doesn't already exist
if ( empty($_SESSION["ajax_token"]) ) {
  $ajax_token = bin2hex(random_bytes(64));
  $_SESSION["ajax_token"] = $ajax_token;
} else {
  $ajax_token = $_SESSION['ajax_token'];
}
```

*Add the token to every AJAX request*

| **sending_from_form.php** :

```js
function ajaxForm(form_id) {
  ...
  AJAX.open(...);

  FD.append('ajax_token', '<?php echo $ajax_token; ?>');
  
  AJAX.send(FD);
}
```

| **sending_simple_array.php** :

```js
AJAX.send("item_1="+<?php echo $item_1; ?>+"&ajax_token=<?php echo $ajax_token; ?>");
```

*Check the token with the AJAX handler*

| **ajax.handler.php** :

```php
if ( $_POST['ajax_token'] !== $_SESSION['ajax_token'] ) {
  exit();
}
```

*Affected files, for your consideration:*

- *ajax.\*.php*
- *`in.head.php`*
- *`edit.php`*
- *`pieces.php`*
- *`medialibrary.php`*
- *`in.editseries.php`*
- *`in.metaeditfunctions.php`*
- *`in.series.php`*
- *`recover.php`*

#### Slugs in URL

*Links to series and individual pieces use "pretty" URL slugs, reflected throughout the code*

- *Main Blog page is simply `/`*
- *Pieces are simply `/slug-of-piece`*
- *Series are `/series/slug-of-series`*

| **.htaccess** :

```
# Blog main page
RewriteRule ^/$ blog.php [L]
RewriteRule ^/\?r=?([0-9]+)$ blog.php?r=$1 [L]

# Series
RewriteRule ^series/?([a-zA-Z0-9-]+)$ blog.php?s=$1 [L]
RewriteRule ^series/?([a-zA-Z0-9-]+)/r=([0-9])$ blog.php?s=$1&r=$2 [L]
```

#### Blog Settings
Access Blog Settings via "Settings" from the header navigation row

*Try uploading to "Site Images" from the "501/blog_uploads" folder*

*See changes in:*

  - *`settings.php`*
  - *`in.functions.php`*
  - *`in.checks.php`*

*See our new database table and global variables*

```sql
CREATE TABLE IF NOT EXISTS `blog_settings` (
  `web_base` VARCHAR(2048) NOT NULL,
  `public` BOOLEAN NOT NULL DEFAULT true,
  `title` VARCHAR(90) DEFAULT '501 Blog',
  `tagline` VARCHAR(120) DEFAULT 'Where code stacks',
  `description` LONGTEXT DEFAULT 'Long, poetic explanations of blog contents are useful in search engines, podcasts, and other places on the interwebs.',
  `keywords` LONGTEXT DEFAULT NULL,
  `summary_words` INT UNSIGNED DEFAULT 50,
  `piece_items` INT UNSIGNED DEFAULT 10,
  `feed_items` INT UNSIGNED DEFAULT 20,
  `default_series` INT UNSIGNED DEFAULT 1,
  `crawler_index` ENUM('index', 'noindex') DEFAULT 'index'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
```

| **in.db.php** :

```php
// Retrieve Blog Settings
$query = $database->prepare("SELECT public, title, tagline, description, keywords, summary_words, piece_items, feed_items, crawler_index FROM blog_settings");
$rows = $pdo->exec_($query);
foreach ($rows as $row) {
  $blog_public = "$row->public";
  $blog_title = "$row->title";
  $blog_tagline = "$row->tagline";
  $blog_description = "$row->description";
  $blog_keywords = "$row->keywords";
  $blog_summary_words = "$row->summary_words";
  $blog_piece_items = "$row->piece_items";
  $blog_feed_items = "$row->feed_items";
  $blog_crawler_index = "$row->crawler_index";
}
```

| **in.conf.php** :

```php
$blog_web_base = 'http://localhost/web'; // from install.php:$web_base
```

*...which was created by `install.php`*

| **install.php** :

```php
// Web base URL
$page = '/install.php';
$protocol = stripos($_SERVER['SERVER_PROTOCOL'],'https') === 0 ? 'https://' : 'http://';
$web_base = $protocol . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$web_base = preg_replace('/'. preg_quote($page, '/') . '$/', '', $web_base);
```

#### SEO

*These `<meta>` tags are common for search engines to understand your web page*

*These could be customized per each piece, but this is a start*

| **in.head.php** :

```php
if ($seo_inf == true) {
  $media_base = "$blog_web_base/media/pro/";
  $blog_seo = (file_exists("$media_base/pro-seo.jpg")) ? "pro-seo.jpg" : "" ;
  $favicon = (file_exists("$media_base/pro-favicon.png")) ? "pro-favicon.png" : "" ;
  echo <<<EOF
  <link href="$blog_web_base/" rel="canonical" />
  <link rel="shortcut icon" type="image/png" href="$media_base/$favicon" />
  <meta name="robots" content="$blog_crawler_index, nofollow" />
  <meta name="description" content="$blog_description" />
  <meta property="og:url" content="$blog_web_base/" />
  <meta property="og:title" content="$blog_title" />
  <meta property="og:image" content="$media_base/$blog_seo" />
  <meta property="og:type" content="website" />
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
EOF;
}
```

#### Series

To open the Series Editor, click on "Edit all series" in:

- Blog Settings
- Pieces
- Editing any piece

*Try uploading RSS & Podcast images from the "501/blog_uploads" folder*

| **in.db.php** :

```php
// Set a default Series from the blog_settings table
$query = $database->prepare("SELECT default_series FROM blog_settings");
$rows = $pdo->exec_($query);
if ($query->numrows == 1) {
  foreach ($rows as $row) {
    $de_series = $row->default_series;
  }
}
```

| **.htaccess** :

```
RewriteRule ^series/?([a-zA-Z0-9-]+)$ blog.php?s=$1 [L]
RewriteRule ^series/?([a-zA-Z0-9-]+)/r=([0-9])$ blog.php?s=$1&r=$2 [L]
```

*Note these rules will break relative paths, such as `style.css`*

- *If we use <link href="style.css"/>*
- *And we load "localhost/web/series/something"*
- *Then HTML will look for the file "localhost/web/series/something/style.css"*

*So, we must use an absolute path to style.css in the header...*

| **in.head.php** :

```php
<link href="<?php echo $blog_web_base;?>/style.css" rel="stylesheet" type="text/css" />
```

*We edit series information here...*

| **ajax.editseries.php** :

*Note the main section where we handle an RSS image upload*

```php
// RSS feed
$rss_info = ($_FILES["pro-rss"]["tmp_name"]) ? getimagesize($_FILES["pro-rss"]["tmp_name"]) : false;
if ($rss_info) {
  $tmp_file = $_FILES["pro-rss"]['tmp_name'];
  $image_width = $rss_info[0];
  $image_height = $rss_info[1];
  $pro_rss_path = $pro_path.$s_id.'-'.$pro_rss_name;
  $upload_ext = strtolower(pathinfo(basename($_FILES["pro-rss"]["name"]),PATHINFO_EXTENSION));
  if ($_FILES['pro-rss']['size'] <= $file_size_limit) {
    if ($rss_info["mime"] == "image/jpeg") {
      if (($image_width == $image_height)
      &&  ($image_width == 144)
      &&  ($image_height == 144)) {

        if (move_uploaded_file($tmp_file, $pro_rss_path)) {
          $upload_img_success = true;
          $upload_rss_success = true;
        } else {
          $ajax_response['message'] = '<p class="red">path:'.$pro_rss_path.' RSS image upload unknown failure.</p>';
          // We're done here
          $json_response = json_encode($ajax_response, JSON_FORCE_OBJECT);
          echo $json_response;
          exit ();
        }

      } else {
        $ajax_response['message'] = '<p class="red">Logo is wrong size. Must be square and 144 pixels wide and high.</p>';
        // We're done here
        $json_response = json_encode($ajax_response, JSON_FORCE_OBJECT);
        echo $json_response;
        exit ();
      }

    } else {
      $ajax_response['message'] = '<p class="red">RSS image is wrong formatt. Allowed: JPEG, PNG, GIF</p>';
      // We're done here
      $json_response = json_encode($ajax_response, JSON_FORCE_OBJECT);
      echo $json_response;
      exit ();
    }

  } else {
    $ajax_response['message'] = '<p class="red">RSS image file size is too big. Limit is 1MB.</p>';
    // We're done here
    $json_response = json_encode($ajax_response, JSON_FORCE_OBJECT);
    echo $json_response;
    exit ();
  }
}
```

*Note the two main AJAX responses, depending on image upload*

```php
if ($upload_img_success == true) {
  $ajax_response['message'] = '<span class="green notehide">Image uploaded. Changes may not take effect until cache reloads.</span>';
  $ajax_response['name'] = $series_name_trim;
  $ajax_response['slug'] = $clean_slug_trim;
  $ajax_response['change'] = 'change';
  $ajax_response['upload'] = 'uploaded';
  $ajax_response['new_podcast'] = ($upload_podcast_success) ? 'newpodcast' : 'notnew';
  $ajax_response['new_rss'] = ($upload_rss_success) ? 'newrss' : 'notnew';
} else {
  $ajax_response['message'] = '<span class="orange notehide">No changes</span>';
  $ajax_response['name'] = $series_name_trim;
  $ajax_response['slug'] = $clean_slug_trim;
  $ajax_response['change'] = 'nochange';
  $ajax_response['upload'] = 'failed';
  $ajax_response['new_podcast'] = 'notnew';
  $ajax_response['new_rss'] = 'notnew';
}
```

| **in.editseriesdiv.php** : (`in.head.php`; called by: `settings.php`, `pieces.php` & `edit.php`)

*This uses `$series_editor_yn = true;` for `in.head.php` to `include`*

```html
<!-- Div for series editor -->
<div id="edit-series-container" style="display:none;">
  <!-- Close button -->
  <div id="edit-series-closer" onclick="seriesEditorHide();" title="close"><b>&#xd7;</b></div>
  <!-- AJAX mediaInsert HTML entity -->
  <div id="edit-series"></div>
</div>
```

| **in.editseriesbutton.php** : (`settings.php`, `pieces.php` & `edit.php`)

`include` wherever you want the "Edit all series" clickable text

```html
...
<form id="edit-series-form">
  <input type="hidden" name="u_id" value="<?php echo $user_id; ?>">
  <button
  type="button"
  class="postform link-button inline blue"
  onclick="seriesEditor(USERID); seriesEditorShowHide();">
</form>

  <small>Edit all series</small>

</button>
```

| **in.editseries.php** : (`settings.php`, `pieces.php` & `edit.php`)

*We introduce some new functions*

*Note `showHideEdit()`...*

```javascript
// Show/hide the edit-series div
seriesEditorShowHide();

// Hide edit-series
seriesEditorHide();

// The editor content
seriesEditor(u_id, PAGE, MESSAGE);

  // show/hide action link
showChangeButton(s_id);

  // show/hide action link
  function showHideEdit(s_id) {
    var y = document.getElementById("e_buttons_"+s_id);
    if (y.style.display === "inline") {
      document.getElementById("change-cancel-"+s_id).innerHTML = 'Change';
      y.style.display = "none";
    } else {
      document.getElementById("change-cancel-"+s_id).innerHTML = 'Cancel';
      y.style.display = "inline";
    }
    // For the Default series, the "Permanently delete series" checkbox and <div> do not exist, so running a JavaScript action for it would break the above line also
    // So, we must check to see if the checkbox <div> even exists, only then we run the script action to change it
    if (elementExists = document.getElementById("delete-checkbox-"+s_id)) {
      var x = document.getElementById("delete-checkbox-"+s_id);
      if (x.style.display === "inline") {
        x.style.display = "none";
      } else {
        x.style.display = "inline";
      }
    }
  }

  // The editor content
seriesSave(sID);
```

| **style.css** :

```css
/* Series editor */
div#edit-series-container {
	background-color: #fff;
	border-style: solid;
	border-width: medium;
	border-color: #ddd;
  position: sticky;
	padding: 0.5em;
	margin: 0 1em 0.5em 1em;
	width: 95vw;
	height: 88vh;
	z-index: 99 !important; /* So it appears above everything */
}
```

*And, we made changes so that in.series.php & ajax.series.php take arguments, used in:*

- *`edit.php`*
- *`settings.php`*

```php
// Set the values
$p_series = (isset($p_series)) ? $p_series : $blog_default_series;
$series_form = 'edit_piece'; // 'edit_piece' or 'blog_settings'
include ('./in.series.php');
```

*...in pagination, we add `$series_get` to the navigation links*

##### View Series

*Links to view a series can be seen in:*

- *`ajax.editseries.php`*
- *`pieces.php`*
  - *`$p_series_slug`, `$p_series_name`& `$p_series_id`*
- *piece.php & `blog.php`*
  - *Follows "::" after date published*

##### Series Podcast Details

To open the Series Details Editor, click on "Edit podcast details" for a series in the Series Editor

*We also added some extra series details via:*

- *`ajax.editseriesdetails.php`*

*Using from in.editseries.php:*

- `detailsEditorHide()`
- `detailsEditor()`
- `detailsSave()`
- `seriesEditor()`

*Note this uses:*

- *Pagination*
- *Same for loading and saving the `<form>`*
- *`$ajax_response['message']` passes through `seriesEditor()` as `detailMessage` to become `$_POST['m']` in `ajax.editseries.php`*
  - *Then it is displayed at the top row of the `<table>` in the Series Editor in in.editseries.php `<div id="series-details-message">`*

*Note, the language for iTunes podcasts only has 50 languages available; more could be added from the two-character list from [ISO 639](http://www.loc.gov/standards/iso639-2/php/code_list.php)*

*This has an interesting way of handling the many iTunes categories, using a simple function*

*Here is a list of accepted [iTunes categories](https://podcasters.apple.com/support/1691-apple-podcasts-categories) as of 2021:*

- Arts
  - Books
  - Design
  - Fashion & Beauty
  - Food
  - Performing Arts
  - Visual Arts
- Business
  - Careers
  - Entrepreneurship
  - Investing
  - Management
  - Marketing
  - Non-Profit
- Comedy
  - Comedy Interviews
  - Improv
  - Stand-Up
- Education
  - Courses
  - How To
  - Language Learning
  - Self-Improvement
- Fiction
  - Comedy Fiction
  - Drama
  - Science Fiction
- Government
- History
- Health & Fitness
  - Alternative Health
  - Fitness
  - Medicine
  - Mental Health
  - Nutrition
  - Sexuality
- Kids & Family
  - Education for Kids
  - Parenting
  - Pets & Animals
  - Stories for Kids
- Leisure
  - Animation & Manga
  - Automotive
  - Aviation
  - Crafts
  - Games
  - Hobbies
  - Home & Garden
  - Video Games
- Music
  - Music Commentary
  - Music History
  - Music Interviews
- News
  - Business News
  - Daily News
  - Entertainment News
  - News Commentary
  - Politics
  - Sports News
  - Tech News
- Religion & Spirituality
  - Buddhism
  - Christianity
  - Hinduism
  - Islam
  - Judiasm
  - Religion
  - Spirituality
- Science
  - Astronomy
  - Chemistry
  - Earth Sciences
  - Life Sciences
  - Mathematics
  - Natural Sciences
  - Nature
  - Physics
  - Social Sciences
- Society & Culture
  - Documentary
  - Personal Journals
  - Philosophy
  - Places & Travel
  - Relationships
- Sports
  - Baseball
  - Basketball
  - Cricket
  - Fantasy Sports
  - Football
  - Golf
  - Hockey
  - Rugby
  - Soccer
  - Swimming
  - Tennis
  - Volleyball
  - Wilderness
  - Wrestling
- Technology
- True Crime
- TV & Film
  - After Shows
  - Film History
  - Film Interviews
  - Film Reviews
  - TV Reviews

#### Piece fields
*New fields `subtitle` & `excerpt`:*
- *SQL tables:*
  - `pieces`
  - `publications`
  - `publication_history`
- *Editing files:*
  - *`in.editprocess.php`*
  - *`in.functions.php`*
  - *`edit.php`*
- *Rendering in `blog.php`*
  - *If there is an excerpt, it will replace the content in blog series pages*

| **blog.php** :

```php
// Is there an excerpt?
if (($p_excerpt != '') && ($p_excerpt != NULL)) {
  // Change the content to the excerpt for our remaining purposes
  $p_content = $p_excerpt;
}
```

#### Audio/Video Duration
- *New file:*
  - *`bash.duration.sh`*
- *Gets time information from an uploaded audio or video file*
- *Output is sent to database table `media_library`, column `duration` in:*
  - *`upload.php`*
- *Displayed in:*
  - *`medialibrary.php`*
  - *`ajax.mediainfoinsert.php`*
- *Retrieved by:*
  - *`in.featuredmedia.php`*

#### Pagination
*We added pagination to:*
- *`blog.php`*
- *`pieces.php`*
- *`trash.php`*
- *`medialibrary.php`*

*We added pagination in AJAX a different way to:*
- *`ajax.editseries.php`*
- *`ajax.mediainsert.php`*
- *`ajax.mediafeature.php`*

*Our example code shows blog.php, but code for pieces.php & trash.php is identical except SQL calls and navigation links*

*Note, pagination only shows:*
- *blog.php: items = "Pieces per page" in Settings*
- *pieces.php & trash.php: `$pageitems = 100;`*
  - *Set to a low number like `2` to see pagination work here*

| **blog.php** :

*The `$query` is the same after `FROM` as in the `$query` to populate the page*

```php
// Valid the Pagination
if ((isset($_GET['r'])) && (filter_var($_GET['r'], FILTER_VALIDATE_INT, array('min_range' => 1)))) {
 $paged = preg_replace("/[^0-9]/","", $_GET['r']);
} else {
 $paged = 1;
}
// Set pagination variables:
$pageitems = $blog_piece_items; // Global variable from blog_settings
$itemskip = $pageitems * ($paged - 1);
// We add this to the end of the $query, after DESC
// LIMIT $itemskip,$pageitems

// Pagination navigation: How many items total?
$query = $database->prepare("SELECT id FROM publications WHERE type='post' AND status='live' AND pubstatus='published'");
$rows = $pdo->exec_($query);
$totalrows = $pdo->numrows;

$totalpages = floor($totalrows / $pageitems);
$remainder = $totalrows % $pageitems;
if ($remainder > 0) {
$totalpages = $totalpages + 1;
}
if ($paged > $totalpages) {
$totalpages = 1;
}
$nextpaged = $paged + 1;
$prevpaged = $paged - 1;
```

*...add this to the end of the main `$query` of the page...*

```sql
LIMIT $itemskip,$pageitems
```

*...then this is wherever you want the pagination links to go...*

```php
// Pagination nav row
if ($totalpages > 1) {
	echo "
	<div class=\"paginate_nav_container\">
		<div class=\"paginate_nav\">
			<table>
				<tr>
					<td>
						<a class=\"paginate";
						if ($paged == 1) {echo " disabled";}
						echo "\" title=\"Page 1\" href=\"$blog_web_base/blog.php?r=1\">&laquo;</a>
					</td>
					<td>
						<a class=\"paginate";
            if ($paged == 1) {echo " disabled";}
           echo "\" title=\"Previous\" href=\"$blog_web_base/blog.php?r=$prevpaged\">&lsaquo;&nbsp;</a>
					</td>
					<td>
						<a class=\"paginate current\" title=\"Next\" href=\"$blog_web_base/blog.php?r=$paged\">Page $paged ($totalpages)</a>
					</td>
					<td>
						<a class=\"paginate";
            if ($paged == $totalpages) {echo " disabled";}
           echo "\" title=\"Next\" href=\"$blog_web_base/blog.php?r=$nextpaged\">&nbsp;&rsaquo;</a>
					</td>
					 <td>
						 <a class=\"paginate";
						 if ($paged == $totalpages) {echo " disabled";}
	 					echo "\" title=\"Last Page\" href=\"$blog_web_base/blog.php?r=$totalpages\">&raquo;</a>
					 </td>
		 		</tr>
			</table>
		</div>
	</div>";
}
```

| **style.css** :

```css
/* Pagination */
div.paginate_nav_container {
	text-align: center;
}

div.paginate_nav {
	display: inline-block;
}

a.paginate {
  text-decoration: none;
  display: inline-block;
  padding: 4px 8px;
	font-size: 0.9em;
	background-color: #ccc;
	color: #fff;
}

a.paginate:hover {
  background-color: #222;
  color: #fff;
}

a.paginate.disabled {
  pointer-events: none;
  background-color: #eee;
}
a.paginate.current {
	pointer-events: none;
}
```

##### Pagination with AJAX
*This is an example of the Series Editor*

*Note the `seriesEditor()` function allows a message to be passed on load, which will be used to display response messages when saving changes*

| **in.editseries.php** :

```JavaScript
function seriesEditor(uID, pageNum = 0, detailMessage = '') { // These arguments can be anything, same as used in this function

  // Bind a new event listener:
  const AJAX = new XMLHttpRequest(); // AJAX handler

  AJAX.addEventListener( "load", function(event) { // This runs when AJAX responds
    document.getElementById("edit-series").innerHTML = event.target.responseText;
  } );

  AJAX.addEventListener( "error", function(event) { // This runs if AJAX fails
    document.getElementById("edit-series").innerHTML = 'Oops! Something went wrong.';
  } );

  AJAX.open("POST", "ajax.editseries.php");
  AJAX.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  AJAX.send("u_id="+uID+"&r="+pageNum+"&m="+detailMessage); // Data as could be sent in a <form>

} // seriesEditor() function
```

| **ajax.editseries.php** :

*Note navigation links use:*

```html
<a href="#" onclick="seriesEditor(USERID, PAGE);">
```

```php
// Pagination nav row
if ($totalpages > 1) {
  echo "
  <div class=\"paginate_nav_container\">
    <div class=\"paginate_nav\">
      <table>
        <tr>
          <td>
            <a class=\"paginate";
            if ($paged == 1) {echo " disabled";}
            echo "\" title=\"Page 1\" href=\"#\" onclick=\"seriesEditor($user_id, 1);\">&laquo;</a>
          </td>
          <td>
            <a class=\"paginate";
            if ($paged == 1) {echo " disabled";}
           echo "\" title=\"Previous\" href=\"#\" onclick=\"seriesEditor($user_id, $prevpaged);\">&lsaquo;&nbsp;</a>
          </td>
          <td>
            <a class=\"paginate current\" title=\"Next\" href=\"#\" onclick=\"seriesEditor($user_id, $paged);\">Page $paged ($totalpages)</a>
          </td>
          <td>
            <a class=\"paginate";
            if ($paged == $totalpages) {echo " disabled";}
           echo "\" title=\"Next\" href=\"#\" onclick=\"seriesEditor($user_id, $nextpaged);\">&nbsp;&rsaquo;</a>
          </td>
           <td>
             <a class=\"paginate";
             if ($paged == $totalpages) {echo " disabled";}
            echo "\" title=\"Last Page\" href=\"#\" onclick=\"seriesEditor($user_id, $totalpages);\">&raquo;</a>
           </td>
        </tr>
      </table>
    </div>
  </div>";
}
```

#### Featured Media

***The code:*** *This was complex to work out and affected many files with the new information*

***The style:*** *In this blog CMS, featured media is not styled, but a little work with CSS can make the featured media come to life*

***The use:***
- *Add options for blog readers*
- *Separate important media from embedded media in main content*
- *Enhance for RSS feeds and podcasts*

*Featured media includes:*
- *Image*
- *Audio*
- *Video*
- *Document*

***The process:*** *In the edit workflow, we basically create a modified `mediaInsert()` JavaScript function, calling an AJAX file modified from `ajax.mediainsert.php`*

*The main mods are:*
- `mediaFeatureInsert(thisMedia)` *mod from* `mediaInsert()`
- ajax.mediafeature.php *mod from* ajax.mediainsert.php

*New files to handle the new information:*
- ajax.mediafeature.php
- in.featuredmedia.php
- in.featuredmediadisplay.php

*Changes in:*
- edit.php
- in.piecefunctions.php
- in.editprocess.php
- blog.php
- piece.php

*New database columns on `pieces` & `publications`:*

```sql
`feat_img` INT UNSIGNED NOT NULL DEFAULT 0
`feat_aud` INT UNSIGNED NOT NULL DEFAULT 0
`feat_vid` INT UNSIGNED NOT NULL DEFAULT 0
`feat_doc` INT UNSIGNED NOT NULL DEFAULT 0
```

| **edit.php** : (inputs & JavaScript functions)

*The orange `insert from media library` button adds `mediaFeatureHide();` to avoid any conflict*

```php
// Featured media
echo '<p><b>Featured media</b></p>';

// Featured image
echo '<form id="image-insert-form"><input type="hidden" name="u_id" value="'.$user_id.'"><input type="hidden" name="feature_type" value="IMAGE"></form>';
echo '<p id="featured_image">'.pieceInput('p_feat_img', $feat_img_id);
echo 'Image: <code id="feat_img_file">'.$feat_img_file_link.'</code><br><small class="gray" style="cursor:pointer;" onclick="mediaFeatureInsert(\'IMAGE\'); mediaInsertHide(); mediaFeatureShow();"><i>(change)</i></small>&nbsp;<small class="red" id="feat_img_remove" style="display:'.$feat_img_showhide.'; cursor:pointer;" onclick="clearFeature(\'IMAGE\')">remove</small>';
echo '<img id="feat_img_thumb" style="display:'.$feat_img_thumb_showhide.';" max-width="'.$img_thum_max.'" max-height="'.$img_thum_max.'" title="'.$feat_img_file_title.'" alt="'.$feat_img_file_alt.'" src="'.$feat_file_basepath.$feat_img_file_location.'/'.$feat_img_thumb.'">';
echo '</p>';
```

```js
// JavaScript functions
// Open the featured media insert, populate via AJAX
function mediaFeatureInsert(thisMedia) { // These arguments can be anything, same as used in this function

  if (thisMedia == 'IMAGE') {
    var inputFormID = 'image-insert-form';
  } else if (thisMedia == 'AUDIO') {
    var inputFormID = 'audio-insert-form';
  } else if (thisMedia == 'VIDEO') {
    var inputFormID = 'video-insert-form';
  } else if (thisMedia == 'DOCUMENT') {
    var inputFormID = 'document-insert-form';
  }

  // Bind a new event listener every time the <form> is changed:
  const FORM = document.getElementById(inputFormID);
  const AJAX = new XMLHttpRequest(); // AJAX handler
  const FD = new FormData(FORM); // Bind to-send data to form element

  AJAX.addEventListener( "load", function(event) { // This runs when AJAX responds
    document.getElementById("feature-insert").innerHTML = event.target.responseText;
  } );

  AJAX.addEventListener( "error", function(event) { // This runs if AJAX fails
    document.getElementById("feature-insert").innerHTML = 'Oops! Something went wrong.';
  } );

  AJAX.open("POST", "ajax.mediafeature.php");

  FD.append('ajax_token', $ajax_token);
  AJAX.send(FD); // Data sent is from the form

}

// Hide mediaFeatureInsert()
function mediaFeatureHide() {
  document.getElementById("feature-insert-container").style.display = "none";
  document.getElementById("featureuploadresponse").innerHTML = '';
}

// Show mediaFeatureInsert()
function mediaFeatureShow() {
  document.getElementById("feature-insert-container").style.display = "block";
}

// When adding from the mediaFeatureInsert() chooser
function setToFeature(thisID, thisFilePath, thisFile, thisMedia, thisImageThumb) {
  if (thisMedia == 'IMAGE') {
    var inputID = 'feat_img_id';
    var showFile = 'feat_img_file';
    var removeAct = 'feat_img_remove';
    document.getElementById('feat_img_thumb').src = thisImageThumb;
    document.getElementById('feat_img_thumb').style.display = "block";
  } else if (thisMedia == 'AUDIO') {
    var inputID = 'feat_aud_id';
    var showFile = 'feat_aud_file';
    var removeAct = 'feat_aud_remove';
  } else if (thisMedia == 'VIDEO') {
    var inputID = 'feat_vid_id';
    var showFile = 'feat_vid_file';
    var removeAct = 'feat_vid_remove';
  } else if (thisMedia == 'DOCUMENT') {
    var inputID = 'feat_doc_id';
    var showFile = 'feat_doc_file';
    var removeAct = 'feat_doc_remove';
  }
  var fileLink = '<a href="'+thisFilePath+'" target="_blank" style="text-decoration:none;">'+'<b>'+thisFile+'</b>'+'</a>';
  document.getElementById(inputID).value = thisID;
  document.getElementById(showFile).innerHTML = fileLink;
  document.getElementById(removeAct).style.display = "inline";
}

// When clicking "remove"
function clearFeature(thisMedia) {
  if (thisMedia == 'IMAGE') {
    var inputID = 'feat_img_id';
    var showFile = 'feat_img_file';
    var removeAct = 'feat_img_remove';
    document.getElementById('feat_img_thumb').src = '';
    document.getElementById('feat_img_thumb').style.display = "none";
  } else if (thisMedia == 'AUDIO') {
    var inputID = 'feat_aud_id';
    var showFile = 'feat_aud_file';
    var removeAct = 'feat_aud_remove';
  } else if (thisMedia == 'VIDEO') {
    var inputID = 'feat_vid_id';
    var showFile = 'feat_vid_file';
    var removeAct = 'feat_vid_remove';
  } else if (thisMedia == 'DOCUMENT') {
    var inputID = 'feat_doc_id';
    var showFile = 'feat_doc_file';
    var removeAct = 'feat_doc_remove';
  }
  document.getElementById(inputID).value = 0;
  document.getElementById(showFile).innerHTML = '<i class="gray">none</i>';
  document.getElementById(removeAct).style.display = "none";
}
```

| **ajax.mediafeature.php** : (new, media chooser)

*This was built from `ajax.mediainsert.php`*

```php
// Extra test in the opening statement
&& (!empty($_POST['feature_type']))
&& (($_POST['feature_type'] == 'IMAGE')
   || ($_POST['feature_type'] == 'AUDIO')
   || ($_POST['feature_type'] == 'VIDEO')
   || ($_POST['feature_type'] == 'DOCUMENT'))
```

```html
<!-- Still using the same media insert <div>, just populating it differently -->
<div id="media-insert-editor-container" style="display:none;">
  <!-- AJAX mediaEdit HTML entity -->
  <div id="media-insert-editor"></div>
</div>
```

```php
// Get the featured media type
// from the <form> sent by mediaFeatureInsert() calling this AJAX
// edit.php: <form><input type="hidden" name="feature_type" value="IMAGE">
$m_basic_type = $_POST['feature_type'];
```

```sql
-- Add WHERE statement to SELECT
WHERE basic_type=:basic_type
```

```php
// Bind the SQL value to $m_basic_type = $_POST['feature_type'];
$query->bindParam(':basic_type', $m_basic_type);

...

// Added some changes to our original

// Paths, also used in setToFeature()
$media_library_folder = '/media/';
$basepath = $blog_web_base.$media_library_folder;
$m_filename_full_path = $basepath.$m_location.'/'.$m_filename;

// $file_thumb variable
if ($m_basic_type == 'IMAGE') {
  $file_thumb = ($m_file_extension == 'svg') ? $basepath.$m_location.'/'.$m_file_base.'_thumb_svg.png' : $basepath.$m_location.'/'.$m_file_base.'_thumb'.'.'."$m_file_extension";
} else {
  $file_thumb = 0;
}

// Clickable text to set featured media
$set_button = '<button class="postform orange" onclick="setToFeature(\''.$m_id.'\', \''.$m_filename_full_path.'\', \''.$m_filename.'\', \''.$m_basic_type.'\', \''.$file_thumb.'\'); onNavWarn();">&larr; '.$m_filename.'</button>&nbsp;('.human_file_size(filesize($m_filename_full_path)).')<br>';

```

| **in.piecefunctions.php** : (processes & functions)

*These are the main updates*

```php
function checkPiece($name, $value) {
  ...
  } elseif ($name == 'p_feat_img') {
    $result = (filter_var($value, FILTER_VALIDATE_INT)) ? $value : 0;

  } elseif ($name == 'p_feat_aud') {
    $result = (filter_var($value, FILTER_VALIDATE_INT)) ? $value : 0;

  } elseif ($name == 'p_feat_vid') {
    $result = (filter_var($value, FILTER_VALIDATE_INT)) ? $value : 0;

  } elseif ($name == 'p_feat_doc') {
    $result = (filter_var($value, FILTER_VALIDATE_INT)) ? $value : 0;
  }
  ...
}

function pieceInput($name, $value) {
  ...
  } elseif ($name == 'p_feat_img') {
    echo '<input id="feat_img_id" form="edit_piece" type="hidden" name="p_feat_img" onchange="onNavWarn();" onkeyup="onNavWarn();" value="'.$value.'">';

  } elseif ($name == 'p_feat_aud') {
    echo '<input id="feat_aud_id" form="edit_piece" type="hidden" name="p_feat_aud" onchange="onNavWarn();" onkeyup="onNavWarn();" value="'.$value.'">';

  } elseif ($name == 'p_feat_vid') {
    echo '<input id="feat_vid_id" form="edit_piece" type="hidden" name="p_feat_vid" onchange="onNavWarn();" onkeyup="onNavWarn();" value="'.$value.'">';

  } elseif ($name == 'p_feat_doc') {
    echo '<input id="feat_doc_id" form="edit_piece" type="hidden" name="p_feat_doc" onchange="onNavWarn();" onkeyup="onNavWarn();" value="'.$value.'">';
  }
  ...
}
```

| **in.editprocess.php** : (new database columns)

```sql
-- SELECT cols
feat_img, feat_aud, feat_vid, feat_doc,

PUB.feat_img=PCE.feat_img,
PUB.feat_aud=PCE.feat_aud,
PUB.feat_vid=PCE.feat_vid,
PUB.feat_doc=PCE.feat_doc,
```

```php
// POST values
$p_feat_img = checkPiece('p_feat_img',$_POST['p_feat_img']);
$p_feat_aud = checkPiece('p_feat_aud',$_POST['p_feat_aud']);
$p_feat_vid = checkPiece('p_feat_vid',$_POST['p_feat_vid']);
$p_feat_doc = checkPiece('p_feat_doc',$_POST['p_feat_doc']);

// Bind parameters
$query->bindParam(':feat_img', $p_feat_img);
$query->bindParam(':feat_aud', $p_feat_aud);
$query->bindParam(':feat_vid', $p_feat_vid);
$query->bindParam(':feat_doc', $p_feat_doc);

// Select row output
$p_feat_img = "$row->feat_img";
$p_feat_aud = "$row->feat_aud";
$p_feat_vid = "$row->feat_vid";
$p_feat_doc = "$row->feat_doc";
```

| **in.featuredmedia.php** : (new, variables)

*This shows only variables for the image; audio, video, and document are in the full file*

```php
// Featured media
$media_library_folder = '/media/';
$img_thum_max = '50px';
$img_blog_max = '100px';
$vid_blog_max = '250px';
$feat_file_basepath = $blog_web_base.$media_library_folder;
// Featured image filename
$query = $database->prepare("SELECT file_base, file_extension, mime_type, title_text, alt_text, location FROM media_library WHERE id=:id AND basic_type='IMAGE'");
$query->bindParam(':id', $p_feat_img);
$rows = $pdo->exec_($query);
// Shoule be 1 row
if ($pdo->numrows == 1) {
  foreach ($rows as $row) {
    // Assign the values
    $feat_img_id = $p_feat_img;
    $feat_img_ext = "$row->file_extension";
    $feat_img_mime = "$row->mime_type";
    $feat_img_file = "$row->file_base".".".$feat_img_ext;
    $feat_img_thumb = ($row->file_extension == 'svg') ? "$row->file_base".'_thumb_svg.png' : "$row->file_base".'_thumb.'."$row->file_extension";
    $feat_img_file_title = "$row->title_text";
    $feat_img_file_alt = "$row->alt_text";
    $feat_img_file_location = "$row->location";
    $feat_img_file_relpath = $media_library_folder.$feat_img_file_location.'/'.$feat_img_file;
    $feat_img_url = $feat_file_basepath.$feat_img_file_location.'/'.$feat_img_file;
    $feat_img_url_blog = ($feat_img_ext == 'svg') ? $feat_file_basepath.$feat_img_file_location.'/'.$feat_img_thumb : $feat_img_url; // SVG files don't scale with <img> size attributes
    $feat_img_file_link = '<a href="'.$feat_img_url.'" target="_blank" style="text-decoration:none;">'."<b>$feat_img_file</b>".'</a>';
    $feat_img_showhide = 'inline';
    $feat_img_thumb_showhide = 'block';
    $feat_img_file_size = filesize($feat_img_file_relpath);
  }
} else {
  $feat_img_id = 0;
  $feat_img_file = 'none';
  $feat_img_file_link = '<i class="gray">'.$feat_img_file.'</i>';
  $feat_img_showhide = 'none';
  $feat_img_thumb_showhide = 'none';
}
```

| **in.featuredmediadisplay.php** : (new `include()` for blog.php & piece.php)

```php
include ('./in.featuredmedia.php');

echo '<div id="featured-media" style="display:block">';

  // Video
  if (($feat_vid_showhide != 'none') && (($feat_vid_ext == 'mp4') || ($feat_vid_ext == 'ogg'))) {
    echo '<div id="featured-video" style="display:block"><video controls height="'.$vid_blog_max.'"><source src="'.$feat_vid_url.'" type="'.$feat_vid_mime.'"></video></div>';
  }

  // Audio/Document line
  if (($feat_aud_showhide != 'none') || ($feat_doc_showhide != 'none')) {

    echo '<div id="featured-audio-document" style="display:block">';

    // Audio
    if (($feat_aud_showhide != 'none') && (($feat_aud_ext == 'mp3') || ($feat_aud_ext == 'ogg'))) {
      echo '<div id="featured-audio" style="display:inline"><audio controls><source src="'.$feat_aud_url.'" type="'.$feat_vid_mime.'"></audio></div>';
    }

    // Document
    if ($feat_doc_showhide != 'none') {
      echo '<div id="featured-document" style="display:inline"><big style="font-size:16pt;">&nbsp;&#x1F5CF;&nbsp;<code>'.$feat_doc_file_link.'</code></big></div>';
    }
    echo '</div>';
  }

  // Image
  if ($feat_img_showhide != 'none') {
    echo '<div id="featured-image"><img max-width="'.$img_blog_max.'" max-height="'.$img_blog_max.'" title="'.$feat_img_file_title.'" alt="'.$feat_img_file_alt.'" src="'.$feat_img_url_blog.'"></div>';
  }

echo '</div>';
```

#### Pre-Drafts first

*We restructured pieces.php so that pre-draft pieces are listed at the top*

- *SQL looks for unpublished pieces first, then orders by `date_live`*

| **pieces.php** :

```sql
SELECT id, type, status, pub_yn, title, date_live, date_created
FROM pieces WHERE status='live'
ORDER BY date_live DESC;
```

*...adds...*

```sql
-- CASE WHEN ... THEN ... ELSE ... END (like an "if" statement)
-- 0 THEN 1 is an index order:
CASE WHEN pub_yn=false THEN 0 ELSE 1 END,
```

*...and becomes...*

```sql
SELECT id, type, status, pub_yn, title, date_live, date_created
FROM pieces WHERE status='live'
ORDER BY
CASE WHEN pub_yn=false THEN 0 ELSE 1 END, -- We added this
date_live DESC;
```

### VI. Beyond
You now have a basic understanding of OOP and PDO when working with PHP and SQL

Our database calls use `prepare()`, `bindParam()` & `execute()`, made simple by putting `execute()` with `try` ... `catch` in a static method

There is much more you will be able to learn on your own

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

- Define a class:

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

- Call objects inside a class statement:

```php
return $this->someProperty;
return $this->someMethod();
return self::SOME_CONSTANT;
return self::$someProperty;
return self::someMethod();
```

- Call static objects from an uninstantiated class:

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

- Define parent & child classes:

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

### PDO Basics

- PDO is an alternative to MySQLi
- PDO connects PHP to MySQL, along with many other SQL database platforms
- With PDO, you can change database platforms without changing your PHP
- A PDO database connection is an object, not a variable or array
- Putting the PDO database connection inside a class can limit what can be accessed, such as retrieving the `lastInsertId()`
  - You may want to keep your PDO connection outside of a class

### PDO Connection

| **PDO Config** :

```php
// Connection with default options
$database = new PDO("mysql:host=$db_host; dbname=$db_name; charset=utf8mb4", $db_user, $db_pass);

// Useful options
$opt = [
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ, // Object built on column names
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH, // Row array is auto-indexed and associated by column name (default)
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // Row array is associated by column name only
  //PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_NUM, // Row array is auto-indexed only
];

// Connection with set options
$database = new PDO("mysql:host=$db_host; dbname=$db_name; charset=utf8mb4", $db_user, $db_pass, $opt);
```

### PDO Queries

- There are three main ways to run queries
  1. `query()` (single, simple SQL statement)
    - Return output with `fetch()`
    - Check with `$statement->rowCount()` & `$database->lastInsertId()`
  2. `prepare()`, `bindParam()` & `execute()` (SQL statement can take arguments for user input, improved security against SQL injection)
    - Return output with `fetch()` or `fetchAll()` for multiple lines
    - Check with:
      - `$statement->rowCount()`
      - `$database->lastInsertId()`
  3. `exec()` (multiple SQL statement)
    - No output, no checks, no secure `bindParam()` statements
    - For output or testing success, run a separate query using `query()` or `execute()`

- Examples & syntax:

| **1. `query()` & `fetch()`** :

```php
$statement = $database->query($query);
return $statement->fetch();

// Set fetch mode different from your $database options
return $statement->fetch(PDO::FETCH_OBJ);
return $statement->fetch(PDO::FETCH_BOTH);
```

| **2. a. `prepare()`, `bindParam()`, `execute()` & `fetchAll()`** :

```php
$query = "SELECT col1, col2, FROM some_table WHERE col3=:somevalue AND col4=:othervalue"
$statement = $database->prepare($query);
$query_uc->bindParam(':somevalue', $somevalue);
$query_uc->bindParam(':othervalue', $othervalue);
$statement->execute();
return $statement->fetchAll(); // Will give most results

// Set fetch mode different from your $database options
return $statement->fetchAll(PDO::FETCH_OBJ);

// These also work, but fetch() can't handle bindParam() arguments
return $statement->fetch();
return $statement->fetch(PDO::FETCH_BOTH);
```

| **2. b. `execute()` Arguments** :

```php
// One argument
$query = "SELECT * FROM fruit WHERE name = ?"; // ? becomes $arg in execute([$arg])
$statement = $database->prepare($query);
$statement->execute([$arg]); // $arg replaces ? in $query

// Multiple arguments
$query = "SELECT * FROM fruit WHERE name = ? AND color = ?"; // 2 arguments
$statement = $database->prepare($query);
$statement->execute([$arg1, $arg2]); // $arg1, $arg2 (respectively)
```

| **3. `exec()`** : To execute multiple SQL statements at once

```php
$query  = "
START TRANSACTION; <!-- Start with this always -->
...
CREATE TABLE IF NOT EXISTS `fruit` ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
DELETE FROM fruit WHERE some_col='val';
INSERT INTO fruit (some_col) VALUES ('val');
INSERT INTO fruit (some_col, other_col) VALUES ('val1', 'val1');
...
COMMIT; <!-- End with this always -->
";
$database->exec($query);
```

## III. PDO with OOP PHP

### Creating PDO Methods in OOP PHP
- Use methods to execute PDO statements to clean up your code
- Some methods can allow multiple arguments and defaults
  - This allows one method to run many types of queries
- Some methods should use few or no arguments, being fully prepared statements
  - This is for complex SQL queries and/or to improve security

### Examples of PDO Methods in OOP PHP

| **1. `class` with `->execute()` Method** :

This is for any SQL query, but ***it must use a prepared statement with binding arguments*** such as `$query->bindParam(':var', $value);`


```php
class DB {
  // We need these to be callable
  public $change;
  public $lastid;

  // Error handler
  function pdo_error($query, $error_message) {
      echo "SQL error from <pre>$query</pre><br>$error_message";
  }

  // exec_ static method to pass properties through a try test
  public function exec_($query) {
    global $database;

    // Try the query
    try {
      $query->execute();
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    // Response info
    $this->numrows = $query->rowCount();
    $this->change = ($query->rowCount() > 0) ? true : false;
    $this->lastid = $database->lastInsertId();
    $this->ok = ($query) ? true : false;

    // Return fetched SQL response object
    return $query->fetchAll();

  } // exec_()
}

// Instantiate
$pdo = new DB;

// Usage
// UPDATE
$query = $database->prepare("UPDATE theaters SET status='open' WHERE id=:id");
$query->bindParam(':id', $id);
$rows = $pdo->exec_($query);
echo ($pdo->change) ? "Stuff changed<br>" : "No change<br>";
// INSERT
$query = $database->prepare("INSERT INTO theaters (name, locale) VALUES (:name, :locale)");
$query->bindParam(':name', $name);
$query->bindParam(':locale', 'Chicago');
$rows = $pdo->exec_($query);
echo "ID of last database INSERT: $pdo->lastid";
```

| **2. `class` with `UPDATE`...`WHERE BINARY` Method** :

This is useful because:

1. `BINARY` matches characters exactly, such as for keys
2. It uses a loop to set a list of columns with a separate list of corresponding values

```php
class DB {

  // Error handler
  public function pdo_error($query, $error_message) {
      echo "SQL error from <pre>$query</pre><br>$error_message";
  }

  // UPDATE WHERE BINARY method for keys
  public function key_update($table, $cols, $vals, $wcol, $vcol) {
    global $database;

    // Sanitize
    $cols = preg_replace("/[^0-9a-zA-Z_, ]/", "", $cols);
    $table = preg_replace("/[^0-9a-zA-Z_]/", "", $table);

    // Prepare array of $cols=key & $vals=value
    $cols_arr = preg_split('~,\s*~', $cols);
    $vals_arr = preg_split('~,\s*~', $vals);
    $set_array = array_combine($cols_arr, $vals_arr);
    $bind_array = array();

    // Prepare SQL SET statement
    $set_statement = "";
    foreach ( $set_array as $k => $v ) {
      $set_statement .= "$k=:$k,";
    }
    $set_statement = rtrim($set_statement, ','); // remove last comma

    // Prepare SQL query
    $query = $database->prepare("UPDATE $table SET $set_statement WHERE BINARY $wcol='$vcol'");

    // Bind values
    foreach ( $set_array as $k => $v ) {
      $query->bindParam(":$k", $v);
    }

    // Try the query
    try {
      $query->execute();
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    // Success statement
    $this->change = ($query->rowCount() > 0) ? true : false;
    $this->ok = ($query) ? true : false;

    // Return fetched SQL response object
    return $query->fetchAll(PDO::FETCH_OBJ);

  } // key_update()
}

// Instantiate
$pdo = new DB;

// Usage
$table = 'fruit';
$columns = 'name, color';
$values = 'apple, red';
$where_col = 'locale';
$where_value = 'Chicago';
$pdo->key_update($table, $columns, $values, $where_col, $where_value);
echo ($pdo->change) ? "Stuff changed<br>" : "No change<br>";
```

| **3. `class` with `SELECT` Method** : (Return single row)

```php
class DB {

  // Error handler
  public function pdo_error($query, $error_message) {
      echo "SQL error from <pre>$query</pre><br>$error_message";
  }

  // SELECT method
  public function select($table, $wcol, $vcol, $cols='*') {
    global $databse;

    // Sanitize
    $cols = preg_replace("/[^0-9a-zA-Z_, ]/", "", $cols);
    $table = preg_replace("/[^0-9a-zA-Z_]/", "", $table);
    $wcol = preg_replace("/[^0-9a-zA-Z_]/", "", $wcol);

    // Prepare SQL query
    $query = $database->prepare("SELECT $cols FROM $table WHERE $wcol=:vcol");
    $query->bindParam(':vcol', $vcol);
    try {
      $query->execute();
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    $this->numrows = $query->rowCount();
    $this->ok = ($query) ? true : false;
    return $query->fetchAll(PDO::FETCH_OBJ);
  }
}

// Instantiate
$pdo = new DB;

// Usage
$table = 'fruit';
$column = 'name';
$value = 'apple';
$val = $pdo->select($table, $column, $value);
echo "Name: $val->name Color: $val->color Locale: $val->locale";
```

| **4. `class` with `SELECT` Method** : (Return multiple rows)

```php
class DB {

  // Error handler
  public function pdo_error($query, $error_message) {
      echo "SQL error from <pre>$query</pre><br>$error_message";
  }

  // SELECT multiple rows method
  public function selectmulti($table, $cols = '*', $wcol = '*', $vcol = '*') {
    global $database;

    // Sanitize
    $cols = preg_replace("/[^0-9a-zA-Z_, ]/", "", $cols);
    $wcol = preg_replace("/[^0-9a-zA-Z_]/", "", $wcol);
    $table = preg_replace("/[^0-9a-zA-Z_]/", "", $table);

    $query = "SELECT $cols FROM $table";
    $query .= (($wcol == '*') || ($vcol == '*')) ?
    "" :
    " WHERE $wcol=:vcol";

    $statement = $database->prepare($query);
    $statement->bindParam(':vcol', $vcol);

    try {
      $statement->execute();
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    $this->numrows = $query->rowCount();
    $this->ok = ($query) ? true : false;

    return $statement->fetchAll(PDO::FETCH_OBJ);
  }
}

// Instantiate
$pdo = new DB;

// Usage
// Returns all columns, all rows
$val = $pdo->selectmulti($table);
foreach ($val as $one) {
  echo "Name: $one->name Color: $one->color Locale: $one->locale<br>";
}
// Returns many rows, but only two columns
$val = $pdo->selectmulti($table, 'name, color');
foreach ($val as $one) {
  echo "Name: $one->name Color: $one->color<br>";
}
// Returns one row
$val = $pdo->selectmulti($table, 'name, color', 'locale', 'Chicago');
foreach ($val as $one) {
  echo "Name: $one->name Color: $one->color<br>";
}
```

| **5. `class` with `DELETE` Method using `execute()` Arguments** :

```php
class DB {
  // We need these to be callable
  public $change;

  // Error handler
  function pdo_error($query, $error_message) {
      echo "SQL error from <pre>$query</pre><br>$error_message";
  }

  // DELETE method
  public function delete($table, $col1, $val1, $col2, $val2) {
    global $databse; // We need our $database

    // Sanitize
    $col1 = preg_replace("/[^0-9a-zA-Z_]/", "", $col1);
    $col2 = preg_replace("/[^0-9a-zA-Z_]/", "", $col2);
    $table = preg_replace("/[^0-9a-zA-Z_]/", "", $table);

    $query = "DELETE FROM fruit WHERE $col1 = ? AND $col2 = ?"; // 2 arguments
    try {
      $statement = $database->prepare($query);
      // Way 1:
        //$statement->execute([$val1, $val2]); // Place arguments directly as array
      // Way 2:
        $arg_array = [$val1, $val2]; // Short syntax to create and populate array
        $statement->execute($arg_array); // Array we use
    } catch (PDOException $error) {
      $this->pdo_error($query, $error->getMessage());
    }

    // Set the response properties
    $this->change = ($statement->rowCount() > 0) ? true : false;
  }
}

// Instantiate
$pdo = new DB;

// Usage
$table = 'fruit';
$column1 = 'name';
$value1 = 'apple';
$column2 = 'market';
$value2 = 'global';
$pdo->delete($table, $column1, $value1, $column2, $value2);
echo ($pdo->change) ? "Stuff changed<br>" : "No change<br>";
```

___

#### [Lesson 12: Production & XML](https://github.com/inkVerb/vip/blob/master/501/Lesson-12.md)
