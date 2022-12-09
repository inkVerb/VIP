# Shell 101
## Lesson 9: find

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
mkdir abc abc-dir
```

| **2** :$

```console
ls
```

*Search for files with `find`*

| **3** :$

```console
find "abc*"
```

*Note the error message*

| **4** :$

```console
find "/bin"
```

*Note it can find an absolute path, which starts with `/`*

*Specify to search somewhere; we'll search "here" (`.` = here)*

| **5** :$

```console
find . "abc"
```

*Note it found everything, it needs: `-name`*

| **6** :$

```console
find . -name "abc"
```

| **7** :$

```console
find . -name "abc*"
```

*...for "Directories": `-type d`*

| **8** :$

```console
find . -type d -name "abc*"
```

*...for "Files": `-type f`*

| **9** :$

```console
find . -type f -name "abc*"
```

| **10** :$

```console
touch abcsed.Setting
```

| **11** :$

```console
touch ink.png ink.PNG ink.jpg ink.JPG
```

| **12** :$

```console
mkdir png PNG jpg JPG
```

| **13** :$

```console
find . -name "png"
```

| **14** :$

```console
find . -name "*.png"
```

| **15** :$

```console
find . -name "*png"
```

*Note `find` is case-sensitive, ignore case with: `-iname`*

| **16** :$

```console
find . -iname "*png"
```

| **17** :$

```console
find . -iname "*jpg"
```

| **18** :$

```console
find . -type f -iname "*png"
```

| **19** :$

```console
find . -type d -iname "*png"
```

___

# The Take

- `find` searches for files
- `find` needs two arguments in order to work:
  - Location
  - `-name what-to-search-for`
  - Order: `find /path/to/search -name what-to-search-for`
- `*` is a "wildcard" for text
- `.` is considered text to search for, not "concatenate" as in some languages
  - `file.*` can return with "file.jpg", "file.png", and "file." (must contain a period)
  - `file*` can return with "file.jpg", "file.png", and "files.jpg" and "files" (even with no period)
  - `*.png` is a normal way to search for all PNG files
- ".png", ".jpg", ".pdf", ".doc", etc are called "(file) extensions"
- `find` is normally case-sensitive, unless using the `-iname` flag
- It may be best to name files with lowercase extensions because of how `find` works
- `find` uses `-type` flags to narrow results
  - `-type d` (directories only)
  - `-type f` (files only)

___

#### [Lesson 10: grep](https://github.com/inkVerb/vip/blob/master/101/Lesson-10.md)
