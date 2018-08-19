# Shell 201
## Lesson 6: wget, curl, git clone

`cd ~/School/VIP/shell/201`

`gedit &`

`nautilus . &`
___

*Download the entire verb.ink page using wget*

`wget -r http://verb.ink`

*Download the verb.ink index page using curl*

`curl http://verb.ink`

`ls`

*Note it only showed the html content, to save it specify an output file:*

`curl http://verb.ink > verb.ink.html`

`ls`

*Take a peek inside*

`gedit verb.ink.html`

*Open it with whatever browser you are using:*

`firefox verb.ink.html` or `chromium-browser verb.ink.html` or `google-chrome verb.ink.html` or `vivaldi verb.ink.html`

## Download the inkVerb/vrk repo from GitHub

### zip via wget

*Download Vrk using wget*

`wget https://github.com/inkVerb/vrk/archive/master.zip`

`ls`

*Specify an output file*

`wget -O vrk.zip https://github.com/inkVerb/vrk/archive/master.zip`

`ls`

*Clean up*

`rm master.zip`

### zip via curl

`curl https://github.com/inkVerb/vrk/archive/master.zip` (wrong)

*Note the redirect message; use* `-L` *to follow redirects*

`curl -L https://github.com/inkVerb/vrk/archive/master.zip` (wrong)

*Note it dumped the raw output to the terminal rather than saving it*

*Use Ctrl + C to close the output*

*Solution: Specify an output file*

`curl -L https://github.com/inkVerb/vrk/archive/master.zip > vkr-curl.zip`

`ls`

*Now that you get the point, we don't need it anymore*

`rm vkr-curl.zip`

### tarball via curl

*Substitute* `github.com` *for* `api.github.com/repos/` *& append with* `/tarball` *& include output file*

`curl -L https://api.github.com/repos/inkVerb/vrk/tarball > vrk.tar`

`ls`

*Now, untar it*

`tar xzf vrk.tar`

`ls`

*Note the strange new directory* `inkVerb-vrk-SOME_CRAZY_NUMBER`

*...that's it, delete it with:*

> `rm -r inkVerb-vrk-SOME_CRAZY_NUMBER`

*We don't need to keep that tarball either*

`rm vrk.tar`

### tarball via curl & untar (single command)

*Substitute* `github.com` *for* `api.github.com/repos/` *& append with* `/tarball` *& untar it right away*

`curl -L https://api.github.com/repos/inkVerb/vrk/tarball | tar xz`

`ls`

*Note the same strange directory* `inkVerb-vrk-SOME_CRAZY_NUMBER`

*...that's it, delete it with:*

> `rm -r inkVerb-vrk-SOME_CRAZY_NUMBER`

### repo via git clone

`git clone https://github.com/inkVerb/vrk`

`ls`

`rm -r vrk`

*Note the error message; you don't own it!* (Ctrl + C to get out of there!)

`sudo rm -r vrk`

> ___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
> 
> `su` *input the password*
> 
> `rm -r vrk`
> 
> `exit`
> ___

`ls`

#### [Lesson 7: tar, xz, zip, gzip, bzip2](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-07.md)
