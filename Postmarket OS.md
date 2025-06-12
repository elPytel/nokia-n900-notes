# Postmarket OS

- [Postmarket OS](#postmarket-os)
  - [OS imgs](#os-imgs)
    - [installation](#installation)
  - [login](#login)
  - [Applications](#applications)
    - [installation](#installation-1)
    - [Bash](#bash)
    - [ssh](#ssh)
  - [Connect from computer](#connect-from-computer)
  - [i3wm](#i3wm)
    - [Shortcuts](#shortcuts)
        - [default mode](#default-mode)
        - [command mode](#command-mode)
        - [workspace mode](#workspace-mode)
        - [Other](#other)
          - [Display brightness](#display-brightness)

## OS imgs
[Postmarket OS - N900 ISO](https://images.postmarketos.org/bpo/v24.12/nokia-n900/)

> [!note]
> xfce is extremely slow

> [!note]
> i3wm is the best choice for N900 with windows manager.

### installation
https://posts.oztamir.com/running-postmarketos-on-a-nokia-n900/


Boot to Maemo. Now we need to install U-Boot. In X-Terminal:  

```sh
root
apt-get install u-boot-flasher u-boot-tools
```
It will ask for flashing kernel - agree.  

```sh
apt-get install kernel-power-bootimg
```
It may ask for flashing kernel - DISagree.  

Now, we create item file for U-Boot. Let's create file:  
```sh
vim /etc/bootmenu.d/10-pmos.item
```

Now type all lines very carefully:  
```txt
ITEM_NAME="postmarketOS"
ITEM_SCRIPT="boot.scr"
ITEM_DEVICE="${EXT_CARD}p1"
ITEM_FSTYPE="ext2"
```
Save it.  

```sh
u-boot-update-bootmenu
```

https://talk.maemo.org/showthread.php?t=101301

## login
Username and password:

**user**

**147147**

## Applications

### installation
```sh
apk add bash curl git make
```

### Bash
```sh
chsh -s /bin/bash user
```

### ssh

Install OpenSSH server

```sh
apk update apk add openssh
```

Start and enable SSH server

Start immediately:

```sh
rc-service sshd start
```

Enable at startup:

```sh
rc-update add sshd default
```

Set a password for login (if you don't have one yet)

For example, for user `user`:

`passwd user`

> [!note]
> If you want to use root access via SSH, you will need to allow `PermitRootLogin yes` in `sshd_config`, but **I do not recommend this** for security reasons.

##  Connect from computer

On your computer (Linux/macOS/WSL/Windows with OpenSSH):

`ssh user@192.168.1.123`

## i3wm

### Shortcuts
##### default mode

- shift + space: switch to "command mode"
##### command mode

- t: open terminal
- k: kill current program
- w: workspace mode
- r: restart i3wm (use after modifying the config)
- q: go back to "default mode"

##### workspace mode

- a/s/d/f/g: switch to workspace 1/2/3/4/5
- q: go back to "command mode"

##### Other

###### Display brightness

With the current configuration, you can adjust the display brightness using the volume keys while holding the Shift key.