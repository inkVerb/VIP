# Shell 101
## Lesson 10: grep

`cd ~/School/VIP/shell/101`

___

| **1** : `echo "jjj" > abc/yoyo`

| **2** : `echo "Apple Jay" > abc/jayapple`

*Search contents inside files with* `grep`

| **3** : `grep jj *`

*Note the error about directories*

| **4** : `grep jj *.*`

*Like* `cp -r`*,* `rm -r`*,* *and* `chown -R`*,* `grep` *also needs* `-R` *with directories*

| **5** : `grep -R jj *`

*...no error*

| **6** : `grep -R Apple *`

| **7** : `grep -R Apples like *`

*Notice the errors, you must "quote" multiple words with spaces*

| **8** : `grep -R "Apples like" *`

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
