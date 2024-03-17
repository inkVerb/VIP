# Linux 101
## Lesson 10: grep

Ready the CLI

```console
cd ~/School/VIP/101
```

___

*Look inside the "`abc`" directory in the Nautilus file explorer*

| **1** :$

```console
echo "jjj" > abc/yoyo
```

| **2** :$

```console
echo "Apple Jay" > abc/jayapple
```

*Take a peek at those just-made files*

| **3** :$

```console
gedit abc/*
```

*Search for a **text string** inside file contents with `grep`*

| **4** :$

```console
grep jj *
```

*Note the error about directories*

*Like `cp -r`, `rm -r`, and `chown -R`, `grep` also needs the `-R` flag with directories*

*`-R` and `-r` flags often stands for **recursive**, meaning "and inside directories"*

| **5** :$

```console
grep -R jj *
```

*...no error*

| **6** :$

```console
grep -R Apple *
```

| **7** :$

```console
grep -R Apples like *
```

*Notice the error; you must "quote" the **search string** when using multiple words with spaces as a single argument*

| **8** :$

```console
grep -R "Apples like" *
```

___

# Glossary
- **recursive** - "and in directories", used in many file and text search/copy/delete operations, often done with `-r` or `-R` flags
- **search string** - A text string that you search for
- **text string** - Many letters, numbers, special characters, and spaces together as one group of text

# The Take
- `grep` searches the contents of files
- `grep` needs two arguments in order to work:
  - Contents to search
  - Location
  - Order: `grep what-to-search-for /files/to/search`
  it can search them also
- `grep` can search within and for wildcards `*`, much like `find`
- If there are directories in the search location, `grep` wants the `-R` option
- Use `"quotes to contain spaces"` in the search text

___

#### [Lesson 11: Special Characters](https://github.com/inkVerb/vip/blob/master/101/Lesson-11.md)
