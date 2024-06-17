# Renoise
*The DAW from [renoise.com](https://renoise.com), on Manjaro*

This needs special dependencies, which can be installed with the [renoise AUR](https://aur.archlinux.org/packages/renoise) package

If you only install with `install.sh` inside the the downloaded tarball, the package manager won't be able to remove it; using the AUR helper will allow it to be removed with `yay -R renoise`

Use the AUR helper to install `renoise`:

1. Download your purchased or trial Reoinse for Linux tarball from [renoise.com](https://renoise.com)
2. Clone the [renoise-AUR](https://aur.archlinux.org/packages/renoise) repo: `git clone https://aur.archlinux.org/renoise.git`
3. Place the Renoise tarball (`.tar.gz`) in the `renoise/` folder just cloned
4. `cd` into the `renoise/` folder
5. Make: `makepkg`
6. Install: `makepkg -i`

___

If you get a "RealTime" error message on Renoise startup, it may be a user privilege issue. If so, try this:

1. Install `realtime-privileges` (`sudo pacman -S realtime-privileges`)
2. Add your user to the `realtime` group (`sudo usermod $USER -a -G realtime`)
3. Reboot

___

If you have other audio problems, try the `rtcqs`<sup>AUR</sup> package, then enter it from the command line. (See the [RTCQS docs](https://codeberg.org/rtcqs/rtcqs) for more instructions.)
