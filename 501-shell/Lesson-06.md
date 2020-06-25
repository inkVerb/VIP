# Shell 501
## Lesson 6: AJAX

Ready the CLI

`cd ~/School/VIP/501`

___


### AJAX: Asynchronous JavaScript and XML

AJAX loads or reloads only ***part*** of a webpage

#### JavaScript: Asynchronous Animation
- JavaScript loads as its goes, before finishing the script
  - Called "asynchronous"
  - Different from PHP Rule 1: Render *after* the script
  - This lets JavaScript animate and move
- JavaScript was created in 1995 by Netscape to compete with Microsoft
- JavaScript animates pieces of HTML and CSS
- Remember [Lesson 0: HTML Fast](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-00.md#html--css-crash-course):
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
- ***AJAX can use either*** **XML** or **JSON**
  - JSON is an alternative to XML
  - JSON may be more common in AJAX
- - We will ***not*** teach XML or JSON in this course

#### AJAX Components

##### JavaScript:

This JavaScript must somehow go in your webpage:

*Note these can be anything:*
  - `vipAjax`
  - `doAjax`
  - `ajax_changes`

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
  ajaxHandler.open("GET", "ajax_source.php", true); // GET could be POST
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

| **1** :
```
sudo cp core/06-ajax1.html web/ajax.html && \
sudo cp core/06-ajaxsource1.txt web/ajax_source.txt && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/06-ajax1.html core/06-ajaxsource1.txt && \
ls web
```

*Note we are using .html and .txt files, not .php*

| **B-1** :// `localhost/web/ajax.html`

*Use Ctrl + Shift + C in browser to see the developer view*

- *Click the button "Go AJAX!"*

*Note:*

- *the entire page did* ***not*** *reload, only the line "Replace me with AJAX"*
- *AJAX worked on an .html page without any PHP*
- *AJAX sourced a .txt file without any PHP*

*Try a PHP counter to see if it actually reloads...*

### AJAX with PHP

| **2** :
```
sudo cp core/06-ajax2.php web/ajax.php && \
sudo cp core/06-ajaxsource2.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/06-ajax2.php core/06-ajaxsource2.php && \
ls web
```

*Note we are using .php files, no longer .html and .txt*

| **B-2** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Reload the page several times to watch the SESSION count go up on reload*
- *Click the button "Go AJAX!"*
- *Reload the page again a few times*

*Note the counter doesn't rise on AJAX, only on reload...*

***...because AJAX does not reload the page!***

### AJAX Method: POST

| **3** :
```
sudo cp core/06-ajax3.php web/ajax.php && \
sudo cp core/06-ajaxsource3.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom wecore/06-ajax3.php core/06-ajaxsource3.php && \
ls web
```

*Note:*

  - *ajax.php*
  - *ajax_source.php*

- *We are using POST, not GET:*
  - *ajaxHandler.open("POST", "ajax_source.php", true);*
- *Added:*
  - *`ajaxHandler.setRequestHeader("Content-type", "application/x-www-form-urlencoded")`*
- *Defined POST content in a GET-URL-like string:*
  - *`ajaxHandler.send("go=AJAX&time=5")`*
- *ajax_source.php processes POST arguments*

| **B-3** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Click the button "Go AJAX!"*
- *Note "AJAX" & "5" appear from our line: `go=AJAX&time=5`*

### AJAX Render JavaScript from PHP

| **4** :
```
sudo cp core/06-ajax4.php web/ajax.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/06-ajax4.php && \
ls web
```

| **B-4** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Note the entire page is the same except our POST values*
- *Note we used PHP to echo the page with our variables*
- *Click the button "Go AJAX!"*
- *Note `$post_go` and `$post_time` replaced the values in the line: `go=AJAX&time=5`*

### AJAX a `<form>` via JavaScript & PHP

#### AJAX Components

##### JavaScript:

JavaScript adapted from [Mozilla's Developer site, MND](https://developer.mozilla.org/en-US/docs/Learn/Forms/Sending_forms_through_JavaScript#Using_FormData_bound_to_a_form_element)

```js
window.addEventListener( "load", function () {
  function sendData() {
    const AJAX = new XMLHttpRequest(); // AJAX handler
    const FD = new FormData( form ); // Bind to-send data to form element

    AJAX.addEventListener( "load", function(event) {
      document.getElementById("ajax_changes").innerHTML = event.target.responseText;
    } ); // Change HTML on successful response

    AJAX.addEventListener( "error", function( event ) {
      document.getElementById("ajax_changes").innerHTML =  'Oops! Something went wrong.';
    } );

    AJAX.open( "POST", "ajax_source.php" ); // Send data, ajax_source.php can be any file or URL

    AJAX.send( FD ); // Data sent is from the form
  } // sendData() function

  const form = document.getElementById( "ajaxForm" ); // Access form
  form.addEventListener( "submit", function ( event ) { // Takeover <input type="submit">
    event.preventDefault();
    sendData();
  } );

} );
```

##### HTML:

```html
<div id="ajax_changes">Replace me with AJAX</div>
<form id="ajaxForm">
```

Our AJAX JavaScript uses these two IDs

| **5** :
```
sudo cp core/06-ajax5.php web/ajax.php && \
sudo cp core/06-ajaxsource5.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom core/06-ajax4.php && \
ls web
```

*Note ajax.php:*
- *The JavaScript is very different*
- *The `<form>` has attribute `id="ajaxForm"`*
  - *This is instead of a `<button>` with `onclick="doAjax();"`*
  - *The `<button>` way has the button call AJAX*
- *This way has JavaScript use the `id=` to "take over" the `<form>`*
  1. *JavaScript gets the form data*
  2. *Then interrupts the `<input="submit">` button*
- ***This uses the JavaScript object called "`FormData`"***

| **B-5** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Note:*
  - *SESSION count*
  - *Here always*
  - *Replace me with AJAX*
- *Click the button "Form AJAX!"*
- *Change the input fields and try many times*

___

# The Take

## AJAX: Asynchronous JavaScript and XML
- JavaScript was created in 1995 by Netscape to compete with Microsoft
- JavaScript loads as it goes, unlike PHP
  - "Asynchronous"
  - Allows animation
- JavaScript animates pieces of HTML and CSS
- AJAX is JavaScript "animating" part of a page into loading/reloading

## XML (eXtensible Markup Language)
- XML looks like HTML, but you can use any tag you want
- XML was created in 1996, HTML in 1993
- ***AJAX can use either*** **XML** or **JSON**
  - JSON is an alternative to XML
  - JSON may be more common in AJAX

## AJAX Reloads Part of a Page
- The AJAX part of the page is the only part that reloads
- We can see that the AJAX part changes, but not the rest of the page
- We used a PHP counting loop to see the difference between the AJAX and the rest of the page
  - The difference can be anything, especially a large page that you don't want to reload

## Use PHP to `echo` HTML
- Using PHP to `echo` the HTML document allows us to put variables everywhere
  - Variables can also change embedded JavaScript

## AJAX a `<form>`
- AJAX can handle an HTML `<form>` via `id=` and "taking over"
- This:
  1. Uses `<form id="some_ID">` instead of `<button onclick="doAjax();">`
  2. "Takes over" the `<input type="submit">` button
    - The form doesn't actually submit, JavaScript does something else instead
- **This uses the JavaScript object: "`FormData`"**
  - You can study this more on your own

___

#### [Lesson 7: Security Keys](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-07.md)
