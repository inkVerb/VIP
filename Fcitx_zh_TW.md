# Install Fcitx for Taiwan-style Mandarin typing input in Manjaro/Arch

1. Update

```bash
sudo pacman -Syyu --noconfirm
```

2. Set the locale

```bash
sudo cp /etc/locale.gen /etc/locale.gen.orig
sudo echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
sudo echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
sudo locale-gen
```

3. Reboot

- Close all browsers first!

```bash
reboot
```

4. Set locale for your user

- Choose

| **English** :

```bash
localectl set-locale LANG=en_US.UTF-8
```

OR

| **Chinese** :

```bash
localectl set-locale LANG=zh_TW.UTF-8
```

- Optionally install language packs

```bash
manjaro-settings-manager
```

  - Language Packs > Install Packages

5. Install Fcitx & Fonts

- Chinese phonetic input
  - Sun Yat-sen's bopomofo system: `fcitx-chewing`
  - Mao Zedong's Romanized pinyin: `fcitx-googlepinyin` or `fcitx-libpinyin`

```bash
sudo pacman -S --noconfirm fcitx fcitx-im fcitx-gtk2 fcitx-gtk3 fcitx-qt5 fcitx-configtool fcitx-chewing libchewing
```

```bash
sudo pacman -S --noconfirm adobe-source-han-sans-tw-fonts adobe-source-han-serif-tw-fonts
```

- Optional:

```bash
yay -S --noconfirm ttf-ms-win10-zh_tw ttf-ms-win8-zh_tw
```

6. Language Settings:

- Settings > Region & Language Language > Input Sources
- Add: Chinese > Chinese (Chewing)

7. Run Fcitx at startup

```bash
cat <<EOF >> .xinitrc
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
EOF
```

8. Reboot

```bash
reboot
```

## Meta + Space = Change language input

All done! Have a cookie...

###
