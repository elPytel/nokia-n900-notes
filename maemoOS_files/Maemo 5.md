# Maemo 5 

- [Maemo 5](#maemo-5)
  - [Update OS](#update-os)
  - [Terminal](#terminal)
    - [root](#root)
    - [SSH](#ssh)
  - [Repository](#repository)
    - [Mirrors](#mirrors)
  - [Apps](#apps)
    - [Installation from `.install` files](#installation-from-install-files)
    - [Installation from `.deb` files](#installation-from-deb-files)
    - [Python](#python)


## Update OS
Update OS:
- https://wiki.maemo.org/Updating_the_firmware

ISO:
- https://web.archive.org/web/20131117073524/http://skeiron.org/tablets-dev/nokia_N900/

CSSU:
- https://wiki.maemo.org/Community_SSU

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

### Installation from `.install` files 
You can install applications on Maemo 5 using `.install` files, which configure repositories and trigger application installation from them. Internet access is required to use `.install` files, and you can open them with the Hildon Application Manager.

### Installation from `.deb` files
To install applications on Maemo 5, you can use `.deb` files. These files can be installed using the `dpkg` command.
```bash
dpkg -i <name>.deb
```

> [!note]
> Check the [maemoOS_files/deb/](./deb/) directory for `.deb` files.

- [Installing_applications](https://wiki.maemo.org/Installing_applications)

### Python
- https://wiki.maemo.org/PyMaemo/QuickStartGuide
- https://wiki.maemo.org/Py2deb#Install_py2deb
- https://talk.maemo.org/showthread.php?t=91341
- https://gnahackteam.wordpress.com/2013/09/12/how-to-install-python-2-7-5-on-n900-maemo-5/
- https://www.stochasticgeometry.ie/2010/04/29/python-on-the-nokia-n900/
