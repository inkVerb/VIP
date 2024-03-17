# Install IBus for Taiwan-style Mandarin typing input in Manjaro/Arch

| **1** :$ Update

```console
sudo pacman -Syyu --noconfirm
```

- If the update is not complete, some things may not work

| **2** :$ Set the locale

```console
sudo cp /etc/locale.gen /etc/locale.gen.orig
sudo echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
sudo echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
sudo locale-gen
```

| **3** :$ Reboot

- Close all browsers first!

```console
reboot
```

| **4** :$ Set locale for your user

- Choose

**English**

```console
localectl set-locale LANG=en_US.UTF-8
```

- OR

**Chinese**

```console
localectl set-locale LANG=zh_TW.UTF-8
```

- Optionally install language packs

```console
manjaro-settings-manager
```

*Language Packs > Install Packages*

| **5** :$ Install IBus

- Chinese phonetic input
  - Sun Yat-sen's bopomofo system: `ibus-chewing`
  - Mao Zedong's Romanized pinyin: `ibus-pinyin`

```console
sudo pacman -S --noconfirm ibus ibus-chewing ibus-pinyin
```

| **6** :$ Install Fonts (this may take a long time)

```console
sudo pacman -S --noconfirm adobe-source-han-sans-tw-fonts adobe-source-han-serif-tw-fonts
```

- Optional Microsoft fonts (this may take a very long time)

```console
yay -S --noconfirm ttf-ms-win10-zh_tw ttf-ms-win8-zh_tw
```

Logout and login again for changes to take effect

| **7** :$ Add the language input in Settings

- *Settings > Region & Language Language > Input Sources*
  - **+** *> Chinese > Chinese (Chewing)?*
  - **+** *> Chinese > Chinese (Pinyin)?*

Extra options

- For other languages or more options, use the IBus guided setup:

```console
ibus-setup
```

## Super + Space = Change language input

- <key>Super</key> = <key>Meta</key> = <key>Windows</key>

# Done! Have a cookie: ### #
