# Linux 201
## Lesson 10: COMMAND > FILE, pwd, uname, who, w

Ready the CLI

```console
cd ~/School/VIP/201
```

___

| **1** :$

```console
mkdir comdump
```

| **2** :$

```console
cd comdump
```

| **3** :$

```console
ls
```

*Remember this...*

| **4** :$

```console
top -n 1 -b
```

*Put it in a file...*

| **5** :$

```console
top -n 1 -b > top.file
```

| **6** :$

```console
ls
```

| **7** :$

```console
gedit top.file
```

| **8** :$

```console
top -n 1 -b > top.file
```

*gedit: Reload top.file*

*Note the file contents changed*

| **9** :$

```console
ps aux
```

| **10** :$

```console
ps aux > psaux.file
```

| **11** :$

```console
ls
```

| **12** :$

```console
gedit psaux.file
```

*Some other useful commands...*

| **13** :$

```console
pwd
```

*Whoah, that's where you are!*

| **14** :$

```console
pwd > pwd.file
```

| **15** :$

```console
gedit pwd.file
```

| **16** :$

```console
uname
```

*eXcellent operationg system, I might add*

| **17** :$

```console
uname > uname.file
```

| **18** :$

```console
who
```

*That's you*

| **19** :$

```console
who > who.file
```

| **20** :$

```console
w
```

*That's you with a lot more info*

| **21** :$

```console
w > w.file
```

| **22** :$

```console
ls
```

| **23** :$

```console
ls > ls.file
```

| **24** :$

```console
ls
```

| **25** :$

```console
gedit ls.file
```

*You can even output `ls` into a file!*

| **26** :$

```console
ls ..
```

*Now output that other directory's contents into a file*

| **27** :$

```console
ls .. > ls.file
```

*gedit: Reload ls.file*

*...or into another directory*

| **28** :$

```console
mkdir -p outputs
```

| **29** :$

```console
ls outputs
```

| **30** :$

```console
ls .. > outputs/ls.file
```

| **31** :$

```console
ls outputs
```

*That's in the directory you just made*

| **32** :$

```console
gedit outputs/ls.file
```

___

# The Take

- STDOUT output of many terminal commands can be sent to a file by adding `> outputfile` to the end of the command
 - This includes: `ls`, `df`, `who`, `pwd`, `ps aux`, `top`, and many more
- *Note that `> outputfile` would overwrite the output file; `>> outputfile` would append the output file*
- "PWD" stands for "present working directory"
  - `pwd` displays the PWD
- `who` displays the current user and most recent login time
- `w` displays uptime, some load information, and user info from `who`
- `uname` verifies that you are using Linux by outputting "Linux", just in case you forgot

___

#### [Lesson 11: more, less, head, tail, sort, tac, diff, nano, vim](https://github.com/inkVerb/vip/blob/master/201/Lesson-11.md)
