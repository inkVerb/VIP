# Shell 101
## Lesson 11: RegEx: Quote/Escape Special Characters

Ready the CLI

`cd ~/School/VIP/101`

___

| **1** :$

```console
echo "$$//" > money.file
```

| **2** :$

```console
gedit money.file
```

*Note how special characters don't always work correctly...*

| **3** :$

```console
echo "\$\$//" > money.file
```

*gedit: Reload money.file*

| **4** :$

```console
sed -i "s///!/g" money.file
```

*Notice the error, "escape" (some say "quote") special characters with: `\`*

| **5** :$

```console
sed -i "s/\//\!/g" money.file
```

*gedit: Reload money.file*

| **6** :$

```console
sed -i "s/$/@/g" money.file
```

*gedit: Reload money.file*

| **7** :$

```console
sed -i "s/\$/@/g" money.file
```

*gedit: Reload money.file*

| **8** :$

```console
sed -i 's/$/@/g' money.file
```

*gedit: Reload money.file*

*Note even with 'single quotes' it still doesn't work...*

| **9** :$

```console
sed -i 's/\$/@/g' money.file
```

*gedit: Reload money.file*

*Sometimes we need BOTH 'single quotes' AND the "backslash" (`\`) quote/escape character!*

*(Can you figure out what `$` means? The answer is in 401 Lesson 7)*

*Use `\` with letters to work with non-characters*

*Note `\t` = tab, `\n` = new line*

| **10** :$

```console
echo "no tab one line" > tab.file
```

| **11** :$

```console
gedit tab.file
```

| **12** :$

```console
sed -i "s/no/\t no/" tab.file
```

*gedit: Reload tab.file*

*Note the tab*

| **13** :$

```console
sed -i "s/\t no/no/" tab.file
```

*gedit: Reload tab.file*

*Note the tab is gone*

| **14** :$

```console
sed -i "s/one/one\n/" tab.file
```

*gedit: Reload tab.file*

| **15** :$

```console
sed -i "s/one\n/one/g" tab.file
```

*gedit: Reload tab.file*

*Note the line was not removed, use `-z` so `sed` is not confused*

| **16** :$

```console
sed -i -z "s/one\n/one/g" tab.file
```

*gedit: Reload tab.file*

___

# The Take

## "RegEx"
- "RegEx" is short for "regular expression"
- Knowing when and how to escape certain characters is part of making a "RegEx"
- We will revisit RegEx again briefly in [Lesson 401-11](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md) when we discuss "[Character Classes](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md#Classes)" (ie: 'only letters' or 'only numbers' or 'only letters and numbers')

## Why "escape" some characters?
- Some special characters "mean something" and will "work"
  - These often include: `$`, `^`, `/`, `?`, `*`, `.`, among others
  - These special characters might be called "**operators**", but the word "**operator**" is more often used to describe special characters used in math functions
- If you want to use a special character literally, without it "working", it must be "escaped" AKA "quoted"
- Common ways of "escaping" working characters:
  1. Backslash (`\`)
  2. 'Single quotes' (`'single_quotes'`)
  3. Flags (`-F` or `-z` etc)
  - Sometimes we need a combination of the above
- Backslash (`\`) also works with letters to define non-characters in text
  - `\n` = "new line"
  - `\t` = "tab"
  - These are called "Metacharacters", which you can study more on your own
    - See a short list here: [Characters](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md#RegEx-Metacharacters)
- There is much more to working with special characters
  - You can get a more in-depth information here: [find-grep-sed.md](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/find-grep-sed.md)

___

#### [Lesson 12: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101/Lesson-12.md)
