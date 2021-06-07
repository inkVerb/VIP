# Shell 201
## Lesson 6: wget, curl, git clone

Ready the CLI

```console
cd ~/School/VIP/201
```

**FOR** | **3 - 11** :$

```console
cd verb.ink
```
___

*Download the entire verb.ink page using wget*

| **1** :$

```console
wget -r https://verb.ink
```

| **2** :$

```console
ls
```

*Take a peek inside*

| **3** :$

```console
cd verb.ink
```

| **4** :$

```console
ls
```

| **5** :$

```console
gedit index.html
```

*Download the verb.ink index page using curl*

| **6** :$

```console
curl https://verb.ink
```

| **7** :$

```console
ls
```

*Note it only output the code of the web page and saved nothing*
- `curl` *"opens" files; to save, specify an output file*
- `wget` *saves files; specify otherwise for a different file name*

| **8** :$

```console
curl https://verb.ink > verb.ink.html
```

| **9** :$

```console
ls
```

*Take a peek inside*

| **10** :$

```console
gedit verb.ink.html
```

*Open it with whatever browser you are using:*

| **11F** :$ (if you're using Firefox)

```console
firefox verb.ink.html
```

| **11C** :$ (if you're using Chromium)

```console
chromium-browser verb.ink.html
```

| **12** :$

```console
cd ..
```

## Download the inkVerb/VIP repo from GitHub

### `.zip` file via wget

*Download VIP using wget*

| **13** :$

```console
wget https://github.com/inkVerb/vip/archive/master.zip
```

| **14** :$

```console
ls
```

*Specify a different output filename with: `-O SAVEASNAME` (CAPITAL '-O'!)*

| **15** :$

```console
wget -O vip.zip https://github.com/inkVerb/vip/archive/master.zip
```

| **16** :$

```console
ls
```

*Clean up*

| **17** :$

```console
rm master.zip
```

### `.zip` file via curl

| **18** :$ *(wrong)*

```console
curl https://github.com/inkVerb/vip/archive/master.zip
```

*Note the redirect message; use `-L` to follow redirects*

| **19** :$ *(wrong)*

```console
curl -L https://github.com/inkVerb/vip/archive/master.zip
```

*Note it dumped the raw output to the terminal rather than saving it*

*Use <kbd>Ctrl</kbd> + <kbd>C</kbd> to close the output*

*Solution: Specify an output file*

| **20** :$

```console
curl -L https://github.com/inkVerb/vip/archive/master.zip > vip-curl.zip
```

| **21** :$

```console
ls
```

*Now that you get the point, we don't need it anymore*

| **22** :$

```console
rm vip-curl.zip
```

### `.tar` file (tarball) via curl

*Substitute `github.com` for `api.github.com/repos/` & append with `/tarball` & include output file*

| **23** :$

```console
curl -L https://api.github.com/repos/inkVerb/vip/tarball > vip.tar
```

| **24** :$

```console
ls
```

*Now, untar it*

| **25** :$

```console
tar xzf vip.tar
```

| **26** :$

```console
ls
```

*Note the strange new directory `inkVerb-VIP-SOME_CRAZY_NUMBER`*

*...that's it, delete it with:*

| **27** :$

```console
rm -r inkVerb-VIP-SOME_CRAZY_NUMBER
```

*We don't need to keep that tarball either...*

| **28** :$

```console
rm vip.tar
```

### tarball via curl & untar (single command)

*Substitute `github.com` for `api.github.com/repos/` & append with `/tarball` & untar it right away*

| **29** :$

```console
curl -L https://api.github.com/repos/inkVerb/vip/tarball | tar xz
```

| **30** :$

```console
ls
```

*Note the same strange directory `inkVerb-VIP-SOME_CRAZY_NUMBER`*

*...that's it, delete it with:*

| **31** :$

```console
rm -r inkVerb-VIP-SOME_CRAZY_NUMBER
```

### repo via git clone

| **32** :$

```console
git clone https://github.com/inkVerb/vip
```

| **33** :$

```console
ls
```

*Take a peek inside*

| **34** :$

```console
cd vip
```

| **35** :$

```console
ls
```

*Note, you can't see the hidden directory ".git" with a normal `ls` command, use `-a`...*

| **36** :$

```console
ls -a
```

*Note the hidden ".git" directory*

| **37** :$

```console
ls -l .git/objects/pack
```

*Note the ".git" directory contains a few read-only files in "objects/pack/", making it harder to delete*

| **38** :$

```console
cd ..
```

| **39** :$

```console
rm -r vip
```

*Note the error message because of the read-only files (<kbd>Ctrl</kbd> + <kbd>C</kbd> to get out of there!)*

*Removing a git-cloned directory is easier with `sudo`*

### This lesson requires a "sudoer" who can use `sudo`
>
___
> Optional: You may login as a "sudoer" if needed
>
> | **S1** :$

```console
su Username
```
___

| **40** :$

```console
sudo rm -r vip
```

| **41** :$

```console
ls
```

*...all gone, no problem*

### IF needed, `exit` from the other "sudoer"
>
___
> Optional: IF you logged in as a "sudoer", now exit
>
> | **S2** :$

```console
exit
```
___


___

# The Take

- `wget` simply downloads and saves a file from a Web address
- `wget -O filename` specifies a "Save as..." filename for the download
- `curl` opens a Web address's content as raw output
- `curl -L` may be needed to follow links, otherwise it won't (`wget` will)
- `curl https://web-address > save-as-filename` is how `curl` saves the downloaded file
- `git` is GitHub's app that syncs and downloads a GitHub repo (files) on your local computer with the GitHub repo (on the GitHub website)
- `git clone GitHub-REPOSITORY-address` is how `git` "downloads" a GitHub repo
- When downloading a .zip file or .tar file (tarball) from GitHub, the contents will have a strange name
- Using `git clone` is the simplest way to download a GitHub repo

___

#### [Lesson 7: tar, xz, zip, gzip, bzip2](https://github.com/inkVerb/vip/blob/master/201/Lesson-07.md)
