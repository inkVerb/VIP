# Linux 101

## Prepare and install

This prepares and installs the apps we will use in these lessons

This requires `sudo` permissions

| **A1** :$ Arch/Manjaro

```console
sudo pacman -S which gedit gnome-text-editor nautilus chromium-browser firefox
```

| **C1** :$ CentOS/Fedora

```console
sudo dnf install gedit gnome-text-editor nautilus chromium-browser firefox
```

| **D1** :$ Debian/Ubuntu

```console
sudo apt install gedit gnome-text-editor nautilus chromium-browser firefox
```

### Alias for the GNOME Text Editor

*This makes the `vedit` command point to `gnome-text-editor` if it is installed, otherwise to `gedit`*

| **2** :$

```console
if which gnome-text-editor; then echo 'alias vedit=gnome-text-editor' >> ~/.bashrc; else echo 'alias vedit=gedit' >> ~/.bashrc; fi
```

### Settings for GNOME Text Editor

| **3** :$

```console
gsettings set org.gnome.TextEditor style-variant 'dark'
gsettings set org.gnome.TextEditor style-scheme 'kate-dark'
gsettings set org.gnome.TextEditor highlight-current-line true
gsettings set org.gnome.TextEditor show-map true
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor wrap-text false
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor spellcheck false
```

*Setup the [Arch F12 Terminal](https://github.com/inkVerb/vip/blob/master/Arch-Drop-Terminal.md)*
