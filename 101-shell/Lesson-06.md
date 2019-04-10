# Shell 101
## Lesson 6: tee
## tee = T

`cd ~/School/VIP/shell/101`

___

| **1** : `gedit applefoo`

| **2** : `sed "s/foo/bar/" applefoo`

| **3** : `echo $(sed "s/foo/bar/" applefoo) > sedoutput.text`

| **4** : `gedit sedoutput.text`

| **5** : `echo "Add a line" >> sedoutput.text`

*gedit: Reload sedoutput.text*

*Both* `echo` *and* `sed` *(without* `-i`*) will send output to the terminal*

*But,* `sed -i` *and* `echo ... > ` *will output to a file*

*But better yet, piping into* `tee` *will do both!*

| **6** : `echo $(sed "s/foo/bar/" applefoo) | tee sedoutput.text`

*gedit: Reload sedoutput.text*

___

# The Take

- Several commands can be combined into one command, including an output file
- "Piping" output into "tee" (`command | tee output-file`) sends the output to both the output file *and* is displayed as raw output in the terminal
- `| tee` will overwrite the destination file!
- `| tee` can be used with many commands

___

#### [Lesson 7: cat vs echo](https://github.com/inkVerb/vip/blob/master/101-shell/Lesson-07.md)
