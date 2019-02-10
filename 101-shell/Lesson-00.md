# Shell 101
## Lesson 0: Terminal Control

`cd ~/School/VIP/shell/101`


___

### Orientation

This is normal text, which may label or tell something, it is rare.

*This is a note that helps teach and explain something.*

*The following is called "preformatted" text, using a "monospace" font:* `preformatted monospace text`

*Preformatted text indicates computer code. Many websites do this.* `i am computer code`

*This note explains code later on this line, but don't enter it in the terminal* `read me but not for terminal`

`i am a command to be entered in the terminal`

`i am another terminal command` *This is a very important note specifically about the command just entered*

`third terminal command`

*Note that was the third terminal command, but it won't actually work*

*Let's enter the fourth and final command, which also won't work*

`fourth broken command`

*That's the end of the Orientation*

___

`gedit`

*Note gedit opened*

*In Terminal: Ctrl + Z*

*Note gedit won't respond*

`jobs`

*gedit's job number should be 1*

`fg 1`

*Note gedit is no longer dark*

*Terminal: Ctrl + Z*

`bg 1`

`jobs`

`killall gedit`

*Note gedit closed*

`jobs`

*Note the terminal registeres gedit "Terminated"*

`gedit`

*Terminal: Ctrl + C*

*Note gedit closed*

`jobs`

*Note gedit either does not register or registers "Done"*

`gedit`

*Terminal: Ctrl + Z*

`jobs`

*This is how to kill job number 1:*

`kill %1`

*Note gedit closed*

`jobs`

*Note the terminal registeres gedit "Terminated"*

*Start gedit so it does not occupy the terminal foreground*

`gedit &`

*Change directory to .../shell/101*

`cd ~/School/VIP/shell/101`

*Open Nautilus file explorer in that directory with:* `.`

`nautilus . &`

#### [Lesson 1: gedit, echo & sed](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-01.md)
