# Shell 201
## Lesson 6: wget, curl, git clone

`cd ~/School/VIP/shell/201`

___

*Download the entire verb.ink page using wget*

| **1** : `wget -r http://verb.ink`

| **2** : `ls`

*Take a peek inside*

| **3** : `cd verb.ink`

| **4** : `ls`

| **5** : `gedit index.html`

*Download the verb.ink index page using curl*

| **6** : `curl http://verb.ink`

| **7** : `ls`

*Note it either output the content or returned an error*
- `curl` needs an output file specified*
- `wget` saves the file by the same name unless otherwise specified*

| **8** : `curl http://verb.ink > verb.ink.html`

| **9** : `ls`

*Take a peek inside*

| **10** : `gedit verb.ink.html`

*Open it with whatever browser you are using:*

| **11** : `firefox verb.ink.html` or `chromium-browser verb.ink.html` or `google-chrome verb.ink.html` or `vivaldi verb.ink.html`

## Download the inkVerb/vrk repo from GitHub

### zip via wget

*Download Vrk using wget*

| **12** : `wget https://github.com/inkVerb/vrk/archive/master.zip`

| **13** : `ls`

*Specify a different output filename with: `-O SAVEASNAME` (CAPITAL '-O'!)*

| **14** : `wget -O vrk.zip https://github.com/inkVerb/vrk/archive/master.zip`

| **15** : `ls`

*Clean up*

| **16** : `rm master.zip`

### zip via curl

| **17** : `curl https://github.com/inkVerb/vrk/archive/master.zip` (wrong)

*Note the redirect message; use `-L` to follow redirects*

| **18** : `curl -L https://github.com/inkVerb/vrk/archive/master.zip` (wrong)

*Note it dumped the raw output to the terminal rather than saving it*

*Use Ctrl + C to close the output*

*Solution: Specify an output file*

| **19** : `curl -L https://github.com/inkVerb/vrk/archive/master.zip > vkr-curl.zip`

| **20** : `ls`

*Now that you get the point, we don't need it anymore*

| **21** : `rm vkr-curl.zip`

### tarball via curl

*Substitute `github.com` for `api.github.com/repos/` & append with `/tarball` & include output file*

| **22** : `curl -L https://api.github.com/repos/inkVerb/vrk/tarball > vrk.tar`

| **23** : `ls`

*Now, untar it*

| **24** : `tar xzf vrk.tar`

| **25** : `ls`

*Note the strange new directory `inkVerb-vrk-SOME_CRAZY_NUMBER`*

*...that's it, delete it with:*

> | **26** : `rm -r inkVerb-vrk-SOME_CRAZY_NUMBER`

*We don't need to keep that tarball either*

| **27** : `rm vrk.tar`

### tarball via curl & untar (single command)

*Substitute `github.com` for `api.github.com/repos/` & append with `/tarball` & untar it right away*

| **28** : `curl -L https://api.github.com/repos/inkVerb/vrk/tarball | tar xz`

| **29** : `ls`

*Note the same strange directory `inkVerb-vrk-SOME_CRAZY_NUMBER`*

*...that's it, delete it with:*

> | **30** : `rm -r inkVerb-vrk-SOME_CRAZY_NUMBER`

### repo via git clone

| **31** : `git clone https://github.com/inkVerb/vrk`

| **32** : `ls`

*Take a peek inside*

| **33** : `cd vrk`

| **34** : `ls -a`

*Note the hidden ".git" directory, it containes a few read-only files*

| **35** : `cd ..`

| **36** : `rm -r vrk`

*Note the error message because of the read-only files* (Ctrl + C to get out of there!)

*Removing a git-cloned directory is easier with `sudo`*

### For a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **37** : `su USERNAME`
>
___

| **38** : `sudo rm -r vrk`

### For an administrator to use `su`
>
___
> If you don't have permission as a "sudoer", the person who administers your machine can use:
>
> | **39** : `su` input the password*
>
> | **40** : `rm -r vrk`
>
___

### IF needed, `exit` from `su` or the other "sudoer"
>
___
>
> | **41** : `exit`
>
___

| **42** : `ls`

___

# The Take

- `wget` simply downloads and saves a file from a Web address
- `wget -O filename` specifies a "Save as..." filename for the download
- `curl` dumps a Web address's content as raw output
- `curl -L` may be needed to follow links, otherwise it won't (`wget` will)
- `curl http://web-address > save-as-filename` is how `curl` saves the downloaded file
- `git` is GitHub's app that syncs and downloads a GitHub repo (files) on your local computer with the GitHub repo (on the GitHub website)
- `git clone GitHub-REPOSITORY-address` is how `git` "downloads" a GitHub repo
- When downloading a .zip file from GitHub, the contents will have a strange name
- Using `git clone` is the simplest way to download a GitHub repo

___

#### [Lesson 7: tar, xz, zip, gzip, bzip2](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-07.md)
