# Shell 101
## Lesson 1: gedit, echo & sed

Ready the CLI

`cd ~/School/VIP/101`

___

| **1** :$

```console
echo "Output to terminal"
```

*The "input" you enter into the terminal is called: "STDIN"*

*The "output" you see in the terminal is called: "STDOUT"*

*Below, the STDIN is `echo "Hello ink!"` and the STDOUT is `Hello ink!`*

| **2** :$

```console
echo "Hello ink!"
```

| **3** :$

```console
echo "abcdefghijklmnopqrstuvwxyz"
```

| **4** :$

```console
ls
```

*See, there are no files here*

*We can send STDOUT to a file with: `> MYFILE`*

| **5** :$

```console
echo "Output to file" > abcd
```

| **6** :$

```console
ls
```

*See, now there's a new file here*

| **7** :$

```console
gedit abcd
```

| **8** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" > abcd
```

*gedit: Reload*

| **9** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" >> abcd
```

*gedit: Reload*

| **10** :$

```console
echo "abcdefghijklmnopqrstuvwxyz" >> abcd
```

*gedit: Reload*

*Note the number of lines*

| **11** :$

```console
echo "foo :-)" >> abcd
```

*gedit: Reload*

| **12** :$

```console
sed -i "s/foo/bar/" abcd
```

*gedit: Reload*

| **13** :$

```console
sed -i "s/bar//" abcd
```

*gedit: Reload*

| **14** :$

```console
echo "add foo and then some" >> abcd
```

*gedit: Reload*

| **15** :$

```console
sed -i "s/foo/bar/" abcd
```

*gedit: Reload*

*Note the line number of "add bar and then some"*

| **16** :$

```console
sed -i "/bar/d" abcd
```

*gedit: Reload*

*Note the line with "bar" is gone*

| **17** :$

```console
echo "Replace this Apple delBar line." >> abcd
```

*gedit: Reload*

| **18** :$

```console
sed -i "/Replace.*/ c\The line with Mr. Apple delBar has been replaced" abcd
```

*gedit: Reload*

*<kbd>Ctrl</kbd> + D deletes a line in gedit*
- Use it to delete the line about "Mr. Apple delBar"
- Then <kbd>Ctrl</kbd> + <kbd>S</kbd> to save the file

___

# The Take

- Computers (the terminal also) work with *input* & *output*
- STDIN = input
- STDOUT = output
- `echo` is a command that inputs something for simple text output
- `echo` can send output to a file with `>` & `>>`
- `ls` "lists" what's in the current directory as output (STDOUT)
- `sed` can replace or delete text in a file
- `sed` uses "d" to delete a line
- Gedit usees **<kbd>Ctrl</kbd> + D** to delete a line

___

#### [Lesson 2: Arguments & Variables](https://github.com/inkVerb/vip/blob/master/101/Lesson-02.md)
