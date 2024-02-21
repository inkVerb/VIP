# Linux 601
## Lesson 4: Git

# The Chalk
## Git
### What is Git?
The Linux kernel originally had no official home for development, but eventually found a home with a comercial project called BitKeeper. In 2005, BitKeeper's restricted licence could no longer work with Linux's OpenSource model. Hence, Git was authored by Linus Torvalds specifically for Linux kernel development.

- A Git repo contains:
  1. Database objects (3 types)
    - Blobs: file contents in chunks of binary data
    - Trees: sets of blobs with file names, thus directory structure
    - Commits: descriptions of each tree's change step
  2. Directory cache
    - State of directory tree

This manages changes better than keeping files separate

### What is Revision Control?
Tracks changes for:

- When
- What
- Who
- Why

Terms

- **Revision Control System (RCS)**
  - Track changes in files
- **Distributed Revision Control System (DRCS)**
  - RCS with many contributors
- **Concurrent Versions System (CVS)**
  - Simultaneous different versions of the same code

### History
- **RCS**: Originally, every file had changes tracked in a subfolder `RCS/` with `v` appended to a text file with the same name
  - One file, one change
- **CVS**: Next, many files in one change; central server tracks changes
  - Multiple contributors, file changes can conflict
- **Git** has no central change tracking
  - Every repository is authoritative
  - Every repository contains the entire code
  - Change review structure can be hierarchical or flat
  - A tool, not a method

### Repositories, Branches, Forks & Pulls
- A Git project is called a **repository** or "repo" in most discussion
- This is structured in the URL and on a GitHub profile:
  - `https://github.com/USERNAME/REPOSITORY`
  - The `USERNAME` can be for a user or for an organization
- One repository can have many branches
  - One branch is usually intended for development
  - A `main` branch always exists, usually intended for production
- Each repository may be **forked**
  - Forking creates an independent repository for your own user account or on an organization you own or have the right permissions for
- After forking and committing changes, you may make a **pull request** with the original repository
  - This would add your own changes to the original repository, "pulling" your fork back to the original repo
  - This is how many developers contribute to others' projects
- Every branch and commit has a unique hash
  - The collected branch and commit hash labels are called a **treeish**, which you may see discussed in some places

### Commits & Tags
- Every stage of change in repo is called a **commit**
  - Each commit is like one step in version development
- Most commits are known by a treeish hash and date, etc
- Tags can be custom added to a commit, usually if it is noteworthy or "important"
- Add tags to a commit with `git tag -a Tag.name -m 'Message about the tag here'`

### Common Commands
- `git --version`
- `git help`
- `git init` Create an empty repository or reinitialize an existing one
- `git clone` Clone/download a repository to local directory
- `git branch` List, create, or delete branches
- `git status` Show working tree status
- `git add` Add file contents to the index
- `git mv` Move or rename a file, directory or symlink
- `git commit` Record changes to the repository
- `git merge` Join two development histories together
- `git pull` Fetch from and integrate with another repository or local branch
- `git push` Update remote refs and associated objects

### User Configuration

| **user setup** :$

```console
git config --global user.name "Jesse Steele"
git config --global user.email "jesse@inkisaverb.com"
git config --global init.defaultBranch main
```

#### Setup Git SSH keys ## Optional!
- Create ssh keys (-N "" for no passphrase, -f /path/to/KEYNAME)
  - `ssh-keygen -t rsa -N "" -f ~/.ssh/GitHub`
- Find the public key to copy-paste
  - `cat ~/.ssh/GitHub.pub`
- Add the key on Github
  - >GitHub Avatar > Settings > SSH and GPG keys + New/Add SSH key
- Do a test on your machine (Necessary)
  - `ssh -T git@github.com`

*Changes will be written to `~/.gitconfig`, which can hold more information including command shortcuts*

### Git Operation
#### Create or Initialize a Repository

| **new repo** :$

```console
mkdir inkverb
cd inkverb
git init
```

- *See what happened...*
  - `git status`
  - `ls -a`
  - `ls .git`

#### Create a Repo File

*Each command ends with `git status -sb -uall` to see how changes are explained*

- `-s` short output
- `-b` branch info
- `-uall` show all untracked files

| **create file** :$

```console
echo "Hello Taiwan" > motd
git status -sb -uall
```

| **add file** :$

```console
git add motd
git status -sb -uall
```

#### Commit New File

| **commit new file** :$

```console
git commit -m 'Message of the day'
git status -sb -uall
```

| **push new file** :$

```console
git push
git status -sb -uall
```

#### Change & Commit Existing File

| **change file** :$

```console
echo "Hello USA" > motd
git status -sb -uall
```

| **add changes** :$

```console
git add motd
git status -sb -uall
```

| **commit changes** :$

```console
git commit -m 'New message of the day'
git status -sb -uall
```

| **diff changes** :$

```console
git diff
```

| **push changes** :$

```console
git push
git status -sb -uall
```

| **check log** :$

```console
git log
```

#### Alternates

- Add many new files easily

| **add many** :$

```console
git add .
```

- Push to specific branch

| **push to main branch** :$

```console
git push -u origin main
```

*...after this, `git push` will continue pushing to the `main` branch*

| **push to devel branch** :$

```console
git checkout -b devel
git add .
git commit -m 'Things changed'
git push -u origin devel
```

*...after this, `git push` will continue pushing to the `devel` branch*

#### Clone

- Any public repo can be cloned using `https://` addresses
  - `clone` includes the master and all branches, so `checkout` can be used later to change branches
 
| **clone unowned repo** :$

```console
git clone https://github.com/inkverb/vip
```

- A repo you own which you will push back requires `git@` notation, under "SSH" on the GitHub website
  - You must have SSH keys set up with your GitHub account to push changes (above)

| **clone working repo** :$

```console
git clone git@github.com:inkVerb/VIP.git
```

- Now edit and push changes
- No need to `checkout` because working on master branch

| **push to devel branch** :$

```console
git add .
git commit -m 'Things changed'
git push -u origin master
```

- You could add a tag anywhere after `clone` and before `push`

| **add a tag** :$

```console
git tag -a v0.2 -m 'Devel stage 2'
```

- Clone from the `devel` branch in your working repo

| **clone working repo 'devel' branch** :$

```console
git clone -b devel git@github.com:inkVerb/VIP.git
```

- Now edit and push changes
- No need to `checkout` because the `devel` branch was specified at `clone`

| **push to devel branch** :$

```console
git add .
git commit -m 'Things changed'
git push -u origin master
```

*Learn more with the [GitCheat Cheat Sheet]((https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/GitCheat.md))*

#### Clone Linux Kernel

- The Linux kernel is available on Git
  - If you like, you may evaluate it from the source on your local machine

| **clone linux kernel** :$

```console
git clone --depth 1 -b master https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux/
```

___

#### [Lesson 5: Kernel](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md)