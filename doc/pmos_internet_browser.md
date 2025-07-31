# Browsers for PMOS on N900
- [Browsers for PMOS on N900](#browsers-for-pmos-on-n900)
  - [Comparison of Browsers for PMOS on N900](#comparison-of-browsers-for-pmos-on-n900)
  - [Firefox ESR](#firefox-esr)
  - [Surf](#surf)
  - [Midori](#midori)

## Comparison of Browsers for PMOS on N900
| Browser         | HTML5 audio/video | Performance on N900 | Recommended usage                |
| --------------- | ----------------- | ------------------- | ------------------------------- |
| **Midori**      | ✅                 | ✔ fast              | Multimedia and light browsing    |
| **Firefox‑esr** | ✅                 | X slow            | Web apps, JS-heavy content       |

[Web Browsers for PMOS](https://wiki.postmarketos.org/wiki/Category:Web_browsers)

## Firefox ESR
Installation:
```bash
sudo apk add icu-libs
sudo apk add firefox-esr
MOZ_USE_XINPUT2=1 firefox-esr
```

It takes like 60 seconds to start and it is unbarebly slow on N900. 

## Surf

Installation:
```bash
sudo apk add surf
```

## Midori
Installation:
```bash
wget https://ftp.udx.icscoe.jp/Linux/alpine/v3.17/community/armv7/midori-9.0-r6.apk
sudo apk add --allow-untrusted midori-9.0-r6.apk
```
Missing dependencies:

```bash
sudo apk add build-base gtk3-dev webkit2gtk-dev meson ninja git
```
Missing dependencies.