# Shell 101

## Prepare and install

This prepares and installs the apps we will use in these lessons

This requires `sudo` permissions

| **A1** :$ Arch/Manjaro

```console
sudo pacman -S gedit gnome-text-editor nautilus chromium-browser firefox
```

| **C1** :$ CentOS/Fedora

```console
sudo dnf install gedit gnome-text-editor nautilus chromium-browser firefox
```

| **D1** :$ Debian/Ubuntu

```console
sudo apt install gedit gnome-text-editor nautilus chromium-browser firefox
```

### Setup the GNOME Text Editor

| **2** :$

```console
su
```

| **3** :#
```console
cat <<EOF > /usr/bin/xedit
#!/bin/bash
$(which gnome-text-editor) \$@
EOF
```

| **4** :#
```console
chmod 755 /usr/bin/xedit
```

| **5** :#
```console
exit
```

### GNOME Text Editor Settings

| **6** :$

```console
gsettings set org.gnome.TextEditor style-variant 'dark'
gsettings set org.gnome.TextEditor highlight-current-line true
gsettings set org.gnome.TextEditor show-map true
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor wrap-text false
gsettings set org.gnome.TextEditor restore-session false
```

*Setup the [Arch F12 Terminal](https://github.com/inkVerb/vip/blob/master/Arch-Drop-Terminal.md)*
