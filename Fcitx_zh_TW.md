# Install Fcitx for Taiwan-style Mandarin typing input in Ubuntu
This installs fcitx on GNOME

1. You must FIRST add Chinese Taiwan/Traditional in:

- Settings > Region & Language > Manage Installed Languages / Language Support

2. ? Optionally, set the language for your User Account Settings

*If using Vrk, do not change your home folders to Chinese names since it is more difficult to type in the terminal*

- If you don't konw what Vrk is: never mind, but how did you get here you awesome web cralwer you!

3. Ctrl + Alt + T (Open the Terminal)

```console
sudo apt-get install fcitx fcitx-ui-qimpanel fcitx-chewing fcitx-table-cangjie3 fcitx-config-gtk
```

*Some may already be installed, that's okay.*

```console
fcitx-qimpanel-configtool
```

*Set to "Vertical", then "Apply", then exit*

*Below is less preferable, better is: Settings > Region & Language > Manage Installed Languages > Keyboard input method*

```console
im-config
```

- Choose: OK, yes, fcitx, OK, OK

*Check if installed correctly*

```console
cat ~/.xinputrc
```

*It should include: run_im fcitx*

*If not...*

```console
echo 'run_im fcitx' > ~/.xinputrc
```

*Then, reboot*

```console
reboot
```

*(Yes, you really have to reboot, even for each user)*

***Add the language***

*Choose Either:*

- In Apps, search and run: fcitx Configuration
- Click the fcitx icon > Configure

**Then...**
- + to add a language
- Deselect "Only Show Current Language"
- For Taiwan bopomofo select "Chewing", OK

All done! Have a cookie...

###
