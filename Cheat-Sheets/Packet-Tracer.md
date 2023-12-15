# CISCO Packet Tracer

- You may watch [this YouTube video](https://www.youtube.com/watch?v=JWrlyQmp8qc) demonstrating the steps below

1. Signup, login, and download the .deb Ubuntu [Packet Tracer](https://www.netacad.com/courses/packet-tracer) package from CISCO
2. Run the `packettracer` installer from the AUR
- This only prepared dependencies, it doesn't actually install anything
```console
yay -S packettracer
```
- You may receive an error message that `Manual intervention is required`, which is normal and expected
3. Move the downloaded .deb file to: `~/.cache/yay/packettracer/`
- You know this is the right folder if it contains a `PKGBUILD` file
2. Run the `packettracer` installer from the AUR *again*
- This actually installs Packet Tracer
```console
yay -S packettracer
```
- Answer `n` (No) for "packages to clean build"
5. Drink a cup of coffee if you feel like it and if your doctor allows you to
- If you don't drink the coffee, it might work anyway, but whatever incredibly difficult class you are using this thing for might require at least two cups of coffee; consult your doctor before using either one