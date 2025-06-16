# pmOS APK Packaging for aplication for binaries

- [pmOS APK Packaging for aplication for binaries](#pmos-apk-packaging-for-aplication-for-binaries)
  - [Packaging](#packaging)
    - [Dependencies](#dependencies)
    - [My script `apk-builder.sh`](#my-script-apk-buildersh)
  - [Making an APK package for `tty-clock`](#making-an-apk-package-for-tty-clock)
    - [Create `.PKGINFO` file (for `tty-clock`)](#create-pkginfo-file-for-tty-clock)
    - [Create APK package](#create-apk-package)
    - [Install the package](#install-the-package)

## Packaging
To package `tty-clock` for PMOS, you can use my script [`apk-builder.sh`](../pmOS_files/scripts/apk-builder.sh) from the directory `pmOS_files/scripts/tty-clock-apk/`. This script will create an APK package for your application.

I have tested it with the [tty-clock](pmos_tty-clock_native.md) app. 

> [!note] 
> I have decided not to use the `apkbuild` tool, which is used for building APK packages. I have created a simple script that can be used to build APK packages for any binary application.

### Dependencies

```sh
sudo apk add abuild
```
```sh
abuild-keygen -a
>>> Generating public/private rsa key pair for abuild
Enter file in which to save the key [/home/user/.abuild/user-684d6508.rsa]:
writing RSA key
>>>
>>> You'll need to install /home/user/.abuild/user-684d6508.rsa.pub into
>>> /etc/apk/keys to be able to install packages and repositories signed with
>>> /home/user/.abuild/user-684d6508.rsa
>>>
>>> Please remember to make a safe backup of your private key:
>>> /home/user/.abuild/user-684d6508.rsa
>>>
```

```sh
sudo cp ~/.abuild/*.rsa.pub /etc/apk/keys/
```


### My script `apk-builder.sh`

```sh
Usage: ./apk-builder.sh [options]
This script builds an APK package for pmOS.
It requires a binary file and a .PKGINFO file in the current directory.
If the application name is not set, it will be taken from the .PKGINFO file.

Options:
         -h, --help              Show this help message
         -n, --name <name>       Name of the application
         -v, --version <version> Version of the application (default: 1.0.0)
         -c, --clean             Clean up the build directory
```

## Making an APK package for `tty-clock`

### Create `.PKGINFO` file (for `tty-clock`)
`.PKGINFO` file for the package can be created as follows:

```txt
maintainer = Martin Duquesnoy <xorg62@gmail.com>
pkgname = tty-clock
pkgver = 1.0.0
pkgdesc = Terminal clock
url = https://github.com/xorg62/tty-clock
license = BSD-3-Clause
depend = ncurses
```

### Create APK package

Run the script `apk-builder.sh` in the directory where you have the binary file `tty-clock` and the `.PKGINFO` file:

```sh
apk-builder.sh
```

You should see output similar to this:
```sh
nokia-n900:~/tty-clock$ sudo apk-builder.sh
Using application name from .PKGINFO: tty-clock
Using application version from .PKGINFO: 1.0.0
Building APK package for tty-clock...
Creating directories...
Copy binary to the package directory...
Creating .PKGINFO metadata...
Adding additional metadata to .PKGINFO...
Creating fake signature files...
Packing APK...
APK package created: tty-clock-1.0.0.apk
Done.
To install the package, use:
sudo apk add --allow-untrusted tty-clock-1.0.0.apk
```

Scipt `apk-builder.sh` will fill the pkginfo file automatically with:
```bash
builddate = $(date +%s)
packager = $(whoami)
size = $(stat -c %s $APP_NAME)
arch = $APP_ARCH
```

And it will create the APK package with the name: `tty-clock-<version>.apk`.

> [!note]
> If you want to remove the generated directory `tty-clock-apk`, you can use the `-c` option:
> ```sh
> apk-builder.sh -n tty-clock -c
> ```

This how the archive structure should look like:

```sh
nokia-n900:~/tty-clock$ tar -tvzf tty-clock-1.0.0.apk
-rw-r--r-- root/root       256 2025-06-14 11:15:59 .PKGINFO
-rw-r--r-- root/root         0 2025-06-14 11:15:59 .SIGN.RSA.fakesign
drwxr-xr-x root/root         0 2025-06-14 11:15:59 usr/
drwxr-xr-x root/root         0 2025-06-14 11:15:59 usr/bin/
-rwxr-xr-x root/root     35632 2025-06-14 11:15:59 usr/bin/tty-clock
drwxr-xr-x root/root         0 2025-06-14 11:15:59 var/
drwxr-xr-x root/root         0 2025-06-14 11:15:59 var/db/
drwxr-xr-x root/root         0 2025-06-14 11:15:59 var/db/apk/
````

> [!note]
> The `.PKGINFO` file must be first in the archive, otherwise the APK package will not be recognized by the `apk` tool.

### Install the package
```sh
sudo apk add --allow-untrusted --no-interactive tty-clock-1.0.0.apk
```

```sh
nokia-n900:~/tty-clock$ sudo apk add --allow-untrusted tty-clock-1.0.0.apk
doas (user@nokia-n900) password:
WARNING: Support for packages without datahash will be dropped in apk-tools 3.
The following NEW packages will be installed:
  ncurses tty-clock
Need to download 75 KiB of packages.
After this operation, 187 KiB of additional disk space will be used.
(1/2) Installing ncurses (6.5_p20241006-r3)
(2/2) Installing tty-clock (1.0.0)
WARNING: Support for packages without datahash will be dropped in apk-tools 3.
Executing busybox-1.37.0-r12.trigger
1371 MiB in 855 packages
```

> [!note]
> In future it would be wise to implement valid signature for the APK package, so you can install it without the `--allow-untrusted` option. For now, you can use this option to install the package.

> [!warning]
> Be careful when using the `--allow-untrusted` option, as it allows you to install packages that are not signed or verified. Make sure you trust the source of the package before installing it.