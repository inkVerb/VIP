# Bourne Shell
## Background
On many Linux modern distros, `/bin/sh` is a symbolic link to `/bin/bash`, and no `/bin/sh` is available

The Bourne Shell (`/bin/sh`) was released in 1977 v7 by Stephen Bourne for Unix v7 from Bell Labs and was kept when POSIX arrived in 1988

Bourne Again Shell came from Brian Fox in 1989 as a free, improved, backward-compatible drop-in replacement

In 2006 Ubuntu started linking `/bin/sh` to `/bin/dash`, having many limits of `/bin/sh`; it still links through 2025

Ubuntu's `/bin/sh` link to `/bin/dash` will bring many of the Bourne Shell limits, so it could affect Ubuntu systems

## Legacy Bourne Shell `/bin/sh`
This has a fork with `make` updates at [github.com/JesseSteele/heirloom-sh](https://github.com/JesseSteele/heirloom-sh)

This process references legacy Unix/Linux code and installs the orignal `/bin/sh` at `/usr/local/bin/sh` with a symbolic link from `/bin/sh`

Prerequisite: make tools, install the following packages

```console
git base-devel gcc make
```

Clone, make, move, link

```console
git clone https://github.com/JesseSteele/heirloom-sh.git
cd heirloom-sh
make
sudo make install
sudo ln -sfn /usr/local/bin/sh /bin/sh
```

Now, `#!/bin/sh` will use the legacy Bourne Shell

To undo, probably run:

```console
sudo ln -sfn /bin/bash /bin/sh
```