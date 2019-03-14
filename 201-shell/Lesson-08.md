# Shell 201
## Lesson 8: Hash – md5sum, sha1sum, sha256sum, sha512sum

`cd ~/School/VIP/shell/201`

___

*Look at the files we will use*

| **1** : `cd compress`

### Hash security

| **2** : `md5sum vrk.tar.xz` (1990s, out of date, never use)

| **3** : `sha1sum vrk.tar.xz` (1990s, better, not good enough)

| **4** : `sha256sum vrk.tar.xz` (better yet)

| **5** : `sha512sum vrk.tar.xz` (great, big)

*Generate a sha256sum hash*

| **6** : `sha256sum vrk.tar.xz`

*It's always the same, that way you are confident the file is not even 1 bit different since downloaded*

| **7** : `sha256sum vrk.tar.xz`

*Note every file's hash is different*

| **8** : `sha256sum vrk.tar.gz`

| **9** : `sha256sum vrk.tar.bz2`

| **10** : `sha256sum vrk.tar`

*Another way: create a hash file so we can check it all at once*

| **11** : `sha256sum vrk.tar.xz > vrk.tar.xz.sha256`

| **12** : `ls`

*Lookie what's inside*

| **13** : `cat vrk.tar.xz.sha256`

| **14** : `gedit vrk.tar.xz.sha256`

*Now check it with* `-c` *and the hash file, in the same directory as the file*

| **15** : `sha256sum -c vrk.tar.xz.sha256`

*The sha256sum hash file KNOWS what it's looking for, play hide-and-seek*

| **16** : `mv vrk.tar.xz vrk.tar.xz.HIDING`

| **17** : `ls`

| **18** : `sha256sum -c vrk.tar.xz.sha256`

*FAIL*

*Try an imposter*

| **19** : `mv vrk.tar.bz2 vrk.tar.xz`

| **20** : `sha256sum -c vrk.tar.xz.sha256`

*FAIL*

*Moral of the story: compressed files need hash checking*

| **21** : `mv vrk.tar.xz vrk.tar.bz2`

| **22** : `mv vrk.tar.xz.HIDING vrk.tar.xz`

| **23** : `cd ..`

___

# The Take

-

___

#### [Lesson 9: du, df, top, ps aux, pgrep, kill](https://github.com/inkVerb/vip/blob/master/201-shell/Lesson-09.md)
