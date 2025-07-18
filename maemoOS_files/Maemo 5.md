# Maemo 5 

- [Maemo 5](#maemo-5)
  - [Update OS](#update-os)
  - [Lock Code](#lock-code)
  - [Terminal](#terminal)
    - [root](#root)
    - [SSH](#ssh)
  - [Repository](#repository)
    - [Mirrors](#mirrors)
  - [Apps](#apps)
    - [Installation from `.install` files](#installation-from-install-files)
    - [Installation from `.deb` files](#installation-from-deb-files)
  - [SW](#sw)
    - [Status Lights](#status-lights)
    - [Shortcuts](#shortcuts)
    - [How to get more symbols on Nokia N900?](#how-to-get-more-symbols-on-nokia-n900)
    - [How to go to Nokia N900 task Manager?](#how-to-go-to-nokia-n900-task-manager)
    - [How to create a screenshot on Nokia N900](#how-to-create-a-screenshot-on-nokia-n900)
    - [Media player shortcuts](#media-player-shortcuts)
    - [Email shortcuts](#email-shortcuts)
    - [Nokia N900 browser shortcuts](#nokia-n900-browser-shortcuts)
    - [Writing tips for Nokia N900](#writing-tips-for-nokia-n900)
  - [Development](#development)
    - [Python](#python)


## Update OS
Update OS:
- https://wiki.maemo.org/Updating_the_firmware

ISO:
- https://web.archive.org/web/20131117073524/http://skeiron.org/tablets-dev/nokia_N900/

CSSU:
- https://wiki.maemo.org/Community_SSU

## Lock Code
Default lockcode is: **12345**

## Terminal
### root

`rootsh` is installable through Hildon Application Manager. You will need it in any circumstance where you need root access to your device.  

`rootsh` download links: [repository.maemo.org/rootsh_1.8_all.deb](http://repository.maemo.org/extras/pool/fremantle/free/r/rootsh/rootsh_1.8_all.deb)


```bash
sudo gainroot
```

`rootsh` will ask for a sudo password, though, so on top of rootsh you can either install sudser, to be found here: 
[sudser](http://maemo.org/packages/view/sudser/)  
  
Or you can manually edit the sudo requirements in  
`/etc/sudoers.d/01sudo` and add sudo as a passwordless command.

`sudser`
- http://repository.maemo.org/extras/pool/diablo/free/s/sudser/sudser_0.2.0-2_all.deb
- http://repository.maemo.org/extras/pool/fremantle/free/s/sudser/
- https://web.archive.org/web/20200927093559/http://repository.maemo.org/extras/pool/fremantle/free/s/sudser/sudser_0.2.0-4_all.deb


- [maemo.org/Root_access](https://wiki.maemo.org/Root_access)

### SSH

[Meamo 5 SSH](../doc/Nokia%20N900%20-%20SSH.md)

## Repository
By default, the N900 only has the Ovi Store and firmware update catalogs in the list. However, a wider selection of applications is available on Maemo user servers. You have to add them manually:

```txt
Maemo Extras
Web address: http://repository.maemo.org/extras/
Distribution: fremantle
Components: free non-free

Maemo Extras-testing
Web address: http://repository.maemo.org/extras-testing/
Distribution: fremantle
Components: free non-free

Maemo Extras-devel
Web address: http://repository.maemo.org/extras-devel/
Distribution: fremantle
Components: free non-free

My-Maemo.com
Web address: http://my-maemo.com/repository/
Distribution: fremantle
Components: user
```

> [!note]
> Check [install](./repository/) files for repository configuration.

> [!warning]
> The servers [repository.maemo.org](repository.maemo.org) are down at the moment of writing this tutorial. But a backup is available for download at:
[web.archive.org](https://web.archive.org/web/20250201032157/http://repository.maemo.org/), or you can use the mirrors listed below.


Source:
- [deset-a-dve-vylepseni-nokie-n900](https://www.idnes.cz/mobil/aplikace/deset-a-dve-vylepseni-nokie-n900-aplikace-ktere-musite-mit.A100209_192018_programy_lhc)

### Mirrors

Mirrors of the Maemo repository can be found at:
- [talk.maemo.org](https://talk.maemo.org/showthread.php?t=101524&page=3)
- [maemo.plan9.de](https://maemo.plan9.de/)
- [maemo.plan9.de/apt-mirror](https://maemo.plan9.de/apt-mirror/mirror/repository.maemo.org/)

> [!note]
> Or you can install mirrors from `*.install` files in the [`maemoOS_files/repository/`](./repository/) directory.

> [!warning]
> Use the mirrors at your own risk, as they may not be up-to-date or reliable.

## Apps
- [talk.maemo.org](https://talk.maemo.org/showthread.php?t=100636)
- [apps-for-your-nokia-n900](http://mynokiablog.com/2010/05/13/apps-apps-and-some-more-apps-for-your-nokia-n900-maemo-5/)

List of recommended applications for the Nokia N900:
- Faster Application Manager - fapman
- HealthCheck
- VNC Viewer
- Personal IP address

Notes for some applications:
- [Games](../doc/maemo_games.md)
- [SMB](../doc/maemo_smb.md)
- [Git](../doc/maemo_git.md)


DropBox
- [Maemo: DropBox](https://talk.maemo.org/showthread.php?t=58882)

### Installation from `.install` files 
You can install applications on Maemo 5 using `.install` files, which configure repositories and trigger application installation from them. Internet access is required to use `.install` files, and you can open them with the Hildon Application Manager.

### Installation from `.deb` files
To install applications on Maemo 5, you can use `.deb` files. These files can be installed using the `dpkg` command.
```bash
dpkg -i <name>.deb
```

> [!note]
> Check the [maemoOS_files/deb/](./deb/) directory for `.deb` files.

- [maemo: Installing applications](https://wiki.maemo.org/Installing_applications)

## SW

- [n900 tips](https://n900tips.blogspot.com/)

### Status Lights
What do the Nokia N900 LED colors mean?

```
1. Blue color (blinking): Incoming message (instant message or SMS message or email) or missed call
2. Orange color (blinking): Battery is Charging
3. Green color: Battery is fully charged
4. White (blinking): Stand-by
5. Red color (blinking): Error
6. Yellow: Device soft on/off
7. White (fade in): Power on
8. White (fade out): Power off
9. Red (blink once): Webcam on
```
- [z/n900-notes](https://github.com/z/n900-notes)

### Shortcuts
Pressing **CTRL + SHIFT + X** brings up the terminal.

Pressing **CTRL + N** in the contact list brings up the new contact screen. This same method works to open a new window in the browser.

Pressing **CTRL + Spacebar** changes input languages if you have more than one language defined.

### How to get more symbols on Nokia N900?

Click **Ctrl + Fn key** (below ctrl key)

### How to go to Nokia N900 task Manager?

Click **Ctrl + Backspace** to immediately to to the task manager

### How to create a screenshot on Nokia N900
Click **Ctrl + Shift + P** at the same time and you will find the screenshot inside the images folder.

### Media player shortcuts
1. Ctrl + Space : Play / Pause of current track
2. Ctrl + Left Arrow: Go to previous track
3. Ctrl + Right Arrow: Go to next track

### Email shortcuts

1. Ctrl + Enter: Send current Email
2. Ctrl + R: Reply to current email

### Nokia N900 browser shortcuts

1. Ctrl + N: Open a new browser window.
2. Ctrl + R: Webpage Refresh/Reload
3. Ctrl + B: Opens the bookmarks folder
4. Ctrl + D: Bookmarks the current page
5. Ctrl + S: Saves current page
6. Circular Zoom: Clockwize - Zoom in / Counter clockwize - Zoom out
7. Double click: 100% zoom in
8. Volume button: + for zoom in and - for zoom out.
9. Space bar: Go to the end of current page
10. Shift + Space: Go to the beginning of current page
11. Ctrl + Shift + O: Activate / deactivate portrait mode (vertical screen mode)

### Writing tips for Nokia N900

1. Ctrl + C: Copy
2. Ctrl + V: Paste
3. Ctrl + X: Cut
4. Ctrl + A: Select all
5. Ctrl + O: Open
6. Ctrl + N: Create new
7. Ctrl + S: Save
8. Ctrl + Z: Undo
9. Ctrl + Y: Redo
10. Ctrl + F: Find
11. Ctrl + Right Arrow button: Go to the word's end
12. Ctrl + Left Arrow button: Go to the word's beginning.

## Development

Thomas Thurman:
- [Writing apps for the N900](https://blogs.gnome.org/tthurman/2009/09/06/n900-tutorial-contents/)
  - [part 1](https://blogs.gnome.org/tthurman/2009/09/03/writing-apps-for-the-n900-part-1/)
  - [part 2 — packaging](https://blogs.gnome.org/tthurman/2009/09/06/writing-apps-for-the-n900-part-2-packaging/)

Thomas Thurman: meego 1.0 mobile application development cookbook 

[Packaging, Deploying and Distributing](https://wiki.maemo.org/Documentation/Maemo_5_Developer_Guide/Packaging,_Deploying_and_Distributing#Making_Application_Packages)
 
[PyMaemo](https://wiki.maemo.org/PyMaemo)

- [Quick Start Guide](https://wiki.maemo.org/PyMaemo/QuickStartGuide)
- [Status menu widgets](https://wiki.maemo.org/PyMaemo/HildonDesktop#Example_-_Status_menu_widgets_.28Fremantle_only.29)

Other:

- [OpenCV](https://www.samontab.com/web/2012/12/installing-opencv-in-the-nokia-n900-maemo/)
- [MPD on the N900 or how to use your Nokia N900 as a Wireless Home Music System](https://www.samontab.com/web/2012/01/mpd-on-the-n900-or-how-to-use-your-nokia-n900-as-a-wireless-home-music-system/)

### Python
- https://wiki.maemo.org/Py2deb#Install_py2deb
- https://talk.maemo.org/showthread.php?t=91341
- [how to install python 2.7.5 on n900 maemo 5](https://gnahackteam.wordpress.com/2013/09/12/how-to-install-python-2-7-5-on-n900-maemo-5/)
- https://www.stochasticgeometry.ie/2010/04/29/python-on-the-nokia-n900/