# Code Headers

In the terminal, create the headers for .sh, .xml, .html & .php files

___

## Reference

Open Terminal: <kbd>F12</kbd> (if you have a drop-down terminal) / <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd> (normal)*

Copy and paste: <kbd>Ctrl</kbd> + <kbd>C</kbd>, <kbd>Ctrl</kbd> + <kbd>V</kbd>

Save: <kbd>Ctrl</kbd> + <kbd>S</kbd>

Close: <kbd>Alt</kbd> + <kbd>F4</kbd>

## Prep Folders

*Watch in the file explorer if you want, in your School folder*

| **1** :$

```console
mkdir -p ~/School/VIP
cd ~/School/VIP
nautilus .
```

*Observe the changes in the file explorer*

| **2** :$

```console
mkdir shell
ls
mkdir xml html php
ls
```

*Each of these folders is for different projects*

### Create proper headers

##### SH script

| **3** :$

```console
gedit head.sh
```

| **head.sh** :

```sh
#!/bin/sh
```

| **4** :$

```console
ls
```

##### XML

| **5** :$

```console
gedit head.xml
```

| **head.xml** :

```xml
<?xml version="1.0" encoding="utf-8"?>
```

| **6** :$

```console
ls
```

##### HTML

| **7** :$

```console
gedit head.html
```

| **head.html** :

```html
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

</body>
</html>
```

| **8** :$

```console
ls
```

##### PHP

| **9** :$

`gedit head.php`

| **head.php** :

```php
<?php
?>
```

| **10** :$

```console
ls
```

### Move files

*Move everything into place*

| **11** :$

```console
mv head.sh shell
mv head.xml xml
mv head.html html
mv head.php php
ls
```

### Note

*To edit any file, html for example, type*

| **12** :$

```console
cd ~/School/VIP/html
gedit new.html
```

...And get coding!
