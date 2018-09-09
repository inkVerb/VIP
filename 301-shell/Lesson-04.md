# Shell 301
## Lesson 4: while & until

`cd ~/School/VIP/shell/301`

`gedit &`

`nautilus . &`

- [Variables](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Variables.md)
- [Tests](https://github.com/inkVerb/vip/blob/master/Cheat-Sheets/Tests.md)

___

### I. `while`

`gedit 04-while-read`

*Note -z means "Zero" or "Zilch" for a variable that is empty*

`./04-while-read`

*Only press Enter to see what happens again and again, comply or use Ctrl + C to close*

`gedit 04-while-count`

*Note ! means "not"*

`./04-while-count`

*Let's put it together into something useful*

`gedit 04-while-count-read`

*Note ! means "not"*

`./04-while-count-read`

### II. `until`

*Do some prep first...*

`mkdir 04COUNT && cp 04-until-count 04COUNT/ && cd 04COUNT`

`gedit 04-until-count`

`ls *.shell`

`./04-until-count 5 shell`

`ls *.shell`

`ls *.sixtn`

`./04-until-count 16 sixtn`

`ls *.sixtn`

`cd ..`

`gedit 04-until-read`

`./04-until-read werdup`

*Input wrong "passwords" to see what it does, input "werdup" or use Ctrl + C to close*

`./04-until-read thepassword`

*Input wrong "passwords" to see what it does, input "thepassword" or use Ctrl + C to close*

#### [Lesson 5: case](https://github.com/inkVerb/vip/blob/master/301-shell/Lesson-05.md)
