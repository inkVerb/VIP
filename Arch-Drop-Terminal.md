# Arch Drop Terminal

With this, you can either use <kbd>Scroll Lock</kbd> or <kbd>F12</kbd> for the dropdown terminal

## Conventional hotkeys for Arch & Manjaro

|:-------------------------------------------------------------------------- |:---------------------- |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>                            | Open floating terminal |
| <kbd>Scroll Lock</kbd>                                                     | Dropdown terminal      |
| <kbd>F12</kbd>                                                             | Dropdown terminal      |
| <kbd>F11</kbd>                                                             | Full screen            |
| <kbd>Ctrl</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd>                    | Change tab             |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd> | Move tab               |
| <kbd>Ctrl</kbd> + <kbd>T</kbd>                                             | New tab                |
| <kbd>Ctrl</kbd> + <kbd>W</kbd>                                             | Close tab              |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>T</kbd>                          | New tab in terminal    |
| <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>                          | Close tab in terminal  |
| <kbd>Shift</kbd> + <kbd>PageUp</kbd>/<kbd>PageDown</kbd>                   | Change volume          |
| <kbd>Shift</kbd> + <kbd>Break</kbd>                                        | Mute volume            |

## 1. Install the Xfce4 terminal

```console
yay -S xfce4-terminal

mkdir -p ~/.config/xfce4/terminal
```

## 2. Set conventional keyboard shortcuts

```console
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Dropdown Terminal: ScrLk'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'Scroll_Lock'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'xfce4-terminal  --drop-down'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "'Dropdown Terminal: F12'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "'f12'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "'xfce4-terminal  --drop-down'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "'Xfce Terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "'<Ctrl><Alt>t'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "'xfce4-terminal'"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Shift>Page_Up']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Shift>Page_Down']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['<Shift>Break']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 3
```

## 3. Set styling for the Xfce4 terminal

```console
cat <<'EOF' > ~/.config/xfce4/terminal/terminalrc
[Configuration]
FontAllowBold=FALSE
MiscAlwaysShowTabs=FALSE
MiscBell=TRUE
MiscBellUrgent=FALSE
MiscBordersDefault=FALSE
MiscCursorBlinks=FALSE
MiscCursorShape=TERMINAL_CURSOR_SHAPE_BLOCK
MiscDefaultGeometry=80x23
MiscInheritGeometry=FALSE
MiscMenubarDefault=FALSE
MiscMouseAutohide=FALSE
MiscMouseWheelZoom=TRUE
MiscToolbarDefault=FALSE
MiscConfirmClose=TRUE
MiscCycleTabs=TRUE
MiscTabCloseButtons=TRUE
MiscTabCloseMiddleClick=TRUE
MiscTabPosition=GTK_POS_TOP
MiscHighlightUrls=TRUE
MiscMiddleClickOpensUri=TRUE
MiscCopyOnSelect=FALSE
MiscShowRelaunchDialog=TRUE
MiscRewrapOnResize=TRUE
MiscUseShiftArrowsToScroll=FALSE
MiscSlimTabs=TRUE
MiscNewTabAdjacent=FALSE
MiscSearchDialogOpacity=100
MiscShowUnsafePasteDialog=FALSE
BackgroundMode=TERMINAL_BACKGROUND_TRANSPARENT
BackgroundDarkness=0.780000
ColorPalette=#0c0d0e;#e31a1c;#31a354;#dca060;#3182bd;#756bb1;#80b1d3;#b7b8b9;#737475;#e31a1c;#31a354;#dca060;#3182bd;#756bb1;#80b1d3;#fcfdfe
DropdownWidth=100
DropdownHeight=25
DropdownStatusIcon=FALSE
FontName=Monospace 11
ShortcutsNoMnemonics=TRUE
ShortcutsNoMenukey=TRUE
ShortcutsNoHelpkey=TRUE
DropdownKeepOpenDefault=TRUE
DropdownToggleFocus=FALSE
EOF
```
