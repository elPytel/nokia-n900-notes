# pmOS APK Packaging for aplication for binaries

- [pmOS APK Packaging for aplication for binaries](#pmos-apk-packaging-for-aplication-for-binaries)
  - [Packaging](#packaging)
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
nokia-n900:~/tty-clock$ apk-builder.sh
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

### Install the package
```sh
sudo apk add --allow-untrusted tty-clock.apk
```

> [!note]
> In future it would be wise to implement valid signature for the APK package, so you can install it without the `--allow-untrusted` option. For now, you can use this option to install the package.

> [!warning]
> Be careful when using the `--allow-untrusted` option, as it allows you to install packages that are not signed or verified. Make sure you trust the source of the package before installing it.