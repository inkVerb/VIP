# Shell 101
## Lesson 11: Quote/Escape Special Characters

`cd ~/School/VIP/shell/101`

___

| **1** : `echo "$$//" > money.file`

| **2** : `gedit money.file`

*Note how special characters don't always work correctly...*

| **3** : `echo "\$\$//" > money.file`

*gedit: Reload money.file*

| **4** : `sed -i "s///!/g" money.file`

*Notice the error, "cancel" (some say "quote") special characters with: `\`*

| **5** : `sed -i "s/\//\!/g" money.file`

*gedit: Reload money.file*

| **6** : `sed -i "s/$/@/g" money.file`

*gedit: Reload money.file*

| **7** : `sed -i "s/\$/@/g" money.file`

*gedit: Reload money.file*

| **8** : `sed -i 's/$/@/g' money.file`

*gedit: Reload money.file*

*Note even with 'single quotes' it still doesn't work...*

| **9** : `sed -i 's/\$/@/g' money.file`

*gedit: Reload money.file*

*Sometimes we need BOTH 'single quotes' AND the "backslash" (`\`) quote/escape character!*

*(Can you figure out what `$` means? The answer is in 401 Lesson 7)*

*Use `\` with letters to work with non-characters*

*Note `\t` = tab, `\n` = new line*

| **10** : `echo "no tab one line" > tab.file`

| **11** : `gedit tab.file`

| **12** : `sed -i "s/no/\t no/" tab.file`

*gedit: Reload tab.file*

*Note the tab*

| **13** : `sed -i "s/\t no/no/" tab.file`

*gedit: Reload tab.file*

*Note the tab is gone*

| **14** : `sed -i "s/one/one\n/" tab.file`

*gedit: Reload tab.file*

| **15** : `sed -i "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

*Note the line was not removed, use `-z` so `sed` is not confused*

| **16** : `sed -i -z "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

___

# The Take

- Some special characters "mean something" and will therefore "work" AKA "operate"
- These special characters might be called "**operators**", but the word "**operator**" is more often used to describe special characters used in math functions
- If you want to use a special character literally, without it "working", it must be "escaped" AKA "quoted"
- These often include: `$`, `^`, `/`, `?`, `*`, `.`, among others
- A common "quote" character is the "backslash" (`\`)
- "Backslash" (`\`) also works with letters to define non-characters in text
  - `\n` = "new line"
  - `\t` = "tab"
  - These are called "Metacharacters", which you can study more on your own
    - See a short list here: [Characters](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Characters.md#RegEx-Metacharacters)
- There is much more to working with special characters
  - You can get a more in-depth information here: [find-grep-sed-rename.md](https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/find-grep-sed-rename.md)

___

#### [Lesson 12: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-12.md)
