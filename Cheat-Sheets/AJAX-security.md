# Sending Securely in AJAX

*Learn more about AJAX in [Linux 501 Lesson 6](https://github.com/inkVerb/vip/blob/master/501/Lesson-06.md)*

Anyone canlook in the browser developer tools and mess with your website

Security with AJAX is important

SESSION is the same for both the client's browser and the AJAX handler on the server

- Use `session_start();` inside your AJAX responder so you can use all `$_SESSION` variables in the same PHP script as your AJAX sending page

## Use `$_POST`

```php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  $post_method = true;
}
```

## Ensure the `$_SERVER['HTTP_REFERER']` is from your own site

```php
if ( (!empty($_SERVER['HTTP_REFERER']))
&&   ($_SERVER['HTTP_REFERER'] === "https://example.tld/my_sending_page.php") ) {
  $from_my_server = true;
} 
```

You can see what this should be, instead of `https://example.tld` with a simple test on your server:

```php
echo $_SERVER['HTTP_REFERER'];
```

## Use a token
This is the hard part, but not too hard.

1. Create the token
2. Set the token in `$_SESSION`
3. Put the token in the AJAX header
4. AJAX responder: confirm the AJAX header token with the `$_SESSION` token

### XML Header

**send_from_me.php**

```php
// Create the token
//$token = md5(rand(10000,99999));  // Not recommended, but possible
$token = bin2hex(random_bytes(64));

// Store in SESSION
$_SESSION['token'] = $token;
```

```js
// Assuming your AJAX is this
const AJAX = new XMLHttpRequest();

...

// This goes inside your AJAX function somewhere after AJAX.open and before AJAX.send
//
AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION['token']; ?>");
//
// That creates $_SERVER['HTTP_AJAX_TOKEN'] which we can use later
```

`AJAX.setRequestHeader("ajax-token", ...)` will become `$_SERVER['HTTP_AJAX_TOKEN']` in the AJAX handler

**ajax_responder.php**

```php
session_start(); // Must have

if ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION['token']) {
  $token_match = true;
} else {
  echo "No script kiddies!";
  exit();
}

// Now it's safe for your AJAX responder to proceed
```

*It could be a good idea to check that the AJAX request came from the same server or whatever page or address we intended*

*But, remember that `$_SERVER['HTTP_REFERER']` can lie because the information comes from the header, which is programmable, so host/server checks like this is only prevent accidents or novice hack attacks...*

```php
// Set the server
// $mysite = 'https://example.tld'; // can custom set it, such as in a config or database
$mysite = $_SERVER['SERVER_NAME']; // automatically retrieve host to confirm origin is from the same web server
$ajax_sending_page = 'my_sending_page.php';

// Confirm origin server and page
if ((!empty($_SERVER['HTTP_REFERER'])) && ($_SERVER['HTTP_REFERER'] === "$mysite/$ajax_sending_page")) {...}
```

#### Working example

**sending_from.php**

```php
<?php

session_start();

$token = bin2hex(random_bytes(64));
$_SESSION['token'] = $token;

?>

<!DOCTYPE html>
<html>
  <head>
    <title>My AJAX Sender</title>
  </head>
  <body>

    <script>
      function ajaxFormData(formID, postTo, ajaxUpdate) {

        // Bind a new event listener every time the <form> is changed:
        const FORM = document.getElementById(formID); // <form> by ID
        const FD = new FormData(FORM); // Bind to-send data to form element
        const AJAX = new XMLHttpRequest(); // AJAX handler

        // This runs when AJAX responds
        AJAX.addEventListener( "load", function(event) {
          document.getElementById(ajaxUpdate).innerHTML = event.target.responseText;
        } );

        // This runs if AJAX fails
        AJAX.addEventListener( "error", function(event) {
          document.getElementById(ajaxUpdate).innerHTML =  'Oops! Something went wrong.';
        } );

        // Open the POST connection before setRequestHeader
        AJAX.open("POST", postTo);

        // Add your token header
        AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION['token']; ?>");

        // Data sent is from the form
        AJAX.send(FD);

      }
    </script>

    <div id="ajax_changes">Replace me with AJAX</div>

      <form id="ajaxForm">
        <input type="text" name="the_simple_response">
        <button type="button" onclick="ajaxFormData('ajaxForm', 'ajax_responder.php', 'ajax_changes');">Send my Secure AJAX</button>
      </form>

  </body>
</html>
```

**ajaxcheck.inc.php**

```php
<?php

// Start the _SESSION so we can have access to the $_SESSION['token']
session_start();

// $mysite = 'https://example.tld'; // manually set host
$mysite = $_SERVER['SERVER_NAME']; // automatically retrieve host
$ajax_sending_page = 'my_sending_page.php';

// All in one test statement
if (($_SERVER['REQUEST_METHOD'] == 'POST')

// Confirm origin server and page
&& ((!empty($_SERVER['HTTP_REFERER'])) && ($_SERVER['HTTP_REFERER'] === "$mysite/$ajax_sending_page"))

// AJAX token test
&& ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION['token'])) {
  
  $ajax_legit = true;
  
} else {
  
  echo "No script kiddies!";
  exit();
  
}

?>
```

**ajax_responder.php**

```php
<?php
// Do all that checking we're learning about by neatly including the file above
require_once('ajaxcheck.inc.php');

// Process your AJAX
echo $_POST['the_simple_response'];

?>
```

### `_POST` Array

Rather than sending the token in the XML header, you can send it in the `_POST` array with the JavaScript `FD.append()` method

In the code above, instead of:

```javascript
AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION['token']; ?>");
```

Then, just add another item in the `_POST`, *BEFORE* `.open`:

```javascript
formData.append('ajax_token', '<?php echo $_SESSION['token']; ?>');

AJAX.open(...);
```

Then in the AJAX handler, instead of:

```php
if ( $_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION['token'] ) {...}
```

Just check a `_POST` value:

```php
if ( $_POST['ajax_token'] === $_SESSION['token'] ) {...}
```