# WordGrinder Installation on PostmarketOS
WordGrinder is a simple word processor that runs in the terminal. To install it on PostmarketOS, follow these steps:

Add Alpine v3.22 community repository.
Open `/etc/apk/repositories` in an editor:

```bash
sudo vim /etc/apk/repositories
```

Add this line (at the end of the file):

```bash
http://dl-cdn.alpinelinux.org/alpine/v3.22/community
```
Save the file and update the package index:

```bash
sudo apk update
```
Check if the package is available:

```bash
apk search wordgrinder
```
→ You should see `wordgrinder-0.8-r2`.

Install:

```bash
sudo apk add wordgrinder
```

Run WordGrinder:
```bash
wordgrinder
```


> [!note]
> App is controled by **esc**. If you cannot find **esc** key on N900 keyboard, try using **shift + blue arrow + backspace**.

![N900_keymap_us](https://wiki.postmarketos.org/images/thumb/e/e1/N900_keymap_us.jpg/1600px-N900_keymap_us.jpg)