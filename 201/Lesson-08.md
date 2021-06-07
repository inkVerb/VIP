# Shell 201
## Lesson 8: Hash – md5sum, sha1sum, sha256sum, sha512sum

Ready the CLI

```console
cd ~/School/VIP/201
```

___

*Look at the files we will use*

| **1** :$

```console
cd compress
```

### Hash Security

| **2** :$ (1990s, out of date, never use)

```console
md5sum vip.tar.xz
```

| **3** :$ (1990s, better, not good enough)

```console
sha1sum vip.tar.xz
```

| **4** :$ (better yet)

```console
sha256sum vip.tar.xz
```

| **5** :$ (great, big)

```console
sha512sum vip.tar.xz
```

*Generate a sha256sum hash*

| **6** :$

```console
sha256sum vip.tar.xz
```

*It's always the same, that way you are confident the file is not even 1 bit different since downloaded*

| **7** :$

```console
sha256sum vip.tar.xz
```

*Note every file's hash is different*

| **8** :$

```console
sha256sum vip.tar.gz
```

| **9** :$

```console
sha256sum vip.tar.bz2
```

| **10** :$

```console
sha256sum vip.tar
```

*Another way: create a hash file so we can check it all at once*

| **11** :$

```console
sha256sum vip.tar.xz > vip.tar.xz.sha256
```

| **12** :$

```console
ls
```

*Lookie what's inside*

| **13** :$

```console
cat vip.tar.xz.sha256
```

| **14** :$

```console
gedit vip.tar.xz.sha256
```

*Now check it with `-c` and the hash file, in the same directory as the file*

| **15** :$

```console
sha256sum -c vip.tar.xz.sha256
```

*The sha256sum hash file KNOWS what it's looking for, play hide-and-seek*

| **16** :$

```console
mv vip.tar.xz vip.tar.xz.HIDING
```

| **17** :$

```console
ls
```

| **18** :$

```console
sha256sum -c vip.tar.xz.sha256
```

*FAIL*

*Try an imposter*

| **19** :$

```console
mv vip.tar.bz2 vip.tar.xz
```

| **20** :$

```console
sha256sum -c vip.tar.xz.sha256
```

*FAIL*

*Moral of the story: compressed files need hash checking*

*We're done, cleanup...*

| **21** :$

```console
mv vip.tar.xz vip.tar.bz2 && mv vip.tar.xz.HIDING vip.tar.xz
```

___

# The Take

- A "hash" is file or string of text run through a one-way math formula, resulting in a long "number" (hash) made of digits and letters
- There are different "hash" programs, but each makes a hash that is the same size
- The original file or text cannot be discovered from the hash, but the original file or text will always result in the same hash
- The only way to "crak" (hack) a hash is with "brute force" testing, which tests many random files and texts to try to re-create the identical hash
- A "hash" is used for two main reasons:
  - ***Storing passwords*** for users (so the password can work without being known)
  - ***Verifying file downloads*** are correct (to know the file was not hacked or corrupted)
- `sha256sum` is probably best

## *Most important* in choosing the hash difficulty level:
*Whether it can reasonably be cracked by interested hackers* ***with available technology today***
  - If a hash can't be reasonably cracked today, but will be tomorrow, then update the software to use the larger hash *tomorrow*, not today

## About each hash
- `md5sum` is the oldest hash still used today, from early 1990s
  - It ***is easy when learning***, not for "production" use (real life)
  - Sometimes we still need it because some developers have not moved on
  - Though outdated it is much better than nothing!
- `sha1sum` is the second-oldest used today, from the late 1990s
  - Because it's not too big, it doesn't slow down software and Internet too much, but is safer than `md5sum`
  - ***Some developers consider it outdated***, but not all; it depends on how important the project is
- `sha256sum` **is probably best for normal computing*** well through the year 2020
  - Its hashes are much longer than `sha1sum` and much more difficult to crack
  - Internet and CPU speeds are fast enough that the longer hash shouldn't slow down software too much
  - Anything longer could slow down software and usually wouldn't be necessary
- `sha512sum` is the largest as of 2019
  - It ***is probably overkill*** for most software even after 2020
  - It would probably be necessary for higher levels of government or top secrecy, such as banking
  - It ***is not enough by itself*** anyway
    - Hackers who can crack a `sha256sum` hash could probably crack a `sha512sum` with more time
    - If `sha512sum` is necessary, then other security measures are also necessary
- There are others, but not covered in this lesson

___

#### [Lesson 9: du, df, top, ps aux, pgrep, kill](https://github.com/inkVerb/vip/blob/master/201/Lesson-09.md)
