# pmOS APK Packaging for aplication for binaries

- [pmOS APK Packaging for aplication for binaries](#pmos-apk-packaging-for-aplication-for-binaries)
  - [Packaging with Abuild](#packaging-with-abuild)
    - [Set up](#set-up)
      - [Install dependencies](#install-dependencies)
      - [Generate RSA key for signing packages](#generate-rsa-key-for-signing-packages)
      - [Set up your build environment](#set-up-your-build-environment)
      - [Set up your local repositories](#set-up-your-local-repositories)
    - [Basic use of `abuild`](#basic-use-of-abuild)
    - [Lets build a package!](#lets-build-a-package)
    - [APKBUILD file with git use and automatic compilation](#apkbuild-file-with-git-use-and-automatic-compilation)
    - [Resources](#resources)

## Packaging with Abuild

Alpine Linux uses `abuild` for building packages. The process involves creating an `APKBUILD` file, which contains the metadata and instructions for building the package.

### Set up

#### Install dependencies

```sh
sudo apk add abuild
```

#### Generate RSA key for signing packages
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

#### Set up your build environment
Edit the file `/etc/abuild.conf` as per requirements. The one field to edit is `PACKAGER`, so that you can get credit (or blame) for packages you create.

```sh
sudo vim /etc/abuild.conf
```

`REPODEST=$HOME/packages/`

```sh
sudo addgroup user abuild
```

> [!note]
> Relogin to apply the group changes.

#### Set up your local repositories
Set up your local repositories to look in the local directory where you have your APK packages. You can do this by editing the file `/etc/apk/repositories` and adding the local paths to the repositories.

`/etc/apk/repositories`:
```
/home/USER/packages/testing/
/home/USER/packages/main/
/home/USER/packages/community/
```

`packages/community/armv7/`

```shell
sudo echo /home/user/packages/community/armv7/ >> /etc/apk/repositories
```

> [!note] 
> Alpine Linux has 3 repositories:

- **main**: Directly supported official packages which are maintained by the Alpine core team.
Similar to core/extra repositories in Arch Linux.
- **community**: Packages that are created by the contributors and developers. Not fully supported, maintenance is dependent on the contributor activity.
Same as community repository on Arch Linux.
- **testing**: New packages that are added by contributors. Packages from this repository are accepted into the community repository. This repository is only available on edge (development) branch of Alpine.

Install the package from the local directory:
```shell
apk add ~/packages/<channel>/<architecture/<package name>-<package version>.apk
```

### Basic use of `abuild`
If you just want to build a package from an `APKBUIL` file, only two command are needed. Both commands operate on an `APKBUILD` file in the current directory, so you should cd into the directory before running them.

- `abuild checksum`: updates the checksums for source files.
- `abuild -r`: builds the package.


### Lets build a package!
We want to build a package for `tty-clock`, which should be available in the `community` repository.
First, create a directory `community` for development and packagging:
```shell
mkdir community
cd community
```

Now download the source code of `tty-clock`:
```shell
git clone <repository URL>
```

Create template for the `APKBUILD` file:
```shell
newapkbuild tty-clock
cd tty-clock
```

This will create a file named `APKBUILD` in the `tty-clock` directory. You can also create the file manually if you prefer.

Now compile the source code of `tty-clock`:
```shell
make
```

Update the `APKBUILD` file with the correct information, such as `pkgname`, `pkgver`, `pkgrel`, `pkgdesc`, `url`, `arch`, `license`, `depends`, and `makedepends`.

Without automtic compilation:
```shell
# Contributor: Martin Duquesnoy <xorg62@gmail.com>
# Maintainer: elPytel <jaroslav.korner1@gmail.com>
pkgname=tty-clock
pkgver=1.0.0
pkgrel=0
pkgdesc="Terminal clock"
url="https://github.com/xorg62/tty-clock"
arch="armv7"
license="BSD-3-Clause"
depends="ncurses"
makedepends="ncurses-dev"
source="tty-clock"
options="!check"

build() {
    cp ./tty-clock "$srcdir/tty-clock"
}

package() {
    install -Dm755 "$srcdir/tty-clock" "$pkgdir/usr/bin/tty-clock"
}
```

- `depend` is the runtime dependency, which is `ncurses` in this case.
- `makedepends` is the build-time dependency, which is `ncurses-dev` in this case.
- `source` is the source file, which is `tty-clock` binary in this case.
- `options` is set to `!check` to skip the test phase, as `tty-clock` does not have any tests.


Create the checksum for the source files. This will update the `APKBUILD` file with the checksums of the source files:
```shell
abuild checksum
```

This will generate a `sha512sums` line in the `APKBUILD` file, which looks like this:
```txt

sha512sums="
df17d7b62b331b12ae8bd01f2c53b5fde6d1be231d3678f183d7cdde5dd532cc9d78e14cd6d1bb3f12daa4099cecab1a40b668c413d81953c034dd9f7a25d20e  tty-clock
"
```

Build the package:
```shell
abuild -r
```

It will also update the index file in the `~/packages/community/armv7/` directory, which contains the information about the package.

The package will be built and placed in the `~/packages/community/armv7/` directory (or the directory you specified in `/etc/abuild.conf`).

> [!note]
> We set the `REPODEST` variable in `/etc/abuild.conf` to point to `~/packages/`, so the built packages will be placed in that directory.
> Architecture is set to `armv7` in the `APKBUILD` file, which selects the correct subdirectory in the `~/packages/community/` directory.

Install the package:
```shell
apk add ~/packages/community/armv7/tty-clock-1.0.0-r0.apk
```
or if you have set up the local repositories correctly, you can simply run:
```shell
apk add tty-clock
```

You can update the apk index to include the new package:
```shell
sudo apk update
```

### APKBUILD file with git use and automatic compilation
[APKBUILD](../pmOS_files/applications/community/tty-clock/APKBUILD) file example for git use:
```shell
# Contributor: Martin Duquesnoy <xorg62@gmail.com>
# Maintainer: elPytel <jaroslav.korner1@gmail.com>
pkgname=tty-clock
pkgver=1.0.0
pkgrel=0
pkgdesc="Terminal clock"
url="https://github.com/xorg62/tty-clock"
arch="armv7"
license="BSD-3-Clause"
depends="ncurses"
makedepends="ncurses-dev git"
source=""
builddir="$srcdir/$pkgname"

prepare() {
    source="https://github.com/xorg62/tty-clock.git"
    if [ ! -d "$builddir" ]; then
        git clone "$source" "$builddir"
    fi
    cd "$builddir"
}

build() {
    make
}

check() {
    :
}

package() {
    install -Dm755 tty-clock "$pkgdir/usr/bin/tty-clock"
}
```

It uses the `git` command to clone the repository and build the package automatically. The `prepare()` function is used to clone the repository if it does not exist in the build directory. The `build()` function compiles the source code, and the `package()` function installs the binary into the package directory.

### Resources
- [Creating an Alpine package](https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package#)
- [Setup your system](https://wiki.alpinelinux.org/wiki/Include:Setup_your_system_and_account_for_building_packages)
- [Abuild and Helpers](https://wiki.alpinelinux.org/wiki/Abuild_and_Helpers)
- [APKBUILD Reference](https://wiki.alpinelinux.org/wiki/APKBUILD_Reference)
- [build an alpine package](https://www.matthewparris.org/build-an-alpine-package/)
- [alpine packaging setup](https://blog.orhun.dev/alpine-packaging-setup/)
- [Creating Alpine Linux Packages](https://gist.github.com/XtendedGreg/ebd54547a28178b443aa521fed571397)
- [archlinux abould man page](https://man.archlinux.org/man/extra/abuild/abuild.1.en)

- https://github.com/alpinelinux/alpine-chroot-install
- https://github.com/orhun/alpkg