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
  - `ajax_thing`

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
      // ajax_thing can be anything, it also is the HTML id
      document.getElementById("ajax_thing").innerHTML = ajaxHandler.responseText;
    }
  }
  ajaxHandler.open("GET", "ajax_source.php", true); // GET could be POST
  ajaxHandler.send();
}
```
##### HTML:

```html
<div id="ajax_thing">Replace me with AJAX</div>
<button onclick="doAjax();">Go AJAX!</button>
```

*Let's try...*

### AJAX without PHP

| **1** :
```
sudo cp core/06-ajax1.html web/ajax.html && \
sudo cp core/06-ajaxsource1.txt web/ajax_source.txt && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/ajax.html web/ajax_source.txt && \
ls web
```

*Note we are using .html and .txt files, not .php*

| **B-1** :// `localhost/web/ajax.html`

*Use Ctrl + Shift + C in browser to see the developer view*

- *Click the button "Do AJAX!"*

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
atom web/ajax.php web/ajax_source.php && \
ls web
```

*Note we are using .php files, no longer .html and .txt*

| **B-2** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Reload the page several times to watch the SESSION count go up on reload*
- *Click the button "Do AJAX!"*
- *Reload the page again a few times*

*Note the counter doesn't rise on AJAX, only on reload...*

***...because AJAX does not reload the page!***

### AJAX Method: POST

| **3** :
```
sudo cp core/06-ajax3.php web/ajax.php && \
sudo cp core/06-ajaxsource3.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/ajax.php && \
ls web
```

*atom: Reload*

- *ajax.php*
- *ajax_source.php*

*Note:*

- *We are using POST, not GET:*
  - *ajaxHandler.open("POST", "ajax_source.php", true);*
- *Added:*
  - *`ajaxHandler.setRequestHeader("Content-type", "application/x-www-form-urlencoded")`*
- *Defined POST content in a GET-URL-like string:*
  - *`ajaxHandler.send("go=AJAX&time=5")`*
- *ajax_source.php processes POST arguments*

| **B-3** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Click the button "Do AJAX!"*
- *Note "AJAX" & "5" appear from our line: `go=AJAX&time=5`*

### AJAX Render JavaScript from PHP

| **4** :
```
sudo cp core/06-ajax4.php web/ajax.php && \
sudo chown -R www-data:www-data /var/www/html && \
atom web/ajax.php && \
ls web
```

*atom: Reload*

- *ajax.php*

| **B-4** :// `localhost/web/ajax.php`

- *Use Ctrl + Shift + C in browser to see the developer view*
- *Note the entire page is the same except our POST values*
- *Note we used PHP to echo the page with our variables*
- *Click the button "Do AJAX!"*
- *Note `$post_go` and `$post_time` replaced the values in the line: `go=AJAX&time=5`*

### Further Study

Using a `<form>` to submit an AJAX request involves deeper knowledge of JavaScript, which is beyond the scope of this course

You can use PHP variables to customize the POST arguments of your AJAX request, which does not require a `<form>`

For now, this should be enough to keep you busy with PHP and AJAX

If you want to AJAX a `<form>`, learn more about the JavaScript object called "FormData"

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

## AJAX with an HTML `<form>`
- AJAX can handle an HTML `<form>`, but that involves complext JavaScript
  - Start by studying the JavaScript object: "FormData"

___

#### [Lesson 7: Security Keys](https://github.com/inkVerb/vip/blob/master/501-shell/Lesson-07.md)
