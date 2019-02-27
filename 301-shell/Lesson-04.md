# Shell 301
## Lesson 4: while & until

`cd ~/School/VIP/shell/301`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `while`

| **1** : `gedit 04-while-read`

*Note -z means "Zero" or "Zilch" for a variable that is empty*

| **2** : `./04-while-read`

*Only press Enter to see what happens again and again, comply or use Ctrl + C to close*

| **3** : `gedit 04-while-count`

*Note ! means "not"*

| **4** : `./04-while-count`

*Let's put it together into something useful*

| **5** : `gedit 04-while-count-read`

*Note ! means "not"*

| **6** : `./04-while-count-read`

### II. `until`

*Do some prep first...*

| **7** : `mkdir 04COUNT && cp 04-until-count 04COUNT/ && cd 04COUNT`

| **8** : `gedit 04-until-count`

| **9** : `ls *.shell`

| **10** : `./04-until-count 5 shell`

| **11** : `ls *.shell`

| **12** : `ls *.sixtn`

| **13** : `./04-until-count 16 sixtn`

| **14** : `ls *.sixtn`

| **15** : `cd ..`

| **16** : `gedit 04-until-read`

| **17** : `./04-until-read werdup`

*Input wrong "passwords" to see what it does, input "werdup" or use Ctrl + C to close*

| **18** : `./04-until-read thepassword`

*Input wrong "passwords" to see what it does, input "thepassword" or use Ctrl + C to close*

#### [Lesson 5: case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
