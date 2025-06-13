# ssh

Install OpenSSH server

```sh
sudo apk update 
sudo apk add openssh
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

```cmd
ssh user@192.168.1.123
```