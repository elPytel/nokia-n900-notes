# Terminal Clock for PMOS

`tty-clock` - terminal clock

- [Terminal Clock for PMOS](#terminal-clock-for-pmos)
  - [Instalation of `tty-clock` on PMOS](#instalation-of-tty-clock-on-pmos)
    - [Install dependencies](#install-dependencies)
    - [Clone and build](#clone-and-build)
      - [Copy binary to `/usr/local/bin`](#copy-binary-to-usrlocalbin)
  - [Next to read](#next-to-read)
  - [Resources](#resources)

## Instalation of `tty-clock` on PMOS
`tty-clock` is a simple terminal clock that can be used on postmarketOS (PMOS). It displays the current time in a terminal window.
### Install dependencies
```sh
sudo apk add ncurses-dev
```

### Clone and build
```sh
git clone https://github.com/xorg62/tty-clock.git
cd tty-clock
make
```

#### Copy binary to `/usr/local/bin`

```sh
sudo cp tty-clock /usr/local/bin/
```

## Next to read
- [pmOS APK Packaging for app binaries](./pmos_apk_packaging.md)

## Resources
- https://github.com/xorg62/tty-clock
