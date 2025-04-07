# IBM COBLO Desktop
This installs the necesary files for the [IBM COBOL course](https://www.ibm.com/training/course/learning-cobol-programming-with-vscode-DL00015G) on Arch/Manjaro Linux using Arch repos

| **Node.js** :$

```console
sudo pacman -Syy --needed --noconfirm node nvm npm
```

| **`jdk-openjdk` Arch Package** :$ (the JDK developer kit only, see [Arch Wiki on Java](https://wiki.archlinux.org/title/Java))

```console
sudo pacman -Syy --needed --noconfirm jdk-openjdk
```

VSCode: Use VSCodium or Code-OSS

| **VSCodium** :$

```console
yay -Syy --noconfirm vscodium-bin
```

| **Code-OSS** :$

```console
sudo pacman -Syy --needed --noconfirm code
```

**Zowe Explorer** and **IBM Z Open Editor** can be installed in the Extensions area of VSCode/Codium/Code-OSS

These are meant to be Arch/Manjaro install instructions while following the instructions to install dependencies for the IBM course
