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

*Notice the error, "cancel" (some say "quote") special characters with:* `\`

| **5** : `sed -i "s/\//\!/g" money.file`

*gedit: Reload money.file*

| **6** : `sed -i "s/$/@/g" money.file`

*gedit: Reload money.file*

| **7** : `sed -i "s/\$/@/g" money.file`

*gedit: Reload money.file*

| **8** : `sed -i 's/\$/@/g' money.file`

*gedit: Reload money.file*

*Use* `\` *with letters to work with non-characters*

*Note* `\t` = tab, `\n` = new line

| **9** : `echo "no tab one line" > tab.file`

| **10** : `gedit tab.file`

| **11** : `sed -i "s/no/\t no/" tab.file`

*gedit: Reload tab.file*

*Note the tab*

| **12** : `sed -i "s/\t no/no/" tab.file`

*gedit: Reload tab.file*

*Note the tab is gone*

| **13** : `sed -i "s/one/one\n/" tab.file`

*gedit: Reload tab.file*

| **14** : `sed -i "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

*Note the line was not removed, use* `-z` *so* `sed` *is not confused*

| **15** : `sed -i -z "s/one\n/one/g" tab.file`

*gedit: Reload tab.file*

#### [Lesson 12: grep with Special Characters](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-12.md)
