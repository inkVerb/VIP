# GLava
For desktop EQ visualization from most desktop audio sources

GLava article:
https://www.linuxuprising.com/2018/11/embed-audio-visualizer-on-your-linux.html

## Install

`sudo add-apt-repository ppa:linuxuprising/apps`

`sudo apt update`

`sudo apt install glava`

Copy the config file to your home directory:

`glava --copy-config`

## Run it

`glava --desktop`

Manual different effects:

`glava --desktop --force-mod=circle`

Options: `radial`,` graph`, `wave`, `circle`, `bars` (default)

## Config

Config file: `~/.config/glava/rc.glsl`

### Effect

Example: `#request mod bars`

### Size and which monitor, examples

- First monitor: `#request setgeometry 0 0 1920 1080`
- Second monitor: `#request setgeometry 1920 0 1920 1080`
- Third monitor: `#request setgeometry 3840 0 1920 1080`

## Startup file

Startup file: `~/.config/autostart/glava.desktop`

```
[Desktop Entry]
Type=Application
Exec=sh -c 'sleep 10 && glava --desktop'
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=GLava
```
