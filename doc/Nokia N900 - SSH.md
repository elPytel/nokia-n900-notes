# Nokia N900 - SSH 

## Nokia Install
If you have the [Maemo Extra repository](https://blog.tersmitten.nl/archives/867) enabled and already installed [rootsh](https://blog.tersmitten.nl/archives/852) the only thing we have to do is search for a package named **openssh**. This is a meta package which contains both **client** and **server**. We install this package and it will ask us to choose a root password. After setting this password the installation is finished. We now should be able to login with that password:

```bash
client: ssh root@192.168.1.4

Nokia-N900-42-11:~#
```

## Keys

```bash
ssh -keygen -t rsa
```

Move the keys between the server and the host.
## Connection
Maemo N900 SSH server is configured to use `ssh-rsa` as the host key algorithm by default. If you encounter issues connecting from a client that does not support `ssh-rsa`, you can specify the host key algorithm explicitly.

windows host:
```bash
ssh -oHostKeyAlgorithms=+ssh-rsa root@192.168.1.50
```

## References
- https://blog.tersmitten.nl/how-to-install-openssh-clientserver-on-the-nokia-n900.html
- https://www.howtoforge.com/set-up-ssh-with-public-key-authentication-debian-etch
