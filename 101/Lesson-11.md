# Linux 101
## Lesson 11: Special Characters

Ready the CLI

```console
cd ~/School/VIP/101
```

___

| **1** :$

```console
echo "$$//" > money.file
```

| **2** :$

```console
gedit money.file
```

*Note how **special characters** don't always behave as expected*

*Special characters that "work" are often called **operators***

*Double dollar sign (`$$`) is the **PID number** for the current terminal; it will be different, yet unchanged, in every terminal*

*To prevent the `$$` and other special characters from "working", we need to "escape" (some say "quote") with: `\`*

| **3** :$

```console
echo "\$\$//" > money.file
```

*gedit: Reload `money.file`*

| **4** :$

```console
sed -i "s///!/g" money.file
```

*Notice the error*

| **5** :$

```console
sed -i "s/\//\!/g" money.file
```

*gedit: Reload `money.file`*

| **6** :$

```console
sed -i "s/$/@/g" money.file
```

*gedit: Reload `money.file`*

*Note the `@` symbol appeares at the end of the line*

| **7** :$

```console
sed -i "s/\$/@/g" money.file
```

*gedit: Reload `money.file`*

*Note even quoted, the `@` symbol appeares at the end of the line*

| **8** :$

```console
sed -i 's/$/@/g' money.file
```

*gedit: Reload `money.file`*

*Note even with 'single quotes', the `@` symbol appeares at the end of the line*

| **9** :$

```console
sed -i 's/\$/@/g' money.file
```

*gedit: Reload `money.file`*

*Sometimes we need BOTH 'single quotes' AND the "backslash" (`\`) quote/escape character!*

*(Can you figure out what `$` means? The answer is in [401 Lesson 7](https://github.com/inkVerb/vip/blob/master/401/Lesson-07.md))*

*Use `\` with letters to represent **metacharacters***

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

*gedit: Reload `tab.file`*

*Note the tab*

| **13** :$

```console
sed -i "s/\t no/no/" tab.file
```

*gedit: Reload `tab.file`*

*Note the tab is gone*

| **14** :$

```console
sed -i "s/one/one\n/" tab.file
```

*gedit: Reload `tab.file`*

| **15** :$

```console
sed -i "s/one\n/one/g" tab.file
```

*gedit: Reload `tab.file`*

*Note the line was not removed*

*Remember, `sed` works line-by-line; we use `-z` so `sed` is not confused*

| **16** :$

```console
sed -i -z "s/one\n/one/g" tab.file
```

*gedit: Reload `tab.file`*

___

# Glossary
- **special character** - any character that is not a letter or number
- **metacharacter** - invisible characters, neither special character nor letter nor number
  - eg: "tab" or "new line" or "start of line" or "end of line"
  - `\t` = "tab" metacharacter
  - `\n` = "new line" metacharacter
- **operator** - a special character that "does something" in computer code (usually for math code, but not always)
- **PID number** - Process ID number - the special number assigned to a running process on the system; every running process has one

# The Take
- We must know when and how to quote or "escape" certain characters
- We will revisit special characters when we learn about RegEx in [401 Lesson 11](https://github.com/inkVerb/vip/blob/master/401/Lesson-11.md)
- Read more in the [Character Classes](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md#Classes) cheat sheet
  - ie: 'only letters' or 'only numbers' or 'only letters and numbers'

## Why "quote/escape" some characters?
- Some special characters "mean something" and will "work"
  - These often include: `$`, `^`, `/`, `?`, `*`, `.`, among others
  - These special characters might be called "**operators**", but the word "**operator**" is more often used to describe special characters used in math
- If you want to use an operator character literally without it "working", it must be "quoted" AKA "escaped"
- Common ways of "escaping" operators:
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
