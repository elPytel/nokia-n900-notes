https://github.com/alpinelinux/alpine-chroot-install

apt install busybox
sudo apt install qemu-system qemu-user-static qemu-system-arm

qemu-system-arm -M virt -cpu cortex-a15 -m 512 -kernel /path/to/vmlinuz-virt -initrd /path/to/initramfs-virt -append "console=ttyAMA0 root=/dev/vda rootfstype=ext4 alpine_repo=http://dl-cdn.alpinelinux.org/alpine/edge/main/" -nographic -drive file=/path/to/alpine-disk.img,if=virtio,format=raw

-M virt: Specifies the machine type as virt (a generic ARM virtual machine). 
-cpu cortex-a15: Sets the CPU model. Other options like cortex-a7 or cortex-a57 might also be suitable. 
-m 512: Allocates 512MB of RAM. 
-kernel and -initrd: Point to the kernel and initial RAM disk from the Alpine image.
-append: Passes boot arguments to the kernel, including the root device, filesystem type, and repository for package installation.
-nographic: Disables graphics output, using the serial console for interaction.
-drive: Defines a disk image. You can create a disk image using qemu-img create -f raw alpine-disk.img 10G and then install Alpine into it. 
if=virtio,format=raw: Specifies the disk interface type and format. 
console=ttyAMA0: Sets the console device for serial output. 
root=/dev/vda: Specifies the root partition. 
rootfstype=ext4: Specifies the root filesystem type.
alpine_repo: Specifies the Alpine Linux repository for package management.

Finally, I successfully booted the virtual machines up. Simply use a command similar to the following one:

aarch64

qemu-system-aarch64 \
  -M virt -m 512M -cpu cortex-a57 \ # Required, cortex-a53 is OK, too
  -kernel vmlinuz-lts -initrd initramfs-lts \ # These two files can be downloaded from http://dl-cdn.alpinelinux.org/alpine/edge/releases/aarch64/netboot/
  -append "console=ttyAMA0 ip=dhcp alpine_repo=http://dl-cdn.alpinelinux.org/alpine/edge/main/" \ # The console argument is required to get console output
  -nographic

armv7

Same as aarch64 but replace qemu-system-aarch64 with qemu-system-arm, and cortex-a57 with cortex-a15.
- https://superuser.com/questions/1397991/running-alpine-linux-on-qemu-arm-guests

# stáhni skript a ověř integritu
wget https://raw.githubusercontent.com/alpinelinux/alpine-chroot-install/v0.14.0/alpine-chroot-install \
 && echo '<sha1sum>  alpine-chroot-install' | sha1sum -c || exit 1

# vytvoř ARMv7 chroot v ~/alpine-arm
chmod +x alpine-chroot-install
sudo ./alpine-chroot-install -d ~/alpine-arm -a armhf

alpine-chroot-install \
	-a armv7 \       # architecture
	-d alpine-arm \  # directory
	-p build-base \  # install build-base
	-p alpine-sdk    # install alpine-sdk

alpine-chroot-install -a armv7 -b v3.18 -d alpine-arm -p build-base -p alpine-sdk

alpine-chroot-install -a armv7 -d alpine-arm -p build-base -p alpine-sdk

alpine-chroot-install -a x86_64 -d alpine -p build-base -p alpine-sdk

alpine/enter-chroot -u "$USER" neofetch

alpine/destroy --remove
alpine-arm/destroy --remove




1. Stáhni zdrojový kód tty-clock
```bash
git clone https://github.com/xorg62/tty-clock.git
cd tty-clock
```


Výstup by měl obsahovat ELF 32-bit LSB executable, ARM, EABI5.


Přesuň a otestuj binárku přímo na zařízení (např. pomocí scp).

## Resources
- https://askubuntu.com/questions/250696/how-to-cross-compile-for-arm

- https://prboom.sourceforge.net/linux.html
- https://sourceforge.net/projects/prboom/files/prboom%20stable/2.5.0/
- https://github.com/libsdl-org/SDL-1.2/blob/main/INSTALL
- https://github.com/libsdl-org/SDL_mixer
- https://github.com/libsdl-org/SDL_net
- https://github.com/libsdl-org/SDL_net

- https://alpinelinux.org/downloads/
- https://github.com/keygenqt/skill-qemu-alpine/tree/main
- https://www.youtube.com/watch?v=oFQm43IH34s