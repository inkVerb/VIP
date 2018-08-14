# Android root, custom ROM, and using adb & fastboot

#### adb (tool)
`adb` accesses the phone when it's running the normal Android OS or a "recovery" (like TWRP).

#### fastboot (PC tool & phone boot mode)
`fastboot` accesses the phone when it's booted to "fastboot" mode.

"Fastboot" is the very early boot mode, similar to how BIOS is the first mode you can access on a PC.
- On many phones, fastboot is a mode selected from the bootloader.
- On a Sony Xperia, fastboot is the same as the bootloader and the screen is blank the entire time.
- Usually you access fastboot/bootloader by pressing volume keys combined with power. Each model is different. (Sony: hold a volume key while connecting to PC via USB)

#### Recovery: Clockwork Mod (CWM) & Team Win Recovery Project (TWRP)
Recoveries are semi-special boot moads, comparable to the GRUB menu on steroids on a PC.
- Recoveries are used by developers.
- Though recoveries don't seem like it at first, they are the professional way to modify an Android phone.
- There are links to various recoveries on the Internet. Sometimes the very newest versions won't work.
- Recoveries can format your phone, install a ROM, perform "root" operations.
- Recoveries can have other tools, like a terminal emulator, file manager, etc.
- Recoveries are very, very small, maybe 12MB.

###### *You DO NOT need an Android .apk or app from the Play market for any of this! Ubuntu/Linux terminal is easier!*
Many instructions for "rooting" your phone and installing a custom ROM involve Android apps. But, it's not necessary. Keep it simple. Making things complicated just to be simple often just makes things too complicated. If you have Ubuntu then you already have what you need.

#### ROM
A ROM is the actual operating system, the "flavor" of Android in a zip file that you download and install after unlocking the phone.
- A "stock" ROM is the ROM that comes with the phone.
- A stock ROM is usually locked and unlocking it requires a key from the manufacturer's website, usually with a registration and signin. If a phone is "locked", it means the "bootloader" is locked and the ROM can't be changed... yet ;-)
- Usually a stock ROM is not rooted and can't be rooted. A rooted ROM usually must be the custom ROM.
- Custom ROMs are made by humans who love people. They do it for the love. They HATE feature requests because they already thought of them all and know the headache of trying to make it all work. If they can make your wonderful idea for a custom ROM work, then it's already out there. If what you want isn't there, either wait or give up. Don't make feature requests for custom ROMs without donating *serious* money to the ROM developer.
- ROM developers are called "chefs" because Android versions are named after deserts.
- ROMs are usually 200MB-1GB or more.

#### Bootloader
- This is simply the start of the bootup of your phone, much like BIOS.
- A "locked bootloader" means the ROM can't be changed.
- Many phones come "locked", meaning the bootloader is locked, meaning you can't make any changes to the operating system.
- This must be unlocked before you can install a custom ROM, usually involving the manufacturer's unique key and using fastboot from the PC terminal.
- Sometimes, this is a menu allowing you to choose "recovery" or "fastboot" modes, othertimes you never see it on the screen at all; it all depends on the manufacturer.

#### How adb and fastboot work
- fastboot will "flash" files onto the phone.
- adb will "push" files onto the phone.
- Both must be run via `sudo` (even when online instructions omit 'sudo', you need to use it in the Linux PC terminal.)

## Custom ROM
### A. Get your tools
#### 1. adb & fastboot on Ubuntu
- install with this:
`sudo apt install android-tools-adb android-tools-fastboot`
#### 2. Custom ROM
- A ROM and recovery must be downloaded specifically for your phone.
- Great place to search and learn: [http://forum.xda-developers.com]
- Some well-known ROM packages:
    - AOSP
    - FoxMod
    - XenonHD
    - VenomOS
    - Resurrection Remix
    - Dirty Unicorns
    - SlimRoms
    - LineageOS
    - SlimRoms
    - Paranoid Android
    - Cyanogen
 #### 3. TWRP (recovery)
- TWRP home: [https://twrp.me/]
- TWRP app downloads: [https://dl.twrp.me/twrpapp/]
- XDA Developer TWRP how-to article: [https://www.xda-developers.com/how-to-install-twrp/]
- Note: This is a `.img` file, sometimes named `boot.img`, othertimes `my-long-version.1.2.3.4.5.6.7.8.9.img`. *The name doesn't matter when you install it.*

### B. Unlock the bootloader

#### 1. Android Settings
1. In Android: Settings: About Phone: Tap "Build number" seven times
2. In Android: Settings: Developer options: Enable "Debugging" mode
3. In Android: Settings: Battery: Disable "Fast boot" (for HTC phones; note "Fast boot" is not *fastboot*)

#### 2. Developer Unlock Bootloader
Basically, follow instructions per phone.

Here is an example with an HTC: [https://htc-one.gadgethacks.com/how-to/unlock-bootloader-root-your-htc-one-running-android-4-4-2-kitkat-0151186/]

Here is another site with concise instructions: [https://forum.xda-developers.com/showthread.php?t=1432199]

For HTC...

`sudo fastboot oem get_identifier_token`

... follow instructions from website and get your email...

`sudo fastboot flash unlocktoken Unlock_code.bin`

Here are some other examples of other devices:

`sudo fastboot -i 0x2a96 oem unlock`

`sudo fastboot -i 0x2b4c oem unlock`

`sudo fastboot -i 0x2a96 oem unlock`

##### Some brands developer unlock links...
- HTC: [http://htcdev.com/]
- Sony: [https://developer.sonymobile.com/unlockbootloader/unlock-yourboot-loader/]
- Samsung: (Some say it's easy.) [https://www.youtube.com/watch?v=oQ2t-6qyxTY] then `sudo fastboot oem unlock`
- Google: Much like Samsung. *No keys needed, just use* `sudo fastboot oem unlock` *(One reason people love Google phones!)*
- ASUS: fat chance. If they support unlocking, it may require an .apk and no one probably makes a ROM for them because they rarely support unlocking.
- iPhone: You even know how to find this web page!? Since you learned this much, your phone doesn't use Android. No way in Heaven, Earth, or the four chambers of Tartarus.

#### Installation stuff & steps
1. Download the custom ROM of choice and the recovery that your trusted websites advise you to, usually TWRP or CWM.
2. Bootloader/fastboot mode 
- Boot to bootloader/fastboot mode (probably power button & volume keys, phone-specific)
- Connect the to your PC via USB
- Then `fastboot flash` a recovery (CWM/TWRP) to the phone from the Linux terminal (below)
(This usually will not hurt your phone and your phone can still boot normally.)

`sudo fastboot flash boot recovery-i-downloaded-prolly-twrp-3.x.2.x.1.x.zip`

3. Boot to the recovery CWM/TWRP (probably from menues using volume/power keys in the bootloader)
(Sometimes the bootloader can boot to the revoery. Sony: only when a recovery is installed, the LED will briefly light up on boot; when the LED lights, press VOLUME UP to enter recovery)
4. Factory reset
- Use the recovery CWM/TWRP to do a "factory reset" AKA "wipe". The new ROM can't install on top of an existing, working Android operating system.
5. Copy the custom ROM to the phone
- Option 1: `adb push` (below)
- Option 2: `adb sideload` (below; installs, but does not copy; instructions are in the recovery CWM/TWRP; skip the rest of instructions)
- Option 3: Just copy it to the SD card physically, mount as a disk in Android to "copy files", or copy it some other way to get it in the phone
6. Install the ROM
- In the recovery CWM/TWRP menues, find the options to choose and Install a ROM.

### adb and fastboot commands

###### Install adb and fastboot
`sudo apt install android-tools-adb android-tools-fastboot`

###### fastboot Commands
`sudo fastboot devices` # list attached devices to see if everything is working

`sudo fastboot oem device-info`

`sudo fastboot oem lock` # in case you want to lock your phone again after unlocking it from the manufacturer

`sudo fastboot oem unlock` # if you want to unlock your phone if/after you don't need a key from the manufacturer

`sudo fastboot flash boot boot.img` # puts the recovery on the phone

`sudo fastboot reboot` # reboots to ROM

`sudo fastboot getvar imei`

`sudo fastboot oem writeimei 123456789012347` # sets or overwrites the imei

`sudo fastboot -w` # format the phone (Erased the known universe!)

###### adb Commands
`adb kill-server` # kill any normal process just in case

`sudo adb start-server`

`sudo adb devices` # list attached devices to see if everything is working

`sudo adb push my-custom-rom.zip destination/on/phone` # copies ROM to phone if you didn't in Android or the SD, ie: `sudo adb push my-custom-rom.zip sdcard`

`sudo adb sideload my-custom-rom.zip` # sideload install method, select this option in the recovery CWM/TWRP before you enter it in the terminal

