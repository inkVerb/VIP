# PHP 501
## Lesson 6: AJAX

Ready the CLI

`cd ~/School/VIP/501`

### This lesson uses two terminals and two browser windows!

Ready the secondary SQL terminal and secondary SQL browser

*(Ctrl + Shift + T for new terminal tab; Ctrl + PageUp/PageDown to switch tabs)*

| **S0** : `mysql -u admin -padminpassword` *(password in the terminal, not safe outside these lessons!)*

*(Ctrl + T for new browser tab; Ctrl + PageUp/PageDown to switch tabs)*

| **SB-0** :// `localhost/phpMyAdmin/` Username: `admin` Password: `adminpassword`

___


### AJAX: Asynchronous JavaScript and XML

AJAX loads or reloads only ***part*** of a webpage

#### JavaScript
- JavaScript is an animation language that works along side HTML and CSS
- Imagine:
  - HTML is a manikin
  - CSS is the clothing
  - JavaScript turns it into a moving robot
- This "moving robot" part of JavaScript allows AJAX to work
- We will ***not*** teach JavaScript in this course, but we will ***use*** some
  - You do not need to understand this JavaScript, only know where to put it
  - Please, study JavaScript on your own before using AJAX on a real website!

#### XML (eXtensible Markup Language)
- XML uses `<tags>` to sort information
- XML files can be used as a database in stead of SQL
- XML can be "parsed" (talked to) just like SQL "parses" (talks to) a database
- XML is the language of an RSS feed
- XML looks like HTML, but you can use any tag you want
- XML syntax:
```xml
<some_tag>
  Info goes here
</some_tag>
```
- We will ***not*** teach XML in this course, but we will "parse" it
- ***AJAX can use either*** **JSON** or **XML**
  - (JSON is an alternative to XML)

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
gedit web/ajax.html web/ajax_source.txt && \
ls web
```

*Note we are using .html and .txt files, not .php*

| **B-1** :// `localhost/web/ajax.html`

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
gedit web/ajax.php web/ajax_source.php && \
ls web
```

*Note we are using .php files, no longer .html and .txt*

| **B-2** :// `localhost/web/ajax.php`

- *Reload the page several times to watch the SESSION count go up on reload*
- *Click the button "Do AJAX!"*
- *Reload the page again a few times*

*Note the counter doesn't rise on AJAX, only on reload...*

***...because AJAX does not reload the page!***

### AJAX Method: POST





| **3** :
```
sudo cp core/06-ajax3.php web/ajax.html && \
sudo cp core/06-ajaxsource3.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/ajax.html && \
ls web
```

*gedit: Reload*

  - *ajax.php*
  - *ajax_source.php*


| **B-3** :// `localhost/web/ajax.php`








| **4** :
```
sudo cp core/06-ajax4.php web/ajax.html && \
sudo cp core/06-ajaxsource4.php web/ajax_source.php && \
sudo chown -R www-data:www-data /var/www/html && \
gedit web/ajax.html && \
ls web
```

*gedit: Reload*

  - *ajax.php*
  - *ajax_source.php*


| **B-4** :// `localhost/web/ajax.php`

| **S4** :> `SELECT id, fullname, email, favnumber FROM users;`

| **SB-4** ://phpMyAdmin **> users**


___

# The Take



___

#### [Lesson 7: Account & Settings](https://github.com/inkVerb/vip/blob/master/501-php/Lesson-07.md)
