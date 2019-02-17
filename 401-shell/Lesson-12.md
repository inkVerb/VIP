# Shell 401
## Lesson 12: Path Plus

`cd ~/School/VIP/shell/401`

`gedit &`

`nautilus . &`

___

### `$PATH`

`echo $PATH`

*This is the "$PATH", the list of directories where executable files can be run by filename only*

*Any file not in the $PATH can only be run by including the path to the file, like `./FILE` or `/full/path/to/FILE`*

***Using the full path*** *let's run a small script containing this:*

```sh
#!/bin/sh
echo "I am executable, but I am not in the \$PATH."
```
1. Relative `/home/` path:

`~/School/VIP/shell/401/iamexec`

2. "here" path:
`./iamexec`

3. "full path" (get with `pwd`)

`pwd` *Execute this output, plus* `/iamexec`

Something like: `/home/USERNAME/School/VIP/shell/401/iamexec`

*This nifty little script lists each directory of the $PATH on a new line:*

*Edit the script*

`gedit listpath`

*It should look like this:*

```sh
#!/bin/sh

# Set the field separator for the `for` loop to the `:` that separates dirs in the $PATH
IFS=:
# If we don't put $PATH in "double-quotes", each dir will appear on one line
# Try removing the "double-quotes" from "$PATH" on the line below to see what happens
# Also try changing the "double-quotes" to 'single-quotes' to see what happens
for pdir in $(echo "$PATH"); do
  echo $pdir
done
```

`./listpath`

*Files in these directories can be run without entering the entire path.*

**Add dirs to path:**

*You can add as many extra directories as you want to your user's path...*
- In this file: `~/.bashrc`
- Add a line with: `export PATH=$PATH:/ADDED/DIR:/ADD/ANOTHER/DIR:/ADD/MORE/DIRS`
- Careful, adding insecure files could be a way to hack your machine, use mindfully and only add directories you ***need***.

### Locations for `crontab` files

- /etc/cron.d/ chmod 640 & `crontab` how to /var/spool/cron/crontabs/USERNAME ; chown USER:crontab


- previous directory $OLDPWD
- with pinkypurple, run command as other user
- copydir... ls -R, ls -d, tree, tree -d, tree -C, ls -b for escape codes ( ) & | ' < > TAB
- ...and `file` to determine a file type
- dir structure, `which` to show file location
- `cp -i` interactive for replacing files
- `rmdir -p` only for empty dirs, -p includes parents
- `ls -a` and include creating hidden files `ls -F` for file types, -t time, -r reverse order
- chmod a ...for all of ugo, = only, + add, - remove
- vim... `view` for read only vim
- ...diff add: sdiff, vimdiff
- 201-12: cat more less head tail... `tail -f` with `cat` to watch a file be appended in real time


# Done! Have a cookie: ### #
