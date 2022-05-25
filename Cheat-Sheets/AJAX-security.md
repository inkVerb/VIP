# Sending securely in AJAX

Anyone can mess with your website, look in the browser developer tools, and mess around

Security with AJAX is important

Running a SESSION is helpful

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

## Verify XMLHTTP/AJAX style request via `$_SERVER` array

```php
if ( (!empty($_SERVER['HTTP_X_REQUESTED_WITH']))
&&   ( strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') ) { 
  $ajax = true; 
} else { 
  $ajax = false; 
} 
```

## Use a token
This is the hard part, but not too hard.

1. Create the token
2. Set the token in `$_SESSION`
3. Put the token in the AJAX header
4. AJAX responder: confirm the AJAX header token with the `$_SESSION` token

**send_from_me.php**

```php
// Create the token
//$token = md5(rand(10000,99999));  // Not recommended, but possible
$token = bin2hex(random_bytes(64));

// Store in SESSION
$_SESSION["token"] = $token;
```

```js
// Assuming your AJAX is this
const AJAX = new XMLHttpRequest();

// This goes inside your AJAX function somewhere before AJAX.send
//
AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION["token"]; ?>");
//
// That creates $_SERVER['HTTP_AJAX_TOKEN'] which we can use later
```

**ajax_responder.php**

```php
session_start(); // Must have

if ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION["token"]) {
  $token_match = true;
} else {
  echo "No script kiddies!";
  exit();
}

// Now it's safe for your AJAX responder to proceed

```

# Let's put all of this into a working example

**sending_from.php**

```php
<?php

session_start();

$token = bin2hex(random_bytes(64));
$_SESSION["token"] = $token;

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

        // Add your token header
        AJAX.setRequestHeader("ajax-token", "<?php echo $_SESSION["token"]; ?>");

        // Open the POST connection
        AJAX.open("POST", postTo);

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

$mysite = 'https://example.tld';

// All in one test
if (($_SERVER['REQUEST_METHOD'] == 'POST')
&& ((!empty($_SERVER['HTTP_REFERER'])) && ($_SERVER['HTTP_REFERER'] === "$mysite/my_sending_page.php"))
&& ((!empty($_SERVER['HTTP_X_REQUESTED_WITH'])) && ( strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest'))
&& ($_SERVER['HTTP_AJAX_TOKEN'] === $_SESSION["token"])) {
  
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

session_start();

// Do all that checking we're learning about by neatly including the file above
require_once('ajaxcheck.inc.php');

// Process your AJAX
echo $_POST['the_simple_response'];

?>
```

