# Linux 501
## Lesson 6: AJAX

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

Schoolwork directory
```console
mv 501 STUDENT_1/
mv STUDENT_2/501 .
```

Re-ready the CLI

```console
cd ~/School/VIP/501
```

- [AJAX Security](AJAX-security.md)
___

### AJAX: Asynchronous JavaScript and XML
AJAX changes only ***part*** of a webpage

This "Asynchronous" action uses JavaScript to:
1. Send a small XML request over HTTP/web (usually via `GET` or `POST`)
  - It is much like submitting a web `<form>`
    - JavaScript can create the entire XML request
    - JavaScript can import the entire XML request from an actual `<form>` in the webpage
2. Receive the "mini HTML webpage" that comes as a response
3. Use JavaScript animation to update the browser with that response

`XMLHttpRequest()` is the JavaScript method that sends this XML request over HTTP/web

#### JavaScript: Asynchronous Animation
- JavaScript loads as its goes, before finishing the script
  - Called "stream"
  - Streaming this mini HTML webpage is called "asynchronous"
  - Different from PHP Rule 1: Render *after* the script
  - This lets JavaScript animate and move
- JavaScript was created in 1995 by Netscape to compete with Microsoft
  - Netscape became Firefox in 2002
- JavaScript animates pieces of HTML and CSS
- Remember [Lesson 0: HTML Fast](https://github.com/inkVerb/vip/blob/master/501/Lesson-00.md#html--css-crash-course):
  - HTML is a manikin
  - CSS is the clothing
  - JavaScript "animates", so the manikin moves like a robot and changes clothes
- JavaScript uses the "moving robot" do AJAX (partial-page loads)
- We will ***not*** teach JavaScript in this course, but we will ***use*** some
  - You do not need to understand this JavaScript, only know where to put it
  - Please, study JavaScript on your own before using AJAX on a real website!

#### XML (eXtensible Markup Language)
- XML uses `<tags>` to sort information
- XML looks like HTML, but you can use any tag you want
- XML was created in 1996, HTML in 1993
- XML files can be used as a database in stead of SQL
- XML can be "parsed" (talked to) just like SQL "parses" (talks to) a database
- XML is the language of an RSS feed
- XML syntax:
```xml
<some_tag>
  Info goes here
</some_tag>
```
- ***AJAX calls can use either*** **XML** or **JSON**
  - JSON is an alternative to XML
  - JSON may be more common in AJAX
  - JSON & XML are covered more in later lessons, *not* in this lesson
    - JSON in [Lesson 9](https://github.com/inkVerb/vip/blob/master/501/Lesson-09.md)
    - XML in [Lesson 12](https://github.com/inkVerb/vip/blob/master/501/Lesson-12.md)
  
#### AJAX Components
##### JavaScript:
This JavaScript must somehow go in your webpage:

*Note these can be anything:*
  - `vipAjax`
  - `doAjax`
  - `ajax_changes`
  - `ajax`
  - `ajaxHandler`

*Note this JavaScript function has settings:*
  - `ajaxHandler.open(method, file, asynchronous_tf);`

```js
function vipAjax() { // vipAjax can be anything
  var ajax;
  ajax = new XMLHttpRequest();
  return ajax;
}

function doAjax() { // doAjax can be anything
  var ajaxHandler = vipAjax();
  ajaxHandler.onreadystatechange = function() {
    if (ajaxHandler.readyState == 4 && ajaxHandler.status == 200) {
      // ajax_changes can be anything, it also is the HTML id
      document.getElementById("ajax_changes").innerHTML = ajaxHandler.responseText;
    }
  }
  ajaxHandler.open("GET", "ajax_responder.php", true); // GET could be POST
  ajaxHandler.send();
}
```
##### HTML:

```html
<div id="ajax_changes">Replace me with AJAX</div>
<button onclick="doAjax();">Go AJAX!</button>
```

*Let's try...*

### AJAX without PHP

| **1** :$

```console
sudo cp core/06-ajax1.html web/ajax.html && \
sudo cp core/06-ajaxresponder1.txt web/ajax_responder.txt && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax1.html core/06-ajaxresponder1.txt && \
ls web
```

*Note we are using .html and .txt files, not .php*

AJAX payload:

```javascript
ajaxHandler.open("GET", "ajax_responder.php", true); // GET could be POST
ajaxHandler.send();
```

| **B-1** ://

```console
localhost/web/ajax.html
```

*Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

- *Click the button "Go AJAX!"*

*Note:*

- *the entire page did* ***not*** *reload, only the line "Replace me with AJAX" changed*
- *AJAX worked on an .html page without any PHP*
- *AJAX responded with a .txt file without any PHP*

*Try a PHP counter to see if the page actually reloads...*

### AJAX with PHP

| **2** :$

```console
sudo cp core/06-ajax2.php web/ajax.php && \
sudo cp core/06-ajaxresponder2.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax2.php core/06-ajaxresponder2.php && \
ls web
```

*Note we are using .php files, no longer .html and .txt*

*The AJAX code is the same except that we are using `$_SESSION['count']` to show how many times the page has loaded*

AJAX payload:

```javascript
ajaxHandler.open("GET", "ajax_responder.php", true); // GET could be POST
ajaxHandler.send();
```

| **B-2** ://

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*
- *Reload the page several times to watch the SESSION count go up on reload*
- *Click the button "Go AJAX!"*
- *Reload the page again a few times*

*Note the counter doesn't increment on AJAX, only on reload...*

***...because AJAX does not reload the page!***

### AJAX Method: POST

| **3** :$

```console
sudo cp core/06-ajax3.php web/ajax.php && \
sudo cp core/06-ajaxresponder3.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax3.php core/06-ajaxresponder3.php && \
ls web
```

Now, we use `POST`

```javascript
ajaxHandler.open("POST", "ajax_responder.php", true); // POST could change to GET

// Send: &_POST['foo'] = 'AJAX'; &_POST['bar'] = '5';
ajaxHandler.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
ajaxHandler.send("foo=AJAX&bar=5");
```

*Note:*

  - *`ajax.php`*
  - *`ajax_responder.php`*

- *We are using POST, not GET:*
  - *`ajaxHandler.open("POST", "ajax_responder.php", true);`*
- *Added:*
  - *`ajaxHandler.setRequestHeader("Content-type", "application/x-www-form-urlencoded")`*
- *Defined POST content in a GET-URL-like string:*
  - *`ajaxHandler.send("go=AJAX&time=5")`*
- *ajax_responder.php processes POST arguments*

| **B-3** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*
- *Click the button "Go AJAX!"*
- *Note "AJAX" & "5" appear from our line: `go=AJAX&time=5`*

### AJAX Render JavaScript from PHP

| **4** :$

```console
sudo cp core/06-ajax4.php web/ajax.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax4.php && \
ls web
```

Use PHP variables to create the POST array:

```javascript
ajaxHandler.open("POST", "ajax_responder.php", true); // POST could change to GET

ajaxHandler.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
ajaxHandler.send(<?php echo '"foo='.$post_foo.'&bar='.$post_bar.'"'; ?>); // PHP generated statement
```

| **B-4** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*
- *Note the entire page is the same except our POST values*
- *Note we used PHP to echo the page with our variables*
- *Click the button "Go AJAX!"*
- *Note `$post_go` and `$post_time` replaced the values in the line: `go=AJAX&time=5`*

### AJAX Capture Data from a `<form>`
#### AJAX JavaScript:
JavaScript adapted from [Mozilla's Developer site, MND](https://developer.mozilla.org/en-US/docs/Learn/Forms/Sending_forms_through_JavaScript#Using_FormData_bound_to_a_form_element)

```js
window.addEventListener( "load", function () {
  function sendData() {
    const AJAX = new XMLHttpRequest(); // AJAX handler
    const FD = new FormData(FORM); // Bind to-send data to form element

    AJAX.addEventListener( "load", function(event) { // This runs when AJAX responds
      document.getElementById("ajax_changes").innerHTML = event.target.responseText;
    } ); // Change HTML on successful response

    AJAX.addEventListener( "error", function( event ) { // This runs if AJAX fails
      document.getElementById("ajax_changes").innerHTML =  'Oops! Something went wrong.';
    } );

    AJAX.open( "POST", "ajax_responder.php" ); // Send data, ajax_responder.php can be any file or URL

    AJAX.send( FD ); // Data sent is from the form
  } // sendData() function

  const FORM = document.getElementById( "ajaxForm" ); // Access <form id="ajaxForm">, id="ajaxForm" can be anything
  FORM.addEventListener( "submit", function ( event ) { // Takeover <input type="submit">
    event.preventDefault();
    sendData();
  } );

} );
```

#### AJAX Response PHP:
AJAX only sends this in response:

```php
echo $go;

echo '<br>';

echo $time;
```

#### AJAX HTML:

```html
<div id="ajax_changes">Replace me with AJAX</div>
<form id="ajaxForm">
```

Our AJAX JavaScript uses these two IDs (`id=`)

*Review the diagrams above along side the following few steps...*

| **5** :$

```console
sudo cp core/06-ajax5.php web/ajax.php && \
sudo cp core/06-ajaxresponder5.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax5.php core/06-ajaxresponder5.php && \
ls web
```

Changes:

```javascript
var ajaxHandler = new XMLHttpRequest();

// became:

const AJAX = new XMLHttpRequest();
```

Now we get the `_POST` array from a `<form>`

```javascript
const FD = new FormData(FORM);
...
AJAX.send(FD);
...
const FORM = document.getElementById("ajaxForm");
```

*Note ajax.php:*
- *The JavaScript is very different*
- *The `<form>` has attribute `id="ajaxForm"`*
  - *This is instead of a `<button>` with `onclick="doAjax();"`*
  - *The `<button>` way uses the button called AJAX*
- *This way has JavaScript use the `id=` to "take over" the `<form>`*
  1. *JavaScript gets the `<form>` data*
  2. *Then interrupts the `<input="submit">` button*
  3. *JavaScript runs AJAX to send the `<form>` data*
- ***This uses the JavaScript object called "`FormData`"***

| **B-5** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

1. Note:
  - "SESSION count:"
  - "Here always"
  - "Replace me with AJAX"
2. Click the button "Form AJAX!"
3. Change the input fields and try many times

### AJAX Capture Data from an *AJAX-Reloaded* `<form>`
In the previous example, JavaScript listens only to the `<form>` created at the first page load:

```js
const FORM = document.getElementById( "ajaxForm" ); // Access form
FORM.addEventListener( "submit", function ( event ) { // Takeover <input type="submit">
  event.preventDefault();
  sendData();
} );
```

If we AJAX-change the `<form>` itself using the AJAX response, AJAX will not interrupt that AJAX-responded `<form>`

So, to listen to a `<form>` created by an AJAX response, we must create an "event listener" that refreshes with each AJAX request

#### AJAX JavaScript:
JavaScript adapted from [Mozilla's Developer site, MND](https://developer.mozilla.org/en-US/docs/Learn/Forms/Sending_forms_through_JavaScript#Using_FormData_bound_to_a_form_element)

```js
window.addEventListener( "load", function () {
  function sendData() {
    const AJAX = new XMLHttpRequest(); // AJAX handler
    const FD = new FormData(form); // Bind to-send data to form element

    AJAX.addEventListener( "load", function(event) { // This runs when AJAX responds
      document.getElementById("ajax_changes").innerHTML = event.target.responseText;

      // Bind a new event listener every time the <form> is changed:
      form = document.getElementById( "ajaxForm" ); // Access <form id="ajaxForm">, id="ajaxForm" can be anything
      listenToForm(); // Listen to updated <form> after it is changed

    } ); // Change HTML on successful response

    AJAX.addEventListener( "error", function(event) { // This runs if AJAX fails
      document.getElementById("ajax_changes").innerHTML =  'Oops! Something went wrong.';
    } );

    AJAX.open("POST", "ajax_responder.php"); // Send data, ajax_responder.php can be any file or URL

    AJAX.send(FD); // Data sent is from the form

  } // sendData() function

  // Declare the variable the first time it is used, not a constant
  const form = document.getElementById("ajaxForm"); // Access <form id="ajaxForm">, id="ajaxForm" can be anything
  function listenToForm(){
    form.addEventListener( "submit", function(event) { // Takeover <input type="submit">
      event.preventDefault();
      sendData();
    } );
  }
  listenToForm();

} );
```

#### AJAX Response PHP:
AJAX sends the entire `<form>` again inside the response:

```php
echo '
'.$foo.'
<br>
'.$bar.'
<br>
<form id="ajaxForm">
  <input type="text" value="'.$foo.'" name="foo">
  <input type="text" value="'.$bar.'" name="bar">
  <input type="submit" value="Form AJAX!">
</form>
';
```

#### AJAX HTML:

```html
<div id="ajax_changes">Replace me with AJAX
  <form id="ajaxForm">...</form>
</div>
```

Our AJAX JavaScript uses these two IDs (`id=`)

This time, the `<form>` is wrapped in the `<div>` AJAX will change

*Review the diagrams above along side the following few steps...*

| **6** :$

```console
sudo cp core/06-ajax6.php web/ajax.php && \
sudo cp core/06-ajaxresponder6.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax6.php core/06-ajaxresponder6.php && \
ls web
```

*Note ajax.php:*
- *The JavaScript is very different*
- *The `<form>` uses `<input type="submit">`*
- *This way has JavaScript use the `id=` to "take over" the `<form>`*\
  1. *JavaScript listens for `<input="submit">` via `listenToForm();`*
  2. *JavaScript gets the form data*
  3. *Then interrupts `<input="submit">` when clicked*
  4. *AJAX responds with a new `<form>`*
  5. *JavaScript runs `listenToForm();` again, to listen for `<input="submit">` again*

| **B-6** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

1. Note:
  - "SESSION count:"
  - "Here always"
  - "Replace me with AJAX"
2. Click the button "Form AJAX!"
3. Note this is a new `<form>`:
  - "I am a new form created by AJAX"
  - "(made by AJAX)"
4. Change the input fields and try many times

*Note in the next examples, we will simplify our JavaScript into one function, among other things...*

### AJAX Capture Data from a `<form>` by `<button>`
In the previous two examples, we interrupted `<input type="submit">`

Here is a way to use a `<button>` to AJAX-capture the `<form>`

The `<input type="submit">` will not be interrupted and will not use AJAX

This can be useful if you want an optional AJAX button in your `<form>`

#### AJAX HTML:

```html
<button type="button" onclick="ajaxFormData('ajaxForm', 'ajax_responder.php', 'ajax_changes');">Button Form AJAX!</button>
```

#### AJAX JavaScript:

```js
function ajaxFormData(formID, postTo, ajaxUpdate) { // These arguments can be anything, same as used in this function
  // Bind a new event listener every time the <form> is changed:
  const FORM = document.getElementById(formID); // <form> by ID to access, formID is the JS argument in the function
  const AJAX = new XMLHttpRequest(); // AJAX handler
  const FD = new FormData(FORM); // Bind to-send data to form element

  AJAX.addEventListener( "load", function(event) { // This runs when AJAX responds
    document.getElementById(ajaxUpdate).innerHTML = event.target.responseText; // HTML element by ID to update, ajaxUpdate is the JS argument in the function
  } );

  AJAX.addEventListener( "error", function(event) { // This runs if AJAX fails
    document.getElementById(ajaxUpdate).innerHTML =  'Oops! Something went wrong.';
  } );

  AJAX.open("POST", postTo); // Send data, postTo is the .php destination file, from the JS argument in the function

  AJAX.send(FD); // Data sent is from the form

} // ajaxFormData() function
```

| **7** :$

```console
sudo cp core/06-ajax7.php web/ajax.php && \
sudo cp core/06-ajaxresponder7.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax7.php core/06-ajaxresponder7.php && \
ls web
```

*Note ajax.php:*
- *The JavaScript is simpler*
- *The `<button>` calls the AJAX JavaScript*
- *Because the `<button>` calls the AJAX JS function, we don't need to run the function on every AJAX response*


| **B-7** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

- *Use <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd> in browser to see the developer view*

1. Note:
  - "SESSION count:"
  - "Here always"
  - "Replace me with AJAX"
2. Click the button "Form AJAX!"
3. Note this is a new `<form>`:
  - "I am a new form created by AJAX"
  - "(made by AJAX)"
4. Change the input fields and try many times

## AJAX Security
Anyone can send their own AJAX requests to your ajax_handler.php file

Read more about AJAX security in the VIP cheat sheets: [AJAX Security](AJAX-security.md)

### AJAX Token
The `$_SESSION` is the same in both the client's web browser and for the AJAX handler, so we can match a random string to verify that it is the same `$_SESSION` and not a random AJAX inquiry

Create a token and store it in the `$_SESSION`

*DO NOT use `md5()`, it's too old*

```php
// DO NOT USE THIS!
$token = md5(rand(10000,99999));
```

*Use `bin2hex()` to create your token*

```php
$token = bin2hex(random_bytes(64));
```

*Store it in the `$_SESSION`, the AJAX handler will also be able to access it*

```php
$_SESSION['ajax_token'] = $token;
```

*Put the `_SESSION` token in the AJAX function on the sending page*

```javascript
AJAX.setRequestHeader("ajax-token", "<?php echo $ajax_token; ?>");
```

OR

```javascript
AJAX.setRequestHeader("ajax-token", "<?php echo $token; ?>");
```

*Note:*
  - `ajax-token` in `AJAX.setRequestHeader("ajax-token", ...)`
  - is `$_SERVER['HTTP_AJAX_TOKEN']` in the AJAX handler

| **ajax-send.php** :

```php
// Start a SESSION before our AJAX JavaScript function so we can use it
session_start();

// AJAX token
if ( empty($_SESSION['ajax_token']) ) {
  $ajax_token = bin2hex(random_bytes(64));
  $_SESSION['ajax_token'] = $ajax_token;
} else {
  $ajax_token = $_SESSION['ajax_token'];
}
...
```

| **ajax-send.php** : (in AJAX `<script>` function)

```javascript
...

// AJAX must first open!
AJAX.open(...);

// Add your token header; use the `_SESSION` array
AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION['token']; ?>");

// Finally send
AJAX.send(...);
```

| **ajax-handler.php** :

```php
session_start();

if ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION['ajax_token']) {
  
  $ajax_legit = true;
  
} else {
  
  echo "No script kiddies!";
  exit();
  
}
```

| **8** :$

```console
sudo cp core/06-ajax8.php web/ajax.php && \
sudo cp core/06-ajaxresponder8.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax8.php core/06-ajaxresponder8.php && \
ls web
```

*Note ajax.php:*
- *Before the JavaScript is our `_SESSION` AJAX token generator*
  - *`session_start();` is now above the JavaScript so that:*
    - *The token resides in the `_SESSION`*
    - *The `_SESSION` token can be used in the JavaScript*
- *The form works the same as in step 7*

```php
session_start();

// AJAX Token
if ( empty($_SESSION['ajax_token']) ) {
  $ajax_token = bin2hex(random_bytes(64));
  $_SESSION['ajax_token'] = $ajax_token;
} else {
  $ajax_token = $_SESSION['ajax_token'];
}
```

| **B-8** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

### AJAX Sending Host
Another layer of security can be half-certain that the AJAX request came from the same server that we intended, but this checks the header and so it could be programmed to lie

| **ajax-handler.php** :

```php
// Set the server
// $mysite = 'https://example.tld'; // can custom set it, such as in a config or database
$mysite = $_SERVER['SERVER_NAME']; // automatically retrieve host to confirm origin is from the same web server
$ajax_sending_page = 'my_sending_page.php';

// Confirm origin server and page
if ((!empty($_SERVER['HTTP_REFERER'])) && ($_SERVER['HTTP_REFERER'] === "$mysite/$ajax_sending_page")) {...}
```

| **9** :$

```console
sudo cp core/06-ajax9.php web/ajax.php && \
sudo cp core/06-ajaxresponder9.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax9.php core/06-ajaxresponder9.php && \
ls web
```

*Note ajax.php:*

- *We `echo` the `$_SERVER["SERVER_NAME"]` value, which should return as `localhost` on our local machine*
  - *This merely demonstreates what `$_SERVER["SERVER_NAME"]` is; we don't actually use it in our AJAX sending page*
- *The form works the same as in step 7*

```php
$mysite = $_SERVER['SERVER_NAME'];

...

echo '$_SERVER["SERVER_NAME"]:'." <code>$mysite</code> // which we use to check in our AJAX handler<br><hr>";
```


| **B-9** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

### `_POST` Array

Rather than sending the token in the XML head, we can simply add the token as an item to the `_POST` array with the JavaScript `FD.append()` method

Instead of:

```javascript
AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION['token']; ?>");
```

Add an item to the `_POST`, *before or after* `.open`:

```javascript
// This can go either before or after AJAX.open()
FD.append('ajax_token', <?php echo $_SESSION['token']; ?>);

AJAX.open(...);
```

And, in the AJAX handler, instead of:

```php
if ( $_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION['ajax_token'] ) {...}
```

Simply check a `_POST` value:

```php
if ( $_POST['ajax_token'] === $_SESSION['token'] ) {...}
```

| **10** :$

```console
sudo cp core/06-ajax10.php web/ajax.php && \
sudo cp core/06-ajaxresponder10.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax10.php core/06-ajaxresponder10.php && \
ls web
```

*Note:*
- *ajax.php:*
  - *We `.append` to the `$_POST` array the `'ajax_token'` key:*
    - `FD.append('ajax_token', <?php echo $_SESSION['ajax_token']; ?>);`
  - *The form works the same as in step 7*
- *ajax_responder.php:*
  - *Displays `$_POST["ajax_token"]` in the response*

| **B-10** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

### `<meta>` Token
We can place our token inside the HTML document itself and retriev it with JavaScript

This could be handy if, for any reason, our JavaScript can't be modified by PHP, so it can get the token directly from the HTML

| | **ajax-send.php** :

```html
<head>

  <?php
  
  session_start();

  if ( empty($_SESSION['ajax_token']) ) {
    $ajax_token = bin2hex(random_bytes(64));
    $_SESSION['ajax_token'] = $ajax_token;
  } else {
    $ajax_token = $_SESSION['ajax_token'];
  }

  ?>

  <!-- We add the token here -->
  <meta name="ajax_token" content="<?php echo $ajax_token; ?>" />

</head>
<body>

  <script>
    function ajaxFormData(formID, postTo, ajaxUpdate) {

      const FORM = document.getElementById(formID);
      const AJAX = new XMLHttpRequest();
      const FD = new FormData(FORM);

      // Get our token from the HTML <head><meta>
      const TOKEN = document.querySelector('meta[name="ajax_token"]').content;

      AJAX.addEventListener( "load", function(event) {
        document.getElementById(ajaxUpdate).innerHTML = event.target.responseText;
      } );

      AJAX.addEventListener( "error", function(event) {
        document.getElementById(ajaxUpdate).innerHTML =  'Oops! Something went wrong.';
      } );

      // Append another item in the _POST array keyed 'ajax_token'
      FD.append('ajax_token', TOKEN);

      // OPEN before setRequestHeader
      AJAX.open("POST", postTo);

      // Create our token header
      AJAX.setRequestHeader("ajax-token", TOKEN);

      AJAX.send(FD);

    }
  </script>
```

| | **ajax-handler.php** :

```php
if ((!empty($_POST['ajax_token'])) && ($_POST['ajax_token'] === $_SESSION["ajax_token"])) {
  
  $ajax_post_legit = true;
  
} else {
  
  echo "No script kiddies!";
  exit();
}
  
if ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION["ajax_token"]) {
  
  $ajax_http_legit = true;
  
} else {
  
  echo "No script kiddies!";
  exit();
}
```

*Note, these are redundant; only one is needed:*

```javascript
FD.append()
AJAX.setRequestHeader()
```

*...appear in the AJAX handler...*

```php
$_POST['ajax_token']
$_SERVER['HTTP_AJAX_TOKEN']
```

| **11** :$

```console
sudo cp core/06-ajax11.php web/ajax.php && \
sudo cp core/06-ajaxresponder11.php web/ajax_responder.php && \
sudo chown -R www:www /srv/www/html && \
code core/06-ajax11.php core/06-ajaxresponder11.php && \
ls web
```

*Note the `$ajax_token` is already set*

Inside `<head>`:

```html
<head>
  ...
  <meta name="ajax_token" content="<?php echo $ajax_token; ?>" />
  ...
</head>
```

Inside our AJAX function:

```javascript
const TOKEN = document.querySelector('meta[name="ajax_token"]').content;
...

// Add to both the POST and the HTTP header
FD.append('ajax_token', TOKEN);
AJAX.open("POST", postTo); // Before setRequestHeader
AJAX.setRequestHeader("ajax-token", TOKEN);
```


| **B-11** :// (<kbd>Ctrl</kbd> + <kbd>R</kbd> to reload)

```console
localhost/web/ajax.php
```

### AJAX Security Summary
- While you can check the *claimed* sending server from the header, that doesn't prove much
- Testing a token that we created and stored in the `_SESSION` is quite fool proof
  - Except for a brute force attack testing millions of tokens; any brute force prevention should stop that

___

# The Take
## AJAX: Asynchronous JavaScript and XML
- JavaScript was created in 1995 by Netscape to compete with Microsoft
- JavaScript loads as it goes, unlike PHP
  - "Asynchronous"
  - Allows animation
- JavaScript animates pieces of HTML and CSS
- AJAX is JavaScript "animating" part of a page without the page loading/reloading

## XML (eXtensible Markup Language)
- XML looks like HTML, but you can use any tag you want
- XML was created in 1996, HTML in 1993
- ***AJAX can use either*** **XML** or **JSON**
  - JSON is an alternative to XML
  - JSON may be more common in AJAX

## AJAX Updates Part of a Page
- The AJAX part of the page is the only part that changes
- The rest of the page does not reload nor change
- We used a PHP counting loop to see the difference between the AJAX and the rest of the page
  - The difference can be anything, especially a large page that you don't want to reload

## Use PHP to `echo` HTML
- Using PHP to `echo` the HTML document allows us to put variables everywhere
  - Variables can also change embedded JavaScript

## AJAX a `<form>`
- AJAX can handle an HTML `<form>` via `id=` and "taking over"
- This:
  1. Obtains POST data via `<form id="some_ID">` instead of `ajaxHandler.send( ... )`
  2. "Takes over" the `<input type="submit">` button
    - The form doesn't actually submit, JavaScript does something else instead
- **This uses the JavaScript object: "`FormData`"**
  - You can study this more on your own

## AJAX a `<form>` via `<button>`
- AJAX can handle an HTML `<form>` via `<button>` rather than `<input type="submit">`
  - The `<input type="submit">` still works as normal
- This:
  1. Uses `<button onclick="doAjax();">`
  2. Uses the JavaScript object "`FormData`", same as with any `<form>`
- You can also pass arguments: `<button onclick="doAjax(arg1, arg2, arg3);">`
  - This is handy in case there is more than one `<form>`, AJAX processor .php file, or HTML to update
  - These could include:
    - ID for which `<form>`
    - Which .php file to AJAX the data to
    - ID for which HTML element to update with the AJAX response

## AJAX Security
- Anyone can send an AJAX request to your AJAX handler
- A soft test looks at the "return address" or claimed http referer from the header
  - This checks if `$_SERVER['HTTP_REFERER']` starts with `$_SERVER['SERVER_NAME']` or matches a set URL
- The more fool-proof test is to create and match a token using the `$_SESSION`
  - The `$_SESSION` is the same in the AJAX handler as in the client's browser
  - Don't create the token with `md5()`
  - Create the token witn `bin2hex()`

___

#### [Lesson 7: Security Keys](https://github.com/inkVerb/vip/blob/master/501/Lesson-07.md)
