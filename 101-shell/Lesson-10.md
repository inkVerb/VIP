# Shell 101
## Lesson 10: grep

`cd ~/School/VIP/shell/101`

___

*Look inside the "abc" directory in the Nautilus file explorer*

| **1** : `echo "jjj" > abc/yoyo`

| **2** : `echo "Apple Jay" > abc/jayapple`

*Take a peek at those just-made files*

| **3** : `gedit abc/*`

*Search contents inside files with `grep`*

| **4** : `grep jj *`

*Note the error about directories*

| **5** : `grep jj *.*`

*Like `cp -r`, `rm -r`, and `chown -R`, `grep` also needs `-R` with directories*

| **6** : `grep -R jj *`

*...no error*

| **7** : `grep -R Apple *`

| **8** : `grep -R Apples like *`

*Notice the errors, you must "quote" multiple words with spaces*

| **9** : `grep -R "Apples like" *`

___

# The Take

- `grep` searches the contents of files
- `grep` needs two arguments in order to work:
  - Contents to search
  - Location
  - Order: `grep what-to-search-for /files/to/search`
  it can search them also
- `grep` can search within and for wildcards `*`, much like `find`
- If there are directories in the search location, `grep` wants the `-R` option so

___

#### [Lesson 11: Quote/Escape Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-11.md)
