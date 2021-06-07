# In the terminal, create the headers for .sh, .xml, .html & .php files

___

## Prep Folders

*Watch in the file explorer if you want, in your School folder*

Open Terminal <kbd>F12</kbd> (if Vrk or Guake is installed) / <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> (normal)*

`cd `

*IF* you don't have a `School` folder, create it: `mkdir School`

`cd School`

`mkdir VIP`

`ls`

`cd VIP`

`nautilus .`

`mkdir shell`

`ls`

`mkdir xml html php`

`ls`

Each of these folders is for different projects.

### Create proper headers

##### SH script

`gedit head.sh`

Copy and paste: <kbd>Ctrl</kbd> + <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>

`#!/bin/sh`

Save: <kbd>Ctrl</kbd> + <kbd>S</kbd>

Close: <kbd>Alt</kbd> + <kbd>F4</kbd>

`ls`

##### XML

`gedit head.xml`

Copy and paste: <kbd>Ctrl</kbd> + <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>

`<?xml version="1.0" encoding="utf-8"?>`

Save: <kbd>Ctrl</kbd> + <kbd>S</kbd>

Close: <kbd>Alt</kbd> + <kbd>F4</kbd>

`ls`

##### HTML

`gedit head.html`

Copy and paste: <kbd>Ctrl</kbd> + <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>

`<!DOCTYPE html>`

`<html>`

`<head>`

`<title></title>`

`</head>`

`<body>`

` `

`</body>`

`</html>`

Save: <kbd>Ctrl</kbd> + <kbd>S</kbd>

Close: <kbd>Alt</kbd> + <kbd>F4</kbd>

`ls`

##### PHP

`gedit head.php`

Copy and paste: <kbd>Ctrl</kbd> + <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>

`<?php`

`?>`

Save: <kbd>Ctrl</kbd> + <kbd>S</kbd>

Close: <kbd>Alt</kbd> + <kbd>F4</kbd>

`ls`

### Move files

Move everything into place

`mv head.sh shell`

`mv head.xml xml`

`mv head.html html`

`mv head.php php`

`ls`

### Note

To edit any file, html for example, type:

```console
u@linux:$ cd 
u@linux:$ cd School/VIP/html
u@linux:$ gedit new.html
```

...And get coding!
