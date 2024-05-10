# Linux 601
## Lesson 4: Git & Revision Control

# The Chalk
## Revision Control Systems
*(AKA Source Control Systems)*

### What is Revision Control?
Tracks changes for:

- When
- What
- Who
- Why

### Terms
- **Software Configuration Management (SCM)**
  - Broader arena of software revision control
- **Revision Control System (RCS)**
  - Track changes in software development
- **Distributed Revision Control System (DRCS)**
  - RCS that can easily harmonize from many contributors
  - Elaborate and reliable
  - Distributed - local repositories on each client, then pushed to the hosting server
- **Centralized Versions Control System (CVS)**
  - Simultaneous different versions of the same code
  - Good for small teams
  - Centrallized - server repository pushed directly from clients to the hosting server

### Revision Control System Implementations
- Distributed
  - **[GitHub](https://github.com)** (Git) - powerfull web GUI; most widely used, hosts Linux source
  - **[Fossil](https://www.fossil-scm.org/)** - local install; also PM: bug tracks, wiki, chat, email alerts, blog; from SQLite developer
  - **[Mercurial](https://www.mercurial-scm.org/)**
  - **[Monotone](https://www.monotone.ca/)**
  - **[GNU Arch](https://www.gnu.org/software/gnu-arch/)** - discontinued
- Centralized
  - **[Apache Subversion](https://subversion.apache.org/)** (SVN) - also hosts WordPress plugins
  - **[Concurrent Versions System](https://cvs.nongnu.org/)** (CVS)
  - **[GNU Revision Control System](https://www.gnu.org/software/rcs/)** (RCS)

### History
- **RCS**: Originally, every file had changes tracked in a subfolder `RCS/` with `v` appended to a text file with the same name
  - One file, one change
- **CVS**: Next, many files in one change; central server tracks changes
  - Multiple contributors, file changes can conflict
- **Git**: Does not require central change tracking
  - Every repository is authoritative
  - Every repository contains the entire code
  - Change review structure can be hierarchical or flat
  - A tool, not a method

## Git
- *[github.com](https://github.com)*
- *[Git Wiki](https://en.wikipedia.org/wiki/Git)*

### What is Git?
The Linux kernel originally had no official home for development, but eventually found a home with a comercial project called BitKeeper.

In 2005, BitKeeper's restricted licence could no longer work with Linux's OpenSource model. Hence, Git was authored by Linus Torvalds specifically for Linux kernel development.

In 2018, Microsoft bought GitHub for $7.5 billion USD.

A Git repo contains:

1. Database objects (3 types)
   - Blobs: file contents in chunks of binary data
   - Trees: sets of blobs with file names, thus directory structure
   - Commits: descriptions of each tree's change step
2. Directory cache
   - State of directory tree

This manages changes better than keeping files separate

### Repositories, Branches, Forks & Pulls
- A Git project is called a **repository** or "repo" in most discussion
- This is structured in the URL and on a GitHub profile:
  - `https://github.com/username/repository`
  - The `username` can be for a user or for an organization
- One repository can have many branches
  - One branch is usually intended for development
  - A `main` branch always exists, usually intended for production
    - The `main` branch can also be called the `master`, depending on how you use `git` commands; just stay consistent with each repo
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
  - `git remote`
  - `ls -a`
  - `ls .git`

| **status check** :$

```console
git status
git status -sb -uall
```

| **remote check** :$

```console
git remote
git remote -v
```

#### Create a Repo File
*Each command ends with `git status -sb -uall` to see how changes are explained*

- `-s` short output
- `-b` branch info
- `-uall` show all untracked files

| **create file** :$

```console
echo "Hello Taiwan" > motd
```

| **add file** :$

```console
git add motd
```

| **add all files** :$

```console
git add .
```

...or...

```console
git add *
```

#### Commit New File

| **commit new file** :$

```console
git commit -m 'Message of the day'
```

| **push first time to `main`** :$

```console
git push -u origin main
```

| **push after working on `main` branch** :$

```console
git push
```

#### Change & Commit Existing File

| **change file** :$

```console
echo "Hello USA" > motd
```

| **diff changes** :$ *pending changes before `git add`*

```console
git diff
```

| **add changes** :$

```console
git add .
git add *
```

| **commit changes** :$

```console
git commit -m 'New message of the day'
```

| **push changes** :$

```console
git push
```

| **check log** :$

```console
git log
```

#### Branches
- Push to specific branch
  - First time pushing to this branch
  - Push to this branch while using another branch

| **push to `main` branch specifically** :$

```console
git push -u origin main
```

- *after this, `git push` will continue pushing to the working branch, seen with `git status`*
- *redundant if:*
  - *already on `git branch -M main` or*
  - *already pushed with `-u origin main`*

| **push to working branch** :$

```console
git push
```

- *pushes to branch specified already with `git checkout somebranch`*

| **create & use new branch `devel`** :$ *via `branch -M` Move/force, optional*

```console
git branch -M devel
```

| **create & use new branch `devel`** :$ *via `checkout -b` Branch/new*

```console
git checkout -b devel
```

| **create new branch `devel`** :$

```console
git branch devel
```

| **work on existing branch `devel`** :$

```console
git checkout devel
```

| **push to `devel` branch first time** :$ *(or while working on another branch)*

```console
git add *
git commit -m 'Things changed'
git push -u origin devel
```

| **push after first push while working on `devel` branch** :$

```console
git add *
git commit -m 'Things changed'
git push
```

| **merge `devel` branch into `main`** :$

```console
git checkout main
git merge origin/devel
git push
```

| **merge `main` branch into `devel`** :$

```console
git checkout devel
git merge main
git push
```

#### Clone
- Any public repo can be cloned using `https://` addresses
  - `clone` includes the main and all branches, so `checkout` can be used later to change branches
 
| **clone unowned repo** :$

```console
git clone https://github.com/inkverb/vip
```

- A repo you own which you will push back requires `git@` notation, under "SSH" on the GitHub website
  - You must have SSH keys set up with your GitHub account to push changes (above)

| **clone owned repo** :$

```console
git clone git@github.com:inkverb/vip.git
```

- Now edit and push changes
- No need to `checkout` because working on main branch

| **push to devel branch** :$

```console
git add *
git commit -m 'Things changed'
git push -u origin devel
```

- You could add a tag anywhere after `clone` and before `push`

| **add a tag** :$

```console
git tag -a v0.2 -m 'Devel stage 2'
```

- Clone from the `devel` branch in your working repo

| **clone owned repo `devel` branch** :$

```console
git clone -b devel git@github.com:inkVerb/VIP.git
```

- Now edit and push changes
- No need to `checkout` because the `devel` branch was specified at `clone`

| **push to `devel` branch** :$

```console
git add .
git commit -m 'Things changed'
git push -u origin main
```

*Learn more with the [GitCheat Cheat Sheet]((https://github.com/inkVerb/VIP/blob/master/Cheat-Sheets/GitCheat.md))*

#### Clone Linux Kernel
- The Linux kernel is available on Git
  - If you like, you may evaluate it from the source on your local machine

| **clone linux kernel** :$

```console
git clone --depth 1 -b main https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux/
```

___


# The Keys
*Practice commands for SysAdmins who already know what these mean*

| **SSH keys for GitHub** :$

```consolecd
mkdir -p ~/.ssh
cd ~/.ssh
ls
# SKIP ssh-keygen if you see id_rsa.pub !!!!
ssh-keygen -t rsa
cat id_rsa.pub
# Add: Github > You > Settings > SSH and GPG Keys https://github.com/settings/keys
```

| **setup GitHub CLI & sandbox** :$

```console
git config --global user.name "myusername"
git config --global user.email "my@example.com"
git config --global init.defaultBranch main
ls -l ~/.gitconfig
vim ~/.gitconfig

cd
mkdir vipgit
cd vipgit
```

| **test GitHub SSH connection** :$

```console
ssh -T git@github.com
# Hi your_user_name! You've successfully authenticated, but GitHub does not provide shell access.

ssh -vT git@github.com
```

| **new repo** :$

- *Create repo `viprepo` at [GitHub.com/new](https://github.com/new)*
  - *anytime before `git push`*
  - *it can be empty*

```console
cd ~/vipgit

mkdir viprepo
cd viprepo

git init
git remote add origin git@github.com:myusername/viprepo.git

git remote
git remote -v
git status

git branch -M main # redundant
git status

echo "# Title" > README.md
git add README.md
git status

git commit -m "New readme"
git status

# Create git repo `viprepo` before proceeding

#git push --set-upstream viprepo main # same as below

git push -u origin main
```

...simple version...

```console
cd viprepo
echo "# viprepo" > README.md
git init
git remote add origin git@github.com:myusername/viprepo
git branch -M main
git add README.md
git commit -m "first commit message"
git push -u origin
```

| **push to main** :$

```console
git status
echo "## Subtitle" >> README.md
git add .
git status
git commit -m "README sub"
git push
```

| **push to branch** :$

```console
git status

git branch vbranch    # create the branch 'vbranch'
git checkout vbranch  # working on branch `vbranch` (optional, for 'git status')

echo "Some text" >> README.md
git add .
git commit -m "README sub"
git push -u origin vbranch

git status
git status -sb -uall
echo "My Name" > CREDITS
git add .
git commit -m "CREDITS"
git push
git log
```

| **branches** :$

```console
git checkout main
git status
git status -sb -uall
git checkout vbranch
git status
git status -sb -uall

git checkout -b tbranch
git status
echo "foo" > bar.text
git add .
git status
git status -sb -uall

git commit -m "Foo Bar Text"
git push -u origin tbranch
git status
git status -sb -uall
git log

git branch devel
git checkout devel
git status
git status -sb -uall

git checkout devel
git checkout main
git checkout vbranch
git checkout tbranch

git checkout devel
git tag -a v0.2 -m 'Devel stage 2'
git push -u origin devel

git checkout vbranch
git tag -a v0.21 -m 'V-Devel stage 2'
git push -u origin vbranch

git checkout tbranch
git tag -a v0.22 -m 'T-Devel stage 2'
git push

git checkout main
git tag -a v0.23 -m 'Main stage 2'
git push -u origin main

# Change branches

touch tfile
git checkout tbranch
git add tfile
git commit -m "add t file"
git push

touch vfile
git checkout vbranch
git add vfile
git commit -m "add v file"
git push

touch dfile
git checkout devel
git add dfile
git commit -m "add devel file"
git push

git checkout main

git merge origin/tbranch -m "merge tbranch to main"
git push

git merge origin/vbranch -m "merge vbranch to main"
git push

git merge origin/devel -m "merge devel to main"
git push

# Update branches to main

git rebase main # redundant

git checkout vbranch
git merge main
git push

git checkout tbranch
git merge main
git push

git checkout devel
git merge main
git push
```

| **monitoring** :$

```console
git remote
git remote -v

git status
git status -sb -uall

git diff # before git add

git log
```

| **remove GitHub CLI settings & sandbox** :$

```console
rm -rf ~/viprepo
rm -f ~/.gitconfig
```

- ***IF `.ssh/` was NEW**, the keys can be removed later for further practice:*

| **remove ALL `.ssh/` keys** :$ ***CAUTION!***

```console
rm -rf ~/.ssh
```

___

#### [Lesson 5: Kernel & Devices](https://github.com/inkVerb/vip/blob/master/601/Lesson-05.md)