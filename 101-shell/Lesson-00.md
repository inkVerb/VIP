# Shell 101
## Lesson 0: Terminal Control

___

### Orientation

This is normal text, which may label or tell something, it is rare in these lessons.

*This italics text is a note that helps teach and explain something in a lesson*

*The following is called "preformatted" text, which uses a "monospace" font:* `preformatted monospace text`

*Preformatted text indicates computer code. Many websites do this* `i am computer code`

*This note explains code later on this line, but don't enter it in the terminal* `read me but not for terminal`

*When a line begins with a number like this number 257:* | **257** : *enter the* `preformatted text` *after it into the terminal*

| **1** : `echo i am a command to be entered in the terminal`

*These numbers help keep track of your place in the lesson and clarify which code you should enter into the terminal*

| **2** : `echo i am another terminal command` *This is a very important note specifically about the command just entered*

| **3** : `third terminal command`

*Note those were three terminal commands, but the third one didn't actually work, but you should have entered it anyway just to watch it not work*

`preformatted code like this` *that does not have a number is only for reference, not to be entered into the terminal*

*Let's enter the fourth and final command, which also won't work*

| **4** : `fourth broken command`

*That's the end of the Orientation*

*Now, on to a basic understanding of controlling an app from the terminal...*

___

### Controlling apps via terminal

| **5** : `gedit`

*Note gedit opened*

*In Terminal: Ctrl + Z*

*Note gedit won't respond*

| **6** : `jobs`

*gedit's job number should be 1*

| **7** : `fg 1`

*Note gedit is no longer dark*

*Terminal: Ctrl + Z*

| **8** : `bg 1`

| **9** : `jobs`

| **10** : `killall gedit`

*Note gedit closed*

| **11** : `jobs`

*Note the terminal registeres gedit "Terminated"*

| **12** : `gedit`

*Terminal: Ctrl + C*

*Note gedit closed*

| **13** : `jobs`

*Note gedit either does not register or registers "Done"*

| **14** : `gedit &`

*Note the terminal is not occupied because we added* `&`

*Run another program, Mines*

| **15** : `gnome-mines &`

| **16** : `jobs`

*This is how to kill job number 2:*

| **17** : `kill %2`

*Note mines closed*

| **18** : `jobs`

*Note the terminal registeres gedit "Terminated"*

*Nautilus (file explorer), also does wonders in the terminal*

*(Open Nautilus if you want)*

*First, make the directory "School" (if it doesn't already exist)...*

| **19** : `mkdir ~/School`

*Change the terminal to that directory*

| **20** : `cd ~/School`

*Open Nautilus file explorer in that directory with:* `.`

| **21** : `nautilus .`


#### [Lesson 1: gedit, echo & sed](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-01.md)
