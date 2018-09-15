# In the terminal, create the headers for .sh, .xml, .html & .php files

___

## Prep Folders

*Watch in the file explorer if you want, in your School folder*

Open Terminal *F12 (if Vrk or Guake is installed) / Ctrl + Alt + T (normal)*

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

Copy and paste. *Ctrl + C, Ctrl + V*

`#!/bin/sh`

Save *Ctrl + S*

Close *Alt + F4*

`ls`

##### XML

`gedit head.xml`

Copy and paste. *Ctrl + C, Ctrl + V*

`<?xml version="1.0" encoding="utf-8"?>`

Save *Ctrl + S*

Close *Alt + F4*

`ls`

##### HTML

`gedit head.html`

Copy and paste. *Ctrl + C, Ctrl + V*

`<!DOCTYPE html>`

`<html>`

`<head>`

`<title></title>`

`</head>`

`<body>`

` `

`</body>`

`</html>`

Save *Ctrl + S*

Close *Alt + F4*

`ls`

##### PHP

`gedit head.php`

Copy and paste. *Ctrl + C, Ctrl + V*

`<?php`

`?>`

Save *Ctrl + S*

Close *Alt + F4*

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

`cd `

`cd School/VIP/html`

`gedit new.html`

...And get coding!
