# Shell 401
## Lesson 7: More with while & sed

Ready the CLI

`cd ~/School/VIP/shell/401`

___

### I. Counter `while` Loop

*Edit this script to see the short version*

| **1** : `gedit loopcount`

*It should look like this:*

| **loopcount** :

```sh
#!/bin/sh

Max="$1"

Count=1

while [ "$Count" -le "$Max" ]; do
echo "Line No. $Count:	" >> countfile  # Note this contains a "tab"
Count=$(expr $Count + 1)
done
```

*Run it and watch carefully*

| **2** : `./loopcount 15`

| **3** : `ls`

*Note the file created: `countfile`*

| **4** : `gedit countfile`

### II. `sed` Special Characters

#### `.` period = concatenate

*Change "No." to "Number"...*

*`.` is escaped with `\` in this `sed` command...*

| **5** : `sed -i "s/No\./Number/" countfile`

*gedit: Reload countfile*

*Change "Number" to "Num"...*

| **6** : `sed -i "s/Nu*/Num/" countfile`

*gedit: Reload countfile*

*Note it now reads "Nummber" because `*` needs concatenating*

*Let's use `.*.` to replace anything between "Nu" and the space after...*

| **7** : `sed -i "s/Nu.*. /Num /" countfile`

*gedit: Reload countfile*

*Now it reads "Num" correctly*

*The period `.` means "more being added", in some circumstances, like `sed` and many programming languages*

#### `$` = "end of line"

This is the same in `vim`, so get used to it.

*Add something to the end of each line*

| **8** : `sed -i "s/$/_add2end/" countfile`

*gedit: Reload countfile*

#### `^` = "start of line"

*Add something to the start of each line*

| **9** : `sed -i "s/^/add2start_/" countfile`

*gedit: Reload countfile*

#### `\n` = new line

*Add a new line to the end of each line*

| **10** : `sed -i "s/$/\n/" countfile`

*gedit: Reload countfile*

#### `\t` = tab

*Replace each tab with the string " TAB "*

| **11** : `sed -i "s/\t/ TAB /" countfile`

*Let's change this "TAB" text into a pipe `|`*

| **12** : `sed -i "s/TAB/|/" countfile`

*gedit: Reload countfile*

*Let's put a tab after the "start_" string...*

| **13** : `sed -i "s/start_/start_\t/" countfile`

*gedit: Reload countfile*

## III. `sed` "Delimiter"

*The "delimiter" separates "foo" from "bar" in `sed "s/foo/bar/"`, here: `/`*

*The delimiter in `sed` can technically be anything!*

```
sed "s/foo/bar/"

sed "s:foo:bar:"

sed "s@foo@bar@"

sed "s?foo?bar?"

sed "s foo bar " # ...Yes, spaces too!

sed "s\afoo\abar\a" # ...Yes, \a can be a delimiter!
```

*This can help solve problems...*

*First, this is the most simple way to use `sed`...*

| **14** : `sed "s/foo/bar/" <<< food`

*What if we want to replace the slash...*

| **15** : `sed "s/foo/daa/bar/pii/" <<< foo/daa`

*...That didn't work because we must escape the delimeter...*

| **16** : `sed "s/foo\/daa/bar\/pii/" <<< foo/daa`

*...But, not with a different delimiter...*

| **17** : `sed "s:foo/daa:bar/pii:" <<< foo/daa`

*...Whatever you're content, use a different character for the delimiter...*

| **18** : `sed "s:foo.daa:bar.pii:" <<< foo.daa`

*Note we just searched `.` without escaping it; `.` doesn't **always** need escaped*

*And escape your delimiter character if you need it literal...*

| **19** : `sed "s:foo\:daa:bar\:pii:" <<< foo:daa`

*This may be useful in a script with a variable containing your delimiter*

| **20** : `echo "Your_City" > sedfile`

| **21** : `gedit sed-delim-var-1 sedfile`

| **22** : `./sed-delim-var-1 America/Chicago`

*Why the error? Let's look at what Linux saw...*

| **23** : `./sed-delim-var-2 America/Chicago`

*Try using a non-conflicting delimiter...*

| **24** : `gedit sed-delim-var-3`

| **25** : `./sed-delim-var-3 America/Chicago`

*Use any delimiter you want...*

| **26** : `./sed-delim-var-4 America/Chicago`

| **27** : `./sed-delim-var-5 America/Chicago`

*Almost every character...*

| **28** : `./sed-delim-var-6 America/Chicago`

*But, special characters can be escaped with `\` and still delimit...*

| **29** : `./sed-delim-var-7 America/Chicago`

### IV. `sed` wildcards

*Replace everything after a match*

| **30** : `sed "s/foo.*//" <<< 12345foo6789`

*...Keep the `foo`*

| **31** : `sed "s/foo.*/foo/" <<< 12345foo6789`

*Replace everything before a match*

| **32** : `sed "s/^.*foo//" <<< 12345foo6789`

*...Keep the `foo`*

| **33** : `sed "s/^.*foo/foo/" <<< 12345foo6789`

*Removing something in the middle*

| **34** : `sed "s/foo.*.bar//" <<< 12345fooSOMETHINGbar6789`

*...Keep the `foobar`*

| **35** : `sed "s/foo.*.bar/foobar/" <<< 12345fooSOMETHINGbar6789`

___

# The Take

- `while` can create an auto-counting loop when combined with `expr` for arithmetic
- Some special characters have meaning in text tools like `sed`:
  - `.` "concatenate" ***(may need escaping, not always)***
  - `$` end of line ***(needs escaping)***
  - `^` start of line ***(needs escaping)***
  - `\n` new line **(already escaped)**
  - `\t` tab **(already escaped)**
- `sed` **delimiters** can be any character
  - "Working" characters can be delimiters if escaped with `\`
  - Whatever character you use in the pattern becomes the delimiter
- `sed` **wildcards** `*`
  - `^.*foo` matches the **start** of a string
  - `foo.*` matches the **end** of a string
  - `foo.*.bar` matches **between** "foo" and "bar"
___

#### [Lesson 8: $IFS (Internal Field Separator)](https://github.com/inkVerb/vip/blob/master/401-shell/Lesson-08.md)
